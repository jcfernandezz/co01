IF (OBJECT_ID ('dbo.vwColCertificadoRetenciones', 'V') IS NULL)
   exec('create view dbo.vwColCertificadoRetenciones as SELECT 1 as t');
go
--
alter view dbo.vwColCertificadoRetenciones as
--Prop�sito. Obtiene las retenciones de los proveedores en Colombia
--16/03/17 jcf Creaci�n. No se puede usar NSAIF01666 porque hay un error en gp al ingresar el nit
--22/05/17 JCF Habilita nsaif0166. El error en gp est� corregido.
--26/05/17 jcf Quita el agrupamiento
--11/10/19 jcf Agrega tipo de impuesto
--
select [Id. de cliente/proveedor], [Nombre de cliente/proveedor], year([Fecha de contabilizaci�n]) gestion, [Fecha de contabilizaci�n] fechaContab, 
		rtrim(ns.nsaif_type_nit) nsaif_type_nit, 
		stuff(replace(rtrim(ns.nsaIfnit), '-', ''), len(replace(rtrim(ns.nsaIfnit), '-', '')), 0, '-') nsaIfnit, 
		[Id. de detalle imp.], [Descripci�n detalle de impuesto], 
		[Porcentaje de detalle de impuestos], 
		tx.[Monto impuesto] montoImpuesto, tx.[Ventas/compras gravables] Imponible ,
		tx.[N�mero de comprobante], tx.[N�mero de documento], tx.[N�mero de cuenta], tx.TXDTLPCH,
		tx.[ADDRESS1], tx.[ADDRESS2]
from [TaxDetailTransactions] tx
	left join NSAIF01666 ns		--nsaif_vendor_nit_mstr [VENDOR nsaIF_Type_Nit nsaIFNit]
		on ns.vendorid = tx.[Id. de cliente/proveedor]
WHERE [Tipo detalle de impuestos] = 'Compras'
and [Porcentaje de detalle de impuestos] < 0
and upper(tx.Anulado) = 'NO'
go

IF (@@Error = 0) PRINT 'Creaci�n exitosa de: vwColCertificadoRetenciones'
ELSE PRINT 'Error en la creaci�n de: vwColCertificadoRetenciones'
GO

-----------------------------------------------------------------------------------------------------------
--test

--select *
--from dbo.vwColCertificadoRetenciones
--where datediff(day, '5/1/17', fechaContab) >= 0
--and datediff(day, '5/31/17', fechaContab) <= 0
--and TXDTLPCH = 'F'
