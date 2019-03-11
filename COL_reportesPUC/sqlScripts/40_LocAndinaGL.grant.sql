--Localizaci�n Andina
--Prop�sito. Dar acceso al usuario col_contador a las vistas de contabilidad que incluyen PUC
--7/7/2010 JCF  Creaci�n

--Creaci�n del rol y asignaci�n de privilegios
---------------------------------------------------------------------------
--use gcol;
IF DATABASE_PRINCIPAL_ID('rol_colcontador') IS NULL
	create role rol_colcontador;

GRANT select ON dbo.vwLocAndinaGLLibroDiario TO rol_colcontador; 
GRANT select ON dbo.vwLocAndinaGLSaldosPucYTerceros TO rol_colcontador; 
GRANT select ON dbo.vwLocAndinaGLSaldosPucTercerosYTrx to rol_colcontador;

go

--Creaci�n de login
---------------------------------------------------------------------------------
--create login rpexcolombia with password = 'ColombiaRpex01', default_database=GCOL
--go

--Creaci�n de usuario de bd
----------------------------------------------------------------------------
--use GCOL
--create user [GILA\ext.training.colombi] for login [GILA\ext.training.colombi];
--exec sp_addrolemember 'rol_colcontador', 'GILA\ext.training.colombi';

--create user rpexcolombia for login rpexcolombia;
--exec sp_addrolemember 'rol_colcontador', 'rpexcolombia';

go
