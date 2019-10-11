IF OBJECT_ID ('dbo.fnColMedMagneticosPmImpuestoTAH') IS NOT NULL
   DROP FUNCTION dbo.fnColMedMagneticosPmImpuestoTAH
GO

create function dbo.fnColMedMagneticosPmImpuestoTAH(@VCHRNMBR char(21), @DOCTYPE smallint)
returns table
as
--Propósito. Impuestos en trabajo, abiertos o históricos. 
--Requisitos. Los impuestos o retenciones deben ser configurados con un código en el campo direccion1 del detalle de impuesto
--10/10/19 jcf Creación 
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

IF (@@Error = 0) PRINT 'Creación exitosa de la función: fnColMedMagneticosPmImpuestoTAH()'
ELSE PRINT 'Error en la creación de la función: fnColMedMagneticosPmImpuestoTAH()'
GO


