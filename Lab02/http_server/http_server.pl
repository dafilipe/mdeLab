:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_json)).
:- use_module(library(random)).
:- use_module(library(lists)).

:- dynamic server_running/0.
:- dynamic mqtt_value/2.
:- dynamic robot_position/3.
:- dynamic op_status/5.
:- dynamic active_assignment/4.

:- http_handler('/mqtt', mqtt_handler, []).
:- http_handler('/status', status_handler, []).

:- http_handler('/new_order', new_order_handler, []).
:- http_handler('/assign_random_pending', assign_random_pending_handler, []).
:- http_handler('/route_for_robot', route_for_robot_handler, []).
:- http_handler('/finish_order', finish_order_handler, []).


% ---------------------------------------------------------
% START SERVER
% ---------------------------------------------------------

start_server(Port) :-
    (
        server_running
    ->
        true
    ;
        assertz(server_running),
        http_server(http_dispatch, [port(Port)])
    ).


% ---------------------------------------------------------
% DEVICE -> ROBOT ID
% ---------------------------------------------------------

device_robot_id(drone1, 1).
device_robot_id(ugv1, 6).
device_robot_id(ac1, 11).

device_robot_id(robot1, 1).
device_robot_id(robot2, 2).
device_robot_id(robot3, 3).
device_robot_id(robot4, 4).
device_robot_id(robot5, 5).
device_robot_id(robot6, 6).
device_robot_id(robot7, 7).
device_robot_id(robot8, 8).
device_robot_id(robot9, 9).
device_robot_id(robot10, 10).
device_robot_id(robot11, 11).
device_robot_id(robot12, 12).
device_robot_id(robot13, 13).
device_robot_id(robot14, 14).
device_robot_id(robot15, 15).


% ---------------------------------------------------------
% MQTT HANDLER
% Exemplo:
% /mqtt?topic=robot1/battery&value=80
% ---------------------------------------------------------

mqtt_handler(Request) :-
    http_parameters(Request, [
        topic(Topic, [atom]),
        value(Value, [atom])
    ]),

    update_mqtt_value(Topic, Value),
    update_knowledge_base_from_mqtt(Topic, Value, Result),

    reply_json(_{
        status: "ok",
        topic: Topic,
        value: Value,
        result: Result
    }).


update_mqtt_value(Topic, Value) :-
    retractall(mqtt_value(Topic, _)),
    assertz(mqtt_value(Topic, Value)).


parse_topic(Topic, Device, Field) :-
    atomic_list_concat([Device, Field], '/', Topic).


% ---------------------------------------------------------
% AUXILIAR op_status/5
% ---------------------------------------------------------

get_robot_status_or_default(RobotID, Location, Battery, MissionStatus, LoadID) :-
    (
        op_status(RobotID, Location, Battery, MissionStatus, LoadID)
    ->
        true
    ;
        Location = 10,
        Battery = 100,
        MissionStatus = idle,
        LoadID = none
    ).


set_robot_status(RobotID, Location, Battery, MissionStatus, LoadID) :-
    retractall(op_status(RobotID, _, _, _, _)),
    assertz(op_status(RobotID, Location, Battery, MissionStatus, LoadID)).


% ---------------------------------------------------------
% UPDATE KNOWLEDGE BASE FROM MQTT
% ---------------------------------------------------------

update_knowledge_base_from_mqtt(Topic, Value, Result) :-
    parse_topic(Topic, Device, battery),
    device_robot_id(Device, RobotID),
    atom_number(Value, Battery),
    update_robot_battery(RobotID, Battery),
    !,
    Result = _{
        type: "battery_update",
        robot_id: RobotID,
        battery: Battery
    }.


update_knowledge_base_from_mqtt(Topic, Value, Result) :-
    parse_topic(Topic, Device, available),
    device_robot_id(Device, RobotID),
    update_robot_availability(RobotID, Value, NewMissionStatus),
    !,
    Result = _{
        type: "availability_update",
        robot_id: RobotID,
        mission_status: NewMissionStatus
    }.


update_knowledge_base_from_mqtt(Topic, Value, Result) :-
    parse_topic(Topic, Device, status),
    device_robot_id(Device, RobotID),
    normalize_status_value(Value, MissionStatus),
    update_robot_mission_status(RobotID, MissionStatus),
    !,
    Result = _{
        type: "status_update",
        robot_id: RobotID,
        mission_status: MissionStatus
    }.


update_knowledge_base_from_mqtt(Topic, Value, Result) :-
    parse_topic(Topic, Device, current_node),
    device_robot_id(Device, RobotID),
    atom_number(Value, CurrentNode),
    update_robot_location(RobotID, CurrentNode),
    sync_active_assignment_with_location(RobotID, CurrentNode),
    !,
    Result = _{
        type: "location_update",
        robot_id: RobotID,
        location: CurrentNode
    }.


update_knowledge_base_from_mqtt(Topic, Value, Result) :-
    parse_topic(Topic, Device, load_id),
    device_robot_id(Device, RobotID),
    parse_load_value(Value, LoadID),
    update_robot_load_id(RobotID, LoadID),
    !,
    Result = _{
        type: "load_update",
        robot_id: RobotID,
        load_id: LoadID
    }.


update_knowledge_base_from_mqtt(Topic, Value, Result) :-
    parse_topic(Topic, Device, latitude),
    device_robot_id(Device, RobotID),
    atom_number(Value, Latitude),
    update_robot_position(RobotID, latitude, Latitude),
    !,
    Result = _{
        type: "latitude_update",
        robot_id: RobotID,
        latitude: Latitude
    }.


update_knowledge_base_from_mqtt(Topic, Value, Result) :-
    parse_topic(Topic, Device, longitude),
    device_robot_id(Device, RobotID),
    atom_number(Value, Longitude),
    update_robot_position(RobotID, longitude, Longitude),
    !,
    Result = _{
        type: "longitude_update",
        robot_id: RobotID,
        longitude: Longitude
    }.


update_knowledge_base_from_mqtt(Topic, Value, Result) :-
    Result = _{
        type: "unknown_topic",
        topic: Topic,
        value: Value
    }.


% ---------------------------------------------------------
% UPDATE ROBOT BATTERY / LOCATION / STATUS / LOAD
% ---------------------------------------------------------

update_robot_battery(RobotID, Battery) :-
    get_robot_status_or_default(RobotID, Location, _, MissionStatus, LoadID),
    set_robot_status(RobotID, Location, Battery, MissionStatus, LoadID).


update_robot_location(RobotID, NewLocation) :-
    get_robot_status_or_default(RobotID, _, Battery, MissionStatus, LoadID),
    set_robot_status(RobotID, NewLocation, Battery, MissionStatus, LoadID).


normalize_status_value(Value, Status) :-
    downcase_atom(Value, Lower),
    (
        Lower = 'in_transit'
    ->
        Status = transporting
    ;
        Lower = 'transporting'
    ->
        Status = transporting
    ;
        Lower = 'idle'
    ->
        Status = idle
    ;
        Lower = 'paused'
    ->
        Status = paused
    ;
        Lower = 'charging'
    ->
        Status = charging
    ;
        Lower = 'damaged'
    ->
        Status = damaged
    ;
        Status = Lower
    ).


update_robot_mission_status(RobotID, MissionStatus) :-
    get_robot_status_or_default(RobotID, Location, Battery, _, LoadID),
    set_robot_status(RobotID, Location, Battery, MissionStatus, LoadID).


update_robot_availability(RobotID, Value, NewMissionStatus) :-
    downcase_atom(Value, Lower),
    get_robot_status_or_default(RobotID, Location, Battery, CurrentMissionStatus, LoadID),
    availability_result_status(Lower, CurrentMissionStatus, LoadID, NewMissionStatus),
    set_robot_status(RobotID, Location, Battery, NewMissionStatus, LoadID).


availability_result_status(true, paused, none, idle) :- !.
availability_result_status(true, unknown, none, idle) :- !.
availability_result_status(true, CurrentMissionStatus, _, CurrentMissionStatus) :- !.

availability_result_status(false, idle, _, paused) :- !.
availability_result_status(false, unknown, _, paused) :- !.
availability_result_status(false, CurrentMissionStatus, _, CurrentMissionStatus) :- !.

availability_result_status(_, CurrentMissionStatus, _, CurrentMissionStatus).


parse_load_value(Value, none) :-
    downcase_atom(Value, none),
    !.

parse_load_value(Value, LoadID) :-
    catch(atom_number(Value, LoadID), _, fail),
    !.

parse_load_value(Value, Value).


update_robot_load_id(RobotID, NewLoadID) :-
    get_robot_status_or_default(RobotID, Location, Battery, MissionStatus, _),
    set_robot_status(RobotID, Location, Battery, MissionStatus, NewLoadID).


% ---------------------------------------------------------
% UPDATE ROBOT GPS POSITION
% ---------------------------------------------------------

update_robot_position(RobotID, latitude, Latitude) :-
    (
        retract(robot_position(RobotID, _, Longitude))
    ->
        true
    ;
        Longitude = unknown
    ),
    assertz(robot_position(RobotID, Latitude, Longitude)).


update_robot_position(RobotID, longitude, Longitude) :-
    (
        retract(robot_position(RobotID, Latitude, _))
    ->
        true
    ;
        Latitude = unknown
    ),
    assertz(robot_position(RobotID, Latitude, Longitude)).


% ---------------------------------------------------------
% STATUS HANDLER
% Exemplo:
% /status?id=1
% ---------------------------------------------------------

status_handler(Request) :-
    http_parameters(Request, [
        id(RobotID, [integer])
    ]),

    (
        op_status(RobotID, Location, Battery, MissionStatus, LoadID)
    ->
        (
            robot_position(RobotID, Latitude, Longitude)
        ->
            true
        ;
            Latitude = unknown,
            Longitude = unknown
        ),

        reply_json(_{
            status: "ok",
            robot_id: RobotID,
            location: Location,
            battery: Battery,
            mission_status: MissionStatus,
            load_id: LoadID,
            latitude: Latitude,
            longitude: Longitude
        })
    ;
        reply_json(_{
            status: "error",
            message: "robot_not_found",
            robot_id: RobotID
        })
    ).


% ---------------------------------------------------------
% NEW ORDER HANDLER
% Exemplo:
% /new_order?destination=18&urgency=2&products=1,4
% ---------------------------------------------------------

new_order_handler(Request) :-
    http_parameters(Request, [
        destination(Destination, [integer]),
        urgency(Urgency, [integer]),
        products(ProductsAtom, [atom])
    ]),

    parse_products_csv(ProductsAtom, ProductList),
    next_order_id(NewOrderID),

    assertz(order(NewOrderID, Destination, Urgency, ProductList, 'Pending')),

    reply_json(_{
        status: "ok",
        type: "new_order_created",
        order_id: NewOrderID,
        destination: Destination,
        urgency: Urgency,
        products: ProductList
    }).


parse_products_csv(ProductsAtom, ProductList) :-
    atomic_list_concat(Parts, ',', ProductsAtom),
    maplist(parse_product_id, Parts, ProductList).


parse_product_id(Part, ProductID) :-
    normalize_space(atom(CleanPart), Part),
    atom_number(CleanPart, ProductID).


next_order_id(NewOrderID) :-
    findall(ID, order(ID, _, _, _, _), IDs),
    (
        IDs = []
    ->
        NewOrderID = 1
    ;
        max_list(IDs, MaxID),
        NewOrderID is MaxID + 1
    ).


% ---------------------------------------------------------
% ASSIGN RANDOM PENDING ORDER
% Usa a lógica da main.pl:
% - best_robot_for_order/5
% - best_order_route_via_suppliers/7
% - robot_can_do_order_option/5
% - battery/capacity/path logic
%
% Exemplo:
% /assign_random_pending
% ---------------------------------------------------------

assign_random_pending_handler(_Request) :-
    findall(OrderID, order(OrderID, _, _, _, 'Pending'), PendingOrders),
    random_permutation(PendingOrders, RandomPendingOrders),

    (
        assign_first_possible_order(RandomPendingOrders, Assignment)
    ->
        reply_json(Assignment)
    ;
        reply_json(_{
            status: "error",
            message: "no_pending_order_can_be_assigned",
            pending_orders: PendingOrders
        })
    ).


assign_first_possible_order([OrderID | Rest], Assignment) :-
    (
        best_robot_for_order(OrderID, RobotID, Path, Distance, Energy)
    ->
        create_or_get_load_for_order(OrderID, LoadID),
        order(OrderID, Destination, Urgency, Products, _),

        retractall(order(OrderID, _, _, _, _)),
        assertz(order(OrderID, Destination, Urgency, Products, 'In_Transit')),

        get_robot_status_or_default(RobotID, StartLocation, Battery, _, _),
        set_robot_status(RobotID, StartLocation, Battery, transporting, LoadID),

        route_edges_to_nodes(StartLocation, Path, NodePath),

        retractall(active_assignment(RobotID, _, _, _)),
        assertz(active_assignment(RobotID, OrderID, NodePath, LoadID)),

        steps_from_edges(Path, Steps),

        Assignment = _{
            status: "ok",
            type: "order_assigned",
            order_id: OrderID,
            load_id: LoadID,
            robot_id: RobotID,
            start_location: StartLocation,
            node_path: NodePath,
            path: Steps,
            distance: Distance,
            energy: Energy
        }
    ;
        assign_first_possible_order(Rest, Assignment)
    ).

assign_first_possible_order([], _) :-
    fail.


create_or_get_load_for_order(OrderID, LoadID) :-
    load(ExistingLoadID, OrderID, _, _),
    !,
    LoadID = ExistingLoadID.

create_or_get_load_for_order(OrderID, LoadID) :-
    order_load_requirements(OrderID, Volume, Weight),
    next_load_id(LoadID),
    assertz(load(LoadID, OrderID, Volume, Weight)).


next_load_id(NewLoadID) :-
    findall(ID, load(ID, _, _, _), IDs),
    (
        IDs = []
    ->
        NewLoadID = 1
    ;
        max_list(IDs, MaxID),
        NewLoadID is MaxID + 1
    ).


% ---------------------------------------------------------
% ROUTE FOR ROBOT
% O Python pergunta ao Prolog qual é o próximo passo.
%
% Exemplo:
% /route_for_robot?id=1
% ---------------------------------------------------------

route_for_robot_handler(Request) :-
    http_parameters(Request, [
        id(RobotID, [integer])
    ]),

    (
        active_assignment(RobotID, OrderID, _NodePath, LoadID)
    ->
        get_robot_status_or_default(RobotID, CurrentLocation, Battery, MissionStatus, _),
        sync_active_assignment_with_location(RobotID, CurrentLocation),
        active_assignment(RobotID, OrderID, UpdatedNodePath, LoadID),

        (
            UpdatedNodePath = [CurrentLocation, NextNode | _]
        ->
            edge_info(CurrentLocation, NextNode, Distance, LinkType),

            reply_json(_{
                status: "ok",
                robot_id: RobotID,
                order_id: OrderID,
                load_id: LoadID,
                mission_status: MissionStatus,
                battery: Battery,
                current_location: CurrentLocation,
                node_path: UpdatedNodePath,
                path: [
                    _{
                        from: CurrentLocation,
                        to: NextNode,
                        distance: Distance,
                        link_type: LinkType
                    }
                ]
            })
        ;
            reply_json(_{
                status: "finished",
                robot_id: RobotID,
                order_id: OrderID,
                load_id: LoadID,
                current_location: CurrentLocation,
                node_path: UpdatedNodePath,
                message: "robot_already_at_final_node"
            })
        )
    ;
        route_for_robot_without_active_assignment(RobotID)
    ).


route_for_robot_without_active_assignment(RobotID) :-
    (
        op_status(RobotID, CurrentLocation, Battery, transporting, LoadID),
        load(LoadID, OrderID, _, _),
        order(OrderID, Destination, _, _, _),
        shortest_path_for_robot(RobotID, CurrentLocation, Destination, p(Path, Distance))
    ->
        route_edges_to_nodes(CurrentLocation, Path, NodePath),
        retractall(active_assignment(RobotID, _, _, _)),
        assertz(active_assignment(RobotID, OrderID, NodePath, LoadID)),

        (
            NodePath = [CurrentLocation, NextNode | _]
        ->
            edge_info(CurrentLocation, NextNode, StepDistance, LinkType),

            reply_json(_{
                status: "ok",
                robot_id: RobotID,
                order_id: OrderID,
                load_id: LoadID,
                battery: Battery,
                current_location: CurrentLocation,
                destination: Destination,
                total_distance: Distance,
                node_path: NodePath,
                path: [
                    _{
                        from: CurrentLocation,
                        to: NextNode,
                        distance: StepDistance,
                        link_type: LinkType
                    }
                ]
            })
        ;
            reply_json(_{
                status: "finished",
                robot_id: RobotID,
                order_id: OrderID,
                load_id: LoadID,
                current_location: CurrentLocation,
                destination: Destination,
                node_path: NodePath
            })
        )
    ;
        reply_json(_{
            status: "error",
            robot_id: RobotID,
            message: "robot_has_no_active_route"
        })
    ).


% ---------------------------------------------------------
% FINISH ORDER
% Exemplo:
% /finish_order?order=7
% ---------------------------------------------------------

finish_order_handler(Request) :-
    http_parameters(Request, [
        order(OrderID, [integer])
    ]),

    (
        order(OrderID, Destination, Urgency, Products, _)
    ->
        retractall(order(OrderID, _, _, _, _)),
        assertz(order(OrderID, Destination, Urgency, Products, 'Delivered')),

        finish_active_assignment_for_order(OrderID, RobotID, LoadID),

        reply_json(_{
            status: "ok",
            type: "order_finished",
            order_id: OrderID,
            robot_id: RobotID,
            load_id: LoadID
        })
    ;
        reply_json(_{
            status: "error",
            message: "order_not_found",
            order_id: OrderID
        })
    ).


finish_active_assignment_for_order(OrderID, RobotID, LoadID) :-
    (
        active_assignment(RobotID, OrderID, _NodePath, LoadID)
    ->
        retractall(active_assignment(RobotID, OrderID, _, _)),
        get_robot_status_or_default(RobotID, Location, Battery, _, _),
        set_robot_status(RobotID, Location, Battery, idle, none)
    ;
        RobotID = none,
        LoadID = none
    ).


% ---------------------------------------------------------
% ROUTE HELPERS
% ---------------------------------------------------------

route_edges_to_nodes(StartLocation, Path, NodePath) :-
    route_edges_to_nodes_aux(Path, [StartLocation], Reversed),
    reverse(Reversed, NodePath).


route_edges_to_nodes_aux([], Acc, Acc).

route_edges_to_nodes_aux([link(_A, B, _D, _T) | Rest], Acc, NodePath) :-
    route_edges_to_nodes_aux(Rest, [B | Acc], NodePath).


steps_from_edges([], []).

steps_from_edges([link(A, B, D, T) | Rest], [Step | RestSteps]) :-
    Step = _{
        from: A,
        to: B,
        distance: D,
        link_type: T
    },
    steps_from_edges(Rest, RestSteps).


edge_info(A, B, Distance, LinkType) :-
    link(A, B, Distance, LinkType),
    !.

edge_info(A, B, Distance, LinkType) :-
    link(B, A, Distance, LinkType).


sync_active_assignment_with_location(RobotID, CurrentLocation) :-
    (
        active_assignment(RobotID, OrderID, NodePath, LoadID),
        drop_until_node(CurrentLocation, NodePath, UpdatedNodePath)
    ->
        retractall(active_assignment(RobotID, _, _, _)),
        assertz(active_assignment(RobotID, OrderID, UpdatedNodePath, LoadID))
    ;
        true
    ).


drop_until_node(Node, [Node | Rest], [Node | Rest]) :-
    !.

drop_until_node(Node, [_ | Rest], Updated) :-
    drop_until_node(Node, Rest, Updated).