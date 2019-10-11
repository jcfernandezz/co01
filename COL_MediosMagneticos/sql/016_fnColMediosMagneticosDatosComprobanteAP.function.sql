--MEDIOS MAGNETICOS
--Proyectos:     COLOMBIA
--Propósito:     funciones para la generación de reportes para Medios magnéticos
--Pre-condición: Localización andina instalada
--Utilizado por: Reportes excel
--
------------------------------------------------------------------------

IF OBJECT_ID ('dbo.fnColMediosMagneticosDatosComprobanteAP') IS NOT NULL
   DROP FUNCTION dbo.fnColMediosMagneticosDatosComprobanteAP 
GO

create FUNCTION dbo.fnColMediosMagneticosDatosComprobanteAP ( @DOCTYPE smallint, @VCHRNMBR char(21), @VENDORID char(15), @CITY char(35), @STATE char(29)) 
RETURNS table as
--Propósito. Obtiene datos específicos de localización
--Requisito. Debe estar instalado localización Andina. Tablas nsaCOA.
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
		case when rtrim(ns.nsaif_type_nit) = '31' then 
			reverse(substring(reverse(rtrim(replace(ns.nsaIfnit, '-', ''))), 2, 50)) 
		else rtrim(ns.nsaIfnit)
		end nsaIfNitSinDV,

		case when rtrim(ns.nsaif_type_nit) = '31' then 
			left(reverse(rtrim(ns.nsaIfnit)), 1) 
		else ''
		end digitoVerificador,

		rtrim(ns.nsaIfnit) nsaIfnit, 
		rtrim(ns.Fname) Fname,
		rtrim(ns.Oname) Oname, 
		rtrim(ns.Fsurname) Fsurname,
		rtrim(ns.Ssurname) Ssurname,
		rtrim(ns.Fname) +' '+ rtrim(ns.Oname) +' '+ rtrim(ns.Fsurname) +' '+ rtrim(ns.Ssurname) Rsocial,
		
		case when isnull(ns.nsaIF_Site_Code, '') = '' then
			left(@STATE, 2) 
		else left(ns.nsaIF_Site_Code, 2)
		end dptoCode,
		
		case when isnull(ns.nsaIF_Site_Code, '') = '' then
			left(@CITY, 5)
		else ns.nsaIF_Site_Code 
		end cityCode,
		
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
IF (@@Error = 0) PRINT 'Creación exitosa de la función: fnColMediosMagneticosDatosComprobanteAP()'
ELSE PRINT 'Error en la creación de la función: fnColMediosMagneticosDatosComprobanteAP()'
GO

