--USE [company]
--GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[sp_LAndinaActivaMapeo]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
    DROP PROCEDURE [sp_LAndinaActivaMapeo];
GO

CREATE PROCEDURE [sp_LAndinaActivaMapeo]
AS
BEGIN
--Propósito. Agrega cuentas corporativas a la lista de referencias puc y actualiza los códigos PUC.
--Requisito.	Una cuenta PUC puede referenciar más de una cuenta GP
--				Una cuenta GP debe referenciar una cuenta PUC
--				Parametrizar el formato de la cuenta. Puede ser por cualquier segmento en tanto el campo pc.cuentagp tenga un formato. Por ejemplo: AAA-__-___-__-AA
--11/03/19 jcf Creación. 
--
--Agregar cuentas corporativas a la lista de referencias puc
insert into nsaPUC_GL00100 (actindx, puccode)
select gl.actindx, ''
from gl00100 gl
left join nsaPUC_GL00100 pu
	on pu.actindx = gl.actindx
where pu.actindx is null

--Actualización GA Perú
--Actualiza la lista de referencias puc a partir del mapeo cargado en tii_mapeo_puc
--El mapeo es por código de cuenta contable
update nsaPUC_GL00100 set PUCCODE = pc.codigopuc
--sELECT cu.actindx, cu.ACTNUMBR_1, cu.ACTNUMBR_2, cu.ACTNUMBR_3, rp.PUCCODE , pc.codigopuc
FROM nsaPUC_GL00100	rp				--relación de cuenta PUC con cuenta gp
inner join 	GL00105 cu
	on cu.ACTINDX = rp.ACTINDX
inner join dbo.vwtii_mapeo_puc pc
	on cu.actnumst like pc.cuentagp
where pc.codigopuc <> rp.PUCCODE

END
GO

-- Display the status of Proc creation
IF (@@Error = 0) PRINT 'Procedure Creation: sp_LAndinaActivaMapeo Succeeded'
ELSE PRINT 'Procedure Creation: sp_LAndinaActivaMapeo Error on Creation'
GO
