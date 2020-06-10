--MEDIOS MAGNETICOS
--Proyectos:     COLOMBIA
--Propósito:     Crea vistas para la generación de reportes para Medios magnéticos
--Pre-condición: Localización andina instalada
--Utilizado por: Reportes excel
--
-----------------------------------------------------------------------------------------------------------
IF OBJECT_ID ('dbo.vwColMediosMagneticosFacturasCompra') IS NOT NULL
   DROP view vwColMediosMagneticosFacturasCompra
GO

create VIEW [dbo].[vwColMediosMagneticosFacturasCompra]
--Propósito. Detalle de transacciones de Payables Management abiertas e históricas con impuestos incluidos
--31/07/19 JCF Creación
--
AS
   SELECT isnull(cs.nsaif_type_nit, '0') nsaif_type_nit, isnull(cs.nsaIfNitSinDV, 'Sin Id de doc.') nsaIfnit, isnull(cs.digitoVerificador, '-') digitoVerificador,
		isnull(cs.Fname, '-') Fname, isnull(cs.Oname, '-') Oname, isnull(cs.Fsurname, '-') Fsurname, isnull(cs.Ssurname, '-') Ssurname, 
		isnull(cs.dptoCode, '') dptoCode, isnull(cs.cityCode, '') cityCode,
		trx.vendname,
		trx.VCHRNMBR, trx.DOCDATE, 
		trx.address1, trx.CITY, trx.[STATE], trx.country, trx.ccode,
		trx.PRCHAMNT,
		isnull(trx.XCHGRATE, 0) XCHGRATE, 
		trx.pstgdate, trx.DOCTYPE, trx.docnumbr, 		
		trx.trxsorce, trx.VOIDED, trx.VENDORID, trx.pordnmbr, trx.bchsourc,
		impu.address1 impuAddress1, impu.address2 impuAddress2,
		impu.TAXDTLID, impu.taxamnt, impu.tdttxpur

		--isnull(iva.tdttxpur, 0) iva_tdttxpur,
		--isnull(iva.taxamnt, 0) iva_taxamnt,
		--isnull(rete.tdttxpur, 0) + isnull(ica.tdttxpur, 0) rete_tdttxpur,
		--isnull(rete.taxamnt, 0) + isnull(ica.taxamnt, 0) rete_taxamnt

     from dbo.vwPmTransaccionesTodas trx
		OUTER APPLY dbo.fnColMediosMagneticosDatosComprobanteAP(trx.DOCTYPE, trx.VCHRNMBR, trx.VENDORID, trx.CITY, trx.[STATE]) cs	
		outer apply dbo.fnColMedMagneticosPmImpuestoTAH(trx.VCHRNMBR, trx.DOCTYPE) impu
	   --   cross apply dbo.fnColParametros('CTIPOIMPOTROS', 'CTIPOIMPIVA', 'CTIPOIMPICA', 'na', 'na', 'na', 'MEDMAG') pr
		
		  --outer apply dbo.fnColMedMagneticosPmSumaImpuestoTAHPorNombre(trx.VCHRNMBR, trx.DOCTYPE, pr.param1) rete	--retenciones

		  --outer apply dbo.fnColMedMagneticosPmSumaImpuestoTAHPorNombre(trx.VCHRNMBR, trx.DOCTYPE, pr.param2) iva	--iva
		  
		  --outer apply dbo.fnColMedMagneticosPmSumaImpuestoTAHPorNombre(trx.VCHRNMBR, trx.DOCTYPE, pr.param3) ica	--ica

		where trx.doctype < 6														--excluye pagos

go 
IF (@@Error = 0) PRINT 'Creación exitosa de: vwColMediosMagneticosFacturasCompra'
ELSE PRINT 'Error en la creación de: vwColMediosMagneticosFacturasCompra'
GO

-----------------------------------------------------

