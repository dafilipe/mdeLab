SET SQL_SAFE_UPDATES = 0;
-- RF tests

-- rf1
SELECT 
    plate AS Matricula,
    entry_time AS Inicio,
    fin_time AS Fim,
    cons_energy AS Energia,
    id_charger AS ID_Carregador
FROM 
    charging_session
WHERE 
    -- Filtro de Matriculas pertencentes ao user com nome : 'Diogo Silva'
    plate IN (
        SELECT plate 
        FROM car 
        WHERE id_user = (
            SELECT id_user 
            FROM user 
            WHERE name = 'Diogo Silva' -- Alterar nome aqui
        )
    )
    -- Filtro de Intervalo de Tempo
    -- Formatdo data ANO-MES-DIA
    AND entry_time BETWEEN '2025-01-01 00:00:00' AND '2025-01-15 23:59:59' -- Alterar datas aqui
ORDER BY 
    -- Ordena por chegada mais recente em cima
    entry_time DESC;
    -- colocar local
    
-- RF 2
SELECT 
    id_session,
    plate AS Matricula,
    entry_time AS Inicio,
    fin_time AS Fim,
    cons_energy AS Energia,
    id_charger AS ID_Carregador
FROM 
    charging_session
WHERE 
    -- Filtra carregadores que pertencem ao posto com ID : x
    id_charger IN (
        SELECT id_charger 
        FROM charger 
        WHERE id_station = 1 -- Mudar posto aqui
    )
ORDER BY 
	-- Ordena por chegada mais recente em cima
    entry_time DESC;
    

-- RF 3
SELECT 
    u.name AS 'Nome User',
    c.plate AS 'Matricula',
    c.brand AS 'Marca',
    c.model AS 'Modelo',
    s.city AS 'Localização Posto',
    s.address AS 'Morada',
    cs.entry_time AS 'Início  Sessão',
    cs.fin_time AS 'Fim  Sessão',
    cs.cons_energy AS 'Energia'
FROM 
    charging_session cs
JOIN 
    car c ON cs.plate = c.plate
JOIN 
    user u ON c.id_user = u.id_user
JOIN 
    charger chr ON cs.id_charger = chr.id_charger
JOIN 
    station s ON chr.id_station = s.id_station
ORDER BY 
	-- Ordena por chegada mais recente
    cs.entry_time DESC;

-- RF4
-- select * from charging_session;
SELECT 
    c.id_charger,
    c.id_station,
    s.city,
    s.address,
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
    u.id_user,
    u.name,
    u.email,
    SUM(cs.cons_energy) AS total_consumed_energy
FROM `user` u
JOIN car c
    ON u.id_user = c.id_user
JOIN charging_session cs
    ON c.plate = cs.plate

GROUP BY u.id_user, u.name, u.email
HAVING SUM(cs.cons_energy) IS NOT NULL
ORDER BY total_consumed_energy DESC;

-- RF6

CREATE VIEW view_sensor_meas1 AS
SELECT
    sm.id_measurement,
    s.id_sensor,
    c.id_charger,
    c.id_station,
    s.sens_type,
    sm.measured_value,
    sm.date_time
FROM sensor_measurement sm
JOIN sensor s
    ON sm.id_sensor = s.id_sensor
JOIN charger c
    ON s.id_charger = c.id_charger
JOIN station se
    ON c.id_station = se.id_station;
    --  tirar id sensor e colocar local estação em vez do id
SELECT * FROM view_sensor_meas1;



-- rf7 e 8

UPDATE charging_session
SET fin_time = '2025-01-31 12:00:00',
    cons_energy = 68.00
WHERE id_session = 6;

select * from charging_session where fin_time is not null; 
SELECT * FROM receipt;
select * from alert;

-- rf10
select * FROM tecnicalDepartment where local_area = "Coimbra";

-- rf11
SELECT local_area, count(*) as total_area 
from tecnicalDepartment group by local_area;

-- rf 12
UPDATE tecnicalDepartment
SET estado = 'disponivel'
WHERE id_tecnico > 0;

update charger set state = "available" WHERE id_charger = 3 ;
select * from charger;
select * from station;
select * FROM tecnicalDepartment;


-- fazer um select para mostrar os rf todos juntos