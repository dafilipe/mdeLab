model_wh :-
    def_isa,
    def_warehouse,
    def_sensor,
    def_sensors,
    def_actuator,
    def_actuators,
    def_product,
    def_order.

% =========================
% WhareHouse
% =========================
def_warehouse.

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
    new_value(sensor_co2, current_value, 400). % idk what value to put

    % to-do 
    % new_frame(sensor_presence)
    % new_frame(sensor_door)

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
    new_value(humidifier, state, off).

    % to-do 
    % new_frame(alarm_system)
    % new_frame(automatic_doors)

% =========================
% Product
% =========================
def_product.

% =========================
% Order
% =========================
def_order.

% =========================
% misc
% =========================