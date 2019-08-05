IF (OBJECT_ID ('dbo.vwColMediosMagneticos1001PagosEnCuentaYRetenciones', 'V') IS NULL)
   exec('create view dbo.vwColMediosMagneticos1001PagosEnCuentaYRetenciones as SELECT 1 as t');
go

--31/07/19 jcf Creación
go
ALTER VIEW dbo.vwColMediosMagneticos1001PagosEnCuentaYRetenciones as
select trx.pstYear , trx.pstMonth,
convert(varchar(8), trx.pstPeriodo) pstPeriodo
, rtrim(trx.VCHRNMBR) VCHRNMBR
, 'M' + convert(varchar(10), isnull(ac.jrnentry, 0)) jrnentryFactura
, ac.jrnentry
, trx.docdate
, trx.fechaVencimiento
, trx.tipo_comprob
, trx.serie
, case trx.tipo_comprob when '05' then right(trx.serie, 1) else trx.serie end serieFactura
, trx.DUAyear
, trx.docnumbr
, right(rtrim(replace(trx.docnumbr, '-', '')), 8) docnumbrFactura
, trx.nsaif_type_nit
, trx.nsaIfnit
, left(dbo.fCfdEsVacio(dbo.fCfdReemplazaSecuenciaDeEspacios(dbo.fCfdReemplazaCaracteresNI(trx.razonSocial), 10)), 60) razonSocial
, trx.baseAOpGravadas
, trx.igvAOpGravadas
, trx.baseAOpGravYNoGrav
, trx.igvAOpGravYNoGrav
, trx.baseAOpNoGravadas
, trx.igvAOpNoGravadas
, trx.noGravado
, trx.isc
, trx.otros
, trx.total
, rtrim(trx.curncyidSunat) curncyidSunat
, trx.XCHGRATE
, trx.docOrigFecha
, trx.docOrigTipo 
, trx.docOrigSerie 
, trx.docOrigDocNumbr
, trx.fechaDetraccion
, case when trx.tipo_comprob in ('07', '08', '87', '88', '97', '98') then convert(varchar(12), isnull(trx.docOrigFecha, 0), 103) else '' end fechaComprobanteQueModifica
, case when trx.tipo_comprob in ('07', '08', '87', '88', '97', '98') then trx.docOrigTipo else '' end tipoComprobanteQueModifica
, case when trx.tipo_comprob in ('07', '08', '87', '88', '97', '98') then trx.docOrigSerie else '' end serieComprobanteQueModifica
, case when trx.tipo_comprob in ('07', '08', '87', '88', '97', '98') then trx.docOrigDocNumbr else '' end numComprobanteQueModifica
, case when convert(varchar(12), isnull(trx.fechaDetraccion, 0), 103) = '01/01/1900' then '' else convert(varchar(12), isnull(trx.fechaDetraccion, 0), 103) end fechaDepositoDetraccion
, trx.numDetraccion
, trx.bienOServicio
, trx.indCanceladoConMedioPago
, case when trx.tipo_comprob in ('02', '03') then '0'	--boleta de venta (sin efecto en el igv)
		else
			case when trx.docPeriodo = trx.pstPeriodo then '1'
			when datediff(month, trx.docdate, trx.pstgdate) <= 12 then '6'
			when datediff(month, trx.docdate, trx.pstgdate) > 12 then '7'
			else '0'
			end
		end statusOportunidadAnotacion

from dbo.vwPmTransaccionesTodas trx
	left join pop30300 rec		
	on rec.poptype in (2, 3)
	and rec.vchrnmbr = trx.vchrnmbr
	and trx.doctype = 1
	and trx.bchsourc like 'Rcvg Trx%'
outer apply dbo.fnGlGetPrimerAsientoContableDeTrx(4,	
	case when trx.bchsourc like 'Rcvg Trx%' then rec.poptype else trx.doctype end, 
	case when trx.bchsourc like 'Rcvg Trx%' then rec.poprctnm else trx.VCHRNMBR end) ac
outer apply dbo.fLcLvParametros('APNODOM', '', '', '', '', '') nd
where 
trx.voided = 0
and trx.tipo_comprob != 'NA'
and trx.VNDCLSID not like nd.param1+'%'

go

IF (@@Error = 0) PRINT 'Creación exitosa de: vwColMediosMagneticos1001PagosEnCuentaYRetenciones'
ELSE PRINT 'Error en la creación de: vwColMediosMagneticos1001PagosEnCuentaYRetenciones'
GO
