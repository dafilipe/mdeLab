-- Feature 1 2 3
-- RF 1 : Visualizar o histórico de sessões de carregamento de um utilizador num intervalo de tempo -> Query simples
-- RF 2 : Visualizar todas as sessões realizadas num determinado posto de carregamento -> Query simples
-- RF 3 : Visualizar todas as sessões de carregamento incluindo nome do utilizador, veículo e localização do posto -> Query com JOIN

-- RF 1
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
            WHERE name = 'Diogo Silva'
        )
    )
    -- Filtro de Intervalo de Tempo
    -- Formatdo data ANO-MES-DIA
    AND entry_time BETWEEN '2025-01-01 00:00:00' AND '2025-01-15 23:59:59'
ORDER BY 
    -- Ordena por chegada mais recente em cima
    entry_time DESC;
    
    
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
    -- Filtra carregadores que pertencem ao posto com ID : '1'
    id_charger IN (
        SELECT id_charger 
        FROM charger 
        WHERE id_station = 1
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

