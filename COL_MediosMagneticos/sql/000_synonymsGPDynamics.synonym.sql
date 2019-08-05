	declare @SYSDBNAME CHAR(80)
	if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SY00100]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	 select top 1 @SYSDBNAME = DBNAME from SY00100
	else
	 set @SYSDBNAME = 'DYNAMICS'

	if OBJECT_ID('dbo.synonymGPCompanyMaster') is not null
		DROP SYNONYM dbo.synonymGPCompanyMaster;
		
	EXEC ('create synonym dbo.synonymGPCompanyMaster for ' +  @SYSDBNAME+'..SY01500;');

	IF (@@Error = 0) PRINT 'Creación exitosa del synonym: synonymGPCompanyMaster'
	ELSE PRINT 'Error en la creación del synonym: synonymGPCompanyMaster'


