-- RF9
drop table tecnicalDepartment;

-- RF10
select * FROM tecnicalDepartment where local_area = "Coimbra";

-- RF11
SELECT local_area, count(*) as total_area 
from tecnicalDepartment group by local_area

-- RF12


