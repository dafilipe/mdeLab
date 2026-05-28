-- RF9
drop table tecnicalDepartment;

-- RF10
select * FROM tecnicalDepartment where local_area = "Coimbra";
select * FROM tecnicalDepartment;
-- RF11
SELECT local_area AS Cidade,
	count(*) AS Tecnicos 
from tecnicalDepartment
group by local_area
Order by Tecnicos DESC;

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

UPDATE tecnicalDepartment
SET estado = 'disponivel'
WHERE id_tecnico > 0;


update charger set state = "available" WHERE id_charger = 3 ;
select * from charger;
select * from station;
SET SQL_SAFE_UPDATES = 0;
select * FROM tecnicalDepartment;

