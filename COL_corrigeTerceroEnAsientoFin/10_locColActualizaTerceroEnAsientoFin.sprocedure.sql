-------------------------------------------------------------------------------------------------------------------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[locColActualizaTerceroEnAsientoFin]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[locColActualizaTerceroEnAsientoFin]
GO

ALTER PROCEDURE [DBO].[locColActualizaTerceroEnAsientoFin]
AS
--Propósito. Actualiza el tercero en asiento ingresado por el financiero en localización Andina
--Utilizado por. Job
--19/01/16 PE Creación
--23/02/17 jcf Agrega caso de transacciones bancarias
--18/04/17 jcf Agrega transferencias bancarias
--03/05/17 jcf Corrige actualización de asientos tipo DG
--11/07/17 jcf Corrige actualización de nombre de tercero en caso de clientes
--10/06/20 jcf Cambia DG por GJ para OEF. Agrega pagos PMPAY, PMCHK y transacciones PMTRX
--

--Actualiza terceros en caso de asiento DG
update gl set ormstrid = fi.custvndr, ormstrnm = case when fi.terctype = 1 then isnull(r.custname, '.') else isnull(p.vendname, '.') end
--select fi.*, r.custname, gl.ormstrid, gl.ormstrnm
from gl20000 gl
inner join if10001 fi
	on fi.jrnentry = gl.jrnentry
	and fi.sqncline = gl.seqnumbr
	and fi.actindx = gl.actindx
inner join gl00100 ma
	on ma.actindx = gl.actindx
left join pm00200 p
	on p.vendorid = fi.custvndr
	and fi.TERCTYPE = 2	--vendor
left join rm00101 r
	on r.custnmbr = fi.custvndr
	and fi.TERCTYPE = 1	--customer
where gl.sourcdoc = 'GJ'
and datediff(day, '1/1/17', gl.trxdate) >= 0
and fi.custvndr != ''
and gl.ormstrid != fi.custvndr
;

--Actualiza terceros en caso de transacciones bancarias, pago y cuentas por pagar a proveedores
update gl set ormstrid = fi.custvndr, ormstrnm = case when fi.terctype = 1 then isnull(rm.custname, '.') else isnull(p.vendname, '.') end
--SELECT gl.*, case when fi.terctype = 1 then rm.custname else isnull(p.vendname, '.') end --into _tmpGl20000_cmtrx
from gl20000 gl
inner join if10001 fi
	on fi.jrnentry = gl.jrnentry
	and fi.sqncline = gl.seqnumbr
inner join gl00100 ma
	on ma.actindx = gl.actindx
left join pm00200 p
	on p.vendorid = fi.custvndr
	and fi.terctype = 2
LEFT JOIN rm00101 rm
	on rm.custnmbr = fi.custvndr
	and fi.terctype = 1
where gl.sourcdoc in ( 'CMTRX', 'CMXFR', 'PMPAY', 'PMTRX', 'PMCHK')
and gl.ormstrid != fi.custvndr
and datediff(day, '1/1/17', gl.trxdate) >= 0
and fi.custvndr != '';
GO

-----------------------------------------------------------------------------
GRANT EXECUTE ON [DBO].[locColActualizaTerceroEnAsientoFin] TO DYNGRP
GO
----------------------------------------------------------------------------
--exec dbo.locColActualizaTerceroEnAsientoFin
--use col10;
