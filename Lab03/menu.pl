:- use_module(library(readutil)).

% =========================
% MENU PRINCIPAL
% =========================

start_menu :-
    (frame_exists(alarmG) -> true ; model_wh),
    main_menu.

main_menu :-
    repeat,
    nl,
    write('========================================'), nl,
    write('        WAREHOUSE MANAGEMENT MENU       '), nl,
    write('========================================'), nl,
    write('1 - FR1: Manage warehouses'), nl,
    write('2 - FR2: Manage sensors and actuators'), nl,
    write('3 - FR3: Manage products and stock'), nl,
    write('4 - FR4: Create orders considering stock'), nl,
    write('5 - FR5: Visualize and update order states'), nl,
    write('6 - FR6: Configure and simulate climate control'), nl,
    write('7 - FR7: Occupancy-based adaptive climate control'), nl,
    write('8 - FR8: Generate and visualize alarms'), nl,
    write('0 - Exit'), nl,
    write('========================================'), nl,
    ask_number('Option:', Option),
    main_option(Option),
    Option =:= 0, !.

main_option(1) :- warehouse_menu.
main_option(2) :- sensor_actuator_menu.
main_option(3) :- product_menu.
main_option(4) :- order_creation_menu.
main_option(5) :- order_state_menu.
main_option(6) :- climate_menu.
main_option(7) :- occupancy_menu.
main_option(8) :- alarm_menu.
main_option(0) :- write('Exiting menu...'), nl.




% =========================
% INPUT HELPERS
% =========================

ask(Prompt, Term) :-
    write(Prompt), write(' '),
    read_line_to_string(user_input, S0),
    normalize_space(string(S), S0),
    string_concat(S, ".", S1),
    catch(
        read_term_from_atom(S1, Term, []),
        _,
        (
            write('Invalid input. Try again using Prolog syntax.'), nl,
            fail
        )
    ).

ask_number(Prompt, Number) :-
    repeat,
    ask(Prompt, Value),
    (
        number(Value) ->
            Number = Value, !
        ;
            write('Input must be a number.'), nl,
            fail
    ).


% =========================
% FR1 - WAREHOUSES
% =========================

warehouse_menu :-
    repeat,
    nl,
    write('---------- FR1: Warehouses ----------'), nl,
    write('1 - Create warehouse'), nl,
    write('2 - Visualize warehouse'), nl,
    write('3 - Update warehouse state'), nl,
    write('4 - Configure warehouse climate limits'), nl,
    write('5 - Delete warehouse'), nl,
    write('0 - Back'), nl,
    ask_number('Option:', Option),
    warehouse_option(Option),
    Option =:= 0, !.

warehouse_option(1) :-
    ask('Warehouse ID:', Id),
    ask('Name:', Name),
    ask('Location:', Location),
    ask_number('Capacity:', Capacity),
    ask('Zones, example [zone1,zone2]:', Zones),
    create_warehouse(Id, Name, Location, Capacity, Zones).

warehouse_option(2) :-
    ask('Warehouse ID:', Id),
    visualize_warehouse(Id).

warehouse_option(3) :-
    ask('Warehouse ID:', Id),
    ask('New state, example active/inactive:', State),
    update_warehouse_state(Id, State).

warehouse_option(4) :-
    ask_number('LAI - absolute lower limit:', Lai),
    ask_number('LI - lower limit:', Li),
    ask_number('LS - upper limit:', Ls),
    ask_number('LAS - absolute upper limit:', Las),
    warehouse_climate_limits(Lai, Li, Ls, Las).

warehouse_option(5) :-
    ask('Warehouse ID:', Id),
    delete_warehouse(Id).

warehouse_option(0) :-
    write('Back to main menu.'), nl.




% =========================
% FR2 - SENSORS AND ACTUATORS
% =========================

sensor_actuator_menu :-
    repeat,
    nl,
    write('---------- FR2: Sensors and Actuators ----------'), nl,
    write('1 - Create sensor'), nl,
    write('2 - Visualize sensor'), nl,
    write('3 - Update sensor value / simulate reading'), nl,
    write('4 - Delete sensor'), nl,
    write('5 - Create actuator'), nl,
    write('6 - Visualize actuator'), nl,
    write('7 - Update actuator state'), nl,
    write('8 - Delete actuator'), nl,
    write('0 - Back'), nl,
    ask_number('Option:', Option),
    sensor_actuator_option(Option),
    Option =:= 0, !.

sensor_actuator_option(1) :-
    ask('Sensor ID:', Id),
    ask('Sensor type:', Type),
    ask('Initial value:', InitialValue),
    ask('Location:', Location),
    create_sensor(Id, Type, InitialValue, Location).

sensor_actuator_option(2) :-
    ask('Sensor ID:', Id),
    visualize_sensor(Id).

sensor_actuator_option(3) :-
    ask('Sensor ID:', Id),
    ask('New value:', NewValue),
    update_sensor_value(Id, NewValue).

sensor_actuator_option(4) :-
    ask('Sensor ID:', Id),
    delete_sensor(Id).

sensor_actuator_option(5) :-
    ask('Actuator ID:', Id),
    ask('Actuator type:', Type),
    create_actuator(Id, Type).

sensor_actuator_option(6) :-
    ask('Actuator ID:', Id),
    visualize_actuator(Id).

sensor_actuator_option(7) :-
    ask('Actuator ID:', Id),
    ask('New state, example on/off/open/closed:', State),
    update_actuator_state(Id, State).

sensor_actuator_option(8) :-
    ask('Actuator ID:', Id),
    delete_actuator(Id).

sensor_actuator_option(0) :-
    write('Back to main menu.'), nl.




% =========================
% FR3 - PRODUCTS AND STOCK
% =========================

product_menu :-
    repeat,
    nl,
    write('---------- FR3: Products and Stock ----------'), nl,
    write('1 - Create product'), nl,
    write('2 - Visualize product'), nl,
    write('3 - Update product stock'), nl,
    write('4 - Delete product'), nl,
    write('0 - Back'), nl,
    ask_number('Option:', Option),
    product_option(Option),
    Option =:= 0, !.

product_option(1) :-
    ask('Product frame ID:', ProductFrame),
    ask('Name:', Name),
    ask('Reference:', Reference),
    ask('Category:', Category),
    ask_number('Quantity:', Quantity),
    ask('Expiration date, example date(2026,6,2):', ExpirationDate),
    ask_number('Ideal temperature:', IdealTemp),
    ask('Warehouse location:', WarehouseLocation),
    ask_number('Unit price:', UnitPrice),
    create_product(
        ProductFrame,
        Name,
        Reference,
        Category,
        Quantity,
        ExpirationDate,
        IdealTemp,
        WarehouseLocation,
        UnitPrice
    ).

product_option(2) :-
    ask('Product frame ID:', Id),
    visualize_product(Id).

product_option(3) :-
    ask('Product frame ID:', Id),
    ask_number('New quantity:', NewQuantity),
    update_product_stock(Id, NewQuantity).

product_option(4) :-
    ask('Product frame ID:', Id),
    delete_product(Id).

product_option(0) :-
    write('Back to main menu.'), nl.




% =========================
% FR4 - ORDERS CONSIDERING STOCK
% =========================

order_creation_menu :-
    repeat,
    nl,
    write('---------- FR4: Orders and Stock Availability ----------'), nl,
    write('1 - Create order'), nl,
    write('2 - Visualize product before ordering'), nl,
    write('0 - Back'), nl,
    ask_number('Option:', Option),
    order_creation_option(Option),
    Option =:= 0, !.

order_creation_option(1) :-
    ask('Order frame ID:', OrderFrame),
    ask('Product frame ID:', ProductFrame),
    ask_number('Quantity:', Quantity),
    create_order(OrderFrame, ProductFrame, Quantity).

order_creation_option(2) :-
    ask('Product frame ID:', ProductFrame),
    visualize_product(ProductFrame).

order_creation_option(0) :-
    write('Back to main menu.'), nl.




% =========================
% FR5 - ORDER STATES
% =========================

order_state_menu :-
    repeat,
    nl,
    write('---------- FR5: Order States ----------'), nl,
    write('1 - Visualize order'), nl,
    write('2 - Update order state'), nl,
    write('3 - Show valid order states'), nl,
    write('0 - Back'), nl,
    ask_number('Option:', Option),
    order_state_option(Option),
    Option =:= 0, !.

order_state_option(1) :-
    ask('Order frame ID:', OrderFrame),
    visualize_order(OrderFrame).

order_state_option(2) :-
    ask('Order frame ID:', OrderFrame),
    ask('New state:', NewState),
    update_order_state(OrderFrame, NewState).

order_state_option(3) :-
    write('Valid states: pending, preparing, shipped, delivered'), nl.

order_state_option(0) :-
    write('Back to main menu.'), nl.





% =========================
% FR6 - CLIMATE CONTROL
% =========================

climate_menu :-
    repeat,
    nl,
    write('---------- FR6: Automatic Climate Control ----------'), nl,
    write('1 - Configure climate limits'), nl,
    write('2 - Simulate temperature sensor'), nl,
    write('3 - Simulate humidity sensor'), nl,
    write('4 - Simulate CO2 sensor'), nl,
    write('5 - Simulate door sensor'), nl,
    write('6 - Visualize climate system state'), nl,
    write('0 - Back'), nl,
    ask_number('Option:', Option),
    climate_option(Option),
    Option =:= 0, !.

climate_option(1) :-
    ask_number('LAI - absolute lower limit:', Lai),
    ask_number('LI - lower limit:', Li),
    ask_number('LS - upper limit:', Ls),
    ask_number('LAS - absolute upper limit:', Las),
    warehouse_climate_limits(Lai, Li, Ls, Las).

climate_option(2) :-
    ask_number('New temperature:', Temperature),
    update_sensor_value(sensor_temp, Temperature).

climate_option(3) :-
    ask_number('New humidity:', Humidity),
    update_sensor_value(sensor_humidity, Humidity).

climate_option(4) :-
    ask_number('New CO2 value:', CO2),
    update_sensor_value(sensor_co2, CO2).

climate_option(5) :-
    ask('Door state, open/closed:', DoorState),
    update_sensor_value(sensor_door, DoorState).

climate_option(6) :-
    visualize_climate_system.

climate_option(0) :-
    write('Back to main menu.'), nl.


visualize_climate_system :-
    nl,
    write('--- Warehouse climate data ---'), nl,
    visualize_warehouse(warehouse),
    nl,
    write('--- Sensors ---'), nl,
    visualize_sensor(sensor_temp),
    visualize_sensor(sensor_humidity),
    visualize_sensor(sensor_co2),
    visualize_sensor(sensor_door),
    nl,
    write('--- Actuators ---'), nl,
    visualize_actuator(cooling_system),
    visualize_actuator(ventilation),
    visualize_actuator(humidifier),
    visualize_actuator(alarm_system),
    visualize_actuator(automatic_doors).


% =========================
% FR7 - OCCUPANCY-BASED CONTROL
% =========================

occupancy_menu :-
    repeat,
    nl,
    write('---------- FR7: Occupancy-Based Climate Control ----------'), nl,
    write('1 - Simulate occupancy sensor'), nl,
    write('2 - Visualize occupancy and warehouse limits'), nl,
    write('0 - Back'), nl,
    ask_number('Option:', Option),
    occupancy_option(Option),
    Option =:= 0, !.

occupancy_option(1) :-
    ask_number('Number of people:', People),
    update_sensor_value(sensor_presence, People).

occupancy_option(2) :-
    visualize_sensor(sensor_presence),
    visualize_warehouse(warehouse).

occupancy_option(0) :-
    write('Back to main menu.'), nl.





% =========================
% FR8 - ALARMS
% =========================

alarm_menu :-
    repeat,
    nl,
    write('---------- FR8: Alarm Messages ----------'), nl,
    write('1 - Visualize all alarms'), nl,
    write('2 - Generate manual alarm'), nl,
    write('3 - Visualize alarm system actuator'), nl,
    write('0 - Back'), nl,
    ask_number('Option:', Option),
    alarm_option(Option),
    Option =:= 0, !.

alarm_option(1) :-
    show_general_alarms.

alarm_option(2) :-
    ask('Source:', Source),
    ask('Event:', Event),
    ask('Value:', Value),
    ask('Severity, example info/warning/critical:', Severity),
    getdate(Date),
    genmsg_general(Source, Event, Value, Severity, Date),
    write('Manual alarm generated.'), nl.

alarm_option(3) :-
    visualize_actuator(alarm_system).

alarm_option(0) :-
    write('Back to main menu.'), nl.

