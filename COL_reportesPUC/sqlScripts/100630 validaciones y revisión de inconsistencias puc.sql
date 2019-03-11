--Propósito. Validaciones varias de la estructura puc y asociación a cuentas gp
--1/7/10 jcf Creación

--busca cuentas puc repetidas (una cuenta puc asignada a varias cuentas gp es permitido)
select *
from dbo.vwtii_mapeo_puc 
where codigopuc in (
	select codigopuc
	from dbo.vwtii_mapeo_puc 
	where nivel >= 6
	and substring(cuentagp, 1, 1) in ('1','2','3','4','5','6','7','8','9' , '0')
	group by codigopuc
	having COUNT(*) > 1)
order by codigopuc

--busca cuentas gp repetidas
select * 
from dbo.vwtii_mapeo_puc 
where cuentagp in (
	select pu.cuentagp
	from dbo.vwtii_mapeo_puc pu
	where substring(pu.cuentagp, 1, 1) in ('1','2','3','4','5','6','7','8','9' , '0')
	and exists (select actnumbr_3 from GL00105 where ACTNUMBR_3 = pu.cuentagp)
	group by pu.cuentagp
	having COUNT(*) > 1)

--Obtiene los códigos padre faltantes en cada nivel puc
select * 
from nsaPUC_GL10000 n2	--PUC_Account_MSTR [nsa_Codigo]
left join nsaPUC_GL10000 n1	--PUC_Account_MSTR [nsa_Codigo]
	on substring(n2.nsa_Codigo, 1, 1) = rtrim(n1.nsa_Codigo)
	and n1.nsa_Nivel_Cuenta = 1
where n2.nsa_Nivel_Cuenta  = 2
and n1.nsa_Codigo is null

select * 
from nsaPUC_GL10000 n2	--PUC_Account_MSTR [nsa_Codigo]
left join nsaPUC_GL10000 n1	--PUC_Account_MSTR [nsa_Codigo]
	on substring(n2.nsa_Codigo, 1, 2) = rtrim(n1.nsa_Codigo)
	and n1.nsa_Nivel_Cuenta = 2
where n2.nsa_Nivel_Cuenta  = 4
and n1.nsa_Codigo is null

select * 
from nsaPUC_GL10000 n2	--PUC_Account_MSTR [nsa_Codigo]
left join nsaPUC_GL10000 n1	--PUC_Account_MSTR [nsa_Codigo]
	on substring(n2.nsa_Codigo, 1, 4) = rtrim(n1.nsa_Codigo)
	and n1.nsa_Nivel_Cuenta = 4
where n2.nsa_Nivel_Cuenta  = 6
and n1.nsa_Codigo is null

select * 
from nsaPUC_GL10000 n2	--PUC_Account_MSTR [nsa_Codigo]
left join nsaPUC_GL10000 n1	--PUC_Account_MSTR [nsa_Codigo]
	on substring(n2.nsa_Codigo, 1, 6) = rtrim(n1.nsa_Codigo)
	and n1.nsa_Nivel_Cuenta = 6
where n2.nsa_Nivel_Cuenta  = 8
and n1.nsa_Codigo is null
---------------------------------------------------------------------------------------------

--Validar que el nivel mínimo de una cuenta puc asociada a la cuenta corporativa sea 4.
--Corregir las siguientes cuentas:
select *
from vwLocAndinaGLCuentasPucyGPAyna
where nsa_codigo in (
	select nsa_codigo
	from vwLocAndinaGLCuentasPucyGPAyna
	where nsa_codigo <> ''
	and actindx <> 0
	and LEN(nsa_codigo) < 4
	group by nsa_codigo
	--order by 1
)
and active = 1

--Cuentas puc inconsistentes que tienen asignado cuentas corporativas a nivel 5 y 6
--Validar que una cuenta puc sólo esté asignada a una cuenta corporativa a nivel de hoja (último nivel = 6)
--Revisa asignaciones de códigos puc a nivel 5 y 6
select *
from (
	select nsa_codigo --, actindx, actnumbr_1, actnumbr_2, actnumbr_3, actnumst, actdescr, nsa_descripcion_codigo
	from vwLocAndinaGLCuentasPucyGPAyna
	where nsa_codigo <> ''
	and actindx <> 0
	and LEN(nsa_codigo) = 5
	group by nsa_codigo
	) n6
inner join (
	select left(nsa_codigo, 6) nsa_codigo --, actindx, actnumbr_1, actnumbr_2, actnumbr_3, actnumst, actdescr, nsa_descripcion_codigo
	from vwLocAndinaGLCuentasPucyGPAyna
	where nsa_codigo <> ''
	and actindx <> 0
	and LEN(nsa_codigo) = 6
	group by nsa_codigo
	) n8
	on n6.nsa_codigo = n8.nsa_codigo
-------------------------------------------------
	--select * --, actindx, actnumbr_1, actnumbr_2, actnumbr_3, actnumst, actdescr, nsa_descripcion_codigo
	--from vwLocAndinaGLCuentasPucyGPAyna
	--where nsa_Codigo like '530520%'
	
	
