use COL10;
--Localización Colombia GP
--Propósito. Cargar el Plan Unico de Cuentas (PUC) y calcular los saldos de una gestión de acuerdo a estas cuentas
--
--8/6/11 jcf Aclara pasos a seguir para Colombia.
--a. Cargar el mapeo en la tabla tii_mapeo_puc. Cumplir la siguiente regla de integridad:
--	a.1 Una cuenta puc puede estar asociada a varias cuentas gp
--	a.2 Una cuenta gp debe estar asociada a una cuenta puc
--b. Cargar la estructura jerárquica de cuentas puc en GP: Herramientas > integrar > importación de tabla: PUC
--		nsaPUC_GL10000 --PUC_Account_MSTR [nsa_Codigo]
--c. En GP, la asociación de cuentas puc y cuentas gp se reinicia en Configuración > financiero > segmentos de cuenta [Actualizar] (reinicia la tabla nsaPUC_GL00100).
--d. Un script actualiza las referencias puc a partir del mapeo cargado en tii_mapeo_puc (a). 

------------------------------------------------------------------------------------------------------------------
create table tii_mapeo_puc(
	cuentagp varchar(50) not null,
	textoingles varchar(100),
	obs varchar(300),
	textoespa varchar(100),
	obs2 varchar(50),
	codigopuc varchar(50) not null,
	textopuc varchar(100),
	nivel int, 
	descNivel varchar(100), 
	procesado varchar(1)
)
go

--alter table tii_mapeo_puc alter column cuentagp varchar(50) not null;
--alter table tii_mapeo_puc alter column codigopuc varchar(50) not null;

ALTER TABLE tii_mapeo_puc WITH NOCHECK 
ADD CONSTRAINT PK_tii_mapeo_puc PRIMARY KEY NONCLUSTERED (codigopuc, cuentagp)
WITH (FILLFACTOR = 75, PAD_INDEX = ON);
go

CREATE view dbo.vwtii_mapeo_puc as
	select cuentagp, textoingles, textoespa, codigopuc, textopuc, nivel, descNivel, procesado
	from tii_mapeo_puc
	where --LEN(cuentagp) = 5
	substring(codigopuc, 1, 1) in ('1','2','3','4','5','6','7','8','9', '0')
go

----------------------------------------------------------------------------------------------------------------- 
--insert into col10.dbo.tii_mapeo_puc (cuentagp,textoingles,obs,textoespa,obs2,codigopuc,textopuc,nivel,descNivel,procesado)
	select cuentagp,textoingles,obs,textoespa,obs2,codigopuc,textopuc,nivel,descNivel,procesado
	from gcol.dbo.tii_mapeo_puc

--busca repetidos
select * 
from tii_mapeo_puc 
where cuentagp + codigopuc in (
	select cuentagp + codigopuc --, count(*)
	from tii_mapeo_puc
	group by cuentagp, codigopuc
	having count(*) > 1
	)

select *
from tii_mapeo_puc 
where --cuentagp = '' and codigopuc = ''
codigopuc like '510572%'
order by codigopuc

--update tii_mapeo_puc set cuentagp = '41225'
--where codigopuc = '425050'

--insert into tii_mapeo_puc (cuentagp, textoingles, textoespa, obs2, codigopuc, textopuc, nivel, descNivel, procesado)
--			values('ESTRUCTURA PUC', '', '', '29/10/13 F Brenta', '4250', 'Recuperaciones', 4, 'Cuenta', 'S')

--*****************************************************************************************************************
--COLOMBIA
--*****************************************************************************************************************

--0. Luego de cargar la planilla a la tabla tii_mapeo_puc, actualizar niveles y descripción de niveles:
--UPDATE tii_mapeo_puc 
set nivel = LEN(codigopuc), 
	descnivel = case when LEN(codigopuc) = 1 then 'Clase'
		when LEN(codigopuc) = 2 then 'Grupo'
		when LEN(codigopuc) = 4 then 'Cuenta'
		when LEN(codigopuc) = 6 then 'Subcuenta'
		when LEN(codigopuc) = 8 then 'Auxiliar'
		else ''
		end,
	procesado = 'S'
where --LEN(cuentagp) = 5
substring(codigopuc, 1, 1) in ('1','2','3','4','5','6','7','8','9' )

--1. Definir los segmentos GP que se relacionan con PUC: Configuración > financiero > segmentos de cuenta 
SELECT * FROM nsaPUC_GL40000	--Configuración de PUC

--2. Si va a modificar estructura puc (niveles y subniveles), borrar los datos de la tabla nsaPUC_GL10000
--   Sino, salte al siguiente punto. (Si sólo va aumentar una nueva cuenta puc que corresponde a la estructura existente, vaya al siguiente punto)
select *
from nsaPUC_GL10000 --PUC_Account_MSTR [nsa_Codigo]
--update nsapuc_gl10000 set nsa_descripcion_codigo = 'IVA descontable 5%'
where nsa_codigo = '415595'
--update nsapuc_gl10000 set nsa_descripcion_codigo = 'GASTOS REGISTRO MERCANTIL'
--where nsa_codigo = '5140'

--3. Revisar el mapeo de las cuentas gp a las cuentas puc en la tabla tii_mapeo_puc
--   Agregar o modificar el mapeo como se requiera.
select * 
--update ma set cuentagp = '', textoingles='', textoespa=''
from tii_mapeo_puc ma
where --ma.cuentagp in ('20503') --('11987'    ,'64420'    ,'41160'    ,'10148')
ma.codigopuc like '23150501%'
order by ma.codigopuc


--update tii_mapeo_puc 
--set nivel = 8, descNivel= 'Auxiliar',
--textopuc ='Anticipo de Impuesto a la equidad (CREE)',codigopuc = '13551502', obs2 = 'F Brenta 21/5/13'
--where cuentagp = '13120'

insert into tii_mapeo_puc (cuentagp, textoingles, obs2,			codigopuc, textopuc,				nivel, descnivel, procesado)
					values ('20503', '-', 'F Brenta 9/6/16',	'23150501', 'Deudas entre compañías / corrientes', 8, 'Auxiliar', 'S' )

--insert into tii_mapeo_puc (cuentagp, textoingles, obs2,			codigopuc, textopuc, nivel, descnivel, procesado)
--					values ('ESTRUCTURA PUC', '-', 'M Gómez 3/8/15',	'133005', 'A PROVEEDORES', 6, 'Subcuenta', 'S' )

--insert into tii_mapeo_puc (cuentagp, textoingles, obs2,			codigopuc, textopuc, nivel, descnivel, procesado)
--					values ('11910', '-', 'M Gómez 3/8/15',	'13300505', 'Anticipos a Proveedores', 8, 'Auxiliar', 'S' )

select *
from dbo.vwtii_mapeo_puc 
where codigopuc like '510572%'

--4. Cargar la nueva estructura puc o la nueva cuenta puc desde un archivo a GP. 
--	Cargar estructura del PUC: Herramientas > integrar > importación de tabla: PUC
-- Usar el siguiente script y copiar el resultado en excel. Borrar duplicados, títulos y guardar en archivo, campos separados por tabuladores
-- puc_account_mstr [nsaPUC_GL10000]
--
select distinct nivel, descnivel, codigopuc, textopuc
from dbo.vwtii_mapeo_puc 
where cuentagp in ('10143', '10148', '20312', '20503')
--codigopuc in
--('510572')	--, '133005', '13300505')
order by codigopuc


--alternativamente copiar la jerarquía de cuentas PUC desde otra compañía
--insert into col10..nsapuc_gl10000(nsa_Nivel_Cuenta,nsa_Descripcion_Nivel,nsa_Codigo,nsa_Descripcion_Codigo)
	--select nsa_Nivel_Cuenta,nsa_Descripcion_Nivel,nsa_Codigo,nsa_Descripcion_Codigo 
	--from  gcol..nsaPUC_GL10000

--5. Si la cuenta puc es nueva, usar la opción Configuración > financiero > segmentos de cuenta [Actualizar] 
--	No marcar ningún segmento. Esto reinicia la tabla nsaPUC_GL00100.
-- Una cuenta PUC puede referenciar más de una cuenta GP
-- Una cuenta GP debe referenciar una cuenta PUC

-- Actualiza las referencias puc a partir del mapeo cargado en tii_mapeo_puc
update rp set PUCCODE = pc.codigopuc
--sELECT cu.actindx, cu.ACTNUMBR_1, cu.ACTNUMBR_2, cu.ACTNUMBR_3, cu.ACTDESCR, rp.PUCCODE , pc.codigopuc
FROM nsaPUC_GL00100	rp	--relación de cuenta PUC con cuenta gp
inner join 	GL00100 cu
	on cu.ACTINDX = rp.ACTINDX
inner join dbo.vwtii_mapeo_puc pc
	on pc.cuentagp = cu.ACTNUMBR_3
where pc.codigopuc <> rp.PUCCODE

--select * from nsaPUC_GL00100
--where PUCCODE = '510572'
--sp_statistics nsaPUC_GL10000 
--sp_statistics nsaPUC_GL00100
--sp_columns nsaPUC_GL00100

--6. validar mapeo puc y estructura puc: "100630 validaciones y revisión de inconsistencias puc.sql"
---------------------------------------------------------------------------------------------------------------
--PRUEBAS
--Saldos por cuenta PUC resumidos por año
select cu.ACTNUMBR_1, cu.ACTNUMBR_2,cu.ACTNUMBR_3, sa.nsa_Nivel_Cuenta, sa.nsa_Descripcion_Nivel, sa.nsa_Codigo, sa.nsa_Descripcion_Codigo, sa.nsa_ACTINDX, sa.nsa_PERINDX, sa.nsa_CURYRFIG_13, sa.nsa_Debit_Figures_13, sa.nsa_Credit_Figures_13, * 
from nsaPUC_RGL00200 sa	--nsaPUC_GL_Resumen
inner join
	GL00100 cu
	on cu.ACTINDX = sa.nsa_ACTINDX
order by sa.nsa_Codigo

--Saldos por cuenta GP
select cu.ACTNUMBR_1, cu.ACTNUMBR_2,cu.ACTNUMBR_3, sa.*	--, nsa_CURYRFIG_13, nsa_Debit_Figures_13, nsa_Credit_Figures_13 --, * 
from nsaPUC_GL00199	sa--nsaPUC_GL_Saldos
inner join
	GL00100 cu
	on cu.ACTINDX = sa.nsa_ACTINDX
------------------------------------------------------------------------------------------------------------	


sp_columns 
sp_tables nsaPUC_GL10000
sp_pkeys nsaPUC_GL10000
sp_statistics nsaPUC_GL10000
sp_fkeys nsaPUC_GL10000
sp_special_columns nsaPUC_GL10000
sp_sproc_columns 
sp_stored_procedures 
sp_databases 
sp_table_privileges nsaPUC_GL10000
sp_column_privileges nsaPUC_GL10000
sp_server_info 
