:- ['golog2_2026.pl'].
:- ['ac.pl'].

model_wh :-
    model_ac,
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
    new_slot(warehouse, operational_state).

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
    new_value(thermo, temp, T),
    new_value(warehouse, current_temperature, T),   

    get_value(thermo, ls, Ls),
    update_cooling(T, Ls).


update_cooling(T, Ls) :-
    T > Ls,
    new_value(cooling_system, state, on).

update_cooling(T, Ls) :-
    T =< Ls,
    new_value(cooling_system, state, off).


% -------------------------
% Humidity demon
% -------------------------

humidity_control(_F, _S, Humidity, Humidity) :-
    Humidity > 70,
    new_value(humidifier, state, off),
    %new_value(ventilation, state, on),
    getdate(D),
    genmsg_general(sensor_humidity, humidity_high, Humidity, warning, D).

humidity_control(_F, _S, Humidity, Humidity) :-
    Humidity < 40,
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
    CO2 > 900,
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
    People > 13,
    adapt_limits(-2),
    getdate(D),
    genmsg_general(sensor_presence, occupancy_high, People, warning, D).

occupancy_control(_F, _S, People, People) :-
    People < 7,
    adapt_limits(2),
    getdate(D),
    genmsg_general(sensor_presence, occupancy_low, People, warning, D).

occupancy_control(_F, _S, People, People) :-
    People >= 7,
    People =< 13,
    adapt_limits(0).

% helper
base_limits(14, 0, 25, 35).

adapt_limits(Z) :-
    base_limits(BaseLi, BaseLai, BaseLs, BaseLas),

    NewLi is BaseLi + Z,
    NewLai is BaseLai + Z,
    NewLs is BaseLs + Z,
    NewLas is BaseLas + Z,

    new_value(thermo, li, NewLi),
    new_value(thermo, ls, NewLs),
    new_value(thermo, lai, NewLai),
    new_value(thermo, las, NewLas).

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

% =========================
% Product creation
% =========================

create_product(ProductFrame, Name, Reference, Category, Quantity, ExpirationDate, IdealTemp, WarehouseLocation, UnitPrice) :-
    Quantity >= 0,
    UnitPrice >= 0,

    new_frame(ProductFrame),
    new_slot(ProductFrame, is_a, product),

    new_value(ProductFrame, name, Name),
    new_value(ProductFrame, reference, Reference),
    new_value(ProductFrame, category, Category),
    new_value(ProductFrame, quantity, Quantity),
    new_value(ProductFrame, expiration_date, ExpirationDate),
    new_value(ProductFrame, ideal_temperature, IdealTemp),
    new_value(ProductFrame, warehouse_location, WarehouseLocation),
    new_value(ProductFrame, unit_price, UnitPrice).

% =========================
% Stock update
% =========================

update_stock(ProductFrame, NewQuantity) :-
    NewQuantity >= 0,
    new_value(ProductFrame, quantity, NewQuantity).

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

% =========================
% Order creation
% =========================

create_order(OrderFrame, ProductFrame, Quantity) :-
    Quantity > 0,
    get_value(ProductFrame, quantity, Stock),
    Stock >= Quantity,

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
    new_value(OrderFrame, order_state, pending).

create_order(_OrderFrame, ProductFrame, Quantity) :-
    Quantity > 0,
    get_value(ProductFrame, quantity, Stock),
    Stock < Quantity,

    getdate(D),
    genmsg_general(stock_system, stock_unavailable, Quantity, warning, D).

% =========================
% Order state update
% =========================

valid_order_state(pending).
valid_order_state(preparing).
valid_order_state(shipped).
valid_order_state(delivered).

update_order_state(OrderFrame, NewState) :-
    valid_order_state(NewState),
    new_value(OrderFrame, order_state, NewState).

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
