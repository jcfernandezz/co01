--Propósito. Obtiene cuentas puc asociadas a cuentas gp
--30/6/10 jcf Creación
--8/7/10 jcf Agrega campos: active, acctentr
--------------------------------------------------------------------------------------------------------------------------

IF (OBJECT_ID ('dbo.vwLocAndinaGLCuentasPucyGP', 'V') IS NULL)
   exec('create view dbo.vwLocAndinaGLCuentasPucyGP as SELECT 1 as t');
go

alter view dbo.vwLocAndinaGLCuentasPucyGP as
	select cu.ACTINDX, cu.ACTNUMBR_1, cu.ACTNUMBR_2, cu.ACTNUMBR_3, cu.ACTNUMST, ma.actdescr, ma.ACTIVE, ma.ACCTENTR,
	rp.PUCCODE, left(rp.puccode, 1) puc1, left(rp.puccode, 2) puc2, left(rp.puccode, 4) puc4, left(rp.puccode, 6) puc6,
	ma.USRDEFS1
	from nsaPUC_GL00100	rp		--relación de cuenta PUC con cuenta gp
	inner join 	GL00105 cu
		on cu.ACTINDX = rp.ACTINDX
	inner join GL00100 ma
		on ma.ACTINDX = rp.ACTINDX
go
IF (@@Error = 0) PRINT 'Creación exitosa de: vwLocAndinaGLCuentasPucyGP'
ELSE PRINT 'Error en la creación de: vwLocAndinaGLCuentasPucyGP'
GO

--------------------------------------------------------------------------------------------------------------------------
--Propósito. Obtiene todas las cuentas puc y gp. Asociadas y no asociadas.
--Utilizado por. Smartlist
--2/2/12 jcf Corrige. No incluía todas las cuentas corporativas.
--
IF (OBJECT_ID ('dbo.vwLocAndinaGLCuentasPucyGPAyna', 'V') IS NULL)
   exec('create view dbo.vwLocAndinaGLCuentasPucyGPAyna as SELECT 1 as t');
go
alter view dbo.vwLocAndinaGLCuentasPucyGPAyna as
--Todas las cuentas puc
SELECT isnull(cu.actindx, 0) actindx, isnull(cu.ACTNUMBR_1, '') ACTNUMBR_1, isnull(cu.ACTNUMBR_2, '') ACTNUMBR_2, isnull(cu.ACTNUMBR_3, '') ACTNUMBR_3, 
	isnull(cu.ACTNUMST, '') ACTNUMST, isnull(cu.ACTDESCR, '') ACTDESCR, isnull(pa.nsa_Codigo, '') nsa_Codigo, isnull(pa.nsa_descripcion_codigo, '') nsa_descripcion_codigo,
	isnull(cu.active, 0) active, cu.acctentr, cu.USRDEFS1
FROM nsaPUC_GL10000 pa			--puc_account_mstr
left join dbo.vwLocAndinaGLCuentasPucyGP cu
	on cu.puccode = pa.nsa_codigo 
union all
--El resto de las cuentas corporativas no asociadas a cuentas puc
SELECT cu.actindx, cu.ACTNUMBR_1, cu.ACTNUMBR_2, cu.ACTNUMBR_3, rtrim(cu.ACTNUMBR_1) +'-'+ rtrim(cu.ACTNUMBR_2) +'-'+ rtrim(cu.ACTNUMBR_3) ACTNUMST, 
	cu.ACTDESCR, '' nsa_Codigo, '' nsa_descripcion_codigo,	cu.active, cu.acctentr, cu.USRDEFS1
from gl00100 cu
left join dbo.vwLocAndinaGLCuentasPucyGP pg
	on pg.ACTINDX = cu.ACTINDX
where isnull(pg.puccode, '') = ''

go
IF (@@Error = 0) PRINT 'Creación exitosa de: vwLocAndinaGLCuentasPucyGPAyna'
ELSE PRINT 'Error en la creación de: vwLocAndinaGLCuentasPucyGPAyna'
GO
--------------------------------------------------------------------------------------------------------------------------

grant select on dbo.vwLocAndinaGLCuentasPucyGPAyna to dyngrp
go