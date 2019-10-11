if exists (select * from dbo.sysobjects where id = 
    Object_id('dbo.spLocColCargaTerceroDesdeAsiento') and type = 'P')
begin
    drop proc dbo.spLocColCargaTerceroDesdeAsiento
end
go

create procedure [dbo].spLocColCargaTerceroDesdeAsiento
		@p_bachnumb as varchar(15),
		@p_bchsourc as varchar(15),
		@p_sourcdoc as varchar(11)
		as
--Propósito. Busca el último asiento que fue creado en un lote y origen específico y carga sus terceros
--Precondición. Los ids de tercero deben estar en la referencia de distribucíón.
--27/08/19 JCF Creación

declare @l_jrnentry int

insert into IF10001 (JRNENTRY,SQNCLINE,CUSTVNDR,TERCTYPE,POSTED,TRXDATE,DEBITAMT,CRDTAMNT,ACTINDX,YEAR1)
select a.jrnentry, c.sqncline, rtrim(c.dscriptn), 2, 0, a.trxdate, c.debitamt, c.crdtamnt, c.actindx, year(a.trxdate)
	from gl10000 a		--[bachnumb, bchsourc, jrnentry]
	inner join gl10001 c
		on c.jrnentry = a.jrnentry
	where a.bachnumb = @p_bachnumb
	and a.bchsourc = @p_bchsourc
	and a.sourcdoc = @p_sourcdoc
	and rtrim(c.dscriptn) != ''
go

------------------------------------------------------------------------------------------------------------------------
grant execute on dbo.spLocColCargaTerceroDesdeAsiento to DYNGRP 
go
------------------------------------------------------------------------------------------------------------------------
--exec [dbo].spLocColCargaTerceroDesdeAsiento 'TEST1', 'GL_Normal', 'CIDE', 'COST CENTER', 'PROJECT', 'INTERCOMPANY', 'ARTST'

