-- ========================
-- PRICING
-- ========================
INSERT INTO pricing VALUES
('basic', 3),
('premium', 2),
('corporate', 1);

-- ========================
-- USERS
-- ========================
INSERT INTO user (name, email, phone_num, register_date, type) VALUES
('Diogo Silva', 'diogo@gmail.com', 911111111, '2024-01-10', 'premium'),
('Ana Costa', 'ana@gmail.com', 922222222, '2024-02-15', 'basic'),
('João Pereira', 'joao@gmail.com', 933333333, '2024-03-20', 'corporate'),
('Maria Lopes', 'maria@gmail.com', 944444444, '2024-04-05', 'basic'),
('Pedro Santos', 'pedro@gmail.com', 955555555, '2024-05-01', 'premium'),
('Carla Mendes', 'carla@gmail.com', 966666666, '2024-06-10', 'basic');

-- ========================
-- CONNECTION TYPES
-- ========================
INSERT INTO conection_type VALUES
('Type2'),
('CCS'),
('CHAdeMO');

-- ========================
-- CARS
-- ========================
INSERT INTO car VALUES
('AA-11-AA', 1, 'Tesla', 'Model 3', 75, 2022, 'Type2'),
('BB-22-BB', 1, 'Nissan', 'Leaf', 40, 2020, 'CHAdeMO'),
('CC-33-CC', 2, 'BMW', 'i3', 42, 2019, 'Type2'),
('DD-44-DD', 3, 'Tesla', 'Model S', 100, 2023, 'CCS'),
('EE-55-EE', 4, 'Renault', 'Zoe', 52, 2021, 'Type2'),
('FF-66-FF', 5, 'Hyundai', 'Kona', 64, 2022, 'CCS'),
('GG-77-GG', 5, 'Peugeot', 'e-208', 50, 2021, 'Type2'),
('HH-88-HH', 6, 'VW', 'ID.3', 58, 2023, 'CCS');

-- ========================
-- STATIONS
-- ========================
INSERT INTO station (city, address, gps, state) VALUES
('Lisboa', 'Av. Liberdade', '38.72,-9.13', 'active'),
('Porto', 'Rua Santa Catarina', '41.15,-8.61', 'active'),
('Coimbra', 'Praça da República', '40.21,-8.42', 'active'),
('Faro', 'Centro', '37.01,-7.93', 'maintenance'),
('Braga', 'Av. Central', '41.55,-8.42', 'active');

-- ========================
-- CHARGERS
-- ========================
INSERT INTO charger (id_station, max_power, state) VALUES
(1, 50, 'available'),
(1, 22, 'occupied'),
(2, 100, 'available'),
(2, 50, 'available'),
(3, 22, 'maintenance'),
(4, 50, 'available'),
(5, 150, 'available');

-- ========================
-- CHARGER CONNECTORS
-- ========================
INSERT INTO charger_conector VALUES
(1, 'Type2'), (1, 'CCS'),
(2, 'Type2'), (2, 'CHAdeMO'),
(3, 'CCS'), (3, 'Type2'),
(4, 'CCS'), (4, 'CHAdeMO'),
(5, 'Type2'), (5, 'CCS'),
(6, 'CHAdeMO'), (6, 'Type2'),
(7, 'CCS'), (7, 'Type2');

-- ========================
-- SENSORS
-- ========================
INSERT INTO sensor (id_charger, error, sens_type, state) VALUES
(1, b'0', 'temperature', b'1'),
(1, b'0', 'power', b'1'),
(2, b'1', 'temperature', b'0'),
(3, b'0', 'occupancy', b'1'),
(4, b'0', 'power', b'1'),
(5, b'0', 'temperature', b'1');

-- ========================
-- SESSIONS
-- ========================
INSERT INTO charging_session (id_charger, plate, entry_time, fin_time, cons_energy) VALUES
(1, 'AA-11-AA', '2025-01-01 10:00:00', '2025-01-01 11:00:00', 20),
(2, 'BB-22-BB', '2025-01-02 12:00:00', '2025-01-02 13:30:00', 25),
(3, 'CC-33-CC', '2025-01-03 09:00:00', '2025-01-03 10:00:00', 18),
(4, 'DD-44-DD', '2025-01-04 14:00:00', '2025-01-04 15:30:00', 40),
(1, 'EE-55-EE', '2025-01-05 08:00:00', '2025-01-05 09:15:00', 22),
(2, 'FF-66-FF', '2025-01-06 16:00:00', '2025-01-06 17:00:00', 30),
(3, 'GG-77-GG', '2025-01-07 11:00:00', '2025-01-07 12:30:00', 28),
(4, 'HH-88-HH', '2025-01-08 18:00:00', '2025-01-08 19:00:00', 35);

-- ========================
-- RECEIPTS
-- ========================
INSERT INTO receipt (plate, id_user, id_session, emission_date, total_amount, state) VALUES
('AA-11-AA', 1, 1, NOW(), 10, 'paid'),
('BB-22-BB', 1, 2, NOW(), 12, 'paid'),
('CC-33-CC', 2, 3, NOW(), 9, 'pending'),
('DD-44-DD', 3, 4, NOW(), 20, 'paid'),
('EE-55-EE', 4, 5, NOW(), 11, 'paid'),
('FF-66-FF', 5, 6, NOW(), 15, 'pending');

-- ========================
-- SENSOR MEASUREMENTS
-- ========================
INSERT INTO sensor_measurement (id_sensor, date_time, measured_value) VALUES
(1, '2025-01-01 10:00:00', 25),
(1, '2025-01-01 10:10:00', 27),
(2, '2025-01-02 12:00:00', 40),
(2, '2025-01-02 12:10:00', 42),
(3, '2025-01-03 09:00:00', 30),
(4, '2025-01-04 14:00:00', 1),
(5, '2025-01-05 08:00:00', 50),
(6, '2025-01-06 16:00:00', 26);