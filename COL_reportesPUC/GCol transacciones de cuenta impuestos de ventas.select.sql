--Colombia transacciones de cuenta impuestos de ventas
select year([Fecha trans.]) [a�o], month([Fecha trans.]) [mes],
		Serie, [Fecha trans.], [N�mero de cuenta], [Descripci�n cuenta], [Monto d�bito], [Monto cr�dito], [Monto d�bito] - [Monto cr�dito] [neto],
		[N�m. documento original], [Id. maestro original], [Nombre maestro original], [Documento origen], [Segment3], [Tipo de contabilizaci�n]
from AccountTransactions
where serie = 'Ventas'

--Colombia tax detail
select [Id. de detalle imp.], [Descripci�n detalle de impuesto], [Tipo detalle de impuestos], [Id. de cliente/proveedor], [Nombre de cliente/proveedor], 
	[Fecha del documento], [Fecha de contabilizaci�n], [Monto impuesto], [Tipo de documento], [N�mero de documento], [Total de ventas/compras], [Ventas/compras gravables]
from [TaxDetailTransactions]
order by 1

