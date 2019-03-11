--Colombia transacciones de cuenta impuestos de ventas
select year([Fecha trans.]) [año], month([Fecha trans.]) [mes],
		Serie, [Fecha trans.], [Número de cuenta], [Descripción cuenta], [Monto débito], [Monto crédito], [Monto débito] - [Monto crédito] [neto],
		[Núm. documento original], [Id. maestro original], [Nombre maestro original], [Documento origen], [Segment3], [Tipo de contabilización]
from AccountTransactions
where serie = 'Ventas'

--Colombia tax detail
select [Id. de detalle imp.], [Descripción detalle de impuesto], [Tipo detalle de impuestos], [Id. de cliente/proveedor], [Nombre de cliente/proveedor], 
	[Fecha del documento], [Fecha de contabilización], [Monto impuesto], [Tipo de documento], [Número de documento], [Total de ventas/compras], [Ventas/compras gravables]
from [TaxDetailTransactions]
order by 1

