:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_json)).

:- dynamic server_running/0.
:- dynamic mqtt_value/2.
:- dynamic robot_position/3.
:- dynamic op_status/5.

:- http_handler('/mqtt', mqtt_handler, []).
:- http_handler('/status', status_handler, []).


% ---------------------------------------------------------
% START SERVER
% ---------------------------------------------------------

start_server(Port) :-
    (
        server_running
    ->
        true
    ;
        assertz(server_running),
        http_server(http_dispatch, [port(Port)])
    ).


% ---------------------------------------------------------
% DEVICE -> ROBOT ID
% ---------------------------------------------------------

device_robot_id(drone1, 1).
device_robot_id(ugv1, 6).
device_robot_id(ac1, 11).


% ---------------------------------------------------------
% MQTT HANDLER
% Exemplo:
% /mqtt?topic=drone1/battery&value=80
% ---------------------------------------------------------

mqtt_handler(Request) :-
    http_parameters(Request, [
        topic(Topic, [atom]),
        value(Value, [atom])
    ]),

    update_mqtt_value(Topic, Value),
    update_knowledge_base_from_mqtt(Topic, Value, Result),

    reply_json(_{
        status: "ok",
        topic: Topic,
        value: Value,
        result: Result
    }).


update_mqtt_value(Topic, Value) :-
    retractall(mqtt_value(Topic, _)),
    assertz(mqtt_value(Topic, Value)).


parse_topic(Topic, Device, Field) :-
    atomic_list_concat([Device, Field], '/', Topic).


% ---------------------------------------------------------
% UPDATE KNOWLEDGE BASE FROM MQTT
% ---------------------------------------------------------

update_knowledge_base_from_mqtt(Topic, Value, Result) :-
    parse_topic(Topic, Device, battery),
    device_robot_id(Device, RobotID),
    atom_number(Value, Battery),
    update_robot_battery(RobotID, Battery),
    !,
    Result = _{
        type: "battery_update",
        robot_id: RobotID,
        battery: Battery
    }.

update_knowledge_base_from_mqtt(Topic, Value, Result) :-
    parse_topic(Topic, Device, available),
    device_robot_id(Device, RobotID),
    availability_to_status(Value, MissionStatus),
    update_robot_mission_status(RobotID, MissionStatus),
    !,
    Result = _{
        type: "availability_update",
        robot_id: RobotID,
        mission_status: MissionStatus
    }.

update_knowledge_base_from_mqtt(Topic, Value, Result) :-
    parse_topic(Topic, Device, latitude),
    device_robot_id(Device, RobotID),
    atom_number(Value, Latitude),
    update_robot_position(RobotID, latitude, Latitude),
    !,
    Result = _{
        type: "latitude_update",
        robot_id: RobotID,
        latitude: Latitude
    }.

update_knowledge_base_from_mqtt(Topic, Value, Result) :-
    parse_topic(Topic, Device, longitude),
    device_robot_id(Device, RobotID),
    atom_number(Value, Longitude),
    update_robot_position(RobotID, longitude, Longitude),
    !,
    Result = _{
        type: "longitude_update",
        robot_id: RobotID,
        longitude: Longitude
    }.

update_knowledge_base_from_mqtt(Topic, Value, Result) :-
    Result = _{
        type: "unknown_topic",
        topic: Topic,
        value: Value
    }.


% ---------------------------------------------------------
% UPDATE ROBOT BATTERY
% ---------------------------------------------------------

update_robot_battery(RobotID, Battery) :-
    (
        retract(op_status(RobotID, Location, _, MissionStatus, LoadID))
    ->
        true
    ;
        Location = 10,
        MissionStatus = idle,
        LoadID = none
    ),
    assertz(op_status(RobotID, Location, Battery, MissionStatus, LoadID)).


% ---------------------------------------------------------
% UPDATE ROBOT AVAILABILITY / MISSION STATUS
% ---------------------------------------------------------

availability_to_status(Value, Status) :-
    downcase_atom(Value, Lower),
    (
        Lower = true
    ->
        Status = idle
    ;
        Lower = false
    ->
        Status = paused
    ;
        Status = unknown
    ).


update_robot_mission_status(RobotID, MissionStatus) :-
    (
        retract(op_status(RobotID, Location, Battery, _, LoadID))
    ->
        true
    ;
        Location = 10,
        Battery = 100,
        LoadID = none
    ),
    assertz(op_status(RobotID, Location, Battery, MissionStatus, LoadID)).


% ---------------------------------------------------------
% UPDATE ROBOT POSITION
% ---------------------------------------------------------

update_robot_position(RobotID, latitude, Latitude) :-
    (
        retract(robot_position(RobotID, _, Longitude))
    ->
        true
    ;
        Longitude = unknown
    ),
    assertz(robot_position(RobotID, Latitude, Longitude)).

update_robot_position(RobotID, longitude, Longitude) :-
    (
        retract(robot_position(RobotID, Latitude, _))
    ->
        true
    ;
        Latitude = unknown
    ),
    assertz(robot_position(RobotID, Latitude, Longitude)).


% ---------------------------------------------------------
% STATUS HANDLER
% Exemplo:
% /status?id=1
% ---------------------------------------------------------

status_handler(Request) :-
    http_parameters(Request, [
        id(RobotID, [integer])
    ]),

    (
        op_status(RobotID, Location, Battery, MissionStatus, LoadID)
    ->
        reply_json(_{
            status: "ok",
            robot_id: RobotID,
            location: Location,
            battery: Battery,
            mission_status: MissionStatus,
            load_id: LoadID
        })
    ;
        reply_json(_{
            status: "error",
            message: "robot_not_found",
            robot_id: RobotID
        })
    ).