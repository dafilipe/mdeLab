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
    write('12. [RF12] Determine routes that include intermediate distribution points'), nl,
    write('22.[DBG] View Knowledge Base (Select Categories)'), nl,    write('0. Exit'), nl,
    write('Enter your choice (0-9): '),
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

% --- RF9: Determine delivery capability (capacity + route + battery check) ---
check_robot_delivery_capability :-
    write('Enter Robot ID: '), read(RobotID),
    write('Enter Order ID (to check Load): '), read(OrderID),

    % Fetch Robot data
    ( robot(RobotID, RobotType, R_Vol, R_Weight, _, _, _) -> true ; write('Robot not found!'), nl, fail ),

    % Fetch Order and Load data
    ( order(OrderID, DestNode, _, _, _) -> true ; write('Order not found!'), nl, fail ),
    ( load(_, OrderID, L_Vol, L_Weight) -> true ; write('Load for this order not found!'), nl, fail ),

    % Fetch Robot operational data
    ( op_status(RobotID, CurrentLoc, CurrentBatPercent, _, _) ->
        true
    ;
        write('Robot has no operational status/location registered!'), nl,
        fail
    ),

    format('Checking if Robot ~w (~w) can perform Order ~w...~n', [RobotID, RobotType, OrderID]),
    format('Current location: Node ~w | Destination: Node ~w | Battery: ~w%%~n', [CurrentLoc, DestNode, CurrentBatPercent]),
    format('Robot Capacity -> Volume: ~w | Weight: ~w~n', [R_Vol, R_Weight]),
    format('Load Required  -> Volume: ~w | Weight: ~w~n', [L_Vol, L_Weight]),

    ( L_Vol =< R_Vol, L_Weight =< R_Weight ->
        write('CAPACITY: [OK] Robot can physically carry this load.'), nl,
        check_robot_route_and_battery(RobotID, CurrentLoc, DestNode)
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