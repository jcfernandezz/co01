--Localizaci�n Colombia
--Prop�sito. Dar acceso al rol_colLocalizacion
--17/3/17 JCF  Creaci�n
--
IF DATABASE_PRINCIPAL_ID('rol_colLocalizacion') IS NULL
	create role rol_colLocalizacion;

GRANT select ON dbo.vwColCertificadoRetenciones to rol_colLocalizacion;

go

