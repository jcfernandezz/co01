

exec dbo.spColMediosMagneticos1008SaldosAR

exec dbo.spColMediosMagneticos1009SaldosAP


select *
from nsaif_40000	--ciudad

select *
from nsaif_40001	--departamento

select *
from nsaif_sy00101	--mstr

----------------------------------------------------------------------------------
sp_columns nsaif_40001	
sp_statistics nsaif_40001	

select *	--tipo, max(len(descripcion))
from cfdiCatalogo
--group by tipo


--master
--insert into nsaif_sy00101 (nsaIF_Site_Code, DSCRIPTN)
select clave, RTRIM(descripcion) --tipo, max(len(descripcion))
from cfdiCatalogo
where tipo = 'CITY'

--departamento
--insert into nsaif_40001 (nsaIF_Code, STATE)
select clave, RTRIM(descripcion) --tipo, max(len(descripcion))
from cfdiCatalogo
where tipo = 'DPTO'

-- No permite ingresar nombres repetidos de ciudades
--insert into nsaif_40000 (nsaif_code_ciudad, city)
--select substring(clave, 3, 3), RTRIM(descripcion) 
--from cfdiCatalogo
--where tipo = 'CITY'
