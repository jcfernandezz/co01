--Inserta asientos faltantes de cuentas por pagar en if10001
insert into if10001 (
JRNENTRY,
SQNCLINE,
CUSTVNDR,
TERCTYPE,
POSTED,
TRXDATE,
DEBITAMT,
CRDTAMNT,
ACTINDX,
YEAR1
)
select gl.jrnentry, gl.seqnumbr, vi.vendorid, 2 terctype, 1 posted, gl.TRXDATE, gl.DEBITAMT, gl.crdtamnt, gl.ACTINDX, gl.HSTYEAR    
--, gl.sourcdoc, vi.vendname vendnameCorrecto,  gl.ormstrid ormstridIncorrecto, gl.ORMSTRNM ormstrnmIncorrecto  
--into _LocColAsientosConVendorIncorrectoPMCHK_200610
--update gl set ormstrid = 
from GL30000 gl
	cross apply (
		select *
		from dbo.vwPmTransaccionesYAsientosContablesConVendorIncorrecto inc
		where inc.jrnentry != '0'
		and inc.jrnentry = cast( gl.jrnentry as varchar(10))
		) vi
    left join dbo.if10001 co
        on co.jrnentry = gl.jrnentry
        and co.sqncline = gl.seqnumbr
where gl.sourcdoc in ( 'PMCHK', 'PMPAY', 'PMTRX')
and co.JRNENTRY is NULL

--AND gl.jrnentry = 1108    --45

----------------------------------------------------------------------------------------------------------------------

--Actualiza terceros en tabla histórica gl en caso de transacciones PMPAY, PMTRX
update gl set ormstrid = fi.custvndr, ormstrnm = case when fi.terctype = 1 then isnull(rm.custname, '.') else isnull(p.vendname, '.') end
--SELECT gl.*, fi.custvndr, case when fi.terctype = 1 then rm.custname else isnull(p.vendname, '.') end --into _tmpGl20000_cmtrx
from gl30000 gl
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
where gl.sourcdoc in ( 'PMCHK', 'PMPAY', 'PMTRX')
and gl.ormstrid != fi.custvndr
and datediff(day, '1/1/17', gl.trxdate) >= 0
and fi.custvndr != '';


--------------------------------------------------------------------------------------------------------------------
