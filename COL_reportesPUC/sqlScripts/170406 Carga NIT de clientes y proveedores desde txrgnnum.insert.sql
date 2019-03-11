----------------------------------------------------------------------
--1. Eliminar los nit de clientes y proveedores
	select * 
	from nsaIF02666
	--select nsaIFNit from nsaIF01666

--2. insertar clientes que tienen nit en el campo Registro de impuesto
--INSERT INTO nsaIF02666 (CUSTNMBR, nsaIF_Type_Nit, nsaIFNit, RSocial ) --nit clientes
select ms.custnmbr, '31', ms.TXRGNNUM, ms.CUSTNAME
from RM00101		ms
left join nsaIF02666 lo
	on ms.CUSTNMBR = lo.CUSTNMBR
	and lo.nsaIF_Type_Nit = '31'
where lo.CUSTNMBR is null
and ms.TXRGNNUM <> ''

--3. insertar proveedores que tienen nit en el campo Registro de impuesto
--INSERT INTO nsaIF01666 (VENDORID, nsaIF_Type_Nit, nsaIFNit, RSocial ) --nit proveedores	
select ms.VENDORID, '31', ms.TXRGNNUM, ms.VENDNAME
from PM00200 ms
left join nsaIF01666 lo
	on ms.VENDORID = lo.VENDORID
	and lo.nsaIF_Type_Nit = '31'
where lo.VENDORID is null
and ms.TXRGNNUM <> ''

--4. Eliminar los nit de terceros inexistentes
select *
from nsaIF00666 where nsaIFNit not in (
	select nsaIFNit from nsaIF01666
	union all
	select nsaIFNit from nsaIF02666
)
