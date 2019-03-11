--Localización GP PERU 
--Propósito. Cargar el Plan General Empresarial
--
--8/6/11 jcf Aclara pasos para iniciar PCGE en Perú.
------------------------------------------------------------------------------------------------------------------
IF not EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[tii_mapeo_puc]') AND OBJECTPROPERTY(id,N'IsTable') = 1)
begin

	create table tii_mapeo_puc(
		cuentagp varchar(50) not null default '',
		textoingles varchar(100) default '',
		obs varchar(100) default '',
		textoespa varchar(100) default '',
		obs2 varchar(50) default '',
		codigopuc varchar(50) not null default '',
		textopuc varchar(100) default '',
		nivel int, 
		descNivel varchar(100) default '',
		procesado varchar(1) default ''
	)
	ALTER TABLE tii_mapeo_puc WITH NOCHECK 
	ADD CONSTRAINT PK_tii_mapeo_puc PRIMARY KEY NONCLUSTERED (codigopuc, cuentagp)
	WITH (FILLFACTOR = 75, PAD_INDEX = ON);

	create index idx1_tii_mapeo_puc on tii_mapeo_puc (cuentagp, codigopuc);
	create index idx1_gl00105 on gl00105 (actnumst, ACTINDX);

end;
go

IF OBJECT_ID ('dbo.vwtii_mapeo_puc') IS NOT NULL
   DROP view dbo.vwtii_mapeo_puc
GO

create view dbo.vwtii_mapeo_puc as
select cuentagp, textoingles, textoespa, codigopuc, textopuc, nivel, descNivel, procesado
from tii_mapeo_puc
where --LEN(cuentagp) = 5
substring(codigopuc, 1, 1) in ('1','2','3','4','5','6','7','8','9', '0' )
go

---------------------------------------------------------------------------------------------------------------------
--insert into per10.dbo.tii_mapeo_puc (cuentagp,textoingles,obs,textoespa,obs2,codigopuc,textopuc,nivel,descNivel,procesado)
--	select cuentagp,textoingles,obs,textoespa,obs2,codigopuc,textopuc,nivel,descNivel,procesado
--	from gperu.dbo.tii_mapeo_puc



--Antes de la carga:
--borrar constraint de llave primaria
-- ALTER TABLE tii_mapeo_puc DROP CONSTRAINT PK_tii_mapeo_puc;
-- alter table tii_mapeo_puc alter column cuentagp varchar(50) null ;
-- alter table tii_mapeo_puc alter column codigopuc varchar(50) null ;

-- --cargar archivo usando integration services

-- --Después de la carga:

-- --actualizar descnivel

-- --Cargar la nueva estructura puc desde un archivo a GP. 
-- select distinct nivel, descnivel, codigopuc, textopuc
-- from dbo.vwtii_mapeo_puc 
-- order by codigopuc

-- --Borrar los padres de la jerarquía. Atención: antes de borrar, cargar la nueva estructura puc
-- select *
-- from tii_mapeo_puc
-- where cuentagp = '';

-- update tii_mapeo_puc set textoespa = rtrim(cuentagp) +'-'+ rtrim(isnull(textoingles, ''));
-- update tii_mapeo_puc set cuentagp = RTRIM(textoespa) + '-__-__-______-____';

-- --Habilitar constraint de llave primaria
-- drop index idx1_tii_mapeo_puc on tii_mapeo_puc;
-- alter table tii_mapeo_puc alter column cuentagp varchar(50) not null ;
-- alter table tii_mapeo_puc alter column codigopuc varchar(50) not null ;

-- ALTER TABLE tii_mapeo_puc WITH NOCHECK 
-- ADD CONSTRAINT PK_tii_mapeo_puc PRIMARY KEY NONCLUSTERED (codigopuc, cuentagp)
-- WITH (FILLFACTOR = 75, PAD_INDEX = ON);
-- ALTER TABLE tii_mapeo_puc ADD DEFAULT '' FOR cuentagp;
-- ALTER TABLE tii_mapeo_puc ADD DEFAULT '' FOR codigopuc;

-- create index idx1_tii_mapeo_puc on tii_mapeo_puc (cuentagp, codigopuc);

