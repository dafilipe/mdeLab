:- ensure_loaded('http_server/http_server.pl').

% Knowledge base template
:- dynamic node/2.
:- dynamic robot/7.
:- dynamic link/4.
:- dynamic op_status/5.
:- dynamic order/5.
:- dynamic load/4.
:- dynamic customer/2.
:- dynamic supplier/3.
:- dynamic charge_station/4.
:- dynamic hub/4.

% DATA LOADING

% load(Load_ID, Order_ID, Total_Volume_L, Total_Weight_kg)
load(1, 1, 10.0, 60.0).
load(2, 2, 5.0, 2.5).
load(3, 3, 7.5, 25.0).
load(4, 4, 30.0, 200.0).
load(5, 5, 6.0, 20.0).
load(6, 6, 27.5, 175.0).
load(20, 20, 12.0, 54.5).

% order(Order_ID, Destination_node, Urgency, List_of_Products, Status)
order(1, 4, 2, [1,1,2,2], 'In_Transit').           % Vol: 10L | Peso: 60kg
order(2, 1, 3, [4,4,4,4,4], 'In_Transit').         % Vol: 5L  | Peso: 2.5kg
order(3, 11, 1, [3,3,3,3,3], 'In_Transit').        % Vol: 7.5L| Peso: 25kg
order(4, 14, 1, [2,2,2,2,2,2,2,2,2,2], 'In_Transit'). % Vol: 30L | Peso: 200kg
order(5, 12, 1, [3,3,3,3], 'In_Transit').          % Vol: 6L  | Peso: 20kg
order(6, 16, 2, [5,5,5,5,5,2,2,2,2,2], 'In_Transit'). % Vol: 27.5L| Peso: 175kg
order(7, 18, 3, [1,4], 'Pending').
order(8, 5, 1, [2,2,2,2,2], 'Pending').
order(9, 9, 2, [6,6,6], 'Pending').
order(20, 10, 1, [1,2,3,4,5,6], 'Pending').

% robot(ID, Type, Volume_cap, Weight_cap, Vel, Max_bat, Cons)              
robot(1, 'Drone', 15, 25, 50, 80, 0.4).
robot(2, 'Drone', 25, 70, 40, 100, 0.6).        
robot(3, 'Drone', 25, 35, 40, 100, 0.6).
robot(4, 'Drone', 15, 20, 50, 80, 0.4).
robot(5, 'Drone', 30, 20, 40, 100, 0.6).
robot(6, 'Ground', 90, 100, 25, 300, 1.5).
robot(7, 'Ground', 70, 80, 25, 300, 1.5).
robot(8, 'Ground', 100, 250, 25, 300, 1.5).     
robot(9, 'Ground', 150, 150, 20, 300, 2.0).
robot(10, 'Ground', 110, 130, 20, 300, 2.0).
robot(11, 'Ground_Auto', 190, 150, 30, 250, 5.0).
robot(12, 'Ground_Auto', 170, 145, 30, 250, 5.0).
robot(13, 'Ground_Auto', 160, 200, 30, 250, 5.0). 
robot(14, 'Ground_Auto', 180, 120, 30, 250, 6.0).
robot(15, 'Ground_Auto', 200, 110, 30, 250, 6.0).

% op_status(Robot_ID, Location, Batt_Level, Mission_status, Load_ID)
op_status(1, 10, 100, idle, none).           
op_status(2, 4, 45, transporting, 1).   
op_status(3, 16, 20, charging, none).        
op_status(4, 1, 85, transporting, 2).   
op_status(5, 18, 5, damaged, none).         

op_status(6, 10, 95, idle, none).            
op_status(7, 6, 60, transporting, 3).   
op_status(8, 11, 40, paused, 4).        
op_status(9, 15, 75, transporting, 5).   
op_status(10, 10, 100, idle, none).       

op_status(11, 13, 15, charging, none).       
op_status(12, 10, 100, idle, none).          
op_status(13, 7, 50, transporting, 6).  
op_status(14, 17, 0, damaged, none).          
op_status(15, 12, 80, idle, none).     

% product(Product_ID, Name, Volume_cm3, Weight_kg)
product(1, 'Package A', 2, 10).
product(2, 'Package B', 3, 20).
product(3, 'Package C', 1.5, 5).
product(4, 'Package D', 1, 0.5).
product(5, 'Package E', 2.5, 15).
product(6, 'Package F', 2, 4).

% supplier(Node_ID, Name, List_of_Products)
supplier(1, 'Supplier A', [1, 2]).
supplier(2, 'Supplier B', [3, 5]).
supplier(3, 'Supplier C', [4, 6]).

% hub(Node_ID, Name, Status, Charge_speed)
hub(4, 'Hub A', 'Available', 10).
hub(5, 'Hub B', 'Occupied', 15).

% charge_station(Node_ID, Name, Status, Charge_speed)
charge_station(6, 'Charge Station A', 'Available', 10).
charge_station(7, 'Charge Station B', 'Occupied', 15).
charge_station(8, 'Charge Station C', 'Available', 20).

% customer(Node_ID, Name)
customer(9, 'Customer A').
customer(10, 'Main Customer').
customer(11, 'Customer C').
customer(12, 'Customer D').
customer(13, 'Customer E').
customer(14, 'Customer F').
customer(15, 'Customer G').
customer(16, 'Customer H').
customer(17, 'Customer I').
customer(18, 'Customer J').

% node(Node_ID, Address)
node(1, 'Place 1').
node(2, 'Place 2').
node(3, 'Place 3').
node(4, 'Place 4').
node(5, 'Place 5').
node(6, 'Place 6').
node(7, 'Place 7').
node(8, 'Place 8').
node(9, 'Place 9').
node(10, 'Fortress').
node(11, 'Place 11').
node(12, 'Place 12').
node(13, 'Place 13').
node(14, 'Place 14').
node(15, 'Place 15').
node(16, 'Place 16').
node(17, 'Place 17').
node(18, 'Place 18').

% link(NodeID_A, NodeID_B, Dist, Tipo)
link(1,4,80,'Mixed').
link(1,6,25,'Mixed').
link(1,9,20,'Aerial').
link(1,10,90,'Aerial').
link(2,4,60,'Mixed').
link(2,16,10,'Aerial').
link(2,17,50,'Mixed').
link(3,18,60,'Aerial').
link(3,15,30,'Mixed').
link(3,10,90,'Aerial').
link(4,13,15,'Mixed').
link(4,11,25,'Aerial').
link(5,9,20,'Mixed').
link(5,10,45,'Ground').
link(5,15,30,'Mixed').
link(5,8,25,'Aerial').
link(5,12,25,'Ground').
link(6,11,15,'Mixed').
link(6,12,20,'Mixed').
link(7,16,20,'Mixed').
link(7,13,30,'Ground').
link(7,11,40,'Mixed').
link(7,17,20,'Mixed').
link(8,14,35,'Mixed').
link(8,15,20,'Mixed').
link(9,12,15,'Mixed').
link(11,14,20,'Mixed').
link(12,14,25,'Ground').
link(13,16,15,'Mixed').
link(14,17,30,'Mixed').
link(14,18,40,'Aerial').
link(17,18,25,'Ground').

:- discontiguous execute/1.








% -------------------------------
% Distance and routing rules
% -------------------------------
% The network is treated as an undirected graph: a link can be travelled
% in either direction. Every route below is recursive and cycle-safe.
%
% Link compatibility rules:
%   - Drone robots can use Aerial and Mixed links.
%   - Ground and Ground_Auto robots can use Ground and Mixed links.
%   - any means ignore robot type and allow every link.

valid_link_for_robot(RobotType, _) :- var(RobotType), !.
valid_link_for_robot(any, _).
valid_link_for_robot('Drone', 'Aerial').
valid_link_for_robot('Drone', 'Mixed').
valid_link_for_robot('Ground', 'Ground').
valid_link_for_robot('Ground', 'Mixed').
valid_link_for_robot('Ground_Auto', 'Ground').
valid_link_for_robot('Ground_Auto', 'Mixed').

% biarc(Start, End, Distance, LinkType)
% Allows movement in both directions even though links are stored once.
biarc(X, Y, D, T) :- link(X, Y, D, T).
biarc(X, Y, D, T) :- link(Y, X, D, T).

% route(Start, End, RobotTypeOrAny, Path, TotalDistance)
% Fully recursive path finder. It remembers visited nodes to avoid loops.
route(X, Y, RobotType, Path, Distance) :-
    route_dfs(X, Y, RobotType, [X], Path, 0, Distance).

route_dfs(Y, Y, _, _, [], Distance, Distance).
route_dfs(Current, Final, RobotType, Visited,
          [link(Current, Next, D, LinkType) | RestPath], AccDistance, TotalDistance) :-
    biarc(Current, Next, D, LinkType),
    valid_link_for_robot(RobotType, LinkType),
    \+ member(Next, Visited),
    NewAccDistance is AccDistance + D,
    route_dfs(Next, Final, RobotType, [Next | Visited], RestPath, NewAccDistance, TotalDistance).

% Backwards-compatible predicates.
% Old calls like distance(1, 11, D, _) still work, but now they are recursive.
distance(X, Y, D, RobotType) :- route(X, Y, RobotType, _, D).
path(X, Y, Path) :- route(X, Y, any, Path, _).
path(X, Y, RobotType, Path) :- route(X, Y, RobotType, Path, _).
pathdist(X, Y, p(Path, D)) :- route(X, Y, any, Path, D).
pathdist(X, Y, RobotType, p(Path, D)) :- route(X, Y, RobotType, Path, D).

% Robot-specific route helpers.
robot_pathdist(RobotID, X, Y, p(Path, D)) :-
    robot(RobotID, RobotType, _, _, _, _, _),
    route(X, Y, RobotType, Path, D).

shortest_path(X, Y, p(Path, D)) :-
    shortest_path(X, Y, any, p(Path, D)).

shortest_path(X, Y, RobotType, p(Path, D)) :-
    findall(p(P, Dist), route(X, Y, RobotType, P, Dist), Routes),
    shortest_route(Routes, p(Path, D)).

shortest_path_for_robot(RobotID, X, Y, p(Path, D)) :-
    robot(RobotID, RobotType, _, _, _, _, _),
    shortest_path(X, Y, RobotType, p(Path, D)).

longest_path(X, Y, p(Path, D)) :-
    longest_path(X, Y, any, p(Path, D)).

longest_path(X, Y, RobotType, p(Path, D)) :-
    findall(p(P, Dist), route(X, Y, RobotType, P, Dist), Routes),
    longest_route(Routes, p(Path, D)).

longest_path_for_robot(RobotID, X, Y, p(Path, D)) :-
    robot(RobotID, RobotType, _, _, _, _, _),
    longest_path(X, Y, RobotType, p(Path, D)).

% Backwards-compatible min/max distance predicates.

shortest_route([Route], Route).
shortest_route([p(P, D) | Rest], Best) :-
    shortest_route(Rest, p(BestP, BestD)),
    ( D =< BestD -> Best = p(P, D) ; Best = p(BestP, BestD) ).

longest_route([Route], Route).
longest_route([p(P, D) | Rest], Best) :-
    longest_route(Rest, p(BestP, BestD)),
    ( D >= BestD -> Best = p(P, D) ; Best = p(BestP, BestD) ).

% Utilities used by RF8/RF9.
path_link_types([], []).
path_link_types([link(_, _, _, LinkType) | Rest], [LinkType | Types]) :-
    path_link_types(Rest, Types).

battery_available_units(RobotID, Available) :-
    robot(RobotID, _, _, _, _, MaxBat, _),
    ( op_status(RobotID, _, CurrentBatPercent, _, _) ->
        Available is MaxBat * CurrentBatPercent / 100
    ;
        Available = MaxBat
    ).

battery_needed_for_distance(RobotID, Distance, Needed) :-
    robot(RobotID, _, _, _, _, _, Consumption),
    Needed is Distance * Consumption.

robot_has_battery_for_distance(RobotID, Distance, Available, Needed) :-
    battery_available_units(RobotID, Available),
    battery_needed_for_distance(RobotID, Distance, Needed),
    Needed =< Available.

available_charge_point(ID, Name, 'Hub', Speed) :-
    hub(ID, Name, 'Available', Speed).
available_charge_point(ID, Name, 'Charge Station', Speed) :-
    charge_station(ID, Name, 'Available', Speed).

print_charge_points([]) :-
    write('No available charging points found within the compatible route distance.'), nl.
print_charge_points([cp(ID, Name, Kind, Speed, Distance) | Rest]) :-
    format('~w ~w: ~w | Speed: ~w | Distance: ~w~n', [Kind, ID, Name, Speed, Distance]),
    print_charge_points(Rest).


% -------------------------------
% RF9 helper rules: supplier-aware order planning
% -------------------------------
% RF9 now plans the real delivery flow:
%   1) the robot starts from its effective location,
%   2) it visits the supplier nodes required by the products in the order,
%   3) it then goes to the customer/destination node.
%
% If there is a load/4 fact for the order, that is used as the official
% volume/weight. If there is no load/4 fact, the values are calculated from
% the order product list so pending orders without a pre-created load can still
% be evaluated.

order_load_requirements(OrderID, Volume, Weight) :-
    load(_, OrderID, Volume, Weight),
    !.
order_load_requirements(OrderID, Volume, Weight) :-
    order(OrderID, _, _, ProductList, _),
    order_products_totals(ProductList, Volume, Weight).

order_products_totals([], 0, 0).
order_products_totals([ProductID | Rest], TotalVolume, TotalWeight) :-
    product(ProductID, _, ProductVolume, ProductWeight),
    order_products_totals(Rest, RestVolume, RestWeight),
    TotalVolume is ProductVolume + RestVolume,
    TotalWeight is ProductWeight + RestWeight.

unique_order_products(OrderID, UniqueProducts) :-
    order(OrderID, _, _, ProductList, _),
    sort(ProductList, UniqueProducts).

product_has_supplier(ProductID) :-
    supplier(_, _, SupplierProducts),
    member(ProductID, SupplierProducts),
    !.

order_products_missing_suppliers(OrderID, MissingProducts) :-
    unique_order_products(OrderID, UniqueProducts),
    findall(ProductID,
        ( member(ProductID, UniqueProducts),
          \+ product_has_supplier(ProductID)
        ),
        MissingProducts).

product_supplier(ProductID, SupplierNodeID) :-
    supplier(SupplierNodeID, _, SupplierProducts),
    member(ProductID, SupplierProducts).

supplier_assignment_for_products([], []).
supplier_assignment_for_products([ProductID | RestProducts], [SupplierNodeID | RestSuppliers]) :-
    product_supplier(ProductID, SupplierNodeID),
    supplier_assignment_for_products(RestProducts, RestSuppliers).

% One possible minimal set of supplier nodes that can provide all unique
% products in an order. If a product is sold by more than one supplier, Prolog
% explores all valid assignments and later chooses the shortest route.
order_supplier_nodes_option(OrderID, SupplierNodes) :-
    unique_order_products(OrderID, UniqueProducts),
    order_products_missing_suppliers(OrderID, []),
    supplier_assignment_for_products(UniqueProducts, AssignedSupplierNodes),
    sort(AssignedSupplierNodes, SupplierNodes).

build_order_route_for_visit_order(RobotID, Start, [], Destination, Path, Distance) :-
    shortest_path_for_robot(RobotID, Start, Destination, p(Path, Distance)).
build_order_route_for_visit_order(RobotID, Start, [SupplierNode | RestSuppliers], Destination, FullPath, TotalDistance) :-
    shortest_path_for_robot(RobotID, Start, SupplierNode, p(PathToSupplier, DistanceToSupplier)),
    build_order_route_for_visit_order(RobotID, SupplierNode, RestSuppliers, Destination, RemainingPath, RemainingDistance),
    append(PathToSupplier, RemainingPath, FullPath),
    TotalDistance is DistanceToSupplier + RemainingDistance.

order_route_candidate(RobotID, Start, OrderID, supplier_route(SupplierNodes, VisitOrder, FullPath, TotalDistance)) :-
    order(OrderID, Destination, _, _, _),
    order_supplier_nodes_option(OrderID, SupplierNodes),
    permutation(SupplierNodes, VisitOrder),
    build_order_route_for_visit_order(RobotID, Start, VisitOrder, Destination, FullPath, TotalDistance).

best_order_route_via_suppliers(RobotID, Start, OrderID, BestPath, BestDistance, BestSupplierNodes, BestVisitOrder) :-
    findall(Route,
        order_route_candidate(RobotID, Start, OrderID, Route),
        Routes),
    shortest_supplier_route(Routes, supplier_route(BestSupplierNodes, BestVisitOrder, BestPath, BestDistance)).

shortest_supplier_route([Route], Route).
shortest_supplier_route(
    [supplier_route(Suppliers1, Visit1, Path1, Distance1), supplier_route(_, _, _, Distance2) | Rest],
    Best
) :-
    Distance1 =< Distance2,
    shortest_supplier_route([supplier_route(Suppliers1, Visit1, Path1, Distance1) | Rest], Best).
shortest_supplier_route(
    [supplier_route(_, _, _, Distance1), supplier_route(Suppliers2, Visit2, Path2, Distance2) | Rest],
    Best
) :-
    Distance1 > Distance2,
    shortest_supplier_route([supplier_route(Suppliers2, Visit2, Path2, Distance2) | Rest], Best).

remaining_battery_after_distance(RobotID, AvailableBefore, Distance, Needed, AvailableAfter) :-
    battery_needed_for_distance(RobotID, Distance, Needed),
    AvailableAfter is AvailableBefore - Needed.

print_supplier_visit_details([]).
print_supplier_visit_details([SupplierNode | Rest]) :-
    ( supplier(SupplierNode, SupplierName, SupplierProducts) ->
        format('  Supplier Node ~w (~w) | Products: ~w~n', [SupplierNode, SupplierName, SupplierProducts])
    ;
        format('  Supplier Node ~w~n', [SupplierNode])
    ),
    print_supplier_visit_details(Rest).

print_order_route_result(Path, SupplierNodes, VisitOrder, Distance, Available, Needed, Remaining) :-
    path_link_types(Path, LinkTypes),
    format('Required supplier nodes: ~w~n', [SupplierNodes]),
    write('Supplier details:'), nl,
    print_supplier_visit_details(SupplierNodes),
    format('Chosen supplier visit order: ~w~n', [VisitOrder]),
    format('ROUTE: [OK] Supplier-aware compatible path found: ~w~n', [Path]),
    format('Route link types: ~w~n', [LinkTypes]),
    format('Total distance: ~w~n', [Distance]),
    format('Battery available: ~2f | Battery needed: ~2f | Battery after route: ~2f~n', [Available, Needed, Remaining]).

check_new_order_from_location(RobotID, OrderID, StartLoc, AvailableBattery) :-
    order_products_missing_suppliers(OrderID, MissingProducts),
    ( MissingProducts \= [] ->
        format('RESULT: [NO] Order has products without any registered supplier: ~w~n', [MissingProducts])
    ; best_order_route_via_suppliers(RobotID, StartLoc, OrderID, Path, Distance, SupplierNodes, VisitOrder) ->
        remaining_battery_after_distance(RobotID, AvailableBattery, Distance, Needed, Remaining),
        print_order_route_result(Path, SupplierNodes, VisitOrder, Distance, AvailableBattery, Needed, Remaining),
        ( Needed =< AvailableBattery ->
            write('RESULT: [YES] Robot can collect the products from suppliers and deliver this order.'), nl
        ;
            write('RESULT: [NO] Robot has a compatible supplier route, but not enough battery.'), nl
        )
    ;
        write('RESULT: [NO] No compatible route exists through the required suppliers for this robot type.'), nl
    ).

check_after_current_order_then_new(RobotID, RequestedOrderID, CurrentLoc, AvailableBattery, CurrentLoadID) :-
    ( load(CurrentLoadID, CurrentOrderID, _, _) ->
        true
    ;
        write('RESULT: [NO] Robot is transporting, but its current Load ID does not match any load/order.'), nl,
        fail
    ),
    ( CurrentOrderID == RequestedOrderID ->
        write('RESULT: [NO] Robot is already executing this requested order.'), nl
    ; order(CurrentOrderID, CurrentDestination, _, _, _) ->
        format('Robot is currently transporting Load ~w for Order ~w.~n', [CurrentLoadID, CurrentOrderID]),
        format('First checking completion of current order to destination Node ~w...~n', [CurrentDestination]),
        ( shortest_path_for_robot(RobotID, CurrentLoc, CurrentDestination, p(CurrentPath, CurrentDistance)) ->
            remaining_battery_after_distance(RobotID, AvailableBattery, CurrentDistance, CurrentNeeded, BatteryAfterCurrent),
            path_link_types(CurrentPath, CurrentLinkTypes),
            format('Current order path: ~w~n', [CurrentPath]),
            format('Current order link types: ~w~n', [CurrentLinkTypes]),
            format('Current order distance: ~w~n', [CurrentDistance]),
            format('Battery before current completion: ~2f | Needed: ~2f | After completion: ~2f~n', [AvailableBattery, CurrentNeeded, BatteryAfterCurrent]),
            ( CurrentNeeded =< AvailableBattery ->
                write('CURRENT ORDER: [OK] Robot can finish its current order first.'), nl,
                format('Now checking requested Order ~w from Node ~w with remaining battery...~n', [RequestedOrderID, CurrentDestination]),
                check_new_order_from_location(RobotID, RequestedOrderID, CurrentDestination, BatteryAfterCurrent)
            ;
                write('RESULT: [NO] Robot cannot be assigned because it lacks battery to finish the current order first.'), nl
            )
        ;
            write('RESULT: [NO] Robot cannot be assigned because no compatible route exists to finish its current order.'), nl
        )
    ;
        write('RESULT: [NO] Robot current order was not found.'), nl
    ).

check_robot_assignment_status(RobotID, OrderID, CurrentLoc, CurrentBatPercent, MissionStatus, LoadID) :-
    battery_available_units(RobotID, AvailableBattery),
    format('Current location: Node ~w | Battery: ~w%% (~2f units) | Status: ~w | Load: ~w~n',
           [CurrentLoc, CurrentBatPercent, AvailableBattery, MissionStatus, LoadID]),
    ( MissionStatus == idle, LoadID == none ->
        write('AVAILABILITY: [OK] Robot is idle and can be evaluated for this order now.'), nl,
        check_new_order_from_location(RobotID, OrderID, CurrentLoc, AvailableBattery)
    ; MissionStatus == idle ->
        write('RESULT: [NO] Robot is idle but still has a Load ID assigned; operational status is inconsistent.'), nl
    ; MissionStatus == transporting ->
        write('AVAILABILITY: [WAIT] Robot is transporting another order; checking if it can do the requested order after finishing the current one.'), nl,
        check_after_current_order_then_new(RobotID, OrderID, CurrentLoc, AvailableBattery, LoadID)
    ;
        format('RESULT: [NO] Robot cannot be assigned while its status is ~w.~n', [MissionStatus])
    ).










% -------------------------------
% Entry point
% -------------------------------

menu :-
    repeat,
    nl,
    write('--- NETWORK MANAGEMENT SYSTEM ---'), nl,
    write('1. [RF1] Add/modify/remove a network node'), nl,
    write('2. [RF2] Add/modify/remove autonomous robots'), nl,
    write('3. [RF3] Add/modify/remove connections between network nodes'), nl,
    write('4. [RF4] Register and update the status of robots'), nl,
    write('5. [RF5] Create, update, and remove delivery orders'), nl,
    write('6. [RF6] List available robots in a given area or region'), nl,
    write('7. [RF7] Check the current status of a specific robot'), nl,
    write('8. [RF8] List available charging stations and hubs in a given area or near a robot'), nl,    
    write('9. [RF9] Determine whether a robot can perform a given delivery'), nl,
    write('10.[RF10] Determine the shortest route between two nodes'), nl,
    write('11.[RF11] Determine the route with the lowest energy consumption'), nl, 
    write('12.[RF12] Determine routes that include intermediate distribution points'), nl,
    write('13.[RF13] Determine routes that include charging stations'), nl,
    write('14.[RF14] Select the best robot for a delivery'), nl,
    write('15.[RF15] Identify robots for grouped/bulk deliveries'), nl,
    write('16.[RF16] Fleet health and risk report'), nl,
    write('22.[DBG] View Knowledge Base (Select Categories)'), nl,
    write('0. Exit'), nl,
    write('Enter your choice: '),
    read(Choice),
    execute(Choice),
    Choice == 0,
    !.

% -------------------------------
% Main menu logic
% -------------------------------

execute(1) :- !, node_menu.                             % RF1
execute(2) :- !, robot_menu.                            % RF2
execute(3) :- !, connection_menu.                       % RF3
execute(4) :- !, status_menu.                           % RF4
execute(5) :- !, order_menu.                            % RF5
execute(6) :- !, list_available_robots.                 % RF6
execute(7) :- !, check_robot_status.                    % RF7
execute(8) :- !, listCS_menu.                           % RF8
execute(9) :- !, check_robot_delivery_capability.       % RF9
execute(10) :- !, shortest_route_menu.                  % RF10
execute(11) :- !, lowest_energy_route_menu.             % RF11
execute(12) :- !, route_with_hub_menu.                  % RF12
execute(13) :- !, route_with_charging_menu.             % RF13
execute(14) :- !, best_robot_menu.                      % RF14
execute(15) :- !, grouped_delivery_menu.               % RF15
execute(16) :- !, fleet_health_report.                 % RF16
execute(22):- !, view_kb.
execute(0) :- !, write('Exiting system... Goodbye!'), nl.
execute(_) :- write('Invalid selection, please try again.'), nl.

% RF1 to RF5 Menus
node_menu :-
    nl,
    write('--- Network Nodes ---'), nl,
    write('1. Add Node'), nl,
    write('2. Modify Node'), nl,
    write('3. Remove Node'), nl,
    read(SubChoice),
    handle_node(SubChoice).

handle_node(1) :- !, add_node.
handle_node(2) :- !, modify_node.
handle_node(3) :- !, remove_node.
handle_node(_) :- write('Invalid option.'), nl.

robot_menu :-
    nl,
    write('--- Autonomous Robots ---'), nl,
    write('1. Add Robot'), nl,
    write('2. Modify Robot'), nl,
    write('3. Remove Robot'), nl,
    read(SubChoice),
    handle_robot(SubChoice).

handle_robot(1) :- !, add_robot.
handle_robot(2) :- !, modify_robot.
handle_robot(3) :- !, remove_robot.
handle_robot(_) :- write('Invalid option.'), nl.

connection_menu :-
    nl,
    write('--- Connections ---'), nl,
    write('1. Add Connection'), nl,
    write('2. Modify Connection'), nl,
    write('3. Remove Connection'), nl,
    read(SubChoice),
    handle_connection(SubChoice).

handle_connection(1) :- !, add_connection.
handle_connection(2) :- !, modify_connection.
handle_connection(3) :- !, remove_connection.
handle_connection(_) :- write('Invalid option.'), nl.

status_menu :-
    nl,
    write('--- Robot Status ---'), nl,
    write('1. Register Status'), nl,
    write('2. Update Status'), nl,
    read(SubChoice),
    handle_status(SubChoice).

handle_status(1) :- !, register_status.
handle_status(2) :- !, update_status.
handle_status(_) :- write('Invalid option.'), nl.

order_menu :-
    nl,
    write('--- Delivery Orders ---'), nl,
    write('1. Create Order'), nl,
    write('2. Update Order'), nl,
    write('3. Remove Order'), nl,
    read(SubChoice),
    handle_order(SubChoice).

handle_order(1) :- !, create_order.
handle_order(2) :- !, update_order.
handle_order(3) :- !, remove_order.
handle_order(_) :- write('Invalid option.'), nl.

% RF 8 Menu

listCS_menu :-
    nl,
    write('--- Search Options ---'), nl,
    write('1. Near a Node'), nl,
    write('2. Near a Robot'), nl,
    read(SubChoice),
    handle_listCs(SubChoice).

handle_listCs(1) :- !, list_charging_stations_node.
handle_listCs(2) :- !, list_charging_stations_robot.
handle_listCs(_) :- write('Invalid option.'), nl.

% -------------------------------
% Dummy predicates (Placeholders para desenvolvimento)
% -------------------------------

% RF1 a RF5
% --- RF1: Nodes ---
add_node :-
    write('Enter Node ID: '), read(ID),
    % Verifica se o nó já existe na base de dados
    ( node(ID, _) ->
        write('ERROR: A node with this ID already exists in the territory!'), nl
    ;
        write('Enter Address (in quotes, e.g., \'New Place\'): '), read(Address),
        assertz(node(ID, Address)),
        write('Node added successfully!'), nl,
        % Chama a função para atribuir a entidade a este nó
        assign_node_entity(ID)
    ).

assign_node_entity(ID) :-
    nl,
    write('What is located at this new node?'), nl,
    write('1. Customer (Buyer)'), nl,
    write('2. Supplier (Source)'), nl,
    write('3. Charge Station'), nl,
    write('4. Hub (Base/Storage)'), nl,
    write('5. None (Just a waypoint on the road)'), nl,
    write('Enter your choice (1-5): '), read(Choice),
    handle_node_entity(Choice, ID).

handle_node_entity(1, ID) :-
    write('Enter Customer Name (in quotes): '), read(Name),
    assertz(customer(ID, Name)),
    write('SUCCESS: Customer linked to this node!'), nl.

handle_node_entity(2, ID) :-
    write('Enter Supplier Name (in quotes): '), read(Name),
    write('Enter List of Product IDs they sell (e.g., [1,3,5]): '), read(Products),
    assertz(supplier(ID, Name, Products)),
    write('SUCCESS: Supplier linked to this node!'), nl.

handle_node_entity(3, ID) :-
    write('Enter Charge Station Name (in quotes): '), read(Name),
    write('Enter Status (in quotes, e.g., \'Available\'): '), read(Status),
    write('Enter Charge Speed (e.g., 10): '), read(Speed),
    assertz(charge_station(ID, Name, Status, Speed)),
    write('SUCCESS: Charge Station online at this node!'), nl.

handle_node_entity(4, ID) :-
    write('Enter Hub Name (in quotes): '), read(Name),
    write('Enter Status (in quotes, e.g., \'Available\'): '), read(Status),
    write('Enter Charge Speed (e.g., 15): '), read(Speed),
    assertz(hub(ID, Name, Status, Speed)),
    write('SUCCESS: Hub established at this node!'), nl.

handle_node_entity(5, _) :-
    write('Node registered as a simple road waypoint. No entities attached.'), nl.

handle_node_entity(_, _) :-
    write('Invalid choice. Node registered as a waypoint by default.'), nl.

modify_node :-
    write('Enter Node ID to modify: '), read(ID),
    ( node(ID, _) ->
        retract(node(ID, _)),
        write('Enter new Address (in quotes): '), read(Address),
        assertz(node(ID, Address)), 
        write('Node modified successfully!'), nl
    ;
        write('ERROR: Node not found!'), nl
    ).

remove_node :-
    write('Enter Node ID to remove: '), read(ID),
    ( retract(node(ID, _)) -> 
        write('Node removed successfully!'), nl
    ;
        write('ERROR: Node not found!'), nl
    ).


% --- RF2: Robots ---
add_robot :-
    write('Enter Robot ID: '), read(ID),
    % 1. Verifica se o ID já existe
    ( robot(ID, _, _, _, _, _, _) ->
        write('ERROR: A robot with this ID already exists in the fleet!'), nl
    ;
        write('Enter Type (\'Drone\', \'Ground\', or \'Ground_Auto\'): '), read(Type),
        % 2. Valida o tipo de robô
        ( (Type == 'Drone' ; Type == 'Ground' ; Type == 'Ground_Auto') ->
            write('Enter Volume Capacity: '), read(Vol),
            write('Enter Weight Capacity: '), read(Weight),
            write('Enter Velocity: '), read(Vel),
            write('Enter Max Battery: '), read(Bat),
            write('Enter Consumption: '), read(Cons),
            
            assertz(robot(ID, Type, Vol, Weight, Vel, Bat, Cons)),
            write('Robot added to the fleet successfully!'), nl,
            
            % 3. Cria automaticamente o op_status inicial
            write('Enter Starting Location (Node ID) for this robot: '), read(Loc),
            assertz(op_status(ID, Loc, 100, idle, none)),
            write('Robot status initialized: 100% Battery, Idle, Ready for orders.'), nl
        ;
            write('ERROR: Invalid Type! We only use \'Drone\', \'Ground\', or \'Ground_Auto\'.'), nl
        )
    ).

modify_robot :-
    write('Enter Robot ID to modify: '), read(ID),
    ( robot(ID, _, _, _, _, _, _) ->
        write('Enter new Type (\'Drone\', \'Ground\', or \'Ground_Auto\'): '), read(Type),
        ( (Type == 'Drone' ; Type == 'Ground' ; Type == 'Ground_Auto') ->
            retract(robot(ID, _, _, _, _, _, _)),
            write('Enter Volume Capacity: '), read(Vol),
            write('Enter Weight Capacity: '), read(Weight),
            write('Enter Velocity: '), read(Vel),
            write('Enter Max Battery: '), read(Bat),
            write('Enter Consumption: '), read(Cons),
            assertz(robot(ID, Type, Vol, Weight, Vel, Bat, Cons)),
            write('Robot modified successfully!'), nl
        ;
            write('ERROR: Invalid Type! Modification aborted.'), nl
        )
    ;
        write('ERROR: Robot not found!'), nl
    ).

remove_robot :-
    write('Enter Robot ID to remove: '), read(ID),
    ( retract(robot(ID, _, _, _, _, _, _)) ->
        % Bónus: Remove também o estado operacional associado para limpar o sistema
        ( retract(op_status(ID, _, _, _, _)) -> true ; true ),
        write('Robot and its operational status removed successfully!'), nl
    ;
        write('ERROR: Robot not found!'), nl
    ).

% RF3: CONNECTIONS 
add_connection :-
    write('Enter Node A ID: '), read(A),
    ( node(A, _) ->
        write('Enter Node B ID: '), read(B),
        ( node(B, _) ->
            ( A \== B ->
                ( \+ link(A, B, _, _) ->
                    write('Enter Distance: '), read(Dist),
                    ( number(Dist), Dist > 0 ->
                        write('Enter Type (\'Mixed\', \'Aerial\', or \'Ground\'): '), read(Type),
                        ( (Type == 'Mixed' ; Type == 'Aerial' ; Type == 'Ground') ->
                            assertz(link(A, B, Dist, Type)),
                            write('Connection added successfully!'), nl
                        ;
                            write('ERROR: Invalid Type! Must be \'Mixed\', \'Aerial\', or \'Ground\'.'), nl
                        )
                    ;
                        write('ERROR: Distance must be a positive number!'), nl
                    )
                ;
                    write('ERROR: A connection between these nodes already exists!'), nl
                )
            ;
                write('ERROR: A node cannot connect to itself!'), nl
            )
        ;
            write('ERROR: Node B does not exist in the territory!'), nl
        )
    ;
        write('ERROR: Node A does not exist in the territory!'), nl
    ).

modify_connection :-
    write('Enter Node A ID: '), read(A),
    write('Enter Node B ID: '), read(B),
    ( link(A, B, _, _) ->
        write('Enter new Distance: '), read(Dist),
        ( number(Dist), Dist > 0 ->
            write('Enter new Type (\'Mixed\', \'Aerial\', or \'Ground\'): '), read(Type),
            ( (Type == 'Mixed' ; Type == 'Aerial' ; Type == 'Ground') ->
                retract(link(A, B, _, _)),
                assertz(link(A, B, Dist, Type)),
                write('Connection modified successfully!'), nl
            ;
                write('ERROR: Invalid Type! Must be \'Mixed\', \'Aerial\', or \'Ground\'.'), nl
            )
        ;
            write('ERROR: Distance must be a positive number!'), nl
        )
    ;
        write('ERROR: Connection between these nodes does not exist!'), nl
    ).

remove_connection :-
    write('Enter Node A ID: '), read(A),
    write('Enter Node B ID: '), read(B),
    ( retract(link(A, B, _, _)) ->
        write('Connection removed successfully!'), nl
    ;
        write('ERROR: Connection between these nodes does not exist!'), nl
    ).
% --- RF4: Robot Status ---
read_existing_robot_status_id(ID) :-
    repeat,
    write('Enter Robot ID to update: '),
    read(ID),
    ( op_status(ID, _, _, _, _) ->
        !
    ;
        write('Error: Robot ID does not have registered status. Please try again.'), nl,
        fail
    ).

read_valid_location_node(Loc) :-
    repeat,
    write('Enter Location Node ID: '),
    read(Loc),
    ( node(Loc, _) ->
        !
    ;
        write('Error: Location Node ID does not exist. Please try again.'), nl,
        fail
    ).

register_status :-
    write('Enter Robot ID: '), read(ID),
    ( robot(ID, _, _, _, _, _, _) ->
        true
    ;
        write('Error: Robot ID does not exist!'), nl,
        !
    ),

    write('Enter Location Node ID: '), read(Loc),
    ( node(Loc, _) ->
        true
    ;
        write('Error: Location Node ID does not exist!'), nl,
        !
    ),

    write('Enter Battery Level (%): '), read(Bat),
    write('Enter Mission Status (idle, transporting, etc.): '), read(Status),
    write('Enter Load ID (or none): '), read(Load),

    assertz(op_status(ID, Loc, Bat, Status, Load)),
    write('Status registered successfully!'), nl.


update_status :-
    read_existing_robot_status_id(ID),

    read_valid_location_node(Loc),

    write('Enter new Battery Level (%): '), read(Bat),
    write('Enter new Mission Status: '), read(Status),
    write('Enter new Load ID: '), read(Load),

    retract(op_status(ID, _, _, _, _)),
    assertz(op_status(ID, Loc, Bat, Status, Load)),

    write('Status updated successfully!'), nl.

% AUXILIARY PREDICATES FOR RF5
read_new_order_id(ID) :-
    repeat,
    write('Enter Order ID: '),
    read(ID),
    ( order(ID, _, _, _, _) ->
        write('Error: Order ID already exists. Please choose another.'), nl,
        fail
    ;
        !
    ).

read_existing_order_id(ID) :-
    repeat,
    write('Enter Order ID: '),
    read(ID),
    ( order(ID, _, _, _, _) ->
        !
    ;
        write('Error: Order ID does not exist. Please try again.'), nl,
        fail
    ).

read_valid_destination_node(Dest) :-
    repeat,
    write('Enter Destination Node ID: '),
    read(Dest),
    ( node(Dest, _) ->
        !
    ;
        write('Error: Destination Node ID does not exist. Please try again.'), nl,
        fail
    ).

read_valid_urgency(Urg) :-
    repeat,
    write('Enter Urgency (1 = high, 2 = medium, 3 = low): '),
    read(Urg),
    ( member(Urg, [1, 2, 3]) ->
        !
    ;
        write('Error: Urgency must be 1, 2, or 3. Please try again.'), nl,
        fail
    ).

valid_product_list([]).
valid_product_list([P|Rest]) :-
    product(P, _, _, _),
    valid_product_list(Rest).

read_valid_product_list(List) :-
    repeat,
    write('Enter List of Products (e.g., [1,2,3]): '),
    read(List),
    ( is_list(List), valid_product_list(List) ->
        !
    ;
        write('Error: Product list invalid. All product IDs must exist. Please try again.'), nl,
        fail
    ).

read_valid_order_status(Status) :-
    repeat,
    write('Enter Status (in quotes, e.g., ''Pending''): '),
    read(Status),
    ( member(Status, ['Pending', 'In_Transit', 'Delivered', 'Cancelled']) ->
        !
    ;
        write('Error: Invalid status. Use ''Pending'', ''In_Transit'', ''Delivered'' or ''Cancelled''.'), nl,
        fail
    ).

% RF5: DELIVERY ORDERS
create_order :-
    read_new_order_id(ID),
    read_valid_destination_node(Dest),
    read_valid_urgency(Urg),
    read_valid_product_list(List),
    read_valid_order_status(Status),

    assertz(order(ID, Dest, Urg, List, Status)),
    write('Order created successfully!'), nl.


update_order :-
    read_existing_order_id(ID),
    read_valid_destination_node(Dest),
    read_valid_urgency(Urg),
    read_valid_product_list(List),
    read_valid_order_status(Status),

    retract(order(ID, _, _, _, _)),
    assertz(order(ID, Dest, Urg, List, Status)),
    write('Order updated successfully!'), nl.


remove_order :-
    read_existing_order_id(ID),
    retract(order(ID, _, _, _, _)),
    write('Order removed successfully!'), nl.

% --- RF6: List available robots in a given area ---
list_available_robots :-
    repeat,
    write('Enter Node ID to search for idle robots: '),
    read(NodeID),
    
    % Verifica se o nó existe, se sim corta o repeat (!), se não, falha e repete
    ( node(NodeID, _) ->
        !
    ;
        write('ERROR: Node ID does not exist in the territory. Please try again.'), nl,
        fail
    ),

    % Procura todos os robôs no NodeID que estejam 'idle'
    findall(RobotID, op_status(RobotID, NodeID, _, idle, _), Robots),

    % Mostra o resultado (com um ÚNICO ponto final no fecho da regra)
    ( Robots == [] ->
        format('No available robots at Node ~w right now.~n', [NodeID])
    ;
        format('Available (idle) robots at Node ~w: ~w~n', [NodeID, Robots])
    ).

% --- RF7: Check current status of a specific robot ---
check_robot_status :-
    write('Enter Robot ID to check: '), read(ID),
    (op_status(ID, Loc, Bat, Status, Load) ->
        format('>>> Robot ~w Status <<<~n', [ID]),
        format('Location: Node ~w~n', [Loc]),
        format('Battery: ~w%~n', [Bat]),
        format('Mission: ~w~n', [Status]),
        format('Load ID: ~w~n', [Load])
    ;
        write('Error: Robot not found in operations table.'), nl
    ).

% ESTAMOS AQUI


% --- RF8: List available charging stations in given area or near a robot---
list_charging_stations_robot :-
    write('Enter Robot ID: '), read(RobotID),
    write('Enter search radius: '), read(SearchRad),
    ( robot(RobotID, RobotType, _, _, _, _, _) -> true ; write('ERROR: Robot not found.'), nl, fail ),
    ( op_status(RobotID, RobotLoc, _, _, _) -> true ; write('ERROR: Robot has no registered location.'), nl, fail ),
    findall(cp(ID, Name, Kind, Speed, Distance),
        ( available_charge_point(ID, Name, Kind, Speed),
          shortest_path_for_robot(RobotID, RobotLoc, ID, p(_, Distance)),
          Distance =< SearchRad
        ),
        Points),
    format('--- Available charging points for Robot ~w (~w) from Node ~w ---~n', [RobotID, RobotType, RobotLoc]),
    print_charge_points(Points).

list_charging_stations_node :-
    write('Enter Node ID: '), read(NodeID),
    write('Enter search radius: '), read(SearchRad),
    ( node(NodeID, _) -> true ; write('ERROR: Node not found.'), nl, fail ),
    findall(cp(ID, Name, Kind, Speed, Distance),
        ( available_charge_point(ID, Name, Kind, Speed),
          shortest_path(NodeID, ID, p(_, Distance)),
          Distance =< SearchRad
        ),
        Points),
    format('--- Available charging points from Node ~w ---~n', [NodeID]),
    print_charge_points(Points).

% --- RF9: Determine delivery capability (capacity + supplier route + battery + status check) ---
check_robot_delivery_capability :-
    write('Enter Robot ID: '), read(RobotID),
    write('Enter Order ID: '), read(OrderID),

    % Fetch Robot data
    ( robot(RobotID, RobotType, R_Vol, R_Weight, _, _, _) -> true ; write('Robot not found!'), nl, fail ),

    % Fetch Order and load/product data
    ( order(OrderID, DestNode, _, ProductList, OrderStatus) -> true ; write('Order not found!'), nl, fail ),
    ( order_load_requirements(OrderID, L_Vol, L_Weight) -> true ; write('Could not calculate load requirements for this order!'), nl, fail ),

    % Fetch Robot operational data
    ( op_status(RobotID, CurrentLoc, CurrentBatPercent, MissionStatus, LoadID) ->
        true
    ;
        write('Robot has no operational status/location registered!'), nl,
        fail
    ),

    format('Checking if Robot ~w (~w) can perform Order ~w...~n', [RobotID, RobotType, OrderID]),
    format('Order destination: Node ~w | Order status: ~w | Products: ~w~n', [DestNode, OrderStatus, ProductList]),
    format('Robot Capacity -> Volume: ~w | Weight: ~w~n', [R_Vol, R_Weight]),
    format('Order Required -> Volume: ~w | Weight: ~w~n', [L_Vol, L_Weight]),

    ( L_Vol =< R_Vol, L_Weight =< R_Weight ->
        write('CAPACITY: [OK] Robot can physically carry this order load.'), nl,
        check_robot_assignment_status(RobotID, OrderID, CurrentLoc, CurrentBatPercent, MissionStatus, LoadID)
    ;
        write('RESULT: [NO] Robot CANNOT carry this order because the load exceeds capacity.'), nl
    ).

% --- RF10: Determine the shortest route between two nodes ---
shortest_route_menu :-
    write('Enter start node ID: '), read(Start),
    write('Enter end node ID: '), read(End),

    ( \+ node(Start, _) ->
        write('ERROR: Start node does not exist.'), nl
    ; \+ node(End, _) ->
        write('ERROR: End node does not exist.'), nl
    ; shortest_path(Start, End, p(Path, Distance)) ->
        format('Shortest route from Node ~w to Node ~w:~n', [Start, End]),
        print_path(Path),
        format('Total distance: ~w~n', [Distance])
    ;
        write('ERROR: No route found between these nodes.'), nl
    ).

print_path([]).

print_path([link(A, B, D, Type) | Rest]) :-
    format('~w -> ~w | Distance: ~w | Type: ~w~n', [A, B, D, Type]),
    print_path(Rest).

% --- RF11: Determine the route with the lowest energy consumption ---
lowest_energy_route_menu :-
    write('Enter Robot ID: '), read(RobotID),
    write('Enter start node ID: '), read(Start),
    write('Enter end node ID: '), read(End),

    ( \+ robot(RobotID, _, _, _, _, _, _) ->
        write('ERROR: Robot does not exist.'), nl
    ; \+ node(Start, _) ->
        write('ERROR: Start node does not exist.'), nl
    ; \+ node(End, _) ->
        write('ERROR: End node does not exist.'), nl
    ; lowest_energy_route(RobotID, Start, End, BestPath, BestDistance, BestEnergy) ->
        format('Lowest energy route for Robot ~w from Node ~w to Node ~w:~n', [RobotID, Start, End]),
        print_path(BestPath),
        format('Total distance: ~w~n', [BestDistance]),
        format('Energy consumption: ~2f~n', [BestEnergy])
    ;
        write('ERROR: No compatible route found for this robot.'), nl
    ).

% --- RF12: Determine routes that include intermediate distribution points ---
route_with_hub_menu :-
    write('Enter start node ID: '), read(Start),
    write('Enter end node ID: '), read(End),

    ( \+ node(Start, _) ->
        write('ERROR: Start node does not exist.'), nl
    ; \+ node(End, _) ->
        write('ERROR: End node does not exist.'), nl
    ; best_route_with_hub(Start, End, HubID, FullPath, TotalDistance) ->
        format('Best route from Node ~w to Node ~w using Hub ~w:~n', [Start, End, HubID]),
        print_path(FullPath),
        format('Total distance: ~w~n', [TotalDistance])
    ;
        write('ERROR: No valid route through an available hub was found.'), nl
    ).

% --- RF13: Determine routes that include charging stations ---
route_with_charging_menu :-
    write('Enter Robot ID: '), read(RobotID),
    write('Enter start node ID: '), read(Start),
    write('Enter end node ID: '), read(End),

    ( \+ robot(RobotID, _, _, _, _, _, _) ->
        write('ERROR: Robot does not exist.'), nl
    ; \+ node(Start, _) ->
        write('ERROR: Start node does not exist.'), nl
    ; \+ node(End, _) ->
        write('ERROR: End node does not exist.'), nl
    ; route_with_charging(RobotID, Start, End, ChargeID, FullPath, TotalDistance, TotalEnergy) ->
        format('Best route for Robot ~w using charging station ~w:~n', [RobotID, ChargeID]),
        print_path(FullPath),
        format('Total distance: ~w~n', [TotalDistance]),
        format('Total energy needed: ~2f~n', [TotalEnergy])
    ;
        write('ERROR: No valid route through an available charging station was found.'), nl
    ).


% --- RF14: Select the best robot for a delivery ---
% RF14 works in two clean passes:
%   PASS 1: choose the best idle robot that can collect from suppliers and deliver
%           using its current battery.
%   PASS 2: only if PASS 1 has no solution and at least one otherwise-valid robot
%           failed only because of battery, retry with charging stops.
%
% Debug is now summary-based. It does NOT print the full analysis for every robot.
best_robot_menu :-
    write('Enter Order ID: '), read(OrderID),
    nl,
    write('--- RF14: Select the best robot for a delivery ---'), nl,

    ( \+ order(OrderID, _, _, _, _) ->
        write('ERROR: Order does not exist.'), nl
    ; order(OrderID, DestNode, Urgency, ProductList, OrderStatus),
      OrderStatus == 'In_Transit' ->
        format('ERROR: Order ~w is already In_Transit and cannot be assigned again.~n', [OrderID]),
        format('Order details -> Destination: Node ~w | Urgency: ~w | Products: ~w | Status: ~w~n',
               [DestNode, Urgency, ProductList, OrderStatus])
    ; \+ order_load_requirements(OrderID, _, _) ->
        write('ERROR: Could not calculate load requirements for this order.'), nl
    ;
        rf14_print_order_summary(OrderID),
        order_products_missing_suppliers(OrderID, MissingProducts),
        ( MissingProducts \= [] ->
            format('SUPPLIERS: [NO] Products without registered supplier: ~w~n', [MissingProducts]),
            write('ERROR: No robot can be selected until all products have suppliers.'), nl
        ;
            write('SUPPLIERS: [OK] Every product has at least one registered supplier.'), nl,
            rf14_print_candidate_summary(OrderID),
            ( best_robot_for_order(OrderID, RobotID, Path, Distance, Energy, Mode, ChargeStops, ChargePoints) ->
                rf14_print_final_result(OrderID, RobotID, Path, Distance, Energy, Mode, ChargeStops, ChargePoints)
            ;
                write('ERROR: No available robot can perform this order, even with charging fallback.'), nl
            )
        )
    ).

rf14_print_order_summary(OrderID) :-
    order(OrderID, DestNode, Urgency, ProductList, OrderStatus),
    order_load_requirements(OrderID, LVol, LWeight),
    format('Order ~w details -> Destination: Node ~w | Urgency: ~w | Products: ~w | Status: ~w~n',
           [OrderID, DestNode, Urgency, ProductList, OrderStatus]),
    format('Order load requirements -> Volume: ~w | Weight: ~w~n', [LVol, LWeight]).

% Compact candidate report: counts only, no per-robot route dumps.
rf14_print_candidate_summary(OrderID) :-
    findall(R, rf14_idle_capacity_route_candidate(OrderID, R, _, _, _, _, _, _), CandidateRobotsRaw),
    sort(CandidateRobotsRaw, CandidateRobots),
    length(CandidateRobots, CandidateCount),
    findall(R, robot_can_do_order_option(OrderID, R, _, _, _), DirectRobotsRaw),
    sort(DirectRobotsRaw, DirectRobots),
    length(DirectRobots, DirectCount),
    findall(R, rf14_battery_limited_candidate(OrderID, R, _, _, _, _, _, _), BatteryRobotsRaw),
    sort(BatteryRobotsRaw, BatteryRobots),
    length(BatteryRobots, BatteryCount),
    nl,
    write('--- RF14 SUMMARY ---'), nl,
    format('Idle robots with capacity and supplier-compatible route: ~w -> ~w~n', [CandidateCount, CandidateRobots]),
    format('PASS 1 direct valid robots: ~w -> ~w~n', [DirectCount, DirectRobots]),
    ( DirectCount > 0 ->
        write('PASS 2 charging fallback: skipped because at least one robot can do the delivery without charging.'), nl
    ;
        format('PASS 2 battery-limited candidates: ~w -> ~w~n', [BatteryCount, BatteryRobots]),
        ( BatteryCount =:= 0 ->
            write('PASS 2 charging fallback: skipped because no robot failed only because of battery.'), nl
        ;
            write('PASS 2 charging fallback: enabled. Searching bounded charging routes...'), nl
        )
    ).

% Backwards-compatible RF14 predicate for older calls.
best_robot_for_order(OrderID, BestRobotID, BestPath, BestDistance, BestEnergy) :-
    best_robot_for_order(OrderID, BestRobotID, BestPath, BestDistance, BestEnergy, _, _, _).

% PASS 1: best direct option, no charging.
best_robot_for_order(OrderID, BestRobotID, BestPath, BestDistance, BestEnergy, direct, 0, []) :-
    findall(
        robot_option(RobotID, Path, Distance, Energy),
        robot_can_do_order_option(OrderID, RobotID, Path, Distance, Energy),
        Options
    ),
    Options \= [],
    best_robot_from_list(Options, robot_option(BestRobotID, BestPath, BestDistance, BestEnergy)),
    !.

% PASS 2: fallback using charging stops. This only runs when PASS 1 has no option
% and at least one robot failed only because of battery.
best_robot_for_order(OrderID, BestRobotID, BestPath, BestDistance, BestEnergy, charging, ChargeStops, ChargePoints) :-
    findall(
        robot_option(RobotID, Path, Distance, Energy),
        robot_can_do_order_option(OrderID, RobotID, Path, Distance, Energy),
        DirectOptions
    ),
    DirectOptions == [],
    findall(RobotID, rf14_battery_limited_candidate(OrderID, RobotID, _, _, _, _, _, _), BatteryBlockedRobots),
    BatteryBlockedRobots \= [],
    findall(
        robot_charge_option(RobotID, Path, Distance, Energy, Stops, Points),
        robot_can_do_order_with_charging_option(OrderID, RobotID, Path, Distance, Energy, Stops, Points),
        ChargingOptions
    ),
    ChargingOptions \= [],
    best_charged_robot_from_list(
        ChargingOptions,
        robot_charge_option(BestRobotID, BestPath, BestDistance, BestEnergy, ChargeStops, ChargePoints)
    ).

% Robot is idle, has capacity, and has a supplier-aware route. Battery is not
% checked here; this is used for summary and for the fallback gate.
rf14_idle_capacity_route_candidate(OrderID, RobotID, Path, Distance, Energy, Available, SupplierNodes, VisitOrder) :-
    order_load_requirements(OrderID, LVol, LWeight),
    robot(RobotID, _, RVol, RWeight, _, _, Consumption),
    op_status(RobotID, CurrentLoc, _, idle, none),
    LVol =< RVol,
    LWeight =< RWeight,
    best_order_route_via_suppliers(RobotID, CurrentLoc, OrderID, Path, Distance, SupplierNodes, VisitOrder),
    Energy is Distance * Consumption,
    battery_available_units(RobotID, Available).

% PASS 1 option: same as above, but energy must fit in current battery.
robot_can_do_order_option(OrderID, RobotID, Path, Distance, Energy) :-
    rf14_idle_capacity_route_candidate(OrderID, RobotID, Path, Distance, Energy, Available, _, _),
    Energy =< Available.

% A robot reaches fallback only when it is otherwise valid but failed because of battery.
rf14_battery_limited_candidate(OrderID, RobotID, Path, Distance, Energy, Available, SupplierNodes, VisitOrder) :-
    rf14_idle_capacity_route_candidate(OrderID, RobotID, Path, Distance, Energy, Available, SupplierNodes, VisitOrder),
    Energy > Available.

% PASS 2 option: bounded charging route. This prevents the previous broad
% recursive search from hanging.
robot_can_do_order_with_charging_option(OrderID, RobotID, Path, Distance, Energy, ChargeStops, ChargePoints) :-
    rf14_battery_limited_candidate(OrderID, RobotID, _, _, _, _, _, _),
    best_order_route_via_suppliers_with_charging(
        RobotID, _, OrderID, Path, Distance, Energy, _, _, ChargeStops, ChargePoints, _
    ).

rf14_print_final_result(OrderID, RobotID, Path, Distance, Energy, Mode, ChargeStops, ChargePoints) :-
    nl,
    write('--- RF14 FINAL RESULT ---'), nl,
    format('Best robot for Order ~w: Robot ~w~n', [OrderID, RobotID]),
    ( Mode == direct ->
        write('Selection mode: direct route without charging.'), nl,
        write('Charging: not needed.'), nl
    ;
        write('Selection mode: charging fallback.'), nl,
        format('Charging stops needed: ~w~n', [ChargeStops]),
        write('Chosen charging points:'), nl,
        print_charge_visit_details(ChargePoints)
    ),
    write('Chosen path:'), nl,
    print_path(Path),
    format('Total distance: ~w~n', [Distance]),
    format('Energy needed for movement: ~2f~n', [Energy]).

print_charge_visit_details([]) :-
    write('  none'), nl.
print_charge_visit_details([ChargeNode | Rest]) :-
    ( available_charge_point(ChargeNode, Name, Kind, Speed) ->
        format('  ~w Node ~w (~w) | Charge speed: ~w~n', [Kind, ChargeNode, Name, Speed])
    ;
        format('  Node ~w~n', [ChargeNode])
    ),
    print_charge_visit_details(Rest).

best_robot_from_list([Option], Option).
best_robot_from_list(
    [robot_option(Robot1, Path1, Dist1, Energy1),
     robot_option(_, _, _, Energy2) | Rest],
    Best
) :-
    Energy1 =< Energy2,
    best_robot_from_list([robot_option(Robot1, Path1, Dist1, Energy1) | Rest], Best).
best_robot_from_list(
    [robot_option(_, _, _, Energy1),
     robot_option(Robot2, Path2, Dist2, Energy2) | Rest],
    Best
) :-
    Energy1 > Energy2,
    best_robot_from_list([robot_option(Robot2, Path2, Dist2, Energy2) | Rest], Best).

best_charged_robot_from_list([Option], Option).
best_charged_robot_from_list(
    [robot_charge_option(Robot1, Path1, Dist1, Energy1, Stops1, Points1),
     robot_charge_option(_, _, Dist2, Energy2, Stops2, _) | Rest],
    Best
) :-
    charged_option_better_or_equal(Stops1, Energy1, Dist1, Stops2, Energy2, Dist2),
    best_charged_robot_from_list([robot_charge_option(Robot1, Path1, Dist1, Energy1, Stops1, Points1) | Rest], Best).
best_charged_robot_from_list(
    [robot_charge_option(_, _, Dist1, Energy1, Stops1, _),
     robot_charge_option(Robot2, Path2, Dist2, Energy2, Stops2, Points2) | Rest],
    Best
) :-
    \+ charged_option_better_or_equal(Stops1, Energy1, Dist1, Stops2, Energy2, Dist2),
    best_charged_robot_from_list([robot_charge_option(Robot2, Path2, Dist2, Energy2, Stops2, Points2) | Rest], Best).

charged_option_better_or_equal(Stops1, Energy1, Dist1, Stops2, Energy2, Dist2) :-
    ( Stops1 < Stops2 -> true
    ; Stops1 =:= Stops2, Energy1 < Energy2 -> true
    ; Stops1 =:= Stops2, Energy1 =:= Energy2, Dist1 =< Dist2
    ).

% Supplier-aware route planner with bounded charging fallback.
% It still allows more than one charge, but avoids the previous unbounded recursion.
best_order_route_via_suppliers_with_charging(
    RobotID, Start, OrderID, BestPath, BestDistance, BestEnergy,
    BestSupplierNodes, BestVisitOrder, BestChargeStops, BestChargePoints, BestFinalBattery
) :-
    ( nonvar(Start) -> EffectiveStart = Start ; op_status(RobotID, EffectiveStart, _, _, _) ),
    battery_available_units(RobotID, StartBattery),
    findall(
        charged_supplier_route(SupplierNodes, VisitOrder, Path, Distance, Energy, ChargeStops, ChargePoints, FinalBattery),
        (
            order(OrderID, Destination, _, _, _),
            order_supplier_nodes_option(OrderID, SupplierNodes),
            permutation(SupplierNodes, VisitOrder),
            build_charging_route_for_visit_order(
                RobotID, EffectiveStart, VisitOrder, Destination, StartBattery,
                Path, Distance, Energy, FinalBattery, ChargeStops, ChargePoints
            )
        ),
        Routes
    ),
    best_charging_supplier_route(
        Routes,
        charged_supplier_route(BestSupplierNodes, BestVisitOrder, BestPath, BestDistance, BestEnergy, BestChargeStops, BestChargePoints, BestFinalBattery)
    ).

build_charging_route_for_visit_order(
    RobotID, Start, VisitOrder, Destination, StartBattery,
    FullPath, TotalDistance, TotalEnergy, FinalBattery, ChargeStops, ChargePoints
) :-
    append(VisitOrder, [Destination], Stops),
    build_charging_route_through_points(
        RobotID, Start, Stops, StartBattery,
        FullPath, TotalDistance, TotalEnergy, FinalBattery, ChargeStops, ChargePoints
    ).

build_charging_route_through_points(_, _, [], Battery, [], 0, 0, Battery, 0, []).
build_charging_route_through_points(
    RobotID, Current, [Next | Rest], BatteryIn,
    FullPath, TotalDistance, TotalEnergy, FinalBattery, TotalChargeStops, ChargePoints
) :-
    best_route_leg_with_charging_bounded(
        RobotID, Current, Next, BatteryIn,
        LegPath, LegDistance, LegEnergy, BatteryAfterLeg, LegChargeStops, LegChargePoints
    ),
    build_charging_route_through_points(
        RobotID, Next, Rest, BatteryAfterLeg,
        RestPath, RestDistance, RestEnergy, FinalBattery, RestChargeStops, RestChargePoints
    ),
    append(LegPath, RestPath, FullPath),
    append(LegChargePoints, RestChargePoints, ChargePoints),
    TotalDistance is LegDistance + RestDistance,
    TotalEnergy is LegEnergy + RestEnergy,
    TotalChargeStops is LegChargeStops + RestChargeStops.

% For each leg, try 0, 1, or 2 charges and choose the best option.
% This supports charging more than once between two required points, but keeps the search finite.
best_route_leg_with_charging_bounded(RobotID, From, To, BatteryIn, BestPath, BestDistance, BestEnergy, BestBatteryOut, BestStops, BestChargePoints) :-
    findall(
        leg_option(Path, Distance, Energy, BatteryOut, Stops, Points),
        route_leg_with_charging_bounded_option(RobotID, From, To, BatteryIn, Path, Distance, Energy, BatteryOut, Stops, Points),
        Options
    ),
    best_leg_option_from_list(Options, leg_option(BestPath, BestDistance, BestEnergy, BestBatteryOut, BestStops, BestChargePoints)).

route_leg_with_charging_bounded_option(RobotID, From, To, BatteryIn, Path, Distance, Energy, BatteryOut, 0, []) :-
    shortest_path_for_robot(RobotID, From, To, p(Path, Distance)),
    battery_needed_for_distance(RobotID, Distance, Energy),
    Energy =< BatteryIn,
    BatteryOut is BatteryIn - Energy.
route_leg_with_charging_bounded_option(RobotID, From, To, BatteryIn, FullPath, TotalDistance, TotalEnergy, BatteryOut, 1, [Charge1]) :-
    available_charge_point(Charge1, _, _, _),
    shortest_leg_if_reachable(RobotID, From, Charge1, BatteryIn, Path1, Dist1, Energy1),
    robot(RobotID, _, _, _, _, MaxBattery, _),
    shortest_leg_if_reachable(RobotID, Charge1, To, MaxBattery, Path2, Dist2, Energy2),
    append(Path1, Path2, FullPath),
    TotalDistance is Dist1 + Dist2,
    TotalEnergy is Energy1 + Energy2,
    BatteryOut is MaxBattery - Energy2.
route_leg_with_charging_bounded_option(RobotID, From, To, BatteryIn, FullPath, TotalDistance, TotalEnergy, BatteryOut, 2, [Charge1, Charge2]) :-
    available_charge_point(Charge1, _, _, _),
    available_charge_point(Charge2, _, _, _),
    Charge1 \== Charge2,
    shortest_leg_if_reachable(RobotID, From, Charge1, BatteryIn, Path1, Dist1, Energy1),
    robot(RobotID, _, _, _, _, MaxBattery, _),
    shortest_leg_if_reachable(RobotID, Charge1, Charge2, MaxBattery, Path2, Dist2, Energy2),
    shortest_leg_if_reachable(RobotID, Charge2, To, MaxBattery, Path3, Dist3, Energy3),
    append(Path1, Path2, TempPath),
    append(TempPath, Path3, FullPath),
    TotalDistance is Dist1 + Dist2 + Dist3,
    TotalEnergy is Energy1 + Energy2 + Energy3,
    BatteryOut is MaxBattery - Energy3.

shortest_leg_if_reachable(_, From, From, _, [], 0, 0).
shortest_leg_if_reachable(RobotID, From, To, BatteryIn, Path, Distance, Energy) :-
    From \== To,
    shortest_path_for_robot(RobotID, From, To, p(Path, Distance)),
    battery_needed_for_distance(RobotID, Distance, Energy),
    Energy =< BatteryIn.

best_leg_option_from_list([Option], Option).
best_leg_option_from_list(
    [leg_option(Path1, Dist1, Energy1, Battery1, Stops1, Points1),
     leg_option(_, Dist2, Energy2, _, Stops2, _) | Rest],
    Best
) :-
    charged_option_better_or_equal(Stops1, Energy1, Dist1, Stops2, Energy2, Dist2),
    best_leg_option_from_list([leg_option(Path1, Dist1, Energy1, Battery1, Stops1, Points1) | Rest], Best).
best_leg_option_from_list(
    [leg_option(_, Dist1, Energy1, _, Stops1, _),
     leg_option(Path2, Dist2, Energy2, Battery2, Stops2, Points2) | Rest],
    Best
) :-
    \+ charged_option_better_or_equal(Stops1, Energy1, Dist1, Stops2, Energy2, Dist2),
    best_leg_option_from_list([leg_option(Path2, Dist2, Energy2, Battery2, Stops2, Points2) | Rest], Best).

best_charging_supplier_route([Route], Route).
best_charging_supplier_route(
    [charged_supplier_route(Sup1, Visit1, Path1, Dist1, Energy1, Stops1, Points1, FinalBat1),
     charged_supplier_route(_, _, _, Dist2, Energy2, Stops2, _, _) | Rest],
    Best
) :-
    charged_option_better_or_equal(Stops1, Energy1, Dist1, Stops2, Energy2, Dist2),
    best_charging_supplier_route(
        [charged_supplier_route(Sup1, Visit1, Path1, Dist1, Energy1, Stops1, Points1, FinalBat1) | Rest],
        Best
    ).
best_charging_supplier_route(
    [charged_supplier_route(_, _, _, Dist1, Energy1, Stops1, _, _),
     charged_supplier_route(Sup2, Visit2, Path2, Dist2, Energy2, Stops2, Points2, FinalBat2) | Rest],
    Best
) :-
    \+ charged_option_better_or_equal(Stops1, Energy1, Dist1, Stops2, Energy2, Dist2),
    best_charging_supplier_route(
        [charged_supplier_route(Sup2, Visit2, Path2, Dist2, Energy2, Stops2, Points2, FinalBat2) | Rest],
        Best
    ).



% -------------------------------
% RF15: Grouped/bulk deliveries
% -------------------------------
% RF15 now considers two mission models:
%   1) no-hub grouped delivery: one robot collects from all required suppliers
%      and delivers the grouped orders directly to the destination node(s);
%   2) hub-assisted grouped delivery: one or more collector robots gather loads
%      from suppliers, consolidate them at an available hub, and one of those
%      robots performs the final bulk delivery.
%
% In the hub-assisted model, RF15 does NOT force one robot per supplier. A
% collector robot may be assigned multiple supplier loads when its capacity,
% battery/autonomy and route compatibility allow it.

grouped_delivery_menu :-
    write('Enter list of Order IDs for grouped delivery (e.g., [20] or [7,8,9]): '),
    read(OrderIDsInput),
    nl,
    write('--- RF15: Grouped/bulk delivery planning ---'), nl,
    ( \+ is_list(OrderIDsInput) ->
        write('ERROR: Please enter a Prolog list, for example [20] or [7,8,9].'), nl
    ; OrderIDsInput == [] ->
        write('ERROR: The grouped delivery list cannot be empty.'), nl
    ;
        sort(OrderIDsInput, OrderIDs),
        rf15_validate_and_run(OrderIDs)
    ).

rf15_validate_and_run(OrderIDs) :-
    rf15_missing_orders(OrderIDs, MissingOrders),
    rf15_non_pending_orders(OrderIDs, NonPendingOrders),
    ( MissingOrders \= [] ->
        format('ERROR: These orders do not exist: ~w~n', [MissingOrders])
    ; NonPendingOrders \= [] ->
        format('ERROR: RF15 only groups Pending orders. Invalid orders/statuses: ~w~n', [NonPendingOrders])
    ; order_products_missing_suppliers_for_orders(OrderIDs, MissingProducts),
      MissingProducts \= [] ->
        format('ERROR: These products have no registered supplier: ~w~n', [MissingProducts])
    ;
        rf15_print_group_summary(OrderIDs),
        ( best_rf15_grouped_delivery_plan(OrderIDs, BestPlan, DirectCount, HubCount) ->
            format('Candidate plans found -> No-hub: ~w | Hub-assisted: ~w~n', [DirectCount, HubCount]),
            rf15_print_plan(BestPlan)
        ;
            write('RESULT: [NO] No valid grouped delivery plan was found.'), nl,
            write('Reason may be capacity, route compatibility, battery/autonomy, hub availability, or robot status.'), nl
        )
    ).

rf15_missing_orders(OrderIDs, MissingOrders) :-
    findall(OrderID,
        ( member(OrderID, OrderIDs),
          \+ order(OrderID, _, _, _, _)
        ),
        MissingOrders).

rf15_non_pending_orders(OrderIDs, NonPendingOrders) :-
    findall(OrderID-Status,
        ( member(OrderID, OrderIDs),
          order(OrderID, _, _, _, Status),
          Status \== 'Pending'
        ),
        NonPendingOrders).

rf15_group_products(OrderIDs, Products) :-
    findall(ProductID,
        ( member(OrderID, OrderIDs),
          order(OrderID, _, _, ProductList, _),
          member(ProductID, ProductList)
        ),
        Products).

order_products_missing_suppliers_for_orders(OrderIDs, MissingProducts) :-
    rf15_group_products(OrderIDs, Products),
    sort(Products, UniqueProducts),
    findall(ProductID,
        ( member(ProductID, UniqueProducts),
          \+ product_has_supplier(ProductID)
        ),
        MissingProducts).

rf15_group_destinations(OrderIDs, Destinations) :-
    findall(Destination,
        ( member(OrderID, OrderIDs),
          order(OrderID, Destination, _, _, _)
        ),
        RawDestinations),
    sort(RawDestinations, Destinations).

rf15_orders_load_requirements([], 0, 0).
rf15_orders_load_requirements([OrderID | Rest], TotalVolume, TotalWeight) :-
    order_load_requirements(OrderID, Volume, Weight),
    rf15_orders_load_requirements(Rest, RestVolume, RestWeight),
    TotalVolume is Volume + RestVolume,
    TotalWeight is Weight + RestWeight.

rf15_supplier_loads_for_orders(OrderIDs, SupplierLoads) :-
    rf15_group_products(OrderIDs, Products),
    findall(SupplierID-ProductID,
        ( member(ProductID, Products),
          once(product_supplier(ProductID, SupplierID))
        ),
        Assignments),
    rf15_supplier_loads_from_assignments(Assignments, SupplierLoads).

rf15_supplier_loads_from_assignments(Assignments, SupplierLoads) :-
    findall(SupplierID, member(SupplierID-_, Assignments), SupplierIDsRaw),
    sort(SupplierIDsRaw, SupplierIDs),
    rf15_build_supplier_loads(SupplierIDs, Assignments, SupplierLoads).

rf15_build_supplier_loads([], _, []).
rf15_build_supplier_loads([SupplierID | Rest], Assignments,
                          [supplier_load(SupplierID, Products, Volume, Weight) | RestLoads]) :-
    findall(ProductID, member(SupplierID-ProductID, Assignments), Products),
    order_products_totals(Products, Volume, Weight),
    rf15_build_supplier_loads(Rest, Assignments, RestLoads).

rf15_supplier_nodes([], []).
rf15_supplier_nodes([supplier_load(SupplierID, _, _, _) | Rest], [SupplierID | RestIDs]) :-
    rf15_supplier_nodes(Rest, RestIDs).

rf15_supplier_loads_totals([], [], 0, 0).
rf15_supplier_loads_totals([supplier_load(_, Products, Volume, Weight) | Rest], AllProducts, TotalVolume, TotalWeight) :-
    rf15_supplier_loads_totals(Rest, RestProducts, RestVolume, RestWeight),
    append(Products, RestProducts, AllProducts),
    TotalVolume is Volume + RestVolume,
    TotalWeight is Weight + RestWeight.

rf15_print_group_summary(OrderIDs) :-
    rf15_orders_load_requirements(OrderIDs, TotalVolume, TotalWeight),
    rf15_group_destinations(OrderIDs, Destinations),
    rf15_supplier_loads_for_orders(OrderIDs, SupplierLoads),
    nl,
    format('Grouped orders: ~w~n', [OrderIDs]),
    format('Delivery destinations: ~w~n', [Destinations]),
    format('Total grouped load -> Volume: ~w | Weight: ~w~n', [TotalVolume, TotalWeight]),
    write('Supplier pickup loads:'), nl,
    rf15_print_supplier_loads(SupplierLoads),
    nl.

rf15_print_supplier_loads([]).
rf15_print_supplier_loads([supplier_load(SupplierID, Products, Volume, Weight) | Rest]) :-
    ( supplier(SupplierID, SupplierName, _) -> true ; SupplierName = 'Unknown supplier' ),
    format('  Supplier Node ~w (~w) -> Products: ~w | Volume: ~w | Weight: ~w~n',
           [SupplierID, SupplierName, Products, Volume, Weight]),
    rf15_print_supplier_loads(Rest).

% ------------------------------------------------------------------
% Best RF15 plan across both models.
% Comparison favours:
%   1) fewer charging stops,
%   2) lower total movement energy,
%   3) shorter total distance,
%   4) fewer robots,
%   5) no-hub plan if everything else ties.
% ------------------------------------------------------------------

best_rf15_grouped_delivery_plan(OrderIDs, BestPlan, DirectCount, HubCount) :-
    findall(Plan, rf15_no_hub_plan(OrderIDs, Plan), DirectPlans),
    findall(Plan, rf15_hub_consolidation_plan(OrderIDs, Plan), HubPlans),
    length(DirectPlans, DirectCount),
    length(HubPlans, HubCount),
    append(DirectPlans, HubPlans, AllPlans),
    AllPlans \= [],
    best_rf15_plan_from_list(AllPlans, BestPlan).

% No-hub plan: one robot collects all supplier loads and performs all deliveries.
rf15_no_hub_plan(OrderIDs,
    rf15_no_hub_plan(RobotID, SupplierLoads, SupplierVisitOrder, Destinations, DestVisitOrder,
                     Path, Distance, Energy, ChargeStops, ChargePoints)
) :-
    rf15_supplier_loads_for_orders(OrderIDs, SupplierLoads),
    rf15_supplier_nodes(SupplierLoads, SupplierNodes),
    rf15_group_destinations(OrderIDs, Destinations),
    rf15_orders_load_requirements(OrderIDs, TotalVolume, TotalWeight),

    robot(RobotID, _, RobotVolumeCap, RobotWeightCap, _, _, _),
    op_status(RobotID, CurrentLoc, _, idle, none),
    TotalVolume =< RobotVolumeCap,
    TotalWeight =< RobotWeightCap,
    battery_available_units(RobotID, StartBattery),

    permutation(SupplierNodes, SupplierVisitOrder),
    permutation(Destinations, DestVisitOrder),
    append(SupplierVisitOrder, DestVisitOrder, FullVisitOrder),
    rf15_best_route_through_points_bounded(
        RobotID, CurrentLoc, FullVisitOrder, StartBattery,
        Path, Distance, Energy, _, ChargeStops, ChargePoints
    ).

% Hub-assisted plan: supplier loads may be grouped per collector robot. A robot
% may collect from one supplier or from several suppliers before going to the hub.
rf15_hub_consolidation_plan(OrderIDs,
    rf15_hub_plan(HubID, HubName, Collectors, FinalRobotID, Destinations, DestVisitOrder,
                  FinalPath, FinalDistance, FinalEnergy,
                  TotalDistance, TotalEnergy, TotalChargeStops, AllChargePoints)
) :-
    hub(HubID, HubName, 'Available', _),
    rf15_supplier_loads_for_orders(OrderIDs, SupplierLoads),
    rf15_group_destinations(OrderIDs, Destinations),
    rf15_orders_load_requirements(OrderIDs, TotalVolume, TotalWeight),

    rf15_assign_supplier_loads_to_robots(SupplierLoads, Assignments),
    rf15_group_assignments_by_robot(Assignments, RobotGroups),
    rf15_collectors_for_robot_groups(
        RobotGroups, HubID, Collectors, CollectorRobotIDs,
        CollectorsDistance, CollectorsEnergy, CollectorsChargeStops, CollectorsChargePoints
    ),

    member(FinalRobotID, CollectorRobotIDs),
    robot(FinalRobotID, _, FinalVolCap, FinalWeightCap, _, FinalMaxBattery, _),
    TotalVolume =< FinalVolCap,
    TotalWeight =< FinalWeightCap,

    rf15_best_destination_route_from_hub(
        FinalRobotID, HubID, Destinations, FinalMaxBattery,
        DestVisitOrder, FinalPath, FinalDistance, FinalEnergy,
        FinalChargeStops, FinalChargePoints
    ),

    append(CollectorsChargePoints, FinalChargePoints, AllChargePoints),
    TotalDistance is CollectorsDistance + FinalDistance,
    TotalEnergy is CollectorsEnergy + FinalEnergy,
    TotalChargeStops is CollectorsChargeStops + FinalChargeStops.

rf15_idle_robot(RobotID) :-
    robot(RobotID, _, _, _, _, _, _),
    op_status(RobotID, _, _, idle, none).

rf15_assign_supplier_loads_to_robots([], []).
rf15_assign_supplier_loads_to_robots([SupplierLoad | Rest], [assignment(RobotID, SupplierLoad) | RestAssignments]) :-
    rf15_idle_robot(RobotID),
    rf15_assign_supplier_loads_to_robots(Rest, RestAssignments).

rf15_group_assignments_by_robot(Assignments, RobotGroups) :-
    findall(RobotID, member(assignment(RobotID, _), Assignments), RobotIDsRaw),
    sort(RobotIDsRaw, RobotIDs),
    rf15_build_robot_groups(RobotIDs, Assignments, RobotGroups).

rf15_build_robot_groups([], _, []).
rf15_build_robot_groups([RobotID | Rest], Assignments, [robot_group(RobotID, SupplierLoads) | RestGroups]) :-
    findall(SupplierLoad, member(assignment(RobotID, SupplierLoad), Assignments), SupplierLoads),
    SupplierLoads \= [],
    rf15_build_robot_groups(Rest, Assignments, RestGroups).

rf15_collectors_for_robot_groups([], _, [], [], 0, 0, 0, []).
rf15_collectors_for_robot_groups(
    [RobotGroup | RestGroups], HubID,
    [Collector | RestCollectors], [RobotID | RestRobotIDs],
    TotalDistance, TotalEnergy, TotalChargeStops, AllChargePoints
) :-
    rf15_collector_group_option(RobotGroup, HubID, Collector),
    Collector = collector(RobotID, _, _, _, _, _, _, Distance, Energy, ChargeStops, ChargePoints),
    rf15_collectors_for_robot_groups(
        RestGroups, HubID,
        RestCollectors, RestRobotIDs,
        RestDistance, RestEnergy, RestChargeStops, RestChargePoints
    ),
    append(ChargePoints, RestChargePoints, AllChargePoints),
    TotalDistance is Distance + RestDistance,
    TotalEnergy is Energy + RestEnergy,
    TotalChargeStops is ChargeStops + RestChargeStops.

rf15_collector_group_option(
    robot_group(RobotID, SupplierLoads), HubID,
    collector(RobotID, SupplierIDs, SupplierVisitOrder, Products, Volume, Weight,
              Path, Distance, Energy, ChargeStops, ChargePoints)
) :-
    rf15_supplier_nodes(SupplierLoads, SupplierIDs),
    rf15_supplier_loads_totals(SupplierLoads, Products, Volume, Weight),
    robot(RobotID, _, RobotVolumeCap, RobotWeightCap, _, _, _),
    op_status(RobotID, CurrentLoc, _, idle, none),
    Volume =< RobotVolumeCap,
    Weight =< RobotWeightCap,
    battery_available_units(RobotID, StartBattery),
    rf15_best_collector_route_to_hub(
        RobotID, CurrentLoc, SupplierIDs, HubID, StartBattery,
        SupplierVisitOrder, Path, Distance, Energy, ChargeStops, ChargePoints
    ).

rf15_best_collector_route_to_hub(
    RobotID, CurrentLoc, SupplierIDs, HubID, StartBattery,
    BestSupplierVisitOrder, BestPath, BestDistance, BestEnergy, BestChargeStops, BestChargePoints
) :-
    findall(route_option(SupplierVisitOrder, Path, Distance, Energy, ChargeStops, ChargePoints),
        ( permutation(SupplierIDs, SupplierVisitOrder),
          append(SupplierVisitOrder, [HubID], VisitOrderWithHub),
          rf15_best_route_through_points_bounded(
              RobotID, CurrentLoc, VisitOrderWithHub, StartBattery,
              Path, Distance, Energy, _, ChargeStops, ChargePoints
          )
        ),
        Options),
    Options \= [],
    best_rf15_route_option_from_list(
        Options,
        route_option(BestSupplierVisitOrder, BestPath, BestDistance, BestEnergy, BestChargeStops, BestChargePoints)
    ).

rf15_best_destination_route_from_hub(
    RobotID, HubID, Destinations, StartBattery,
    BestDestVisitOrder, BestPath, BestDistance, BestEnergy, BestChargeStops, BestChargePoints
) :-
    findall(route_option(DestVisitOrder, Path, Distance, Energy, ChargeStops, ChargePoints),
        ( permutation(Destinations, DestVisitOrder),
          rf15_best_route_through_points_bounded(
              RobotID, HubID, DestVisitOrder, StartBattery,
              Path, Distance, Energy, _, ChargeStops, ChargePoints
          )
        ),
        Options),
    Options \= [],
    best_rf15_route_option_from_list(
        Options,
        route_option(BestDestVisitOrder, BestPath, BestDistance, BestEnergy, BestChargeStops, BestChargePoints)
    ).

best_rf15_route_option_from_list([Option], Option).
best_rf15_route_option_from_list(
    [route_option(Visit1, Path1, Dist1, Energy1, Stops1, Points1),
     route_option(_, _, Dist2, Energy2, Stops2, _) | Rest],
    Best
) :-
    charged_option_better_or_equal(Stops1, Energy1, Dist1, Stops2, Energy2, Dist2),
    best_rf15_route_option_from_list([route_option(Visit1, Path1, Dist1, Energy1, Stops1, Points1) | Rest], Best).
best_rf15_route_option_from_list(
    [route_option(_, _, Dist1, Energy1, Stops1, _),
     route_option(Visit2, Path2, Dist2, Energy2, Stops2, Points2) | Rest],
    Best
) :-
    \+ charged_option_better_or_equal(Stops1, Energy1, Dist1, Stops2, Energy2, Dist2),
    best_rf15_route_option_from_list([route_option(Visit2, Path2, Dist2, Energy2, Stops2, Points2) | Rest], Best).

best_rf15_plan_from_list([Plan], Plan).
best_rf15_plan_from_list([Plan1, Plan2 | Rest], Best) :-
    rf15_plan_better_or_equal(Plan1, Plan2),
    best_rf15_plan_from_list([Plan1 | Rest], Best).
best_rf15_plan_from_list([Plan1, Plan2 | Rest], Best) :-
    \+ rf15_plan_better_or_equal(Plan1, Plan2),
    best_rf15_plan_from_list([Plan2 | Rest], Best).

rf15_plan_metrics(
    rf15_no_hub_plan(_, _, _, _, _, _, Distance, Energy, ChargeStops, _),
    ChargeStops, Energy, Distance, 1, 0
).
rf15_plan_metrics(
    rf15_hub_plan(_, _, Collectors, _, _, _, _, _, _, TotalDistance, TotalEnergy, TotalChargeStops, _),
    TotalChargeStops, TotalEnergy, TotalDistance, RobotCount, 1
) :-
    rf15_collector_robot_ids(Collectors, RobotIDs),
    sort(RobotIDs, UniqueRobotIDs),
    length(UniqueRobotIDs, RobotCount).

rf15_collector_robot_ids([], []).
rf15_collector_robot_ids([collector(RobotID, _, _, _, _, _, _, _, _, _, _) | Rest], [RobotID | RestIDs]) :-
    rf15_collector_robot_ids(Rest, RestIDs).

rf15_plan_better_or_equal(Plan1, Plan2) :-
    rf15_plan_metrics(Plan1, Stops1, Energy1, Dist1, Robots1, TypeRank1),
    rf15_plan_metrics(Plan2, Stops2, Energy2, Dist2, Robots2, TypeRank2),
    ( Stops1 < Stops2 -> true
    ; Stops1 =:= Stops2, Energy1 < Energy2 -> true
    ; Stops1 =:= Stops2, Energy1 =:= Energy2, Dist1 < Dist2 -> true
    ; Stops1 =:= Stops2, Energy1 =:= Energy2, Dist1 =:= Dist2, Robots1 < Robots2 -> true
    ; Stops1 =:= Stops2, Energy1 =:= Energy2, Dist1 =:= Dist2, Robots1 =:= Robots2, TypeRank1 =< TypeRank2
    ).

rf15_print_plan(Plan) :-
    Plan = rf15_no_hub_plan(_, _, _, _, _, _, _, _, _, _),
    !,
    rf15_print_no_hub_plan(Plan).
rf15_print_plan(Plan) :-
    rf15_print_hub_plan(Plan).

rf15_print_no_hub_plan(
    rf15_no_hub_plan(RobotID, SupplierLoads, SupplierVisitOrder, Destinations, DestVisitOrder,
                     Path, Distance, Energy, ChargeStops, ChargePoints)
) :-
    nl,
    write('--- RF15 FINAL RESULT ---'), nl,
    write('RESULT: [YES] Grouped delivery can be executed by ONE robot without hub consolidation.'), nl,
    format('Selected robot: Robot ~w~n', [RobotID]),
    write('Supplier pickup loads:'), nl,
    rf15_print_supplier_loads(SupplierLoads),
    format('Supplier visit order: ~w~n', [SupplierVisitOrder]),
    format('Destination visit order: ~w from requested destinations ~w~n', [DestVisitOrder, Destinations]),
    format('Total route distance: ~w~n', [Distance]),
    format('Total movement energy: ~2f~n', [Energy]),
    format('Charging stops: ~w~n', [ChargeStops]),
    write('Charging points used:'), nl,
    print_charge_visit_details(ChargePoints),
    nl,
    write('Robot path:'), nl,
    print_path(Path).

rf15_print_hub_plan(
    rf15_hub_plan(HubID, HubName, Collectors, FinalRobotID, Destinations, DestVisitOrder,
                  FinalPath, FinalDistance, FinalEnergy,
                  TotalDistance, TotalEnergy, TotalChargeStops, AllChargePoints)
) :-
    nl,
    write('--- RF15 FINAL RESULT ---'), nl,
    write('RESULT: [YES] Grouped delivery can be executed using hub consolidation.'), nl,
    format('Consolidation hub: Node ~w (~w)~n', [HubID, HubName]),
    write('Collector assignments:'), nl,
    rf15_print_collectors(Collectors),
    nl,
    format('Final bulk delivery robot: Robot ~w~n', [FinalRobotID]),
    format('Final destination visit order: ~w from requested destinations ~w~n', [DestVisitOrder, Destinations]),
    format('Final route distance: ~w | Final route energy: ~2f~n', [FinalDistance, FinalEnergy]),
    format('Total mission distance across all robots: ~w~n', [TotalDistance]),
    format('Total movement energy across all robots: ~2f~n', [TotalEnergy]),
    format('Total charging stops across plan: ~w~n', [TotalChargeStops]),
    write('Charging points used:'), nl,
    print_charge_visit_details(AllChargePoints),
    nl,
    write('Final robot path:'), nl,
    print_path(FinalPath).

rf15_print_collectors([]).
rf15_print_collectors([collector(RobotID, SupplierIDs, SupplierVisitOrder, Products, Volume, Weight, Path, Distance, Energy, ChargeStops, ChargePoints) | Rest]) :-
    format('  Robot ~w -> Supplier Nodes ~w -> Hub | Supplier visit order: ~w | Products: ~w | Load V/W: ~w/~w | Distance: ~w | Energy: ~2f | Charges: ~w~n',
           [RobotID, SupplierIDs, SupplierVisitOrder, Products, Volume, Weight, Distance, Energy, ChargeStops]),
    write('    Supplier details:'), nl,
    rf15_print_supplier_id_details(SupplierIDs),
    ( ChargePoints == [] -> true ; write('    Charging points: '), write(ChargePoints), nl ),
    write('    Collector route:'), nl,
    print_path_indented(Path, '      '),
    rf15_print_collectors(Rest).

rf15_print_supplier_id_details([]).
rf15_print_supplier_id_details([SupplierID | Rest]) :-
    ( supplier(SupplierID, SupplierName, SupplierProducts) ->
        format('      Supplier Node ~w (~w) | Products sold: ~w~n', [SupplierID, SupplierName, SupplierProducts])
    ;
        format('      Supplier Node ~w~n', [SupplierID])
    ),
    rf15_print_supplier_id_details(Rest).

print_path_indented([], _).
print_path_indented([link(A, B, D, Type) | Rest], Indent) :-
    format('~w~w -> ~w | Distance: ~w | Type: ~w~n', [Indent, A, B, D, Type]),
    print_path_indented(Rest, Indent).


% RF15 uses this non-greedy route builder instead of choosing the best leg
% independently. That matters because a slightly longer leg that charges at a
% hub/charge station can leave enough battery for the following leg.
rf15_best_route_through_points_bounded(
    RobotID, Start, Points, StartBattery,
    BestPath, BestDistance, BestEnergy, BestFinalBattery, BestChargeStops, BestChargePoints
) :-
    findall(route_solution(Path, Distance, Energy, FinalBattery, ChargeStops, ChargePoints),
        rf15_route_through_points_bounded(
            RobotID, Start, Points, StartBattery,
            Path, Distance, Energy, FinalBattery, ChargeStops, ChargePoints
        ),
        Routes),
    Routes \= [],
    best_rf15_route_solution_from_list(
        Routes,
        route_solution(BestPath, BestDistance, BestEnergy, BestFinalBattery, BestChargeStops, BestChargePoints)
    ).

rf15_route_through_points_bounded(_, _, [], Battery, [], 0, 0, Battery, 0, []).
rf15_route_through_points_bounded(
    RobotID, Current, [Next | Rest], BatteryIn,
    FullPath, TotalDistance, TotalEnergy, FinalBattery, TotalChargeStops, ChargePoints
) :-
    route_leg_with_charging_bounded_option(
        RobotID, Current, Next, BatteryIn,
        LegPath, LegDistance, LegEnergy, BatteryAfterLeg, LegChargeStops, LegChargePoints
    ),
    rf15_route_through_points_bounded(
        RobotID, Next, Rest, BatteryAfterLeg,
        RestPath, RestDistance, RestEnergy, FinalBattery, RestChargeStops, RestChargePoints
    ),
    append(LegPath, RestPath, FullPath),
    append(LegChargePoints, RestChargePoints, ChargePoints),
    TotalDistance is LegDistance + RestDistance,
    TotalEnergy is LegEnergy + RestEnergy,
    TotalChargeStops is LegChargeStops + RestChargeStops.

best_rf15_route_solution_from_list([Option], Option).
best_rf15_route_solution_from_list(
    [route_solution(Path1, Dist1, Energy1, Battery1, Stops1, Points1),
     route_solution(_, Dist2, Energy2, _, Stops2, _) | Rest],
    Best
) :-
    charged_option_better_or_equal(Stops1, Energy1, Dist1, Stops2, Energy2, Dist2),
    best_rf15_route_solution_from_list([route_solution(Path1, Dist1, Energy1, Battery1, Stops1, Points1) | Rest], Best).
best_rf15_route_solution_from_list(
    [route_solution(_, Dist1, Energy1, _, Stops1, _),
     route_solution(Path2, Dist2, Energy2, Battery2, Stops2, Points2) | Rest],
    Best
) :-
    \+ charged_option_better_or_equal(Stops1, Energy1, Dist1, Stops2, Energy2, Dist2),
    best_rf15_route_solution_from_list([route_solution(Path2, Dist2, Energy2, Battery2, Stops2, Points2) | Rest], Best).

route_with_charging(RobotID, Start, End, BestChargeID, BestPath, BestDistance, BestEnergy) :-
    robot(RobotID, RobotType, _, _, _, MaxBat, Consumption),
    findall(
        charge_route(ChargeID, FullPath, TotalDistance, TotalEnergy),
        (
            charge_station(ChargeID, _, 'Available', _),

            route(Start, ChargeID, RobotType, Path1, D1),
            route(ChargeID, End, RobotType, Path2, D2),

            Energy1 is D1 * Consumption,
            Energy2 is D2 * Consumption,

            Energy1 =< MaxBat,
            Energy2 =< MaxBat,

            append(Path1, Path2, FullPath),
            TotalDistance is D1 + D2,
            TotalEnergy is Energy1 + Energy2
        ),
        Routes
    ),
    lowest_charge_route(Routes, charge_route(BestChargeID, BestPath, BestDistance, BestEnergy)).

lowest_charge_route([Route], Route).

lowest_charge_route([charge_route(C1, Path1, Dist1, Energy1), charge_route(_, _, _, Energy2) | Rest], Best) :-
    Energy1 =< Energy2,
    lowest_charge_route([charge_route(C1, Path1, Dist1, Energy1) | Rest], Best).

lowest_charge_route([charge_route(_, _, _, Energy1), charge_route(C2, Path2, Dist2, Energy2) | Rest], Best) :-
    Energy1 > Energy2,
    lowest_charge_route([charge_route(C2, Path2, Dist2, Energy2) | Rest], Best).


best_route_with_hub(Start, End, BestHub, BestPath, BestDistance) :-
    findall(
        hub_route(HubID, FullPath, TotalDistance),
        (
            hub(HubID, _, 'Available', _),
            shortest_path(Start, HubID, p(Path1, D1)),
            shortest_path(HubID, End, p(Path2, D2)),
            append(Path1, Path2, FullPath),
            TotalDistance is D1 + D2
        ),
        Routes
    ),
    shortest_hub_route(Routes, hub_route(BestHub, BestPath, BestDistance)).

shortest_hub_route([Route], Route).

shortest_hub_route([hub_route(Hub1, Path1, Dist1), hub_route(_, _, Dist2) | Rest], Best) :-
    Dist1 =< Dist2,
    shortest_hub_route([hub_route(Hub1, Path1, Dist1) | Rest], Best).

shortest_hub_route([hub_route(_, _, Dist1), hub_route(Hub2, Path2, Dist2) | Rest], Best) :-
    Dist1 > Dist2,
    shortest_hub_route([hub_route(Hub2, Path2, Dist2) | Rest], Best).
lowest_energy_route(RobotID, Start, End, BestPath, BestDistance, BestEnergy) :-
    robot(RobotID, RobotType, _, _, _, _, Consumption),
    findall(
        energy_route(Path, Distance, Energy),
        (
            route(Start, End, RobotType, Path, Distance),
            Energy is Distance * Consumption
        ),
        Routes
    ),
    lowest_energy_from_list(Routes, energy_route(BestPath, BestDistance, BestEnergy)).

lowest_energy_from_list([Route], Route).

lowest_energy_from_list([energy_route(Path1, Dist1, Energy1), energy_route(_, _, Energy2) | Rest], Best) :-
    Energy1 =< Energy2,
    lowest_energy_from_list([energy_route(Path1, Dist1, Energy1) | Rest], Best).

lowest_energy_from_list([energy_route(_, _, Energy1), energy_route(Path2, Dist2, Energy2) | Rest], Best) :-
    Energy1 > Energy2,
    lowest_energy_from_list([energy_route(Path2, Dist2, Energy2) | Rest], Best).

check_robot_route_and_battery(RobotID, CurrentLoc, DestNode) :-
    ( shortest_path_for_robot(RobotID, CurrentLoc, DestNode, p(Path, Distance)) ->
        path_link_types(Path, LinkTypes),
        battery_available_units(RobotID, Available),
        battery_needed_for_distance(RobotID, Distance, Needed),
        format('ROUTE: [OK] Compatible shortest path found: ~w~n', [Path]),
        format('Route link types: ~w~n', [LinkTypes]),
        format('Total distance: ~w~n', [Distance]),
        format('Battery available: ~2f | Battery needed: ~2f~n', [Available, Needed]),
        ( Needed =< Available ->
            write('RESULT: [YES] Robot can perform this delivery with current battery.'), nl
        ;
            write('RESULT: [NO] Robot has a compatible route, but not enough battery.'), nl
        )
    ;
        write('RESULT: [NO] No compatible route exists for this robot type.'), nl
    ).


% -------------------------------
% RF16: Fleet health and risk report
% -------------------------------
% This report gives a compact operational overview of the fleet.
% Robots may appear in more than one risk section. For example, a damaged
% robot with 5% battery appears both under battery risk and damaged robots.

fleet_health_report :-
    nl,
    write('--- RF16: Fleet Health / Risk Report ---'), nl,
    nl,
    print_ready_robots_section,
    nl,
    print_battery_risk_section,
    nl,
    print_damaged_robots_section,
    nl,
    print_charging_robots_section,
    nl,
    print_busy_robots_section,
    nl,
    print_fleet_health_summary.

robot_status_record(RobotID, Type, Loc, Bat, Status, Load) :-
    robot(RobotID, Type, _, _, _, _, _),
    op_status(RobotID, Loc, Bat, Status, Load).

ready_robot(RobotID) :-
    robot_status_record(RobotID, _, _, Bat, idle, none),
    Bat > 35.

battery_risk_robot(RobotID) :-
    robot_status_record(RobotID, _, _, Bat, _, _),
    Bat =< 35.

damaged_robot(RobotID) :-
    robot_status_record(RobotID, _, _, _, damaged, _).

charging_robot(RobotID) :-
    robot_status_record(RobotID, _, _, _, charging, _).

busy_robot(RobotID) :-
    robot_status_record(RobotID, _, _, _, transporting, _).
busy_robot(RobotID) :-
    robot_status_record(RobotID, _, _, _, paused, _).


battery_risk_label(Bat, 'CRITICAL') :-
    Bat =< 15,
    !.
battery_risk_label(Bat, 'LOW') :-
    Bat =< 35,
    !.
battery_risk_label(_, 'OK').

print_ready_robots_section :-
    write('READY ROBOTS:'), nl,
    findall(RobotID, ready_robot(RobotID), Robots),
    sort(Robots, SortedRobots),
    ( SortedRobots == [] ->
        write('No ready robots found.'), nl
    ;
        forall(member(RobotID, SortedRobots), print_ready_robot(RobotID))
    ).

print_ready_robot(RobotID) :-
    robot_status_record(RobotID, Type, Loc, Bat, _, _),
    format('Robot ~w | ~w | Node ~w | Battery: ~w%%~n', [RobotID, Type, Loc, Bat]).

print_battery_risk_section :-
    write('LOW / CRITICAL BATTERY:'), nl,
    findall(RobotID, battery_risk_robot(RobotID), Robots),
    sort(Robots, SortedRobots),
    ( SortedRobots == [] ->
        write('No low or critical battery robots found.'), nl
    ;
        forall(member(RobotID, SortedRobots), print_battery_risk_robot(RobotID))
    ).

print_battery_risk_robot(RobotID) :-
    robot_status_record(RobotID, Type, Loc, Bat, Status, _),
    battery_risk_label(Bat, Risk),
    format('Robot ~w | ~w | Node ~w | Battery: ~w%% | Risk: ~w | Status: ~w~n',
           [RobotID, Type, Loc, Bat, Risk, Status]).

print_damaged_robots_section :-
    write('DAMAGED / UNAVAILABLE ROBOTS:'), nl,
    findall(RobotID, damaged_robot(RobotID), Robots),
    sort(Robots, SortedRobots),
    ( SortedRobots == [] ->
        write('No damaged robots found.'), nl
    ;
        forall(member(RobotID, SortedRobots), print_damaged_robot(RobotID))
    ).

print_damaged_robot(RobotID) :-
    robot_status_record(RobotID, Type, Loc, Bat, _, Load),
    format('Robot ~w | ~w | Node ~w | Battery: ~w%% | Load: ~w | Action: send to maintenance~n',
           [RobotID, Type, Loc, Bat, Load]).

print_charging_robots_section :-
    write('CHARGING ROBOTS:'), nl,
    findall(RobotID, charging_robot(RobotID), Robots),
    sort(Robots, SortedRobots),
    ( SortedRobots == [] ->
        write('No robots currently charging.'), nl
    ;
        forall(member(RobotID, SortedRobots), print_charging_robot(RobotID))
    ).

print_charging_robot(RobotID) :-
    robot_status_record(RobotID, Type, Loc, Bat, _, _),
    format('Robot ~w | ~w | Node ~w | Battery: ~w%% | Status: charging~n',
           [RobotID, Type, Loc, Bat]).

print_busy_robots_section :-
    write('BUSY ROBOTS:'), nl,
    findall(RobotID, busy_robot(RobotID), Robots),
    sort(Robots, SortedRobots),
    ( SortedRobots == [] ->
        write('No busy robots found.'), nl
    ;
        forall(member(RobotID, SortedRobots), print_busy_robot(RobotID))
    ).

print_busy_robot(RobotID) :-
    robot_status_record(RobotID, Type, Loc, Bat, Status, Load),
    format('Robot ~w | ~w | Node ~w | Battery: ~w%% | Status: ~w | Load: ~w~n',
           [RobotID, Type, Loc, Bat, Status, Load]).

print_fleet_health_summary :-
    count_all_robots(Total),
    count_ready_robots(Ready),
    count_battery_risk_robots(BatteryRisk),
    count_damaged_robots(Damaged),
    count_charging_robots(Charging),
    count_busy_robots(Busy),
    nl,
    write('SUMMARY:'), nl,
    format('Total robots: ~w~n', [Total]),
    format('Ready: ~w | Busy: ~w | Charging: ~w | Damaged: ~w~n', [Ready, Busy, Charging, Damaged]),
    format('Low/Critical battery: ~w~n', [BatteryRisk]).

count_all_robots(Count) :-
    findall(RobotID, robot(RobotID, _, _, _, _, _, _), Robots),
    length(Robots, Count).

count_ready_robots(Count) :-
    findall(RobotID, ready_robot(RobotID), Robots),
    length(Robots, Count).

count_battery_risk_robots(Count) :-
    findall(RobotID, battery_risk_robot(RobotID), Robots),
    length(Robots, Count).

count_damaged_robots(Count) :-
    findall(RobotID, damaged_robot(RobotID), Robots),
    length(Robots, Count).

count_charging_robots(Count) :-
    findall(RobotID, charging_robot(RobotID), Robots),
    length(Robots, Count).

count_busy_robots(Count) :-
    findall(RobotID, busy_robot(RobotID), Robots),
    length(Robots, Count).


% DEV TOOL: VIEW KNOWLEDGE BASE (SUB-MENU)
view_kb :-
    nl, write('================ KNOWLEDGE BASE VIEWER =================='), nl,
    write('1. View Nodes (Addresses)'), nl,
    write('2. View Customers'), nl,
    write('3. View Suppliers'), nl,
    write('4. View Hubs & Charging Stations'), nl,
    write('5. View Robots'), nl,
    write('6. View Connections (Links)'), nl,
    write('7. View Robot Status'), nl,
    write('8. View Orders & Loads'), nl,
    write('22. View All'), nl,
    write('0. Cancel / Go Back'), nl,
    write('Select what to display: '), read(Choice),
    handle_view_kb(Choice).

handle_view_kb(1) :- !,
    nl, write('--- NODES ---'), nl,
    forall(node(ID, Addr), format('node(~w, ~q).~n', [ID, Addr])).

handle_view_kb(2) :- !,
    nl, write('--- CUSTOMERS ---'), nl,
    forall(customer(C_ID, C_Name), format('customer(~w, ~q).~n', [C_ID, C_Name])).

handle_view_kb(3) :- !,
    nl, write('--- SUPPLIERS ---'), nl,
    forall(supplier(S_ID, S_Name, S_Prods), format('supplier(~w, ~q, ~w).~n', [S_ID, S_Name, S_Prods])).

handle_view_kb(4) :- !,
    nl, write('--- HUBS ---'), nl,
    forall(hub(H_ID, H_Name, H_Stat, H_Spd), format('hub(~w, ~q, ~q, ~w).~n', [H_ID, H_Name, H_Stat, H_Spd])),
    nl, write('--- CHARGING STATIONS ---'), nl,
    forall(charge_station(CS_ID, CS_Name, CS_Stat, CS_Spd), format('charge_station(~w, ~q, ~q, ~w).~n', [CS_ID, CS_Name, CS_Stat, CS_Spd])).

handle_view_kb(5) :- !,
    nl, write('--- ROBOTS ---'), nl,
    forall(robot(ID, Type, V, W, Vel, Bat, Cons), format('robot(~w, ~q, ~w, ~w, ~w, ~w, ~w).~n', [ID, Type, V, W, Vel, Bat, Cons])).

handle_view_kb(6) :- !,
    nl, write('--- CONNECTIONS ---'), nl,
    forall(link(A, B, Dist, Type), format('link(~w, ~w, ~w, ~q).~n', [A, B, Dist, Type])).

handle_view_kb(7) :- !,
    nl, write('--- STATUS ---'), nl,
    forall(op_status(ID, Loc, Bat, Status, Load), format('op_status(~w, ~w, ~w, ~w, ~w).~n', [ID, Loc, Bat, Status, Load])).

handle_view_kb(8) :- !,
    nl, write('--- ORDERS ---'), nl,
    forall(order(ID, Dest, Urg, Prod, Status), format('order(~w, ~w, ~w, ~w, ~q).~n', [ID, Dest, Urg, Prod, Status])),
    nl, write('--- LOADS ---'), nl,
    forall(load(L_ID, O_ID, Vol, Wt), format('load(~w, ~w, ~w, ~w).~n', [L_ID, O_ID, Vol, Wt])).

handle_view_kb(22) :- !,
    handle_view_kb(1),
    handle_view_kb(2),
    handle_view_kb(3),
    handle_view_kb(4),
    handle_view_kb(5),
    handle_view_kb(6),
    handle_view_kb(7),
    handle_view_kb(8).

handle_view_kb(0) :- !,
    write('Returning to main menu...'), nl.

handle_view_kb(_) :- 
    write('Invalid option.'), nl.


start_system :-
    start_server(8001),
    menu.