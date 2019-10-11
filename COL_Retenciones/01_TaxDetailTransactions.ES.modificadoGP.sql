SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF (OBJECT_ID ('dbo.TaxDetailTransactions', 'V') IS NULL)
   exec('create view dbo.TaxDetailTransactions as SELECT 1 as t');
go


ALTER VIEW [dbo].[TaxDetailTransactions] AS 
--Propósito. Lista todos los impuestos contabilizados de compras y ventas de la compañía
--			Adicionalmente lista los impuestos de compras PM, POP no contabilizados.
--			El campo Serie no funciona. En su lugar usar: Tipo detalle de impuestos
--Usa. vwCiaHistorialImpuestos y DYN_FUNC_Series_Tax_Detail_Trx (modificado)
--15/03/12 JCF Agrega impuestos de compras en lote PM y POP. 
--16/03/17 jcf Agrega TXRGNNUM, voided de facturas POP
--11/10/19 jcf Agrega tipo de impuesto (address1)
--
select rtrim(['Tax History'].[TAXDTLID]) as 'Id. de detalle imp.', 
	rtrim(['Sales/Purchases Tax Master'].[TXDTLDSC]) as 'Descripción detalle de impuesto', 
	'Tipo detalle de impuestos' = dbo.DYN_FUNC_Tax_Detail_Type(['Sales/Purchases Tax Master'].[TXDTLTYP]), 
	rtrim(['Tax History'].[DOCNUMBR]) as 'Número de comprobante', 
	rtrim(['Tax History'].[CustomerVendor_ID]) as 'Id. de cliente/proveedor', 
	case ISNULL(['PM Vendor Master File'].[VENDORID],'empty') WHEN 'empty'  
		THEN rtrim(['RM Customer MSTR'].[CUSTNAME])  
		ELSE rtrim(['PM Vendor Master File'].[VENDNAME]) 
	END as 'Nombre de cliente/proveedor', 
	['Tax History'].[DOCDATE] as 'Fecha del documento', 
	['Tax History'].[PSTGDATE] as 'Fecha de contabilización', 
	['Tax History'].[DOCAMNT] as 'Total de ventas/compras', 
	['Tax History'].[Taxable_Amount] as 'Ventas/compras gravables', 
	['Tax History'].[TAXAMNT] as 'Monto impuesto',  
		(select rtrim([ACTNUMST]) 
		from [GL00105] as ['Account Index Master'] 
		where ['Account Index Master'].[ACTINDX] = ['Tax History'].[ACTINDX]) as 'Número de cuenta', 
	['Tax History'].[CURRNIDX] as 'Índice de monedas', 
	rtrim(['RM Customer MSTR'].[CUSTNAME]) as 'Nombre de cliente', 
	rtrim(['RM Customer MSTR'].[CUSTNMBR]) as 'Número de cliente', 
	'Tipo de documento' = dbo.DYN_FUNC_Document_Type_Tax_Detail_Trx(['Tax History'].[TIPODOC]), 
	'Transacción UE' = dbo.DYN_FUNC_Boolean_All(['Tax History'].[ECTRX]), 
	'Incluido en devolución' = dbo.DYN_FUNC_Boolean_All(['Tax History'].[Included_On_Return]), 
	['Tax History'].[ORTAXAMT] as 'Monto impuestos original', 
	['Tax History'].[Originating_Taxable_Amt] as 'Ventas/compras gravables originales', 
	['Tax History'].[ORDOCAMT] as 'Total de ventas/compras original', 
	'Serie' = dbo.DYN_FUNC_Series_Tax_Detail_Trx(['Tax History'].[SERIES]), 
	['Tax History'].[Tax_Date] as 'Fecha impuesto', 
	['Sales/Purchases Tax Master'].[TXDTLAMT] as 'Monto de detalle de impuestos', 
	['Sales/Purchases Tax Master'].[TXDTLBSE] as 'Base de detalle de impuestos', 
	['Sales/Purchases Tax Master'].[TXDTLPCT] as 'Porcentaje de detalle de impuestos', 
	rtrim(['Tax History'].[Tax_Return_ID]) as 'Id. devolución impuestos', rtrim(['PM Vendor Master File'].[VENDORID]) as 'Id. de proveedor', 
	rtrim(['PM Vendor Master File'].[VENDNAME]) as 'Nombre proveedor', 
	['PM Vendor Master File'].TXRGNNUM,
	'Anulado' = dbo.DYN_FUNC_Voided(['Tax History'].[VOIDSTTS] + ['Tax History'].voided),  
	['Tax History'].[DOCTYPE], 
	rtrim(['Tax History'].NUMDOCU) as 'Número de documento', 
	['Tax History'].ORIGEN,	['Tax History'].NoGravable, ['Tax History'].Gravable,
	['Tax History'].NoGravable + ['Tax History'].Gravable + ['Tax History'].[TAXAMNT] TotalDocumento,
    ['Sales/Purchases Tax Master'].TXDTLPCH,
	['Sales/Purchases Tax Master'].ADDRESS1,
	['Sales/Purchases Tax Master'].ADDRESS2

	from vwCiaHistorialImpuestos as ['Tax History']
--		[TX30000] as ['Tax History'] with (NOLOCK) 
		left outer join [TX00201] as ['Sales/Purchases Tax Master'] with (NOLOCK) 
			on ['Tax History'].[TAXDTLID] = ['Sales/Purchases Tax Master'].[TAXDTLID] 
		left outer join [PM00200] as ['PM Vendor Master File'] with (NOLOCK) 
			on ['Tax History'].[CustomerVendor_ID] = ['PM Vendor Master File'].[VENDORID] 
		left outer join [RM00101] as ['RM Customer MSTR'] with (NOLOCK) 
			on ['Tax History'].[CustomerVendor_ID] = ['RM Customer MSTR'].[CUSTNMBR] 
GO


IF (@@Error = 0) PRINT 'Creación exitosa de: [dbo].[TaxDetailTransactions]'
ELSE PRINT 'Error en la creación de: [dbo].[TaxDetailTransactions]'
GO


