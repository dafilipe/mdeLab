% Ficheiro principal do LAB02

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