--Propósito. Transacciones contables que incluye cuentas puc y nits
--24/6/10 JCF Creación

------------------------------------------------------------------------------

IF OBJECT_ID ('dbo.f_obtieneDatosTerceros') IS NOT NULL
   DROP function dbo.f_obtieneDatosTerceros
GO

create function dbo.f_obtieneDatosTerceros (@p_series smallint, @p_TERCTYPE smallint, @p_CUSTVNDR varchar(15))
returns table
as 
--Propósito. Obtiene el código de impuesto de clientes o proveedores. 
--			En la localización andina es posible registrar diferentes nit por cada cuenta de un asiento contable desde el financiero, compras o ventas.
--Requisito. @p_CUSTVNDR debe indicar el código de cliente o proveedor
--25/06/10 JCF Creación
--30/06/10 JCF Obtiene nit de tablas de localización
--09/04/13 jcf Agrega direcciones y optimiza consulta. Ya no utiliza parámetros p_series, p_terctype.
--08/10/19 jcf Agrega otros datos de localización del proveedor o cliente
--
return(
	select top 1 dt.TXRGNNUM, dt.ADDRESS1, dt.ADDRESS2, dt.ADDRESS3, dt.CITY, dt.[STATE], dt.ZIPCODE, dt.COUNTRY, 
		dt.nsaif_type_nit,
		dt.nsaIfNitSinDV,
		dt.digitoVerificador,
		dt.nsaIfnit, 
		dt.Fname,		dt.Oname, 		dt.Fsurname,		dt.Ssurname,
		dt.nsaIF_Site_Code
			--case when isnull(dt.nsaIF_Site_Code, '') = '' then
			--	left(dt.[STATE], 2) 
			--else left(dt.nsaIF_Site_Code, 2)
			--end dptoCode,
			--case when isnull(dt.nsaIF_Site_Code, '') = '' then
			--	left(dt.CITY, 5)
			--else dt.nsaIF_Site_Code 
			--end cityCode
	from (
		select isnull(np.nsaIFNit, '') TXRGNNUM, ms.ADDRESS1, ms.ADDRESS2, ms.ADDRESS3, ms.CITY, ms.[STATE], ms.ZIPCODE, ms.COUNTRY,
			rtrim(np.nsaif_type_nit) nsaif_type_nit,
			case when rtrim(np.nsaif_type_nit) = '31' then 
				reverse(substring(reverse(rtrim(replace(np.nsaIfnit, '-', ''))), 2, 50)) 
			else rtrim(np.nsaIfnit)
			end nsaIfNitSinDV,

			case when rtrim(np.nsaif_type_nit) = '31' then 
				left(reverse(rtrim(np.nsaIfnit)), 1) 
			else ''
			end digitoVerificador,

			rtrim(np.nsaIfnit) nsaIfnit, 
			rtrim(np.Fname) Fname,
			rtrim(np.Oname) Oname, 
			rtrim(np.Fsurname) Fsurname,
			rtrim(np.Ssurname) Ssurname,
			np.nsaIF_Site_Code
		from nsaIF01666	np			--nit proveedores
			right join PM00200 ms
			on ms.vendorid = np.vendorid
		where ms.VENDORID = @p_CUSTVNDR
		--and (@p_series = 4			--compras
		--	or (@p_series = 2		--financiero
		--	and @p_TERCTYPE = 2))	--proveedores
			
		union all
		
		select nc.nsaIFNit TXRGNNUM, ms.ADDRESS1, ms.ADDRESS2, ms.ADDRESS3, ms.CITY, ms.[STATE], ms.ZIP ZIPCODE, ms.COUNTRY,
			rtrim(nc.nsaif_type_nit) nsaif_type_nit,
			case when rtrim(nc.nsaif_type_nit) = '31' then 
				reverse(substring(reverse(rtrim(replace(nc.nsaIfnit, '-', ''))), 2, 50)) 
			else rtrim(nc.nsaIfnit)
			end nsaIfNitSinDV,

			case when rtrim(nc.nsaif_type_nit) = '31' then 
				left(reverse(rtrim(nc.nsaIfnit)), 1) 
			else ''
			end digitoVerificador,

			rtrim(nc.nsaIfnit) nsaIfnit, 
			rtrim(nc.Fname) Fname,
			rtrim(nc.Oname) Oname, 
			rtrim(nc.Fsurname) Fsurname,
			rtrim(nc.Ssurname) Ssurname,
			nc.nsaIF_Site_Code
		from nsaIF02666	nc			--nit clientes
			right join RM00101 ms
			on ms.custnmbr = nc.custnmbr
		where ms.CUSTNMBR = @p_CUSTVNDR
		--and (@p_series = 3			--ventas
		--	or (@p_series = 2		--financiero
		--	and @p_TERCTYPE = 1))	--clientes
		) dt
)
go
IF (@@Error = 0) PRINT 'Creación exitosa de: f_obtieneDatosTerceros'
ELSE PRINT 'Error en la creación de: f_obtieneDatosTerceros'
GO
