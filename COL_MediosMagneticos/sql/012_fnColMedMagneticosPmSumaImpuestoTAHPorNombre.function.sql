IF OBJECT_ID ('dbo.fnColMedMagneticosPmSumaImpuestoTAHPorNombre') IS NOT NULL
   DROP FUNCTION dbo.fnColMedMagneticosPmSumaImpuestoTAHPorNombre
GO

create function dbo.fnColMedMagneticosPmSumaImpuestoTAHPorNombre(@VCHRNMBR char(21), @DOCTYPE smallint, @tipoTributo varchar(30))
returns table
as
--Prop�sito. Suma de impuestos en trabajo, abiertos o hist�ricos. Filtra los impuestos requeridos por @tipoTributo y comprobante
--Requisitos. Los impuestos o retenciones deben ser configurados con un c�digo en el campo Name de la direcci�n del detalle de impuesto
--05/08/19 jcf Creaci�n 
--
return
(
	select sum(tax.taxamnt) taxamnt, sum(tax.tdttxpur) tdttxpur
	from (
		select tw.vchrnmbr, tw.doctype, tw.TAXDTLID, tw.taxamnt, tw.tdttxpur
		from PM10500 tw --pm_tax_work
			inner join tx00201 tx
			on tx.taxdtlid = tw.taxdtlid
			and UPPER(tx.ADDRESS1) = @tipoTributo
		where tw.VCHRNMBR = @VCHRNMBR
		   AND tw.DOCTYPE = @DOCTYPE
		   --and tw.TAXDTLID like @prefijo + '%'

		union all

		select tw.vchrnmbr, tw.doctype, tw.TAXDTLID, tw.taxamnt, tw.tdttxpur
		from PM30700 tw --pm_tax_hist
			inner join tx00201 tx
			on tx.taxdtlid = tw.taxdtlid
			and UPPER(tx.ADDRESS1) = @tipoTributo
		where tw.VCHRNMBR = @VCHRNMBR
		   AND tw.DOCTYPE = @DOCTYPE
		   --and tw.TAXDTLID like @prefijo + '%'
		) tax
)

go

IF (@@Error = 0) PRINT 'Creaci�n exitosa de la funci�n: fnColMedMagneticosPmSumaImpuestoTAHPorNombre()'
ELSE PRINT 'Error en la creaci�n de la funci�n: fnColMedMagneticosPmSumaImpuestoTAHPorNombre()'
GO


