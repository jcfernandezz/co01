IF (OBJECT_ID ('dbo.vwColMediosMagneticos1001PagosEnCuentaYRetenciones', 'V') IS NULL)
   exec('create view dbo.vwColMediosMagneticos1001PagosEnCuentaYRetenciones as SELECT 1 as t');
go

--19/08/19 jcf Creaci�n
go
ALTER VIEW dbo.vwColMediosMagneticos1001PagosEnCuentaYRetenciones as

SELECT year(trx.DOCDATE) [A�o], month(trx.DOCDATE) Mes, 
	nsaif_type_nit, nsaIfnit, digitoVerificador,
		Fname, Oname, Fsurname, Ssurname, trx.vendname,
		trx.VCHRNMBR, trx.DOCDATE, 
		trx.address1, 

		trx.cityCode, 
		trx.dptoCode, 
		trx.CITY, 
		trx.[STATE], 
		
		trx.country, trx.ccode,
		trx.PRCHAMNT,
		trx.XCHGRATE, 
		trx.pstgdate, trx.DOCTYPE, trx.docnumbr, 		
		trx.trxsorce, trx.VOIDED, trx.VENDORID, trx.pordnmbr, trx.bchsourc,

		trx.impuAddress1, trx.impuAddress2,
		trx.TAXDTLID, trx.taxamnt, trx.tdttxpur

		--iva_tdttxpur,
		--iva_taxamnt,
		--rete_tdttxpur,
		--rete_taxamnt
from dbo.[vwColMediosMagneticosFacturasCompra] trx
where trx.voided = 0

go

IF (@@Error = 0) PRINT 'Creaci�n exitosa de: vwColMediosMagneticos1001PagosEnCuentaYRetenciones'
ELSE PRINT 'Error en la creaci�n de: vwColMediosMagneticos1001PagosEnCuentaYRetenciones'
GO

------------------------------------------------------------------------------------------------

--SELECT [A�o], Mes, 
--	nsaif_type_nit [Tipo Documento], nsaIfnit [N�mero Identificaci�n], digitoVerificador [D�gito Verificador],
--		Fname [Primer nombre] , Oname [Otros nombres], Fsurname [Primer apellido], Ssurname [Segundo apellido], trx.vendname [Raz�n social],
--		trx.VCHRNMBR, trx.DOCDATE, 
--		trx.address1 [Direcci�n], 
--		trx.cityCode Municipio, 
--		trx.stateCode Departamento, 
--		trx.country [Pa�s], trx.ccode,
--		trx.PRCHAMNT [Pago Deducible],
--		iva_tdttxpur,
--		iva_taxamnt [Iva deducible],
--		rete_tdttxpur,
--		rete_taxamnt [Retenci�n Practicada]
--from dbo.vwColMediosMagneticos1001PagosEnCuentaYRetenciones trx


