% Knowledge base template

% robots(ID, Type, Volume_cap, Weight_cap, Vel, Max_bat, Cons)              
% op_status(Robot_ID, Location, Batt_Level, Mission_status, Load_ID)        
% supplier(Node_ID, Name, List_of_Products)                                 FEITO
% hub(Node_ID, Name, Status, Charge_speed)                                  FEITO
% charge_station(Node_ID, Name, Status, Charge_speed)                       FEITO
% customer(Node_ID, Name)                                                   FEITO
% load(Load_ID, Order_ID, Volume, Weight)                                   
% order(Order_ID, Destination_node, Urgency, List_of_Products, Status)      
% product(Product_ID, Name, Volume, Weight)                                 FEITO
% node(Node_ID, Address)                                                    FEITO
% link(NodeID_A, NodeID_B, Dist, Tipo).                                     FEITO

% DATA LOADING
% product(Product_ID, Name, Volume, Weight)
product(1, 'Molly', 1, 1).
product(2, 'Cocaine', 1, 1).
product(3, 'Weed', 1, 1).
product(4, 'LSD', 1, 1).
product(5, 'Heroin', 1, 1).
product(6, 'Shrooms', 1, 1).

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
    write('--- NETWORK MANAGEMENT SYSTEM ---'), nl,
    write('1. Manage Network Nodes'), nl,
    write('2. Manage Autonomous Robots'), nl,
    write('3. Manage Connections Between Nodes'), nl,
    write('4. Update Robot Status'), nl,
    write('5. Manage Delivery Orders'), nl,
    write('0. Exit'), nl,
    write('Enter your choice: '),
    read(Choice),
    execute(Choice),
    Choice == 0,
    !.

% -------------------------------
% Main menu logic
% -------------------------------

execute(1) :- !, node_menu.
execute(2) :- !, robot_menu.
execute(3) :- !, connection_menu.
execute(4) :- !, status_menu.
execute(5) :- !, order_menu.
execute(0) :- !, write('Exiting... Goodbye!'), nl.
execute(_) :- write('Invalid selection, please try again.'), nl.

% -------------------------------
% RF1 - Nodes
% -------------------------------

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

% -------------------------------
% RF2 - Robots
% -------------------------------

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

% -------------------------------
% RF3 - Connections
% -------------------------------

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

% -------------------------------
% RF4 - Robot Status
% -------------------------------

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

% -------------------------------
% RF5 - Delivery Orders
% -------------------------------

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
% Dummy predicates (placeholders)
% -------------------------------

add_node :- write('add_node called'), nl.
modify_node :- write('modify_node called'), nl.
remove_node :- write('remove_node called'), nl.

add_robot :- write('add_robot called'), nl.
modify_robot :- write('modify_robot called'), nl.
remove_robot :- write('remove_robot called'), nl.

add_connection :- write('add_connection called'), nl.
modify_connection :- write('modify_connection called'), nl.
remove_connection :- write('remove_connection called'), nl.

register_status :- write('register_status called'), nl.
update_status :- write('update_status called'), nl.

create_order :- write('create_order called'), nl.
update_order :- write('update_order called'), nl.
remove_order :- write('remove_order called'), nl.