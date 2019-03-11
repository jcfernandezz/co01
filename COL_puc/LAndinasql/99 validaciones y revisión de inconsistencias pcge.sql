--Propósito. Validaciones varias de la estructura pcge y asociación a cuentas gp
--27/7/10 jcf Creación

	--VALIDACIONES
	--busca cuentas puc repetidas. Es factible encontrar repetidos dado que varias cuentas corporativas pueden ser asignadas a una misma cuenta puc
	select *
	from dbo.vwtii_mapeo_puc 
	where codigopuc in (
		select codigopuc
		from dbo.vwtii_mapeo_puc 
		where nivel >= 5
		and substring(cuentagp, 1, 1) in ('1','2','3','4','5','6','7','8','9' , '0')
		and procesado = 'S'
		group by codigopuc
		having COUNT(*) > 1)

	--busca cuentas gp repetidas. No debería haber repetidos.
	select * 
	from dbo.vwtii_mapeo_puc 
	where cuentagp in (
		select pu.cuentagp
		from dbo.vwtii_mapeo_puc pu
		where substring(pu.cuentagp, 1, 1) in ('1','2','3','4','5','6','7','8','9' , '0')
		and exists (select ACTNUMST from GL00105 where ACTNUMST = pu.cuentagp)
		and procesado = 'S'
		and left(pu.codigopuc,2) not between '62' and '68'	--cuentas virtuales
		group by pu.cuentagp
		having COUNT(*) > 1)

	--cuentas de tii_mapeo_puc que no existen en el plan de cuentas corporativo
	select pu.*
	from dbo.vwtii_mapeo_puc pu
	left join GL00105 gl
		on gl.actnumst = pu.cuentagp
	where gl.ACTINDX is null


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
where n2.nsa_Nivel_Cuenta  = 3
and n1.nsa_Codigo is null

select * 
from nsaPUC_GL10000 n2	--PUC_Account_MSTR [nsa_Codigo]
left join nsaPUC_GL10000 n1	--PUC_Account_MSTR [nsa_Codigo]
	on substring(n2.nsa_Codigo, 1, 3) = rtrim(n1.nsa_Codigo)
	and n1.nsa_Nivel_Cuenta = 3
where n2.nsa_Nivel_Cuenta  = 4
and n1.nsa_Codigo is null
ORDER BY 3

select * 
--select 4 nsa_nivel_cuenta, 'Divisionaria' nsa_descripcion_nivel, rtrim(left(n2.nsa_codigo, 4)) nsa_codigo, rtrim(n2.nsa_descripcion_codigo) nsa_descripcion_codigo 
from nsaPUC_GL10000 n2	--PUC_Account_MSTR [nsa_Codigo]
left join nsaPUC_GL10000 n1	--PUC_Account_MSTR [nsa_Codigo]
	on substring(n2.nsa_Codigo, 1, 4) = rtrim(n1.nsa_Codigo)
	and n1.nsa_Nivel_Cuenta = 4
where n2.nsa_Nivel_Cuenta  = 5
and n1.nsa_Codigo is null

select * 
from nsaPUC_GL10000 n2	--PUC_Account_MSTR [nsa_Codigo]
left join nsaPUC_GL10000 n1	--PUC_Account_MSTR [nsa_Codigo]
	on substring(n2.nsa_Codigo, 1, 5) = rtrim(n1.nsa_Codigo)
	and n1.nsa_Nivel_Cuenta = 5
where n2.nsa_Nivel_Cuenta  = 7
and n1.nsa_Codigo is null
order by 3

select * 
from nsaPUC_GL10000 n2	--PUC_Account_MSTR [nsa_Codigo]
left join nsaPUC_GL10000 n1	--PUC_Account_MSTR [nsa_Codigo]
	on substring(n2.nsa_Codigo, 1, 7) = rtrim(n1.nsa_Codigo)
	and n1.nsa_Nivel_Cuenta = 7
where n2.nsa_Nivel_Cuenta  = 8
and n1.nsa_Codigo is null
order by 3

---------------------------------------------------------------------------------------------

--Validar que el nivel mínimo de una cuenta puc asociada a la cuenta corporativa sea ....
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

--Cuentas puc inconsistentes que tienen asignado cuentas corporativas imputables
--Validar que una cuenta puc sólo esté asignada a una cuenta corporativa a nivel de hoja (último nivel = 8)
--Revisa asignaciones de códigos puc a nivel 6 y 8
--Ejemplo de inconsistencia: cuenta corporativa 10410 asignada a cuenta puc 1051, y también a cuenta puc 10511
--NIVEL 4
select *
from (
	select nsa_codigo
	from vwLocAndinaGLCuentasPucyGPAyna
	where nsa_codigo <> ''
	and actindx <> 0
	and LEN(nsa_codigo) = 4
	group by nsa_codigo
	) n4
inner join (
	select left(nsa_codigo, 4) nsa_codigo
	from vwLocAndinaGLCuentasPucyGPAyna
	where nsa_codigo <> ''
	and actindx <> 0
	and LEN(nsa_codigo) = 5
	group by nsa_codigo
	) n5
	on n4.nsa_codigo = n5.nsa_codigo

--NIVEL 5
select *
from (
	select nsa_codigo
	from vwLocAndinaGLCuentasPucyGPAyna
	where nsa_codigo <> ''
	and actindx <> 0
	and LEN(nsa_codigo) = 5
	group by nsa_codigo
	) n5
inner join (
	select left(nsa_codigo, 5) nsa_codigo
	from vwLocAndinaGLCuentasPucyGPAyna
	where nsa_codigo <> ''
	and actindx <> 0
	and LEN(nsa_codigo) = 6
	group by nsa_codigo
	) n6
	on n5.nsa_codigo = n6.nsa_codigo
