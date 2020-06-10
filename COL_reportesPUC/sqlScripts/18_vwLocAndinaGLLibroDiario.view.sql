--Propósito. Transacciones contables que incluye cuentas puc y nits
--24/6/10 JCF Creación

---------------------------------------------------------------------------------------------------------------
--Propósito. Transacciones contables que incluye cuentas puc y nit de localización andina
--24/06/10 JCF Creación
--21/07/10 jcf Agrega puc_y_desc
--24/11/10 jcf Agrega asientos históricos
--07/12/10 jcf Agrega campo rctrxseq
--09/4/13 jcf Agrega direcciones y optimiza consulta. Ya no utiliza parámetros p_series, p_terctype.
--
IF (OBJECT_ID ('dbo.vwLocAndinaGLLibroDiario', 'V') IS NULL)
   exec('create view dbo.vwLocAndinaGLLibroDiario as SELECT 1 as t');
go
alter view dbo.vwLocAndinaGLLibroDiario as
SELECT ta.origen,ta.jrnentry, ta.rctrxseq, ta.refrence,ta.trxdate,ta.OPENYEAR, ta.mes, ta.bachnumb,ta.dscriptn,
	ta.curncyid,ta.debitamt,ta.crdtamnt,ta.ORDBTAMT,ta.ORCRDAMT,ta.xchgrate,ta.exchdate,
	ta.sqncline,ta.ACTNUMST,ta.actdescr,ta.actindx,ta.ACCTTYPE,
    ta.ACTNUMBR_1, ta.ACTNUMBR_2, ta.ACTNUMBR_3, ta.USRDEFS1,
	ta.ORGNATYP,ta.ORTRXTYP,ta.ORCTRNUM,ta.ORDOCNUM,ta.ORMSTRID,ta.ORMSTRNM,ta.ORTRXSRC,
	ta.SOURCDOC,ta.trxsorce,ta.series,
	isnull(dt.TXRGNNUM, ta.ORMSTRID) registroImpuesto,			--si no existe nit registrado en tablas de localización, muestra el id de maestro
	isnull(dt.TXRGNNUM, '') TXRGNNUM,
	dt.ADDRESS1, dt.ADDRESS2, dt.ADDRESS3, dt.CITY, dt.[STATE], dt.ZIPCODE, dt.COUNTRY, 
	isnull(ep.nsa_Codigo, '') nsa_Codigo, isnull(ep.nsa_Descripcion_Codigo, '') nsa_Descripcion_Codigo, 
	rtrim(isnull(ep.nsa_Codigo, '')) +' '+ rtrim(isnull(ep.nsa_Descripcion_Codigo, '')) puc_y_desc,
	isnull(ep.nsa_Nivel_Cuenta, '') nsa_Nivel_Cuenta, isnull(ep.nsa_Descripcion_Nivel, 'nsa_Descripcion_Nivel') nsa_Descripcion_Nivel,
	ta.fecha
FROM dbo.vwFINAsientosTAH ta		--trx gp en trabajo, abiertas e histórico
left join nsaPUC_GL00100	rp		--Loc And. relación entre PUC y plan de cuentas gp
	on rp.ACTINDX = ta.ACTINDX 
left join nsaPUC_GL10000 ep			--Loc And. estructura PUC
	on ep.nsa_Codigo = rp.PUCCODE
left join IF10001 tr				--Loc And. IF_GL_TRX_WORK_LINE Información fiscal terceros
	on tr.JRNENTRY = ta.jrnentry
	and tr.SQNCLINE = ta.sqncline
outer apply dbo.f_obtieneDatosTerceros (ta.series, isnull(tr.TERCTYPE, 0), ISNULL(tr.CUSTVNDR, ta.ORMSTRID)) dt

go
---------------------------------------------------------------------------------------------------------------

grant select on dbo.vwLocAndinaGLLibroDiario to dyngrp
go

IF (@@Error = 0) PRINT 'Creación exitosa de: vwLocAndinaGLLibroDiario'
ELSE PRINT 'Error en la creación de: vwLocAndinaGLLibroDiario'
GO

------------------------------------------------------------------------------
--PRUEBAS
--select TXRGNNUM, count(*)
--from vwLocAndinaGLLibroDiario
--group by TXRGNNUM
--order by 1

--select *
--from dbo.vwLocAndinaGLLibroDiario
--where origen = 'Abrir'
--and OPENYEAR = 2010
--AND nsa_Codigo = '41559511'

--select puccode, *
--from dbo.vwLocAndinaGLSaldosPucYTerceros 
--where añoAbierto = 2010
--and puccode = '41559511'
----and mes = 'Enero'
