% Ficheiro principal do LAB02

% Robots - Capacity, Type, Autonomy, Speed, Energy Consumption
% Type: Ground, Drone, Autonomous
% robot(Type, Autonomy, Speed, EnergyConsumption).

% OpStatus - IdRobot, Location, BatLevel, Status, LoadId
% opstatus(IdRobot, Location, BatLevel, Status, LoadId).

% Supplier - NodeId
% supplier(NodeId).

% Nodes - NodeId
% node(NodeId).

% Links - Node1, Node2, Distance, tipo
% link(Node1, Node2, Distance, Type).

% Produtos - ProdId, ARRAY idSupplier
% product(ProdId, [IdSupplier1, IdSupplier2, ...]).


% Entry point
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

% -------- RF1 --------
execute(1) :-
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

% -------- RF2 --------
execute(2) :-
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

% -------- RF3 --------
execute(3) :-
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

% -------- RF4 --------
execute(4) :-
    nl,
    write('Updating robot status...'), nl.

% Exit
execute(0) :-
    write('Exiting... Goodbye!'), nl.

% Catch-all
execute(_) :-
    write('Invalid selection, please try again.'), nl.