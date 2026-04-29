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


%Menu
start :-
    menu.

menu :-
    repeat,              % Magic predicate that allows backtracking
    nl,
    write('--- GENERIC PROLOG MENU ---'), nl,
    write('1. Say Hello'), nl,
    write('2. Display Current Date'), nl,
    write('3. Reveal Secret Message'), nl,
    write('0. Exit'), nl,
    write('Enter your choice: '),
    read(Choice),        % User must type choice followed by a dot (e.g., 1.)
    execute(Choice),
    Choice == 0,         % Loop terminates when Choice is 0
    !.

% Logic for each choice
execute(1) :-
    write('Hello there! Hope you are having a logical day.'), nl.

execute(2) :-
    get_time(Stamp),
    stamp_date_time(Stamp, DateTime, local),
    write('Current local time/date: '), write(DateTime), nl.

execute(3) :-
    write('The secret to Prolog is understanding recursion!'), nl.

execute(0) :-
    write('Exiting... Goodbye!'), nl.

% Catch-all for invalid inputs
execute(_) :-
    write('Invalid selection, please try again.'), nl.