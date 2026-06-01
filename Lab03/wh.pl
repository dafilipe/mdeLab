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
    new_slot(sensor, curren_value),
    new_slot(sensor,location),
    new_slot(sensor,state).

def_sensors :-
    new_frame(sensor_temp),
    new_slot(sensor_temp, is_a, sensor),
    new_values(sensor_temp, type, temperature),
    new_value(sensor_temp, current_value, 20), % starting at 20ºC

    new_frame(sensor_humidity),
    new_slot(sensor_humidity, is_a, sensor),
    new_values(sensor_humidity, type, humidity),
    new_value(sensor_humidity, current_value, 50), % starting at 50% humidity

    new_frame(sensor_co2),
    new_slot(sensor_co2, is_a, sensor),
    new_values(sensor_co2, type, co2),
    new_value(sensor_co2, current_value, 400). % idk what value to put

    % to-do 
    % new_frame(sensor_presence)
    % new_frame(sensor_door)

% =========================
% Actuator
% =========================
def_actuator.

% =========================
% Product
% =========================
def_product.

% =========================
% Order
% =========================
def_order.