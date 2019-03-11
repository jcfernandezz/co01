
--USE [company]
--GO

/****** Object:  StoredProcedure [proc_tii_mapeo_pucLoadByPrimaryKey]    Script Date: 15/04/2013 12:32:43 p.m. ******/
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[proc_tii_mapeo_pucLoadByPrimaryKey]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
    DROP PROCEDURE [proc_tii_mapeo_pucLoadByPrimaryKey];
GO

CREATE PROCEDURE [proc_tii_mapeo_pucLoadByPrimaryKey]
(
	@cuentagp varchar(50),
	@codigopuc varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[cuentagp],
		[textoingles],
		[obs],
		[textoespa],
		[obs2],
		[codigopuc],
		[textopuc],
		[nivel],
		[descNivel],
		[procesado]
	FROM [tii_mapeo_puc]
	WHERE
		([cuentagp] = @cuentagp) AND
		([codigopuc] = @codigopuc)

	SET @Err = @@Error

	RETURN @Err
END
GO


-- Display the status of Proc creation
IF (@@Error = 0) PRINT 'Procedure Creation: proc_tii_mapeo_pucLoadByPrimaryKey Succeeded'
ELSE PRINT 'Procedure Creation: proc_tii_mapeo_pucLoadByPrimaryKey Error on Creation'
GO

/****** Object:  StoredProcedure [proc_tii_mapeo_pucLoadAll]    Script Date: 15/04/2013 12:32:43 p.m. ******/
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[proc_tii_mapeo_pucLoadAll]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
    DROP PROCEDURE [proc_tii_mapeo_pucLoadAll];
GO

CREATE PROCEDURE [proc_tii_mapeo_pucLoadAll]
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[cuentagp],
		[textoingles],
		[obs],
		[textoespa],
		[obs2],
		[codigopuc],
		[textopuc],
		[nivel],
		[descNivel],
		[procesado]
	FROM [tii_mapeo_puc]

	SET @Err = @@Error

	RETURN @Err
END
GO


-- Display the status of Proc creation
IF (@@Error = 0) PRINT 'Procedure Creation: proc_tii_mapeo_pucLoadAll Succeeded'
ELSE PRINT 'Procedure Creation: proc_tii_mapeo_pucLoadAll Error on Creation'
GO

/****** Object:  StoredProcedure [proc_tii_mapeo_pucUpdate]    Script Date: 15/04/2013 12:32:43 p.m. ******/
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[proc_tii_mapeo_pucUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
    DROP PROCEDURE [proc_tii_mapeo_pucUpdate];
GO

CREATE PROCEDURE [proc_tii_mapeo_pucUpdate]
(
	@cuentagp varchar(50),
	@textoingles varchar(100) = NULL,
	@obs varchar(100) = NULL,
	@textoespa varchar(100) = NULL,
	@obs2 varchar(50) = NULL,
	@codigopuc varchar(50),
	@textopuc varchar(100) = NULL,
	@nivel int = NULL,
	@descNivel varchar(100) = NULL,
	@procesado varchar(1) = NULL
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	UPDATE [tii_mapeo_puc]
	SET
		[textoingles] = @textoingles,
		[obs] = @obs,
		[textoespa] = @textoespa,
		[obs2] = @obs2,
		[textopuc] = @textopuc,
		[nivel] = @nivel,
		[descNivel] = @descNivel,
		[procesado] = @procesado
	WHERE
		[cuentagp] = @cuentagp
	AND	[codigopuc] = @codigopuc


	SET @Err = @@Error


	RETURN @Err
END
GO


-- Display the status of Proc creation
IF (@@Error = 0) PRINT 'Procedure Creation: proc_tii_mapeo_pucUpdate Succeeded'
ELSE PRINT 'Procedure Creation: proc_tii_mapeo_pucUpdate Error on Creation'
GO




/****** Object:  StoredProcedure [proc_tii_mapeo_pucInsert]    Script Date: 15/04/2013 12:32:43 p.m. ******/
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[proc_tii_mapeo_pucInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
    DROP PROCEDURE [proc_tii_mapeo_pucInsert];
GO

CREATE PROCEDURE [proc_tii_mapeo_pucInsert]
(
	@cuentagp varchar(50),
	@textoingles varchar(100) = NULL,
	@obs varchar(100) = NULL,
	@textoespa varchar(100) = NULL,
	@obs2 varchar(50) = NULL,
	@codigopuc varchar(50),
	@textopuc varchar(100) = NULL,
	@nivel int = NULL,
	@descNivel varchar(100) = NULL,
	@procesado varchar(1) = NULL
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	INSERT
	INTO [tii_mapeo_puc]
	(
		[cuentagp],
		[textoingles],
		[obs],
		[textoespa],
		[obs2],
		[codigopuc],
		[textopuc],
		[nivel],
		[descNivel],
		[procesado]
	)
	VALUES
	(
		@cuentagp,
		@textoingles,
		@obs,
		@textoespa,
		@obs2,
		@codigopuc,
		@textopuc,
		@nivel,
		@descNivel,
		@procesado
	)

	SET @Err = @@Error


	RETURN @Err
END
GO


-- Display the status of Proc creation
IF (@@Error = 0) PRINT 'Procedure Creation: proc_tii_mapeo_pucInsert Succeeded'
ELSE PRINT 'Procedure Creation: proc_tii_mapeo_pucInsert Error on Creation'
GO

/****** Object:  StoredProcedure [proc_tii_mapeo_pucDelete]    Script Date: 15/04/2013 12:32:43 p.m. ******/
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[proc_tii_mapeo_pucDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
    DROP PROCEDURE [proc_tii_mapeo_pucDelete];
GO

CREATE PROCEDURE [proc_tii_mapeo_pucDelete]
(
	@cuentagp varchar(50),
	@codigopuc varchar(50)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DELETE
	FROM [tii_mapeo_puc]
	WHERE
		[cuentagp] = @cuentagp AND
		[codigopuc] = @codigopuc
	SET @Err = @@Error

	RETURN @Err
END
GO


-- Display the status of Proc creation
IF (@@Error = 0) PRINT 'Procedure Creation: proc_tii_mapeo_pucDelete Succeeded'
ELSE PRINT 'Procedure Creation: proc_tii_mapeo_pucDelete Error on Creation'
GO
