--MEDIOS MAGNETICOS
--Proyectos:     COLOMBIA
--Propósito:     Crea vistas y funciones para la generación de reportes para Medios magnéticos
--Pre-condición: Localización andina instalada
--Utilizado por: Reportes excel
--
------------------------------------------------------------------------

IF OBJECT_ID ('dbo.fnColMediosMagneticosDatosComprobante') IS NOT NULL
   DROP FUNCTION dbo.fnColMediosMagneticosDatosComprobante 
GO

create FUNCTION dbo.fnColMediosMagneticosDatosComprobante ( @DOCTYPE smallint, @VCHRNMBR char(21), @VENDORID char(15)) 
RETURNS table as
--Propósito. Obtiene datos específicos de localización
--Requisito. Debe estar instalado localización Andina. Tablas nsaCOA.
--		nsa_cod_transac indica Adquisiciones Gravadas destinadas a operaciones: 1 Gravadas y/o de exportación, 2 Gravadas y/o de export. y a operaciones no gravadas, 3 No gravadas
		--nsa_cod_transac 	TIPO DE TRANSACCION
		--nsa_tipo_comprob 	Tipo de comprobante
		--nsa_cred_trib 		Tipo adquisición
		--nsa_cod_ice		(ice) Bien o servicio
		--nsa_autorizacion	Núm. Depósito detracción
		--daterecd		(date received)	Fecha detracción
		--nsa_cod_iva2		Item detracción
--31/07/19 Creación. JCF
--
return
(
	select top 1 rtrim(ot.nsa_tipo_comprob) tipo_comprob, rtrim(ot.nsa_cod_transac) cod_transac,
		rtrim(ot.nsa_autorizacion) autorizacion, case when isnull(ot.nsa_cod_iva2, '') = '' then '1/1/1900' else ot.daterecd end daterecd,
		rtrim(ot.nsa_cod_iva1) codRetencionIva1,															--retenciones
		rtrim(ot.nsaCoa_secuencial) Coa_secuencial,
		right(rtrim(ot.nsa_cod_ice), 1) bienOServicio,																	--tabla 30

		rtrim(ns.nsaif_type_nit) nsaif_type_nit,
		reverse(substring(reverse(rtrim(ns.nsaIfnit)), 2, 30)) nsaIfNitSinDV,
		left(reverse(rtrim(ns.nsaIfnit)), 1) digitoVerificador,
		rtrim(ns.nsaIfnit) nsaIfnit, 
		rtrim(ns.Fname) Fname,
		rtrim(ns.Oname) Oname, 
		rtrim(ns.Fsurname) Fsurname,
		rtrim(ns.Ssurname) Ssurname,
		rtrim(ns.Fname) +' '+ rtrim(ns.Oname) +' '+ rtrim(ns.Fsurname) +' '+ rtrim(ns.Ssurname) Rsocial,
		case when ot.nsa_tipo_comprob in ('01', '03', '04', '07', '08') then right(rtrim(ot.nsa_serie), 4)	--factura, boleta, liq compra, nc, nd
			when ot.nsa_tipo_comprob in ('50', '52') then right(rtrim(ot.nsa_serie), 3)						--importación
			else rtrim(ot.nsa_serie)
		end serie,
		case when ot.nsa_tipo_comprob in ('50', '52') then year(ot.docdate) else 0 end DUAyear,				--importación
		--doc original modificado:
		case when ot.nsa_tipo_comprob_mod in ('01', '03', '04', '07', '08') then right(rtrim(ot.nsa_sernota), 4)	--factura, boleta, liq compra, nc, nd
			when ot.nsa_tipo_comprob in ('50', '52') then right(rtrim(ot.nsa_sernota), 3)						--importación
			else rtrim(ot.nsa_sernota)
		end nsa_sernota,
		ot.nsaCoa_date_nota, rtrim(ot.nsa_tipo_comprob_mod) nsa_tipo_comprob_mod, rtrim(ot.nsacoa_secuencial_mod) nsacoa_secuencial_mod
	from NSAIF01666 ns					--nsaif_vendor_nit_mstr [VENDOR nsaIF_Type_Nit nsaIFNit]
		left join nsacoa_gl00021 ot		--NSAcoa_compra [nsa_RUC_Prov VENDORID DOCNUMBR]
			on ns.vendorid = ot.VENDORID
			and ot.DOCNUMBR = @VCHRNMBR
	where ns.VENDORID = @VENDORID
)

go
IF (@@Error = 0) PRINT 'Creación exitosa de la función: fnColMediosMagneticosDatosComprobante()'
ELSE PRINT 'Error en la creación de la función: fnColMediosMagneticosDatosComprobante()'
GO
-----------------------------------------------------------------------------------------------------------
IF OBJECT_ID ('dbo.vwColMediosMagneticosFacturasCompra') IS NOT NULL
   DROP view vwColMediosMagneticosFacturasCompra
GO

create VIEW [dbo].[vwColMediosMagneticosFacturasCompra]
--Propósito. Detalle de transacciones de Payables Management abiertas e históricas
--31/07/19 JCF Creación
--
AS
   SELECT isnull(cs.nsaif_type_nit, '0') nsaif_type_nit, isnull(cs.nsaIfNitSinDV, 'El proveedor no tiene un Id de doc.') nsaIfnit, isnull(cs.digitoVerificador, '-') digitoVerificador,
		isnull(cs.Fname, '-') Fname, isnull(cs.Oname, '-') Oname, isnull(cs.Fsurname, '-') Fsurname, isnull(cs.Ssurname, '-') Ssurname, trx.vendname,
		trx.VCHRNMBR, trx.DOCDATE, 
		trx.address1, trx.CITY, trx.[STATE], trx.country, trx.ccode,
		trx.PRCHAMNT,
		isnull(trx.XCHGRATE, 0) XCHGRATE, 
		trx.pstgdate, trx.DOCTYPE, trx.docnumbr, 		
		trx.trxsorce, trx.VOIDED, trx.VENDORID, trx.pordnmbr, trx.bchsourc,
		isnull(iva.tdttxpur, 0) iva_tdttxpur,
		isnull(iva.taxamnt, 0) iva_taxamnt,
		isnull(rete.tdttxpur, 0) + isnull(ica.tdttxpur, 0) rete_tdttxpur,
		isnull(rete.taxamnt, 0) + isnull(ica.taxamnt, 0) rete_taxamnt

     from dbo.vwPmTransaccionesTodas trx
		OUTER APPLY dbo.fnColMediosMagneticosDatosComprobante(trx.DOCTYPE, trx.VCHRNMBR, trx.VENDORID) cs	--datos sunat 
	      cross apply dbo.fnColParametros('C_PREFRETE', 'C_PREFIVA', 'C_PREFICA', 'na', 'na', 'na', 'MEDMAG') pr
			   
		  outer apply dbo.fnColMedMagneticosPmSumaImpuestoTAHPorPrefijo(trx.VCHRNMBR, trx.DOCTYPE, pr.param2) rete	--retenciones

		  outer apply dbo.fnColMedMagneticosPmSumaImpuestoTAHPorPrefijo(trx.VCHRNMBR, trx.DOCTYPE, pr.param1) iva	--iva
		  
		  outer apply dbo.fnColMedMagneticosPmSumaImpuestoTAHPorPrefijo(trx.VCHRNMBR, trx.DOCTYPE, pr.param3) ica	--ica

		where trx.doctype < 6														--excluye pagos

go 
IF (@@Error = 0) PRINT 'Creación exitosa de: vwColMediosMagneticosFacturasCompra'
ELSE PRINT 'Error en la creación de: vwColMediosMagneticosFacturasCompra'
GO

-----------------------------------------------------

