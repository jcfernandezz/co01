IF OBJECT_ID ('dbo.fnColMedMagneticosPmSumaImpuestoTAHPorPrefijo') IS NOT NULL
   DROP FUNCTION dbo.fnColMedMagneticosPmSumaImpuestoTAHPorPrefijo
GO

create function dbo.fnColMedMagneticosPmSumaImpuestoTAHPorPrefijo(@VCHRNMBR char(21), @DOCTYPE smallint, @prefijo varchar(15))
returns table
as
--Propósito. Suma de impuestos en trabajo, abiertos o históricos. Filtra los impuestos requeridos por @prefijo y comprobante
--Requisitos. Los impuestos o retenciones deben ser configurados con un prefijo constante
--05/08/19 jcf Creación 
--
return
(
	select sum(tax.taxamnt) taxamnt, sum(tax.tdttxpur) tdttxpur
	from (
		select tw.vchrnmbr, tw.doctype, tw.TAXDTLID, tw.taxamnt, tw.tdttxpur
		from PM10500 tw --pm_tax_work
		where tw.VCHRNMBR = @VCHRNMBR
		   AND tw.DOCTYPE = @DOCTYPE
		   and tw.TAXDTLID like @prefijo + '%'
		union all
			select tw.vchrnmbr, tw.doctype, tw.TAXDTLID, tw.taxamnt, tw.tdttxpur
		from PM30700 tw --pm_tax_hist
		where tw.VCHRNMBR = @VCHRNMBR
		   AND tw.DOCTYPE = @DOCTYPE
		   and tw.TAXDTLID like @prefijo + '%'
		) tax
)

go

IF (@@Error = 0) PRINT 'Creación exitosa de la función: fnColMedMagneticosPmSumaImpuestoTAHPorPrefijo()'
ELSE PRINT 'Error en la creación de la función: fnColMedMagneticosPmSumaImpuestoTAHPorPrefijo()'
GO
