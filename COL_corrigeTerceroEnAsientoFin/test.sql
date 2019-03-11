select top 100 * from slbAccountTrx 
where jrnentry = 24606

select *
from gl20000
where 
--jrnentry = 24606
 ormstrid = ''
 and sourcdoc != 'BBF'
 and sourcdoc != 'P/L'


 use gcol;

select *
from vwFINAsientosTAH
where jrnentry = 27895


select top 100 *
from nsaif_gl00050
where ormstrid = 'HSBC COP 099385'
order by 1

select top 100 *
from if10001
where jrnentry = 27895

--update gl set ormstrid = fi.custvndr, ormstrnm = isnull(p.vendname, '.')
SELECT gl.* --into _tmpGl20000_cmtrx
from gl20000 gl
inner join if10001 fi
	on fi.jrnentry = gl.jrnentry
	and fi.sqncline = gl.seqnumbr
inner join gl00100 ma
	on ma.actindx = gl.actindx
left join pm00200 p
	on p.vendorid = fi.custvndr
where gl.sourcdoc = 'CMTRX'
and gl.ormstrid != fi.custvndr
and datediff(day, '10/1/15', gl.trxdate) >= 0
and fi.custvndr != ''
--order by 2


use gcol;
