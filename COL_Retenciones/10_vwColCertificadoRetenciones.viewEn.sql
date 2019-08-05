--use gcol;
--
create view dbo.vwColCertificadoRetenciones as
--Propósito. Obtiene las retenciones de los proveedores en Colombia
--16/03/17 jcf Creación. No se puede usar NSAIF01666 porque hay un error en gp al ingresar el nit
--22/05/17 JCF Habilita nsaif0166. El error en gp está corregido.
--26/05/17 jcf Quita el agrupamiento
--11/07/19 jcf Asume [TaxDetailTransactions] en inglés
--
select tx.[Customer/Vendor ID] [Id. de cliente/proveedor], tx.[Customer/Vendor Name] [Nombre de cliente/proveedor], 
		year(tx.[Posting Date]) gestion, tx.[Posting Date] fechaContab, 
		rtrim(ns.nsaif_type_nit) nsaif_type_nit, 
		stuff(replace(rtrim(ns.nsaIfnit), '-', ''), len(replace(rtrim(ns.nsaIfnit), '-', '')), 0, '-') nsaIfnit, 
		tx.[Tax Detail ID] [Id. de detalle imp.], tx.[Tax Detail Description] [Descripción detalle de impuesto], 
		tx.[Tax Detail Percent] [Porcentaje de detalle de impuestos], 
		tx.[Tax Amount] montoImpuesto, tx.[Taxable Sales/Purchases] Imponible ,
		tx.[Document Number] [Número de comprobante], tx.[Document Number] [Número de documento], tx.[Account Number] [Número de cuenta]
from [TaxDetailTransactions] tx
	left join NSAIF01666 ns		--nsaif_vendor_nit_mstr [VENDOR nsaIF_Type_Nit nsaIFNit]
		on ns.vendorid = tx.[Customer/Vendor ID]
WHERE tx.[Tax Detail Type] = 'Purchases'
and tx.[Tax Detail Percent] < 0
and lower(tx.Voided) = 'no'
go
-----------------------------------------------------------------------------------------------------------
--test

--select *
--from dbo.vwColCertificadoRetenciones
--where datediff(day, '5/1/17', fechaContab) >= 0
--and datediff(day, '5/31/17', fechaContab) <= 0
--and TXDTLPCH = 'F'
