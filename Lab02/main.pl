% Ficheiro principal do LAB02

:- discontiguous execute/1.

% -------------------------------
% Base de conhecimento (comentada)
% -------------------------------

% robot(Type, Autonomy, Speed, EnergyConsumption).
% opstatus(IdRobot, Location, BatLevel, Status, LoadId).
% supplier(NodeId).
% node(NodeId).
% link(Node1, Node2, Distance, Type).
% product(ProdId, [IdSupplier1, IdSupplier2, ...]).

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
    write('0. Exit'), nl,
    write('Enter your choice: '),
    read(Choice),
    execute(Choice),
    Choice == 0,
    !.

% -------------------------------
% Main menu logic
% -------------------------------

execute(1) :-
    node_menu.

execute(2) :-
    robot_menu.

execute(3) :-
    connection_menu.

execute(4) :-
    nl,
    write('Updating robot status...'), nl.

execute(0) :-
    write('Exiting... Goodbye!'), nl.

execute(_) :-
    write('Invalid selection, please try again.'), nl.

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

handle_node(1) :-
    write('Adding node...'), nl.

handle_node(2) :-
    write('Modifying node...'), nl.

handle_node(3) :-
    write('Removing node...'), nl.

handle_node(_) :-
    write('Invalid option.'), nl.

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

handle_robot(1) :-
    write('Adding robot...'), nl.

handle_robot(2) :-
    write('Modifying robot...'), nl.

handle_robot(3) :-
    write('Removing robot...'), nl.

handle_robot(_) :-
    write('Invalid option.'), nl.

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

handle_connection(1) :-
    write('Adding connection...'), nl.

handle_connection(2) :-
    write('Modifying connection...'), nl.

handle_connection(3) :-
    write('Removing connection...'), nl.

handle_connection(_) :-
    write('Invalid option.'), nl.