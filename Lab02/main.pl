% Knowledge base template

% robot(ID, Type, Volume_cap, Weight_cap, Vel, Max_bat, Cons)               FEITO
% op_status(Robot_ID, Location, Batt_Level, Mission_status, Load_ID)        FEITO
% supplier(Node_ID, Name, List_of_Products)                                 FEITO
% hub(Node_ID, Name, Status, Charge_speed)                                  FEITO
% charge_station(Node_ID, Name, Status, Charge_speed)                       FEITO
% customer(Node_ID, Name)                                                   FEITO
% load(Load_ID, Order_ID, Volume, Weight)                                   
% order(Order_ID, Destination_node, Urgency, List_of_Products, Status)      
% product(Product_ID, Name, Volume L, Weight kg)                         FEITO
% node(Node_ID, Address)                                                    FEITO
% link(NodeID_A, NodeID_B, Dist, Tipo).                                     FEITO
:- dynamic node/2.
:- dynamic robot/7.
:- dynamic link/4.
:- dynamic op_status/5.
:- dynamic order/5.
:- dynamic load/4.

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
op_status(5, 18, 5, fudido, none).         

op_status(6, 10, 95, idle, none).            
op_status(7, 6, 60, transporting, 3).   
op_status(8, 11, 40, paused, 4).        
op_status(9, 15, 75, transporting, 5).   
op_status(10, 10, 100, idle, none).       

op_status(11, 13, 15, charging, none).       
op_status(12, 10, 100, idle, none).          
op_status(13, 7, 50, transporting, 6).  
op_status(14, 17, 0, fudido, none).          
op_status(15, 12, 80, idle, none).     

% product(Product_ID, Name, Volume_cm3, Weight_kg)
product(1, 'Molly', 2, 10).
product(2, 'Cocaine', 3, 20).
product(3, 'Weed', 1.5, 5).
product(4, 'LSD', 1, 0.5).
product(5, 'Heroin', 2.5, 15).
product(6, 'Shrooms', 2, 4).

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
customer(10, 'King pin').
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
% Entry point
% -------------------------------

start :-
    menu.

menu :-
    repeat,
    nl,
    write('--- FORERO TORERO CARTEL, NETWORK MANAGEMENT SYSTEM ---'), nl,
    write('1. [RF1] Add/modify/remove a network node'), nl,
    write('2. [RF2] Add/modify/remove autonomous robots'), nl,
    write('3. [RF3] Add/modify/remove connections between network nodes'), nl,
    write('4. [RF4] Register and update the status of robots'), nl,
    write('5. [RF5] Create, update, and remove delivery orders'), nl,
    write('6. [RF6] List available robots in a given area or region'), nl,
    write('7. [RF7] Check the current status of a specific robot'), nl,
    write('8. [RF8] List available charging stations in a given area or near a robot'), nl,
    write('9. [RF9] Determine whether a robot can perform a given delivery'), nl,
    write('10. [RF10] View entire knowledge base'), nl,
    write('0. Exit'), nl,
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
execute(8) :- !, list_charging_stations.                % RF8
execute(9) :- !, check_robot_delivery_capability.       % RF9
execute(10):- !, view_kb.
execute(0) :- !, write('Exiting the underworld... Goodbye!'), nl.
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

% -------------------------------
% Dummy predicates (Placeholders para desenvolvimento)
% -------------------------------

% RF1 a RF5
% --- RF1: Nodes ---
add_node :-
    write('Enter Node ID: '), read(ID),
    write('Enter Address (in quotes, e.g., \'New Place\'): '), read(Address),
    assertz(node(ID, Address)),
    write('Node added successfully!'), nl.

modify_node :-
    write('Enter Node ID to modify: '), read(ID),
    retract(node(ID, _)),
    write('Enter new Address (in quotes): '), read(Address),
    assertz(node(ID, Address)),
    write('Node modified successfully!'), nl.

remove_node :-
    write('Enter Node ID to remove: '), read(ID),
    retract(node(ID, _)),
    write('Node removed successfully!'), nl.

% --- RF2: Robots ---
add_robot :-
    write('Enter Robot ID: '), read(ID),
    write('Enter Type (e.g., \'Drone\'): '), read(Type),
    write('Enter Volume Capacity: '), read(Vol),
    write('Enter Weight Capacity: '), read(Weight),
    write('Enter Velocity: '), read(Vel),
    write('Enter Max Battery: '), read(Bat),
    write('Enter Consumption: '), read(Cons),
    assertz(robot(ID, Type, Vol, Weight, Vel, Bat, Cons)),
    write('Robot added successfully!'), nl.

modify_robot :-
    write('Enter Robot ID to modify: '), read(ID),
    retract(robot(ID, _, _, _, _, _, _)),
    write('Enter Type: '), read(Type),
    write('Enter Volume Capacity: '), read(Vol),
    write('Enter Weight Capacity: '), read(Weight),
    write('Enter Velocity: '), read(Vel),
    write('Enter Max Battery: '), read(Bat),
    write('Enter Consumption: '), read(Cons),
    assertz(robot(ID, Type, Vol, Weight, Vel, Bat, Cons)),
    write('Robot modified successfully!'), nl.

remove_robot :-
    write('Enter Robot ID to remove: '), read(ID),
    retract(robot(ID, _, _, _, _, _, _)),
    write('Robot removed successfully!'), nl.

% --- RF3: Connections ---
add_connection :-
    write('Enter Node A ID: '), read(A),
    write('Enter Node B ID: '), read(B),
    write('Enter Distance: '), read(Dist),
    write('Enter Type (in quotes, e.g., \'Mixed\'): '), read(Type),
    assertz(link(A, B, Dist, Type)),
    write('Connection added successfully!'), nl.

modify_connection :-
    write('Enter Node A ID: '), read(A),
    write('Enter Node B ID: '), read(B),
    retract(link(A, B, _, _)),
    write('Enter new Distance: '), read(Dist),
    write('Enter new Type (in quotes): '), read(Type),
    assertz(link(A, B, Dist, Type)),
    write('Connection modified successfully!'), nl.

remove_connection :-
    write('Enter Node A ID: '), read(A),
    write('Enter Node B ID: '), read(B),
    retract(link(A, B, _, _)),
    write('Connection removed successfully!'), nl.


% --- RF4: Robot Status ---
register_status :-
    write('Enter Robot ID: '), read(ID),
    write('Enter Location Node ID: '), read(Loc),
    write('Enter Battery Level (%): '), read(Bat),
    write('Enter Mission Status (idle, transporting, etc.): '), read(Status),
    write('Enter Load ID (or none): '), read(Load),
    assertz(op_status(ID, Loc, Bat, Status, Load)),
    write('Status registered successfully!'), nl.

update_status :-
    write('Enter Robot ID to update: '), read(ID),
    retract(op_status(ID, _, _, _, _)),
    write('Enter new Location Node ID: '), read(Loc),
    write('Enter new Battery Level (%): '), read(Bat),
    write('Enter new Mission Status: '), read(Status),
    write('Enter new Load ID: '), read(Load),
    assertz(op_status(ID, Loc, Bat, Status, Load)),
    write('Status updated successfully!'), nl.

% --- RF5: Delivery Orders ---
create_order :-
    write('Enter Order ID: '), read(ID),
    write('Enter Destination Node ID: '), read(Dest),
    write('Enter Urgency (1-3): '), read(Urg),
    write('Enter List of Products (e.g., [1,2,3]): '), read(List),
    write('Enter Status (in quotes, e.g., \'Pending\'): '), read(Status),
    assertz(order(ID, Dest, Urg, List, Status)),
    write('Order created successfully!'), nl.

update_order :-
    write('Enter Order ID to update: '), read(ID),
    retract(order(ID, _, _, _, _)),
    write('Enter new Destination Node ID: '), read(Dest),
    write('Enter new Urgency: '), read(Urg),
    write('Enter new List of Products: '), read(List),
    write('Enter new Status (in quotes): '), read(Status),
    assertz(order(ID, Dest, Urg, List, Status)),
    write('Order updated successfully!'), nl.

remove_order :-
    write('Enter Order ID to remove: '), read(ID),
    retract(order(ID, _, _, _, _)),
    write('Order removed successfully!'), nl.

% --- RF6: List available robots in a given area ---
list_available_robots :-
    write('Enter Node ID to search for idle robots: '), read(NodeID),
    findall(RobotID, op_status(RobotID, NodeID, _, idle, _), Robots),
    (Robots \= [] ->
        format('Available (idle) robots at Node ~w: ~w~n', [NodeID, Robots])
    ;
        format('No available robots at Node ~w right now.~n', [NodeID])
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

% --- RF8: List available charging stations ---
list_charging_stations :-
    write('--- Available Hubs ---'), nl,
    forall(hub(ID, Name, 'Available', Speed), format('Hub ~w: ~w (Speed: ~w)~n', [ID, Name, Speed])),
    write('--- Available Charge Stations ---'), nl,
    forall(charge_station(ID, Name, 'Available', Speed), format('Station ~w: ~w (Speed: ~w)~n', [ID, Name, Speed])).

% --- RF9: Determine delivery capability (Capacity Check) ---
check_robot_delivery_capability :-
    write('Enter Robot ID: '), read(RobotID),
    write('Enter Order ID (to check Load): '), read(OrderID),
    
    % Fetch Robot data
    (robot(RobotID, _, R_Vol, R_Weight, _, R_Bat, _) -> true ; write('Robot not found!'), nl, fail),
    
    % Fetch Load data related to Order
    (load(_, OrderID, L_Vol, L_Weight) -> true ; write('Load for this order not found!'), nl, fail),
    
    % Fetch Robot Battery from Status
    (op_status(RobotID, _, CurrentBat, _, _) -> true ; CurrentBat = R_Bat), 
    
    format('Checking if Robot ~w can carry Order ~w...~n', [RobotID, OrderID]),
    format('Robot Capacity -> Volume: ~w | Weight: ~w~n', [R_Vol, R_Weight]),
    format('Load Required  -> Volume: ~w | Weight: ~w~n', [L_Vol, L_Weight]),
    
    (L_Vol =< R_Vol, L_Weight =< R_Weight ->
        write('RESULT: [YES] Robot has enough physical capacity for this delivery.'), nl,
        (CurrentBat > 20 -> 
            write('STATUS: Battery is above critical level.')
        ; 
            write('WARNING: Battery is low, might need charge!')
        ), nl
    ;
        write('RESULT: [NO] Robot CANNOT carry this order (Exceeds capacity).'), nl
    ).

% DEV TOOL: VIEW ENTIRE KNOWLEDGE BASE
view_kb :-
    nl, write('================ KNOWLEDGE BASE STATE =================='), nl,
    write('--- NODES ---'), nl,
    forall(node(ID, Addr), format('node(~w, ~q).~n', [ID, Addr])),
    write('--- ROBOTS ---'), nl,
    forall(robot(ID, Type, V, W, Vel, Bat, Cons), format('robot(~w, ~q, ~w, ~w, ~w, ~w, ~w).~n', [ID, Type, V, W, Vel, Bat, Cons])),
    write('--- CONNECTIONS ---'), nl,
    forall(link(A, B, Dist, Type), format('link(~w, ~w, ~w, ~q).~n', [A, B, Dist, Type])),
    write('--- STATUS ---'), nl,
    forall(op_status(ID, Loc, Bat, Status, Load), format('op_status(~w, ~w, ~w, ~w, ~w).~n', [ID, Loc, Bat, Status, Load])),
    write('--- ORDERS ---'), nl,
    forall(order(ID, Dest, Urg, Prod, Status), format('order(~w, ~w, ~w, ~w, ~q).~n', [ID, Dest, Urg, Prod, Status])),
    write('========================================================'), nl.