:- ['golog2_2026.pl'].
:- ['ac.pl'].

model_wh :-
    def_warehouse,
    def_sensor,
    def_sensors,
    def_actuator,
    def_actuators,
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
    new_value(humidifier, state, off).
    %new_value(ventilation, state, on).

humidity_control(_F, _S, Humidity, Humidity) :-
    Humidity < 40,
    new_value(humidifier, state, on).

humidity_control(_F, _S, Humidity, Humidity) :-
    Humidity >= 40,
    Humidity =< 70,
    new_value(humidifier, state, off).


% -------------------------
% CO2 demon
% -------------------------

co2_control(_F, _S, CO2, CO2) :-
    CO2 > 900,
    new_value(ventilation, state, on).

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
    genmsg(People, occupancy_high, D).

occupancy_control(_F, _S, People, People) :-
    People < 7,
    adapt_limits(2),
    getdate(D),
    genmsg(People, occupancy_low, D).

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
    update_doors(DoorState).

update_doors(open) :-
    new_value(automatic_doors, state, open).

update_doors(closed) :-
    new_value(automatic_doors, state, closed).

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
% misc
% =========================