-- RF4
-- select * from charging_session;
SELECT 
    c.id_charger AS Carregador,
    c.id_station AS Estacao,
    s.city AS Cidade,
    s.address AS Morada,
    COUNT(cs.id_session) AS total_sessions
FROM charging_session cs
JOIN charger c 
    ON cs.id_charger = c.id_charger
JOIN station s
    ON c.id_station = s.id_station
WHERE cs.entry_time BETWEEN '2025-01-01 00:00:00' AND '2025-01-30 23:59:59' -- alterar data aqui
GROUP BY c.id_charger, c.id_station, s.city, s.address
ORDER BY total_sessions DESC;

-- RF5

SELECT 
    u.id_user AS Utilizador,
    u.name AS Nome,
    u.email AS Email,
    SUM(cs.cons_energy) AS total_consumed_energy
FROM `user` u
JOIN car c
    ON u.id_user = c.id_user
JOIN charging_session cs
    ON c.plate = cs.plate
GROUP BY u.id_user, u.name, u.email
ORDER BY total_consumed_energy DESC;

-- RF6

CREATE VIEW view_sensor_meas1 AS
SELECT
    sm.id_measurement AS ID_Medida,
    s.id_sensor AS Sensor,
    c.id_charger AS Carregador,
    c.id_station AS Estacao,
    s.sens_type AS Tipo,
    sm.measured_value AS Medida,
    sm.date_time AS Data_Hora
FROM sensor_measurement sm
JOIN sensor s
    ON sm.id_sensor = s.id_sensor
JOIN charger c
    ON s.id_charger = c.id_charger
JOIN station se
    ON c.id_station = se.id_station;
    
SELECT * FROM view_sensor_meas1;