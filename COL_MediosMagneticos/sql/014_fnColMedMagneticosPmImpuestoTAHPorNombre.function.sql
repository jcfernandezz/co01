IF OBJECT_ID ('dbo.fnColMedMagneticosPmImpuestoTAH') IS NOT NULL
   DROP FUNCTION dbo.fnColMedMagneticosPmImpuestoTAH
GO

create function dbo.fnColMedMagneticosPmImpuestoTAH(@VCHRNMBR char(21), @DOCTYPE smallint)
returns table
as
--Prop�sito. Impuestos en trabajo, abiertos o hist�ricos. 
--Requisitos. Los impuestos o retenciones deben ser configurados con un c�digo en el campo direccion1 del detalle de impuesto
--10/10/19 jcf Creaci�n 
--
return
(
		select UPPER(tx.ADDRESS1) ADDRESS1, UPPER(tx.ADDRESS2) ADDRESS2, tw.vchrnmbr, tw.doctype, tw.TAXDTLID, tw.taxamnt, tw.tdttxpur
		from PM10500 tw --pm_tax_work
			inner join tx00201 tx
			on tx.taxdtlid = tw.taxdtlid
		where tw.VCHRNMBR = @VCHRNMBR
		   AND tw.DOCTYPE = @DOCTYPE

		union all

		select UPPER(tx.ADDRESS1) ADDRESS1, UPPER(tx.ADDRESS2) ADDRESS2, tw.vchrnmbr, tw.doctype, tw.TAXDTLID, tw.taxamnt, tw.tdttxpur
		from PM30700 tw --pm_tax_hist
			inner join tx00201 tx
			on tx.taxdtlid = tw.taxdtlid
		where tw.VCHRNMBR = @VCHRNMBR
		   AND tw.DOCTYPE = @DOCTYPE
)

go

IF (@@Error = 0) PRINT 'Creaci�n exitosa de la funci�n: fnColMedMagneticosPmImpuestoTAH()'
ELSE PRINT 'Error en la creaci�n de la funci�n: fnColMedMagneticosPmImpuestoTAH()'
GO


