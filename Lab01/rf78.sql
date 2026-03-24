-- criacao tabela alerta --
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

-- TRIGGER RF7
DELIMITER $$
CREATE TRIGGER trg_high_energy_alert
AFTER INSERT ON charging_session
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


-- trigger rf8
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


-- testes
DELETE FROM alert;
DELETE FROM receipt;
SET SQL_SAFE_UPDATES = 0;




SELECT * FROM pricing;
SELECT * FROM charging_session;

-- nao deve criar alerta

INSERT INTO charging_session (id_charger, plate, entry_time, fin_time, cons_energy)
VALUES (1, 'AA-11-AA', '2025-01-01 10:00:00', '2025-01-01 11:00:00', 20);

SELECT * FROM alert;

INSERT INTO charging_session (id_charger, plate, entry_time, fin_time, cons_energy)
VALUES (1, 'AA-11-AA', '2025-01-01 10:00:00', '2025-01-01 11:00:00', 75.00);

INSERT INTO charging_session (id_charger, plate, entry_time, fin_time, cons_energy)
VALUES (1, 'AA-11-AA', '2025-01-01 11:00:00', '2025-01-01 12:00:00', 50.00);


-- teste rf8
ALTER TABLE charging_session
MODIFY fin_time DATETIME NULL;

INSERT INTO charging_session (id_charger, plate, entry_time, fin_time, cons_energy)
VALUES (1, 'AA-11-AA', '2025-01-01 11:00:00', NULL, 50.00);

SELECT * 
FROM charging_session
ORDER BY id_session DESC
LIMIT 1;

UPDATE charging_session
SET fin_time = '2025-01-01 12:00:00',
    cons_energy = 50.00
WHERE id_session = 35;

SELECT * FROM receipt;

