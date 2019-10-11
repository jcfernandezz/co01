IF OBJECT_ID ('dbo.fnLocColombiaDatosCliente') IS NOT NULL
   DROP FUNCTION dbo.fnLocColombiaDatosCliente 
GO

create FUNCTION dbo.fnLocColombiaDatosCliente (@CUSTNMBR char(15), @CITY char(35), @STATE char(29)) 
RETURNS table as
--Prop�sito. Obtiene datos del cliente espec�ficos de localizaci�n
--Requisito. -
--07/10/19 Creaci�n. JCF
--
return
(
	select rtrim(ns.nsaif_type_nit) nsaif_type_nit,
        rtrim(ns.nsaIFNit) nsaIFNit,
		reverse(substring(reverse(rtrim(replace(ns.nsaIfnit, '-', ''))), 2, 50)) nsaIfNitSinDV,
		left(reverse(rtrim(ns.nsaIfnit)), 1) digitoVerificador,
		rtrim(ns.Fname) Fname,
		rtrim(ns.Oname) Oname, 
		rtrim(ns.Fsurname) Fsurname,
		rtrim(ns.Ssurname) Ssurname,
		rtrim(ns.Fname) +' '+ rtrim(ns.Oname) +' '+ rtrim(ns.Fsurname) +' '+ rtrim(ns.Ssurname) Rsocial,
		ns.nsaIF_Site_Code,
		case when isnull(ns.nsaIF_Site_Code, '') = '' then
			left(@STATE, 2) 
		else left(ns.nsaIF_Site_Code, 2)
		end dptoCode,
		case when isnull(ns.nsaIF_Site_Code, '') = '' then
			left(@CITY, 5)
		else ns.nsaIF_Site_Code 
		end cityCode
	from  NSAIF02666 ns		--nsaif_customer_nit_mstr [CUSTNMBR nsaIF_Type_Nit nsaIFNit]
	where ns.CUSTNMBR = @CUSTNMBR
)

go
IF (@@Error = 0) PRINT 'Creaci�n exitosa de la funci�n: fnLocColombiaDatosCliente()'
ELSE PRINT 'Error en la creaci�n de la funci�n: fnLocColombiaDatosCliente()'
GO
