:- ['golog2_2026.pl'].

model_wh :-
    def_isa,
    def_warehouse,
    def_sensor,
    def_sensors,
    def_actuator,
    def_actuators,
    def_general_alarm,
    def_sensor_demons,
    def_product,
    def_order.

% =========================
% WhareHouse
% =========================
def_warehouse :-
    new_frame(warehouse),
    new_slot(warehouse, name),
    new_slot(warehouse, location),
    new_slot(warehouse, capacity),
    new_slot(warehouse, zones),
    new_slot(warehouse, current_temperature),
    new_slot(warehouse, operational_state),
    new_slot(warehouse, lai),
    new_slot(warehouse, li),
    new_slot(warehouse, ls),
    new_slot(warehouse, las).

create_warehouse(Id, Name, Location, Capacity, Zones) :-
    \+ frame_exists(Id), !,
    new_frame(Id),
    new_slot(Id, is_a, warehouse),
    new_value(Id, name, Name),
    new_value(Id, location, Location),
    new_value(Id, capacity, Capacity),
    new_value(Id, zones, Zones),
    new_value(Id, current_temperature, 20),         % Temp inicial
    new_value(Id, operational_state, activo),       % Estado inicial
    new_value(Id, lai, 0),                          % FREEZING limit
    new_value(Id, li, 14),                          % COLD limit
    new_value(Id, ls, 25),                          % HOT limit
    new_value(Id, las, 35),                         % BURNING limit
    write( 'Warehouse [' ), write(Id), write( '] created' ), nl.

create_warehouse(Id, _, _, _, _) :-
    write( 'Warehouse [' ), write(Id), write( '] already exist' ), nl.


visualize_warehouse(Id) :-
    frame_exists(Id), !,
    write('   DADOS DO ARMAZÉM: '), write(Id), nl,
    show_frame(Id).

visualize_warehouse(Id) :-
    write( 'Warehouse [' ), write(Id), write( '] not found' ), nl.


update_warehouse_state(Id, NewState) :-
    frame_exists(Id), !,
    new_value(Id, operational_state, NewState),
    write( 'Warehouse [' ), write(Id), write( '] is now ' ), write(NewState), nl.

update_warehouse_state(Id, _) :-
    write( 'Warehouse [' ), write(Id), write( '] not found' ), nl.


warehouse_climate_limits(Lai, Li, Ls, Las) :-
    Lai < Li, Li < Ls, Ls < Las, !,
    new_value(warehouse, lai, Lai),
    new_value(warehouse, li, Li),
    new_value(warehouse, ls, Ls),
    new_value(warehouse, las, Las),
    write( 'Warehouse climate limits changed' ), nl.

warehouse_climate_limits(_, _, _, _) :-
    write( 'Invalid limits' ), nl.


delete_warehouse(Id) :-
    frame_exists(Id), !,
    delete_frame(Id),
    write( 'Warehouse [' ), write(Id), write( '] was deleted' ), nl.

delete_warehouse(Id) :-
    write( 'Warehouse [' ), write(Id), write( '] not found' ), nl.

% =========================
% Sensors
% =========================
def_sensor :- 
    new_frame(sensor),
    new_slot(sensor,id),
    new_slot(sensor,type),
    new_slot(sensor, current_value),
    new_slot(sensor,location),
    new_slot(sensor,state).

def_sensors :-
    new_frame(sensor_temp),
    new_slot(sensor_temp, is_a, sensor),
    new_value(sensor_temp, type, temperature),
    new_value(sensor_temp, current_value, 20), % starting at 20ºC

    new_frame(sensor_humidity),
    new_slot(sensor_humidity, is_a, sensor),
    new_value(sensor_humidity, type, humidity),
    new_value(sensor_humidity, current_value, 50), % starting at 50% humidity

    new_frame(sensor_co2),
    new_slot(sensor_co2, is_a, sensor),
    new_value(sensor_co2, type, co2),
    new_value(sensor_co2, current_value, 400), % 400 ppm = good. 1000 ppm = very bad

    new_frame(sensor_presence),
    new_slot(sensor_presence, is_a, sensor),
    new_value(sensor_presence, type, presence),
    new_value(sensor_presence, current_value, 0),

    new_frame(sensor_door),
    new_slot(sensor_door, is_a, sensor),
    new_value(sensor_door, type, door_sensor),
    new_value(sensor_door, current_value, closed).

create_sensor(Id, Type, InitialValue, Location) :-
    \+ frame_exists(Id), !,
    new_frame(Id),
    new_slot(Id, is_a, sensor),
    new_value(Id, type, Type),
    new_value(Id, current_value, InitialValue),
    new_value(Id, location, Location),
    new_value(Id, state, active),                           % Começa state ativo
    write( 'Sensor [' ), write(Id), write( '] created' ), nl.

create_sensor(Id, _, _, _) :-
    write( 'Sensor [' ), write(Id), write( '] already exists' ), nl.


visualize_sensor(Id) :-
    frame_exists(Id), !,
    show_frame(Id).

visualize_sensor(Id) :-
    write( 'Sensor [' ), write(Id), write( '] not found' ), nl.


update_sensor_value(Id, NewValue) :-
    frame_exists(Id), !,
    new_value(Id, current_value, NewValue),
    write( 'Sensor [' ), write(Id), write( '] value changed to ' ), write(NewValue), nl.

update_sensor_value(Id, _) :-
    write( 'Sensor [' ), write(Id), write( '] not found' ), nl.


delete_sensor(Id) :-
    frame_exists(Id), !,
    delete_frame(Id),
    write( 'Sensor [' ), write(Id), write( '] was deleted' ), nl.

delete_sensor(Id) :-
    write( 'Sensor [' ), write(Id), write( '] not found' ), nl.

% -------------------------
% Sensors Demons
% -------------------------

def_sensor_demons :-
    % Demon to activate cooling attached to temperature sensor
    new_demon(sensor_temp, current_value, temp_control, if_write, after, side_effect),

    % Demon for humidification
    new_demon(sensor_humidity, current_value, humidity_control, if_write, after, side_effect),

    % Demon for CO2 ventilation
    new_demon(sensor_co2, current_value, co2_control, if_write, after, side_effect),

    % Demon for adaptive climate control
    new_demon(sensor_presence, current_value, occupancy_control, if_write, after, side_effect),

    % Demon for for door control
    new_demon(sensor_door, current_value, door_control, if_write, after, side_effect).


% -------------------------
% Temperature demon
% -------------------------
temp_control(_F, _S, T, T) :-
    new_value(warehouse, current_temperature, T),   
    get_value(warehouse, ls, Ls),
    get_value(warehouse, las, Las),
    get_value(warehouse, lai, Lai),
    get_value(warehouse, li, Li), !,
    eval_climate_states(T, Lai, Li, Ls, Las).


eval_climate_states(T, _Lai, _Li, _Ls, Las) :-
    T > Las, !,
    new_value(cooling_system, state, on),
    new_value(alarm_system, state, on),
    getdate(D),
    genmsg_general(sensor_temp, burning, T, critical, D),
    write( 'BURNING -> Cooling ON, Alarm ON' ), nl.

eval_climate_states(T, _Lai, _Li, Ls, Las) :-
    T >= Ls, T =< Las, !,
    new_value(cooling_system, state, on),
    new_value(alarm_system, state, off),
    write( 'HOT -> Cooling ON' ), nl.

eval_climate_states(T, Lai, _Li, _Ls, _Las) :-
    T < Lai, !,
    new_value(cooling_system, state, off),
    new_value(alarm_system, state, on),
    getdate(D),
    genmsg_general(sensor_temp, freezing, T, critical, D),
    write( 'FREEZING -> Alarm ON' ), nl.

eval_climate_states(T, Lai, Li, _Ls, _Las) :-
    T >= Lai, T < Li, !,
    new_value(cooling_system, state, off),
    new_value(alarm_system, state, off),
    write( 'COLD' ), nl.

eval_climate_states(_T, _Lai, _Li, _Ls, _Las) :-
    new_value(cooling_system, state, off),
    new_value(alarm_system, state, off),
    write( 'COMFORT' ), nl.


% -------------------------
% Humidity demon
% -------------------------

humidity_control(_F, _S, Humidity, Humidity) :-
    Humidity > 70, !,
    new_value(humidifier, state, off),
    getdate(D),
    genmsg_general(sensor_humidity, humidity_high, Humidity, warning, D).

humidity_control(_F, _S, Humidity, Humidity) :-
    Humidity < 40, !,
    new_value(humidifier, state, on),
    getdate(D),
    genmsg_general(sensor_humidity, humidity_low, Humidity, warning, D).

humidity_control(_F, _S, Humidity, Humidity) :-
    Humidity >= 40,
    Humidity =< 70,
    new_value(humidifier, state, off).


% -------------------------
% CO2 demon
% -------------------------

co2_control(_F, _S, CO2, CO2) :-
    CO2 > 900, !,
    new_value(ventilation, state, on),
    getdate(D),
    genmsg_general(sensor_co2, co2_high, CO2, warning, D).

co2_control(_F, _S, CO2, CO2) :-
    CO2 =< 900,
    new_value(ventilation, state, off).

% -------------------------
% Occupancy demon 
% X = 10 (expected amount of people)
% Y = 3  (tolerance)
% Z = 2  (degrees to adapt)
% -------------------------
occupancy_control(_F, _S, People, People) :-
    People > 13, !,
    adapt_limits(-2),
    getdate(D),
    genmsg_general(sensor_presence, occupancy_high, People, warning, D).

occupancy_control(_F, _S, People, People) :-
    People < 7, !,
    adapt_limits(2),
    getdate(D),
    genmsg_general(sensor_presence, occupancy_low, People, warning, D).

occupancy_control(_F, _S, People, People) :-
    People >= 7,
    People =< 13,
    adapt_limits(0).


adapt_limits(Z) :-
    get_value(warehouse, lai, CurrentLai),
    get_value(warehouse, li, CurrentLi),
    get_value(warehouse, ls, CurrentLs),
    get_value(warehouse, las, CurrentLas),
    
    NewLai is CurrentLai + Z,
    NewLi is CurrentLi + Z,
    NewLs is CurrentLs + Z,
    NewLas is CurrentLas + Z,
    
    warehouse_climate_limits(NewLai, NewLi, NewLs, NewLas).


% -------------------------
% Door demon
% -------------------------

door_control(_F, _S, DoorState, DoorState) :-
    update_doors(DoorState),
    door_alarm(DoorState).

update_doors(open) :-
    new_value(automatic_doors, state, open).

update_doors(closed) :-
    new_value(automatic_doors, state, closed).

door_alarm(open) :-
    getdate(D),
    genmsg_general(sensor_door, door_open, open, info, D).

door_alarm(closed).

% =========================
% Actuator
% =========================
def_actuator :-
    new_frame(actuator),
    new_slot(actuator,id),
    new_slot(actuator, type),
    new_slot(actuator, state).

def_actuators :- 
    new_frame(cooling_system),
    new_slot(cooling_system,is_a, actuator),
    new_value(cooling_system, type, cooling),
    new_value(cooling_system, state, off),

    new_frame(ventilation),
    new_slot(ventilation,is_a, actuator),
    new_value(ventilation, type, ventilation),
    new_value(ventilation, state, on),

    new_frame(humidifier),
    new_slot(humidifier,is_a, actuator),
    new_value(humidifier, type, humidifier),
    new_value(humidifier, state, off),

    new_frame(alarm_system),
    new_slot(alarm_system, is_a, actuator),
    new_value(alarm_system, type, alarm),
    new_value(alarm_system, state, off),

    new_frame(automatic_doors),
    new_slot(automatic_doors, is_a, actuator),
    new_value(automatic_doors, type, doors),
    new_value(automatic_doors, state, closed).

create_actuator(Id, Type) :-
    \+ frame_exists(Id), !,
    new_frame(Id),
    new_slot(Id, is_a, actuator),
    new_value(Id, type, Type),
    new_value(Id, state, off),                              % Começa state off
    write( 'Actuator [' ), write(Id), write( '] created' ), nl.

create_actuator(Id, _) :-
    write( 'Actuator [' ), write(Id), write( '] already exists' ), nl.


visualize_actuator(Id) :-
    frame_exists(Id), !,
    show_frame(Id).

visualize_actuator(Id) :-
    write( 'Actuator [' ), write(Id), write( '] not found' ), nl.


update_actuator_state(Id, NewState) :-
    frame_exists(Id), !,
    new_value(Id, state, NewState),
    write( 'Actuator [' ), write(Id), write( '] state changed to ' ), write(NewState), nl.

update_actuator_state(Id, _) :-
    write( 'Actuator [' ), write(Id), write( '] not found' ), nl.


delete_actuator(Id) :-
    frame_exists(Id), !,
    delete_frame(Id),
    write( 'Actuator [' ), write(Id), write( '] was deleted' ), nl.

delete_actuator(Id) :-
    write( 'Actuator [' ), write(Id), write( '] not found' ), nl.

% =========================
% Product
% =========================
def_product :-
    new_frame(product),
    new_slot(product, name),
    new_slot(product, reference),
    new_slot(product, category),
    new_slot(product, quantity),
    new_slot(product, expiration_date),
    new_slot(product, ideal_temperature),
    new_slot(product, warehouse_location),
    new_slot(product, unit_price).


create_product(ProductFrame, _, _, _, _, _, _, _, _) :-
    frame_exists(ProductFrame), !,
    write( 'Product [' ), write(ProductFrame), write( '] already exists' ), nl.

create_product(ProductFrame, Name, Reference, Category, Quantity, ExpirationDate, IdealTemp, WarehouseLocation, UnitPrice) :-
    Quantity >= 0,
    UnitPrice >= 0, !,

    new_frame(ProductFrame),
    new_slot(ProductFrame, is_a, product),

    new_value(ProductFrame, name, Name),
    new_value(ProductFrame, reference, Reference),
    new_value(ProductFrame, category, Category),
    new_value(ProductFrame, quantity, Quantity),
    new_value(ProductFrame, expiration_date, ExpirationDate),
    new_value(ProductFrame, ideal_temperature, IdealTemp),
    new_value(ProductFrame, warehouse_location, WarehouseLocation),
    new_value(ProductFrame, unit_price, UnitPrice),
    write( 'Product [' ), write(ProductFrame), write( '] created' ), nl.

create_product(ProductFrame, _, _, _, Quantity, _, _, _, UnitPrice) :-
    write( 'Product [' ), write(ProductFrame), write( '] failed: invalid quantity or unit price (' ),
    write(Quantity), write(', '), write(UnitPrice), write( ')' ), nl.


visualize_product(Id) :-
    frame_exists(Id), !,
    show_frame(Id).

visualize_product(Id) :-
    write( 'Product [' ), write(Id), write( '] not found' ), nl.


update_product_stock(Id, _) :-
    \+ frame_exists(Id), !,
    write( 'Product [' ), write(Id), write( '] not found' ), nl.

update_product_stock(Id, NewQuantity) :-
    NewQuantity >= 0, !,
    new_value(Id, quantity, NewQuantity),
    write( 'Product [' ), write(Id), write( '] stock changed to ' ), write(NewQuantity), nl.

update_product_stock(Id, NewQuantity) :-
    write( 'Product [' ), write(Id), write( '] failed: invalid quantity (' ),
    write(NewQuantity), write( ')' ), nl.


delete_product(Id) :-
    frame_exists(Id), !,
    delete_frame(Id),
    write( 'Product [' ), write(Id), write( '] was deleted' ), nl.

delete_product(Id) :-
    write( 'Product [' ), write(Id), write( '] not found' ), nl.

% =========================
% Order
% =========================
def_order :-
    new_frame(order),
    new_slot(order, reference),
    new_slot(order, included_products),
    new_slot(order, quantity),
    new_slot(order, price),
    new_slot(order, order_state).


valid_order_quantity(Quantity) :-
    number(Quantity),
    Quantity > 0.

valid_product_for_order(ProductFrame) :-
    frame_exists(ProductFrame),
    get_value(ProductFrame, is_a, product),
    get_value(ProductFrame, quantity, Stock),
    number(Stock),
    get_value(ProductFrame, unit_price, UnitPrice),
    number(UnitPrice).

valid_order_frame(OrderFrame) :-
    frame_exists(OrderFrame),
    get_value(OrderFrame, is_a, order).


create_order(OrderFrame, _, _) :-
    frame_exists(OrderFrame), !,
    write( 'Order [' ), write(OrderFrame), write( '] already exists' ), nl.

create_order(OrderFrame, _, Quantity) :-
    \+ valid_order_quantity(Quantity), !,
    write( 'Order [' ), write(OrderFrame), write( '] failed: invalid quantity (' ),
    write(Quantity), write( ')' ), nl.

create_order(OrderFrame, ProductFrame, _) :-
    \+ valid_product_for_order(ProductFrame), !,
    write( 'Order [' ), write(OrderFrame), write( '] failed: product [' ),
    write(ProductFrame), write( '] not found or invalid' ), nl.

create_order(OrderFrame, ProductFrame, Quantity) :-
    get_value(ProductFrame, quantity, Stock),
    Stock < Quantity, !,

    getdate(D),
    genmsg_general(stock_system, stock_unavailable, Quantity, warning, D),
    write( 'Order [' ), write(OrderFrame), write( '] failed because of insufficient stock' ), nl.

create_order(OrderFrame, ProductFrame, Quantity) :-
    get_value(ProductFrame, quantity, Stock),
    get_value(ProductFrame, unit_price, UnitPrice),

    Price is Quantity * UnitPrice,
    NewStock is Stock - Quantity,

    new_value(ProductFrame, quantity, NewStock),

    new_frame(OrderFrame),
    new_slot(OrderFrame, is_a, order),
    new_value(OrderFrame, reference, OrderFrame),
    new_value(OrderFrame, included_products, ProductFrame),
    new_value(OrderFrame, quantity, Quantity),
    new_value(OrderFrame, price, Price),
    new_value(OrderFrame, order_state, pending),
    write( 'Order [' ), write(OrderFrame), write( '] created successfully' ), nl.


visualize_order(Id) :-
    valid_order_frame(Id), !,
    show_frame(Id).

visualize_order(Id) :-
    write( 'Order [' ), write(Id), write( '] not found' ), nl.


valid_order_state(pending).
valid_order_state(preparing).
valid_order_state(shipped).
valid_order_state(delivered).

update_order_state(OrderFrame, _) :-
    \+ valid_order_frame(OrderFrame), !,
    write( 'Order [' ), write(OrderFrame), write( '] not found' ), nl.

update_order_state(OrderFrame, NewState) :-
    valid_order_state(NewState), !,
    new_value(OrderFrame, order_state, NewState),
    write( 'Order [' ), write(OrderFrame), write( '] state changed to ' ), write(NewState), nl.

update_order_state(OrderFrame, NewState) :-
    write( 'Order [' ), write(OrderFrame), write( '] failed: invalid state (' ),
    write(NewState), write( ')' ), nl.

% =========================
% GENERAL ALARM DEFINITION
% =========================

def_general_alarm :-
    new_frame(alarmG),
    new_slot(alarmG, event),
    new_slot(alarmG, source),
    new_slot(alarmG, value),
    new_slot(alarmG, severity),
    new_slot(alarmG, message),
    new_slot(alarmG, date),
    new_slot(alarmG, count, 0).

genmsg_general(Source, Event, Value, Severity, Date) :-
    genname_general(N),
    new_frame(N),
    new_slot(N, is_a, alarmG),

    new_value(N, event, Event),
    new_value(N, source, Source),
    new_value(N, value, Value),
    new_value(N, severity, Severity),

    alarm_message(Event, Message),
    new_value(N, message, Message),

    new_value(N, date, Date),

    activate_alarm_system.

genname_general(N) :-
    get_value(alarmG, count, A),
    A1 is A + 1,
    new_value(alarmG, count, A1),
    atom_concat(alarmG, A1, N).

activate_alarm_system :-
    frame_exists(alarm_system),
    new_value(alarm_system, state, on).
activate_alarm_system.

% =========================
% ALARM MESSAGES
% =========================

alarm_message(burning, temperature_above_absolute_upper_limit).
alarm_message(freezing, temperature_below_absolute_lower_limit).
alarm_message(occupancy_high, occupancy_above_expected_range).
alarm_message(occupancy_low, occupancy_below_expected_range).
alarm_message(stock_unavailable, insufficient_stock_available).
alarm_message(door_open, door_is_open).
alarm_message(door_closed, door_is_closed).
alarm_message(humidity_high, humidity_above_safe_range).
alarm_message(humidity_low, humidity_below_safe_range).
alarm_message(co2_high, co2_above_safe_range).

alarm_message(_, generic_alarm).

show_general_alarms :-
    get_value(alarmG, count, Total),
    write('Total general alarms: '), write(Total), nl,
    show_general_alarms_from(Total).

show_general_alarms_from(0) :-
    !.

show_general_alarms_from(N) :-
    N > 0,
    atom_concat(alarmG, N, AlarmFrame),
    (frame_exists(AlarmFrame) -> show_frame(AlarmFrame) ; true),
    N1 is N - 1,
    show_general_alarms_from(N1).

% =========================
% MISC
% =========================

getdate(D) :-
    get_time(T),
    stamp_date_time(T, D, 'UTC').

def_isa :-
    new_relation(is_a, transitive, all, nil).