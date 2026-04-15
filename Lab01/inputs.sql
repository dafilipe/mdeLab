USE voltWay_db;

-- =========================
-- PRICING
-- =========================
INSERT INTO pricing VALUES
('basic', 3),
('premium', 2),
('corporate', 1);

-- =========================
-- USERS 
-- =========================
INSERT INTO user (name, email, phone_num, register_date, type) VALUES
('Diogo Silva', 'diogo@gmail.com', 911111111, '2024-01-10', 'premium'),
('Ana Costa', 'ana@gmail.com', 922222222, '2024-02-15', 'basic'),
('João Pereira', 'joao@gmail.com', 933333333, '2024-03-20', 'corporate'),
('Maria Lopes', 'maria@gmail.com', 944444444, '2024-04-05', 'basic'),
('Pedro Santos', 'pedro@gmail.com', 955555555, '2024-05-01', 'premium'),
('Carla Mendes', 'carla@gmail.com', 966666666, '2024-06-10', 'basic');

-- =========================
-- CONNECTION TYPES
-- =========================
INSERT INTO conection_type VALUES
('Type2'),
('CCS'),
('CHAdeMO');

-- =========================
-- CARS 
-- =========================
INSERT INTO car VALUES
('AA-11-AA', 1, 'Tesla', 'Model 3', 75, 2022, 'Type2'),
('BB-22-BB', 1, 'Nissan', 'Leaf', 40, 2020, 'CHAdeMO'),
('CC-33-CC', 2, 'BMW', 'i3', 42, 2019, 'Type2'),
('DD-44-DD', 3, 'Tesla', 'Model S', 100, 2023, 'CCS'),
('EE-55-EE', 4, 'Renault', 'Zoe', 52, 2021, 'Type2'),
('FF-66-FF', 5, 'Hyundai', 'Kona', 64, 2022, 'CCS'),
('GG-77-GG', 5, 'Peugeot', 'e-208', 50, 2021, 'Type2'),
('HH-88-HH', 6, 'VW', 'ID.3', 58, 2023, 'CCS');

-- =========================
-- STATIONS 
-- =========================
INSERT INTO station (city, address, gps, state) VALUES
('Lisboa', 'Av. Liberdade', '38.72,-9.13', 'active'),
('Porto', 'Rua Santa Catarina', '41.15,-8.61', 'active'),
('Coimbra', 'Praça da República', '40.21,-8.42', 'active'),
('Faro', 'Centro', '37.01,-7.93', 'maintenance'),
('Braga', 'Av. Central', '41.55,-8.42', 'active');

-- =========================
-- CHARGERS 
-- =========================
INSERT INTO charger (id_station, max_power, state) VALUES
(1, 50, 'available'),
(1, 22, 'occupied'),
(2, 100, 'available'),
(2, 50, 'available'),
(3, 22, 'available'),
(4, 50, 'available'),
(5, 150, 'available');

-- =========================
-- CHARGER CONNECTORS 
-- =========================
INSERT INTO charger_conector VALUES
(1, 'Type2'), (1, 'CCS'),
(2, 'Type2'), (2, 'CHAdeMO'),
(3, 'CCS'), (3, 'Type2'),
(4, 'CCS'), (4, 'CHAdeMO'),
(5, 'Type2'), (5, 'CCS'),
(6, 'CHAdeMO'), (6, 'Type2'),
(7, 'CCS'), (7, 'Type2');

-- =========================
-- SENSORS 
-- =========================
INSERT INTO sensor (id_charger, error, sens_type, state) VALUES
(1, b'0', 'temperature', b'1'),
(1, b'0', 'power', b'1'),
(2, b'1', 'temperature', b'0'),
(3, b'0', 'occupancy', b'1'),
(4, b'0', 'power', b'1'),
(5, b'0', 'temperature', b'1');

-- =========================
-- CHARGING SESSIONS (
-- =========================
INSERT INTO charging_session (id_charger, plate, entry_time) VALUES
(1, 'AA-11-AA', '2025-01-01 10:00:00'),
(2, 'BB-22-BB', '2025-01-02 12:00:00'),
(3, 'CC-33-CC', '2025-01-03 09:00:00'),
(4, 'DD-44-DD', '2025-01-04 14:00:00'),
(1, 'EE-55-EE', '2025-01-05 08:00:00'),
(2, 'FF-66-FF', '2025-01-06 16:00:00'),
(3, 'GG-77-GG', '2025-01-07 11:00:00'),
(4, 'HH-88-HH', '2025-01-08 18:00:00'),
(5, 'AA-11-AA', '2025-01-09 10:00:00'),
(6, 'BB-22-BB', '2025-01-10 12:00:00'),
(7, 'CC-33-CC', '2025-01-11 09:00:00'),
(1, 'DD-44-DD', '2025-01-12 14:00:00'),
(2, 'EE-55-EE', '2025-01-13 08:00:00'),
(3, 'FF-66-FF', '2025-01-14 16:00:00'),
(4, 'GG-77-GG', '2025-01-15 11:00:00'),
(5, 'HH-88-HH', '2025-01-16 18:00:00'),
(6, 'AA-11-AA', '2025-01-17 10:00:00'),
(7, 'BB-22-BB', '2025-01-18 12:00:00'),
(1, 'CC-33-CC', '2025-01-19 09:00:00'),
(2, 'DD-44-DD', '2025-01-20 14:00:00');

-- =========================
-- SENSOR MEASUREMENTS 
-- =========================
INSERT INTO sensor_measurement (id_sensor, date_time, measured_value) VALUES
-- Sensor 1
(1, '2025-01-01 10:00:00', 25),
(1, '2025-01-01 10:10:00', 27),
(1, '2025-01-01 10:20:00', 29),
(1, '2025-01-01 10:30:00', 30),
(1, '2025-01-01 10:40:00', 31),

-- Sensor 2
(2, '2025-01-02 12:00:00', 40),
(2, '2025-01-02 12:10:00', 42),
(2, '2025-01-02 12:20:00', 45),
(2, '2025-01-02 12:30:00', 47),
(2, '2025-01-02 12:40:00', 48),

-- Sensor 3
(3, '2025-01-03 09:00:00', 30),
(3, '2025-01-03 09:10:00', 32),
(3, '2025-01-03 09:20:00', 33),
(3, '2025-01-03 09:30:00', 34),
(3, '2025-01-03 09:40:00', 35),

-- Sensor 4 
(4, '2025-01-04 14:00:00', 1),
(4, '2025-01-04 14:10:00', 0),
(4, '2025-01-04 14:20:00', 1),
(4, '2025-01-04 14:30:00', 1),
(4, '2025-01-04 14:40:00', 0),

-- Sensor 5 
(5, '2025-01-05 08:00:00', 50),
(5, '2025-01-05 08:10:00', 55),
(5, '2025-01-05 08:20:00', 60),
(5, '2025-01-05 08:30:00', 58),
(5, '2025-01-05 08:40:00', 62),

-- Sensor 6
(6, '2025-01-06 16:00:00', 26),
(6, '2025-01-06 16:10:00', 28),
(6, '2025-01-06 16:20:00', 30),
(6, '2025-01-06 16:30:00', 32),
(6, '2025-01-06 16:40:00', 33);

ALTER TABLE tecnicalDepartment
MODIFY id_tecnico INT NOT NULL AUTO_INCREMENT;


INSERT INTO tecnicalDepartment (nome, telefone, email, local_area, estado) VALUES
-- Lisboa
('João Silva', 912345678, 'joao.silva@email.com', 'Lisboa', 'disponivel'),

('Ana Costa', 913456789, 'ana.costa@email.com', 'Lisboa', 'ocupado'),

-- Porto
('Rui Pereira', 914567890, 'rui.pereira@email.com', 'Porto', 'disponivel'),
('Marta Lopes', 915678901, 'marta.lopes@email.com', 'Porto', 'indisponivel'),

-- Coimbra
('Pedro Gomes', 916789012, 'pedro.gomes@email.com', 'Coimbra', 'ocupado'),
('Josefino Esdrubal', 912675967, 'Josefino.Esdrubal@email.com', 'Coimbra', 'Disponivel'),

-- Faro
('Sofia Almeida', 917890123, 'sofia.almeida@email.com', 'Faro', 'disponivel'),

-- Braga
('Tiago Fernandes', 918901234, 'tiago.fernandes@email.com', 'Braga', 'ocupado'),
('Carla Ribeiro', 919012345, 'carla.ribeiro@email.com', 'Braga', 'disponivel');

-- Criar View do RF6
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
    
-- Criar tabela para rf78

CREATE TABLE alert (
    id_alert INT NOT NULL AUTO_INCREMENT,
    id_session INT NOT NULL,
    energy_value DECIMAL(10,2) NOT NULL,
    threshold_value DECIMAL(10,2) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_alert),
    CONSTRAINT fk_alert_session
        FOREIGN KEY (id_session) REFERENCES charging_session(id_session)
);

-- Criar trigger de rf7

DELIMITER $$
CREATE TRIGGER trg_high_energy_alert
AFTER update ON charging_session
FOR EACH ROW
BEGIN
    DECLARE energy_limit DECIMAL(10,2) DEFAULT 50.00;

    IF NEW.cons_energy > energy_limit THEN
        INSERT INTO alert (
            id_session,
            energy_value,
            threshold_value,
            created_at)
        VALUES (
            NEW.id_session,
            NEW.cons_energy,
            energy_limit,
            NOW());
    END IF;
END$$
DELIMITER ;

-- criar trigger rf8
DELIMITER $$

CREATE TRIGGER trg_create_receipt_after_session_update
AFTER UPDATE ON charging_session
FOR EACH ROW
BEGIN
    DECLARE v_id_user INT;
    DECLARE v_total_amount DECIMAL(10,2);

    IF OLD.fin_time IS NULL
       AND NEW.fin_time IS NOT NULL
       AND NOT EXISTS (
           SELECT 1
           FROM receipt r
           WHERE r.id_session = NEW.id_session
       ) THEN

        -- obter o utilizador dono do carro
        SELECT c.id_user
        INTO v_id_user
        FROM car c
        WHERE c.plate = NEW.plate
        LIMIT 1;

        IF v_id_user IS NOT NULL THEN

            -- calcular valor da fatura
            SELECT NEW.cons_energy * p.price_per_hour
            INTO v_total_amount
            FROM user u
            JOIN pricing p ON u.type = p.type
            WHERE u.id_user = v_id_user
            LIMIT 1;

            INSERT INTO receipt (
                plate,
                id_user,
                id_session,
                emission_date,
                total_amount,
                state
            )
            VALUES (
                NEW.plate,
                v_id_user,
                NEW.id_session,
                NEW.fin_time,
                v_total_amount,
                'issued'
            );
        END IF;

    END IF;
END$$

DELIMITER ;

-- RF12

DELIMITER $$

CREATE PROCEDURE atribuir_tecnico_manutencao(IN p_id_charger INT)
BEGIN
    DECLARE v_id_station INT DEFAULT NULL;
    DECLARE v_city VARCHAR(45) DEFAULT NULL;
    DECLARE v_id_tecnico INT DEFAULT NULL;

    -- obter id da station associada ao charger
    SELECT id_station
    INTO v_id_station
    FROM charger
    WHERE id_charger = p_id_charger
    LIMIT 1;

    IF v_id_station IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Charger não encontrado.';
    END IF;

    -- obter cidade da station
    SELECT city
    INTO v_city
    FROM station
    WHERE id_station = v_id_station
    LIMIT 1;

    IF v_city IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Station associada não encontrada.';
    END IF;

    -- alterar estado do posto para maintenance
    UPDATE station
    SET state = 'maintenance'
    WHERE id_station = v_id_station;

    -- procurar técnico disponível obrigatoriamente da mesma cidade
    SELECT id_tecnico
    INTO v_id_tecnico
    FROM tecnicalDepartment
    WHERE local_area = v_city
      AND estado = 'disponivel'
    ORDER BY id_tecnico
    LIMIT 1;

    IF v_id_tecnico IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não existe técnico disponível nessa cidade.';
    END IF;

    -- atribuir técnico ao posto e mudar estado para ocupado
    UPDATE tecnicalDepartment
    SET estado = 'ocupado',
        posto_atribuido = v_id_station
    WHERE id_tecnico = v_id_tecnico;

END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_charger_manutencao
AFTER UPDATE ON charger
FOR EACH ROW
BEGIN
    IF NEW.state = 'maintenance' AND OLD.state <> 'maintenance' THEN
        CALL atribuir_tecnico_manutencao(NEW.id_charger);
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE libertar_tecnico_manutencao(IN p_id_charger INT)
BEGIN
    DECLARE v_id_station INT DEFAULT NULL;

    -- obter a station associada ao charger
    SELECT id_station
    INTO v_id_station
    FROM charger
    WHERE id_charger = p_id_charger
    LIMIT 1;
	
	SELECT id_station
    INTO v_id_station
    FROM charger
    WHERE id_charger = p_id_charger
    LIMIT 1;

    IF v_id_station IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Charger não encontrado.';
    END IF;
    
    -- alterar estado do posto para maintenance
    UPDATE station
    SET state = 'available'
    WHERE id_station = v_id_station;
    IF v_id_station IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Charger não encontrado.';
    END IF;

    -- libertar técnico(s) associado(s) a essa station
    UPDATE tecnicalDepartment
    SET estado = 'disponivel',
        posto_atribuido = NULL
    WHERE posto_atribuido = v_id_station;

END$$

DELIMITER ;
drop procedure libertar_tecnico_manutencao;
DELIMITER $$

CREATE TRIGGER trg_charger_sai_manutencao
AFTER UPDATE ON charger
FOR EACH ROW
BEGIN
    IF OLD.state = 'maintenance'
       AND NEW.state IN ('available', 'occupied') THEN
        CALL libertar_tecnico_manutencao(NEW.id_charger);
    END IF;
END$$

DELIMITER ;