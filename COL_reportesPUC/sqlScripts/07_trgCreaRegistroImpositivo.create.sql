--GETTY LOCALIZACION ANDINA (Colombia)
--Creación de registro impositivo para clientes y proveedores
--------------------------------------------------------------------------------------------------
--CLIENTES


IF EXISTS (SELECT * 
           FROM   sys.triggers 
           WHERE  object_id = OBJECT_ID(N'trgRM00101_ins01')) 
	DROP TRIGGER trgRM00101_ins01;
GO 
create TRIGGER trgRM00101_ins01 ON RM00101 AFTER INSERT AS  
BEGIN 
--Propósito. Crea el registro NIT en tablas de localización andina
--13/7/11 jcf Creación. Elimina todos los nit del cliente antes de insertar el nuevo.
--4/6/13 jcf Corrige eliminación de nit

		declare @CUSTNMBR char(15), @TXRGNNUM char(25)
		select @CUSTNMBR = CUSTNMBR, @TXRGNNUM = TXRGNNUM from inserted

		if (rtrim(@TXRGNNUM) <> '')
		begin
			delete from nsaIF02666 --nit clientes
			where custnmbr = @CUSTNMBR

		 INSERT INTO nsaIF02666 (CUSTNMBR, nsaIF_Type_Nit, nsaIFNit ) --nit clientes
						values  (@CUSTNMBR, '31', left(rtrim(@TXRGNNUM), 15))
						
		end
	
END 
GO 
---------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * 
           FROM   sys.triggers 
           WHERE  object_id = OBJECT_ID(N'trgRM00101_upd01')) 
	DROP TRIGGER trgRM00101_upd01
GO 
create TRIGGER trgRM00101_upd01 ON RM00101 AFTER UPDATE AS  
BEGIN 
--Propósito. Crea el registro NIT en tablas de localización andina
--13/7/11 jcf Creación. Elimina todos los nit del cliente antes de insertar el nuevo.
--4/6/13 jcf Corrige eliminación de nit

	IF UPDATE(TXRGNNUM)
	begin
		declare @CUSTNMBR char(15), @TXRGNNUM char(25) --, @TXRGNNUM_OLD char(25)
		select @CUSTNMBR = CUSTNMBR, @TXRGNNUM = TXRGNNUM from inserted
	
		if (rtrim(@TXRGNNUM) <> '')
		begin
			delete from nsaIF02666 --nit clientes
			where custnmbr = @CUSTNMBR
		
		 INSERT INTO nsaIF02666 (CUSTNMBR, nsaIF_Type_Nit, nsaIFNit ) --nit clientes
						values  (@CUSTNMBR, '31', left(rtrim(@TXRGNNUM), 15))

		end
	end
END
GO
---------------------------------------------------------------------------------------------------
--PROVEEDORES
IF EXISTS (SELECT * 
           FROM   sys.triggers 
           WHERE  object_id = OBJECT_ID(N'trgPM00200_ins01')) 
		   DROP TRIGGER trgPM00200_ins01
GO 
create TRIGGER trgPM00200_ins01 ON PM00200 AFTER INSERT AS  
BEGIN 
--Propósito. Crea el registro NIT en tablas de localización andina
--13/7/11 jcf Creación. Elimina todos los nit del proveedor antes de insertar el nuevo.
--4/6/13 jcf Corrige eliminación de nit

		declare @VENDORID char(15), @TXRGNNUM char(25)
		select @VENDORID = VENDORID, @TXRGNNUM = TXRGNNUM from inserted

		if (rtrim(@TXRGNNUM) <> '')
		begin
			delete from nsaIF01666 --nit proveedores
			where vendorid = @VENDORID
		
		 INSERT INTO nsaIF01666 (VENDORID, nsaIF_Type_Nit, nsaIFNit ) --nit proveedores	
						values  (@VENDORID, '31', left(rtrim(@TXRGNNUM), 15))
		end
	
END 
GO 
---------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * 
           FROM   sys.triggers 
           WHERE  object_id = OBJECT_ID(N'trgPM00200_upd01')) 
		   DROP TRIGGER trgPM00200_upd01
GO 
create TRIGGER trgPM00200_upd01 ON PM00200 AFTER UPDATE AS  
BEGIN 
--Propósito. Crea el registro NIT en tablas de localización andina
--13/7/11 jcf Creación. Elimina todos los nit del proveedor antes de insertar el nuevo.
--4/6/13 jcf Corrige eliminación de nit

	IF UPDATE(TXRGNNUM)
	begin
		declare @VENDORID char(15), @TXRGNNUM char(25)
		select @VENDORID = VENDORID, @TXRGNNUM = TXRGNNUM from inserted

		if (rtrim(@TXRGNNUM) <> '')
		begin
			delete from nsaIF01666 --nit proveedores
			where vendorid = @VENDORID
		
		 INSERT INTO nsaIF01666 (VENDORID, nsaIF_Type_Nit, nsaIFNit ) --nit proveedores	
						values  (@VENDORID, '31', left(rtrim(@TXRGNNUM), 15))
		end
	end
END
GO

IF (@@Error = 0) PRINT 'Creación exitosa de: triggers'
ELSE PRINT 'Error en la creación de: triggers'
GO
-------------------------------------------------------------------------------------------------------
--Es posible que se requiera también insertar datos en la tabla nsaIF00666 nit de tercero
		 --insert into nsaIF00666 (nsaIFNit, nsaIF_CV, nsaIF_Type_Nit) --nit de tercero
			--			values  (left(rtrim(@TXRGNNUM), 15), 0, '31')


--Ajuste de datos luego de activar los triggers arriba definidos.
						