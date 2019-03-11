--Localización Andina
--Propósito. Funciones que obtienen saldos contables agrupados por cuenta puc, tercero y transacciones
--
-----------------------------------------------------------------------------------------------------------
IF OBJECT_ID ('dbo.f_LocandinaGLSaldosPucYTerceros') IS NOT NULL
   DROP function dbo.f_LocandinaGLSaldosPucYTerceros
GO
create function dbo.f_LocandinaGLSaldosPucYTerceros (@p_mes smallint)
returns table 
--Propósito. Obtiene los saldos contables por cuenta puc y tercero
--1/7/10 JCF Creación
--15/7/10 JCF Agrega saldos iniciales y finales para cada mes
--20/7/10 JCF Agrega campo USRDEFS1
--09/4/13 jcf Agrega dirección de terceros
--
as return (
select 	@p_mes mes,
	isnull(pg.puc1 +' _______ '+ rtrim(p1.nsa_Descripcion_Codigo), '') puc_y_desc1,
	isnull(pg.puc2 +' ______ '+ rtrim(p2.nsa_Descripcion_Codigo), '') puc_y_desc2,
	isnull(pg.puc4 +' ____ '+ rtrim(p4.nsa_Descripcion_Codigo), '') puc_y_desc4,
	isnull(pg.puc6 +' __ '+ rtrim(p6.nsa_Descripcion_Codigo), '') puc_y_desc6,
	isnull(rtrim(pg.puccode) +' _ '+ rtrim(p8.nsa_Descripcion_Codigo), '') puc_y_desc,
	cs.nsaIF_YEAR añoAbierto, cs.ACTINDX,cs.ACTNUMBR_1 compañía,cs.ACTNUMBR_2 brand,cs.ACTNUMBR_3 cuentaContable,cs.ACTNUMST númeroCuenta, isnull(pg.actdescr, '') descripciónDeCuenta, 
	case when cs.nsaIFNit='' then cs.ormstrid else cs.nsaIFNit end registroDeImpuesto, cs.nsaIFNit NIT, cs.nsaIF_Type_Nit tipoNIT, 
	cs.ORMSTRID idMaestro, rtrim(cs.ORMSTRNM) nombreMaestroOriginal,
	dt.ADDRESS1, dt.ADDRESS2, dt.ADDRESS3, dt.CITY, dt.[STATE], dt.ZIPCODE, dt.COUNTRY, 
	case when @p_mes = 1 then 	cs.nsaIF_SI_1
		when @p_mes = 2 then 	cs.nsaIF_SI_2
		when @p_mes = 3 then 	cs.nsaIF_SI_3
		when @p_mes = 4 then 	cs.nsaIF_SI_4
		when @p_mes = 5 then 	cs.nsaIF_SI_5
		when @p_mes = 6 then 	cs.nsaIF_SI_6
		when @p_mes = 7 then 	cs.nsaIF_SI_7
		when @p_mes = 8 then 	cs.nsaIF_SI_8
		when @p_mes = 9 then 	cs.nsaIF_SI_9
		when @p_mes = 10 then 	cs.nsaIF_SI_10
		when @p_mes = 11 then 	cs.nsaIF_SI_11
		when @p_mes = 12 then 	cs.nsaIF_SI_12
		else 0
	end SaldoAnterior,
	case when @p_mes = 1 then 	cs.nsaIF_SDeb_1
		when @p_mes = 2 then 	cs.nsaIF_SDeb_2
		when @p_mes = 3 then 	cs.nsaIF_SDeb_3
		when @p_mes = 4 then 	cs.nsaIF_SDeb_4
		when @p_mes = 5 then 	cs.nsaIF_SDeb_5
		when @p_mes = 6 then 	cs.nsaIF_SDeb_6
		when @p_mes = 7 then 	cs.nsaIF_SDeb_7
		when @p_mes = 8 then 	cs.nsaIF_SDeb_8
		when @p_mes = 9 then 	cs.nsaIF_SDeb_9
		when @p_mes = 10 then 	cs.nsaIF_SDeb_10
		when @p_mes = 11 then 	cs.nsaIF_SDeb_11
		when @p_mes = 12 then 	cs.nsaIF_SDeb_12
		else 0
	end Débitos,
	case when @p_mes = 1 then 	cs.nsaIF_SCred_1
		when @p_mes = 2 then 	cs.nsaIF_SCred_2
		when @p_mes = 3 then 	cs.nsaIF_SCred_3
		when @p_mes = 4 then 	cs.nsaIF_SCred_4
		when @p_mes = 5 then 	cs.nsaIF_SCred_5
		when @p_mes = 6 then 	cs.nsaIF_SCred_6
		when @p_mes = 7 then 	cs.nsaIF_SCred_7
		when @p_mes = 8 then 	cs.nsaIF_SCred_8
		when @p_mes = 9 then 	cs.nsaIF_SCred_9
		when @p_mes = 10 then 	cs.nsaIF_SCred_10
		when @p_mes = 11 then 	cs.nsaIF_SCred_11
		when @p_mes = 12 then 	cs.nsaIF_SCred_12
		else 0
	end Créditos,
	case when @p_mes = 1 then 	cs.nsaIF_SF_1
		when @p_mes = 2 then 	cs.nsaIF_SF_2
		when @p_mes = 3 then 	cs.nsaIF_SF_3
		when @p_mes = 4 then 	cs.nsaIF_SF_4
		when @p_mes = 5 then 	cs.nsaIF_SF_5
		when @p_mes = 6 then 	cs.nsaIF_SF_6
		when @p_mes = 7 then 	cs.nsaIF_SF_7
		when @p_mes = 8 then 	cs.nsaIF_SF_8
		when @p_mes = 9 then 	cs.nsaIF_SF_9
		when @p_mes = 10 then 	cs.nsaIF_SF_10
		when @p_mes = 11 then 	cs.nsaIF_SF_11
		when @p_mes = 12 then 	cs.nsaIF_SF_12
		else 0
	end SaldoFinal,
	cs.nsaIF_SI_1 SaldoAntEnero,
	cs.nsaIF_SI_2 SaldoAntFebrero,
	cs.nsaIF_SI_3 SaldoAntMarzo,
	cs.nsaIF_SI_4 SaldoAntAbril,
	cs.nsaIF_SI_5 SaldoAntMayo,
	cs.nsaIF_SI_6 SaldoAntJunio,
	cs.nsaIF_SI_7 SaldoAntJulio,
	cs.nsaIF_SI_8 SaldoAntAgosto,
	cs.nsaIF_SI_9 SaldoAntSeptiembre,
	cs.nsaIF_SI_10 SaldoAntOctubre,
	cs.nsaIF_SI_11 SaldoAntNoviembre,
	cs.nsaIF_SI_12 SaldoAntDiciembre,
	cs.nsaIF_SF_1 SaldoFinEnero,
	cs.nsaIF_SF_2 SaldoFinFebrero,
	cs.nsaIF_SF_3 SaldoFinMarzo,
	cs.nsaIF_SF_4 SaldoFinAbril,
	cs.nsaIF_SF_5 SaldoFinMayo,
	cs.nsaIF_SF_6 SaldoFinJunio,
	cs.nsaIF_SF_7 SaldoFinJulio,
	cs.nsaIF_SF_8 SaldoFinAgosto,
	cs.nsaIF_SF_9 SaldoFinSeptiembre,
	cs.nsaIF_SF_10 SaldoFinOctubre,
	cs.nsaIF_SF_11 SaldoFinNoviembre,
	cs.nsaIF_SF_12 SaldoFinDiciembre,
	cs.nsaIF_SDeb0 DébitoAnual, cs.nsaIF_SDeb01 CréditoAnual,	cs.nsaIF_SF0, cs.nsaIF_SI0,
	isnull(pg.puc1, '') puc1, isnull(pg.puc2, '') puc2, isnull(pg.puc4, '') puc4, isnull(pg.puc6, '') puc6, isnull(pg.puccode, '') puccode, 
	isnull(p1.nsa_Descripcion_Codigo, '') nsa_Descripcion_puc1, isnull(p2.nsa_Descripcion_Codigo, '') nsa_Descripcion_puc2, 
	isnull(p4.nsa_Descripcion_Codigo, '') nsa_Descripcion_puc4, isnull(p6.nsa_Descripcion_Codigo, '') nsa_Descripcion_puc6, 
	ISNULL(p8.nsa_Descripcion_Codigo, '') nsa_Descripcion_puc8, pg.USRDEFS1
from nsaif_gl00050	cs					--nsaIF_Conciliacion_saldos
left join dbo.vwLocAndinaGLCuentasPucyGP pg	--
	on pg.ACTINDX = cs.actindx
left join nsaPUC_GL10000 p1				--PUC_Account_MSTR [nsa_Codigo]
	on p1.nsa_Codigo = pg.puc1
left join nsaPUC_GL10000 p2				--PUC_Account_MSTR [nsa_Codigo]
	on p2.nsa_Codigo = pg.puc2
left join nsaPUC_GL10000 p4				--PUC_Account_MSTR [nsa_Codigo]
	on p4.nsa_Codigo = pg.puc4
left join nsaPUC_GL10000 p6				--PUC_Account_MSTR [nsa_Codigo]
	on p6.nsa_Codigo = pg.puc6
left join nsaPUC_GL10000 p8				--PUC_Account_MSTR [nsa_Codigo]
	on p8.nsa_Codigo = pg.puccode
outer apply dbo.f_obtieneDatosTerceros (0, 0, cs.ORMSTRID) dt
--where cs.nsaIF_YEAR >= 2015
)
GO
IF (@@Error = 0) PRINT 'Creación exitosa de: f_LocandinaGLSaldosPucYTerceros'
ELSE PRINT 'Error en la creación de: f_LocandinaGLSaldosPucYTerceros'
GO

-------------------------------------------------------------------------------------------------------

IF OBJECT_ID ('dbo.f_LocAndinaGLSaldosPucTercerosYTrx') IS NOT NULL
   DROP function dbo.f_LocAndinaGLSaldosPucTercerosYTrx
GO
create function dbo.f_LocAndinaGLSaldosPucTercerosYTrx (@p_mes smallint)
returns table 
--Propósito. Obtiene los saldos contables por cuenta puc, tercero y sus movimientos del mes
--01/07/10 JCF Creación
--19/07/10 JCF Agrega saldos anteriores y finales
--24/11/10 jcf Agrega asientos históricos
--07/12/10 jcf Agrega campos rctrxseq y sqncline
--04/02/13 jcf Agrega sourcdoc
--09/04/13 jcf Agrega dirección de terceros
--
as return (
--totales y subtotales por puc y nit
select sp.mes,sp.puc_y_desc1,sp.puc_y_desc2,sp.puc_y_desc4,sp.puc_y_desc6,sp.puc_y_desc,
	sp.añoAbierto,sp.ACTINDX,sp.compañía,sp.brand,sp.cuentaContable,sp.númeroCuenta,sp.descripciónDeCuenta,
	sp.registroDeImpuesto, sp.NIT,  sp.tipoNIT, sp.idMaestro, sp.nombreMaestroOriginal,
	sp.ADDRESS1, sp.ADDRESS2, sp.ADDRESS3, sp.CITY, sp.[STATE], sp.ZIPCODE, sp.COUNTRY,
	sp.SaldoAnterior,	sp.Débitos,	sp.Créditos,	sp.SaldoFinal,
	sp.puc1,sp.puc2,sp.puc4,sp.puc6,sp.puccode,
	sp.nsa_Descripcion_puc1,sp.nsa_Descripcion_puc2,sp.nsa_Descripcion_puc4,sp.nsa_Descripcion_puc6,sp.nsa_Descripcion_puc8,
	sp.SaldoAntEnero,
	sp.SaldoAntFebrero,
	sp.SaldoAntMarzo,
	sp.SaldoAntAbril,
	sp.SaldoAntMayo,
	sp.SaldoAntJunio,
	sp.SaldoAntJulio,
	sp.SaldoAntAgosto,
	sp.SaldoAntSeptiembre,
	sp.SaldoAntOctubre,
	sp.SaldoAntNoviembre,
	sp.SaldoAntDiciembre,
	sp.SaldoFinEnero,
	sp.SaldoFinFebrero,
	sp.SaldoFinMarzo,
	sp.SaldoFinAbril,
	sp.SaldoFinMayo,
	sp.SaldoFinJunio,
	sp.SaldoFinJulio,
	sp.SaldoFinAgosto,
	sp.SaldoFinSeptiembre,
	sp.SaldoFinOctubre,
	sp.SaldoFinNoviembre,
	sp.SaldoFinDiciembre,
	sp.DébitoAnual, sp.CréditoAnual,
	0 entradaDiario, 0 rctrxseq, 0 sqncline, 0 secuencia,
	0 fechaTrans, 
	'' referencia, 
	'' descripción, 
	0 tipoTransOriginal,
	'' númeroControlOriginal,
	'' númeroDocumentoOriginal,
	0 montoDébito,
	0 montoCrédito,
	0 montoDébitoO,
	0 montoCréditoO, 
	'' idMoneda,
	'' sourcdoc
from dbo.f_LocandinaGLSaldosPucYTerceros(@p_mes) sp
union all
--asientos contables por cada puc y nit
select sp.mes,sp.puc_y_desc1,sp.puc_y_desc2,sp.puc_y_desc4,sp.puc_y_desc6,sp.puc_y_desc,
	sp.añoAbierto,sp.ACTINDX,sp.compañía,sp.brand,sp.cuentaContable,sp.númeroCuenta,sp.descripciónDeCuenta,
	sp.registroDeImpuesto, sp.NIT, sp.tipoNIT, sp.idMaestro, sp.nombreMaestroOriginal,
	sp.ADDRESS1, sp.ADDRESS2, sp.ADDRESS3, sp.CITY, sp.[STATE], sp.ZIPCODE, sp.COUNTRY ,
	0 SaldoAnterior,	0 Débitos,	0 Créditos,	0 SaldoFinal,
	sp.puc1,sp.puc2,sp.puc4,sp.puc6,sp.puccode,
	sp.nsa_Descripcion_puc1,sp.nsa_Descripcion_puc2,sp.nsa_Descripcion_puc4,sp.nsa_Descripcion_puc6,sp.nsa_Descripcion_puc8,
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	isnull(ld.jrnentry, 0) entradaDiario, 
	ld.rctrxseq, ld.sqncline, ld.rctrxseq + ld.sqncline secuencia,
	isnull(ld.trxdate, 0) fechaTrans, 
	isnull(ld.refrence, '') referencia, 
	isnull(ld.dscriptn, '') descripción, 
	isnull(ld.ORTRXTYP, 0) tipoTransOriginal,
	isnull(ld.ORCTRNUM, '') númeroControlOriginal,
	isnull(ld.ORDOCNUM, '') númeroDocumentoOriginal,
	isnull(ld.debitamt, 0) Débito,
	isnull(ld.crdtamnt, 0) Crédito,
	isnull(ld.ORDBTAMT, 0) montoDébitoO,
	isnull(ld.ORCRDAMT, 0) montoCréditoO, 
	isnull(ld.curncyid, '') idMoneda,
	ld.sourcdoc
from dbo.f_LocandinaGLSaldosPucYTerceros (@p_mes) sp
inner join	dbo.vwLocAndinaGLLibroDiario ld	
	on ld.actindx = sp.ACTINDX
	and ld.ormstrid = sp.idMaestro
	and ld.openyear = sp.añoAbierto
	and ld.mes = sp.mes
	and ld.origen in ('Abrir', 'Histórico')
)
GO
IF (@@Error = 0) PRINT 'Creación exitosa de: f_LocAndinaGLSaldosPucTercerosYTrx'
ELSE PRINT 'Error en la creación de: f_LocAndinaGLSaldosPucTercerosYTrx'
GO
-----------------------------------------------------------------------------------------------------------
IF (OBJECT_ID ('dbo.vwLocAndinaGLSaldosPucYTerceros', 'V') IS NULL)
   exec('create view dbo.vwLocAndinaGLSaldosPucYTerceros as SELECT 1 as t');
go
ALTER view dbo.vwLocAndinaGLSaldosPucYTerceros as
--Propósito. Localización andina. Saldos mensuales agrupados por cuenta PUC y terceros
--Utilizado por. Planilla excel
--6/7/10 JCF Creación
--15/7/10 JCF Modifica consulta para usar sy_period_setp
--20/7/10 JCF Agrega USRDEFS1
--09/04/13 jcf Agrega dirección de terceros
--
select pr.PERIODID, pr.PERNAME Mes,
	pyt.puc_y_desc1,pyt.puc_y_desc2,pyt.puc_y_desc4,pyt.puc_y_desc6,pyt.puc_y_desc,
	pyt.añoAbierto,pyt.ACTINDX,pyt.compañía,pyt.brand,pyt.cuentaContable,pyt.númeroCuenta,pyt.descripciónDeCuenta,
	pyt.registroDeImpuesto, pyt.NIT, pyt.tipoNIT,pyt.idMaestro,pyt.nombreMaestroOriginal,	
	pyt.ADDRESS1, pyt.ADDRESS2, pyt.ADDRESS3, pyt.CITY, pyt.[STATE], pyt.ZIPCODE, pyt.COUNTRY ,
	pyt.SaldoAnterior,pyt.Débitos,pyt.Créditos,pyt.SaldoFinal,	
	case when pr.PERIODID = 1 then pyt.SaldoAntEnero else 0 end SaldoAnt_Enero,
	case when pr.PERIODID = 2 then 	pyt.SaldoAntFebrero else 0 end SaldoAnt_Febrero ,
	case when pr.PERIODID = 3 then 	pyt.SaldoAntMarzo else 0 end SaldoAnt_Marzo ,
	case when pr.PERIODID = 4 then 	pyt.SaldoAntAbril else 0 end SaldoAnt_Abril ,
	case when pr.PERIODID = 5 then 	pyt.SaldoAntMayo else 0 end SaldoAnt_Mayo ,
	case when pr.PERIODID = 6 then 	pyt.SaldoAntJunio else 0 end SaldoAnt_Junio ,
	case when pr.PERIODID = 7 then 	pyt.SaldoAntJulio else 0 end SaldoAnt_Julio ,
	case when pr.PERIODID = 8 then 	pyt.SaldoAntAgosto else 0 end SaldoAnt_Agosto ,
	case when pr.PERIODID = 9 then 	pyt.SaldoAntSeptiembre else 0 end SaldoAnt_Septiembre ,
	case when pr.PERIODID = 10 then 	pyt.SaldoAntOctubre else 0 end SaldoAnt_Octubre ,
	case when pr.PERIODID = 11 then 	pyt.SaldoAntNoviembre else 0 end SaldoAnt_Noviembre ,
	case when pr.PERIODID = 12 then 	pyt.SaldoAntDiciembre else 0 end SaldoAnt_Diciembre ,
	case when pr.PERIODID = 1 then pyt.SaldoFinEnero else 0 end SaldoFin_Enero,
	case when pr.PERIODID = 2 then 	pyt.SaldoFinFebrero else 0 end SaldoFin_Febrero ,
	case when pr.PERIODID = 3 then 	pyt.SaldoFinMarzo else 0 end SaldoFin_Marzo ,
	case when pr.PERIODID = 4 then 	pyt.SaldoFinAbril else 0 end SaldoFin_Abril ,
	case when pr.PERIODID = 5 then 	pyt.SaldoFinMayo else 0 end SaldoFin_Mayo ,
	case when pr.PERIODID = 6 then 	pyt.SaldoFinJunio else 0 end SaldoFin_Junio ,
	case when pr.PERIODID = 7 then 	pyt.SaldoFinJulio else 0 end SaldoFin_Julio ,
	case when pr.PERIODID = 8 then 	pyt.SaldoFinAgosto else 0 end SaldoFin_Agosto ,
	case when pr.PERIODID = 9 then 	pyt.SaldoFinSeptiembre else 0 end SaldoFin_Septiembre ,
	case when pr.PERIODID = 10 then 	pyt.SaldoFinOctubre else 0 end SaldoFin_Octubre ,
	case when pr.PERIODID = 11 then 	pyt.SaldoFinNoviembre else 0 end SaldoFin_Noviembre ,
	case when pr.PERIODID = 12 then 	pyt.SaldoFinDiciembre else 0 end SaldoFin_Diciembre ,
	pyt.DébitoAnual,pyt.CréditoAnual,pyt.nsaIF_SF0,pyt.nsaIF_SI0,
	pyt.puc1,pyt.puc2,pyt.puc4,pyt.puc6,pyt.puccode,
	pyt.nsa_Descripcion_puc1,pyt.nsa_Descripcion_puc2,pyt.nsa_Descripcion_puc4,pyt.nsa_Descripcion_puc6,pyt.nsa_Descripcion_puc8,
	pyt.USRDEFS1
from SY40100 pr	--sy_period_setp
outer apply (
		select *
		from dbo.f_LocandinaGLSaldosPucYTerceros (pr.PERIODID)
		) pyt
where pr.FORIGIN = 1
and pr.YEAR1 = 2009
and pr.SERIES = 0
and pr.ODESCTN = ''
and pr.PERIODID > 0
go
IF (@@Error = 0) PRINT 'Creación exitosa de: vwLocAndinaGLSaldosPucYTerceros'
ELSE PRINT 'Error en la creación de: vwLocAndinaGLSaldosPucYTerceros'
GO

grant select on dbo.vwLocAndinaGLSaldosPucYTerceros to dyngrp
go

-----------------------------------------------------------------------------------------------------------
IF (OBJECT_ID ('dbo.vwLocAndinaGLSaldosPucTercerosYTrx', 'V') IS NULL)
   exec('create view dbo.vwLocAndinaGLSaldosPucTercerosYTrx as SELECT 1 as t');
go

ALTER view dbo.vwLocAndinaGLSaldosPucTercerosYTrx as
--Propósito. Localización andina. Saldos mensuales agrupados por cuenta PUC, terceros y detalle de asientos contables
--Utilizado por. Planilla excel
--06/07/10 JCF Creación
--19/07/10 JCF Agrega saldos anteriores y finales
--07/12/10 jcf Agrega campo secuencia
--04/02/13 jcf Agrega sourcdoc
--09/04/13 jcf Agrega dirección de terceros
--
select pr.PERIODID, pr.PERNAME Mes,
	pyt.puc_y_desc1,pyt.puc_y_desc2,pyt.puc_y_desc4,pyt.puc_y_desc6,pyt.puc_y_desc,
	pyt.añoAbierto,pyt.ACTINDX,pyt.compañía,pyt.brand,pyt.cuentaContable,pyt.númeroCuenta,pyt.descripciónDeCuenta,
	pyt.registroDeImpuesto, pyt.NIT, pyt.tipoNIT,pyt.idMaestro,pyt.nombreMaestroOriginal,	
	pyt.ADDRESS1, pyt.ADDRESS2, pyt.ADDRESS3, pyt.CITY, pyt.[STATE], pyt.ZIPCODE, pyt.COUNTRY ,
	pyt.SaldoAnterior,pyt.Débitos,pyt.Créditos,pyt.SaldoFinal,	
	case when pr.PERIODID = 1 then pyt.SaldoAntEnero else 0 end SaldoAnt_Enero,
	case when pr.PERIODID = 2 then 	pyt.SaldoAntFebrero else 0 end SaldoAnt_Febrero ,
	case when pr.PERIODID = 3 then 	pyt.SaldoAntMarzo else 0 end SaldoAnt_Marzo ,
	case when pr.PERIODID = 4 then 	pyt.SaldoAntAbril else 0 end SaldoAnt_Abril ,
	case when pr.PERIODID = 5 then 	pyt.SaldoAntMayo else 0 end SaldoAnt_Mayo ,
	case when pr.PERIODID = 6 then 	pyt.SaldoAntJunio else 0 end SaldoAnt_Junio ,
	case when pr.PERIODID = 7 then 	pyt.SaldoAntJulio else 0 end SaldoAnt_Julio ,
	case when pr.PERIODID = 8 then 	pyt.SaldoAntAgosto else 0 end SaldoAnt_Agosto ,
	case when pr.PERIODID = 9 then 	pyt.SaldoAntSeptiembre else 0 end SaldoAnt_Septiembre ,
	case when pr.PERIODID = 10 then 	pyt.SaldoAntOctubre else 0 end SaldoAnt_Octubre ,
	case when pr.PERIODID = 11 then 	pyt.SaldoAntNoviembre else 0 end SaldoAnt_Noviembre ,
	case when pr.PERIODID = 12 then 	pyt.SaldoAntDiciembre else 0 end SaldoAnt_Diciembre ,
	case when pr.PERIODID = 1 then pyt.SaldoFinEnero else 0 end SaldoFin_Enero,
	case when pr.PERIODID = 2 then 	pyt.SaldoFinFebrero else 0 end SaldoFin_Febrero ,
	case when pr.PERIODID = 3 then 	pyt.SaldoFinMarzo else 0 end SaldoFin_Marzo ,
	case when pr.PERIODID = 4 then 	pyt.SaldoFinAbril else 0 end SaldoFin_Abril ,
	case when pr.PERIODID = 5 then 	pyt.SaldoFinMayo else 0 end SaldoFin_Mayo ,
	case when pr.PERIODID = 6 then 	pyt.SaldoFinJunio else 0 end SaldoFin_Junio ,
	case when pr.PERIODID = 7 then 	pyt.SaldoFinJulio else 0 end SaldoFin_Julio ,
	case when pr.PERIODID = 8 then 	pyt.SaldoFinAgosto else 0 end SaldoFin_Agosto ,
	case when pr.PERIODID = 9 then 	pyt.SaldoFinSeptiembre else 0 end SaldoFin_Septiembre ,
	case when pr.PERIODID = 10 then 	pyt.SaldoFinOctubre else 0 end SaldoFin_Octubre ,
	case when pr.PERIODID = 11 then 	pyt.SaldoFinNoviembre else 0 end SaldoFin_Noviembre ,
	case when pr.PERIODID = 12 then 	pyt.SaldoFinDiciembre else 0 end SaldoFin_Diciembre ,
	pyt.DébitoAnual,pyt.CréditoAnual,
	pyt.puc1,pyt.puc2,pyt.puc4,pyt.puc6,pyt.puccode,
	pyt.nsa_Descripcion_puc1,pyt.nsa_Descripcion_puc2,pyt.nsa_Descripcion_puc4,pyt.nsa_Descripcion_puc6,pyt.nsa_Descripcion_puc8,
	pyt.entradaDiario, 	pyt.fechaTrans, 	pyt.referencia, 	pyt.descripción, 	pyt.tipoTransOriginal,	pyt.númeroControlOriginal,	pyt.númeroDocumentoOriginal,
	pyt.montoDébito,	pyt.montoCrédito,	pyt.montoDébitoO,	pyt.montoCréditoO, 	pyt.idMoneda, isnull(pyt.secuencia, 0) secuencia, pyt.sourcdoc
from SY40100 pr	--sy_period_setp
outer apply (
		select *
		from dbo.f_LocAndinaGLSaldosPucTercerosYTrx(pr.PERIODID)
		) pyt
where pr.FORIGIN = 1
and pr.YEAR1 = 2009
and pr.SERIES = 0
and pr.ODESCTN = ''
and pr.PERIODID > 0
go

IF (@@Error = 0) PRINT 'Creación exitosa de: vwLocAndinaGLSaldosPucTercerosYTrx'
ELSE PRINT 'Error en la creación de: vwLocAndinaGLSaldosPucTercerosYTrx'
GO
-------------------------------------------------------------------------------------------------------

grant select on dbo.vwLocAndinaGLSaldosPucTercerosYTrx to dyngrp
go

-----------------------------------------------------------------------------------------------------------
--pruebas
--select entradaDiario, registroDeImpuesto, *
--from dbo.vwLocAndinaGLSaldosPucTercerosYTrx
--where --añoAbierto = 2010
----ACTINDX = 165
-- entradaDiario = 1239
-- and idMaestro = '79784072'
-- and númeroCuenta = 'F03-000-60110'
--order by idmaestro, añoabierto, periodid
                       
--select *
--from dbo.f_LocandinaGLSaldosPucYTerceros (5)
--where --añoAbierto = 2010
--puc6 like '510506%'

--select puccode, *
--from dbo.vwLocAndinaGLSaldosPucYTerceros 
--where --añoAbierto = 2010
--idmaestro = '8300971496'	--'130505'
--order by periodid

--select *
--from dbo.f_LocAndinaGLSaldosPucTercerosYTrx (5)
--where idmaestro = '8300971496'
----puc6 like '510506%'

--select *
--from dbo.f_obtieneDatosTerceros (0, 0, '8600509309')

