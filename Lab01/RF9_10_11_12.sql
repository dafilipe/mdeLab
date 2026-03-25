-- RF9
drop table tecnicalDepartment;

SELECT posto_atribuido 
FROM tecnicalDepartment
WHERE posto_atribuido IS NOT NULL
AND posto_atribuido NOT IN (SELECT id_station FROM station);
-- RF10
select * FROM tecnicalDepartment where local_area = "Coimbra";

-- RF11
SELECT local_area, count(*) as total_area 
from tecnicalDepartment group by local_area

-- RF12


