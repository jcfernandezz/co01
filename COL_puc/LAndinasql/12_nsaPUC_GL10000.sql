
--USE [company]
--GO

/****** Object:  StoredProcedure [proc_nsaPUC_GL10000LoadByPrimaryKey]    Script Date: 15/04/2013 12:27:26 p.m. ******/
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[proc_nsaPUC_GL10000LoadByPrimaryKey]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
    DROP PROCEDURE [proc_nsaPUC_GL10000LoadByPrimaryKey];
GO

CREATE PROCEDURE [proc_nsaPUC_GL10000LoadByPrimaryKey]
(
	@nsa_Codigo char(101)
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[nsa_Nivel_Cuenta],
		[nsa_Descripcion_Nivel],
		[nsa_Codigo],
		[nsa_Descripcion_Codigo],
		[DEX_ROW_ID]
	FROM [nsaPUC_GL10000]
	WHERE
		([nsa_Codigo] = @nsa_Codigo)

	SET @Err = @@Error

	RETURN @Err
END
GO


-- Display the status of Proc creation
IF (@@Error = 0) PRINT 'Procedure Creation: proc_nsaPUC_GL10000LoadByPrimaryKey Succeeded'
ELSE PRINT 'Procedure Creation: proc_nsaPUC_GL10000LoadByPrimaryKey Error on Creation'
GO

/****** Object:  StoredProcedure [proc_nsaPUC_GL10000LoadAll]    Script Date: 15/04/2013 12:27:26 p.m. ******/
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[proc_nsaPUC_GL10000LoadAll]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
    DROP PROCEDURE [proc_nsaPUC_GL10000LoadAll];
GO

CREATE PROCEDURE [proc_nsaPUC_GL10000LoadAll]
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[nsa_Nivel_Cuenta],
		[nsa_Descripcion_Nivel],
		[nsa_Codigo],
		[nsa_Descripcion_Codigo],
		[DEX_ROW_ID]
	FROM [nsaPUC_GL10000]

	SET @Err = @@Error

	RETURN @Err
END
GO


-- Display the status of Proc creation
IF (@@Error = 0) PRINT 'Procedure Creation: proc_nsaPUC_GL10000LoadAll Succeeded'
ELSE PRINT 'Procedure Creation: proc_nsaPUC_GL10000LoadAll Error on Creation'
GO

/****** Object:  StoredProcedure [proc_nsaPUC_GL10000Update]    Script Date: 15/04/2013 12:27:26 p.m. ******/
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[proc_nsaPUC_GL10000Update]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
    DROP PROCEDURE [proc_nsaPUC_GL10000Update];
GO

CREATE PROCEDURE [proc_nsaPUC_GL10000Update]
(
	@nsa_Nivel_Cuenta char(11),
	@nsa_Descripcion_Nivel char(101),
	@nsa_Codigo char(101),
	@nsa_Descripcion_Codigo char(101),
	@DEX_ROW_ID int
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	UPDATE [nsaPUC_GL10000]
	SET
		[nsa_Nivel_Cuenta] = @nsa_Nivel_Cuenta,
		[nsa_Descripcion_Nivel] = @nsa_Descripcion_Nivel,
		[nsa_Descripcion_Codigo] = @nsa_Descripcion_Codigo
	WHERE
		[nsa_Codigo] = @nsa_Codigo


	SET @Err = @@Error


	RETURN @Err
END
GO


-- Display the status of Proc creation
IF (@@Error = 0) PRINT 'Procedure Creation: proc_nsaPUC_GL10000Update Succeeded'
ELSE PRINT 'Procedure Creation: proc_nsaPUC_GL10000Update Error on Creation'
GO




/****** Object:  StoredProcedure [proc_nsaPUC_GL10000Insert]    Script Date: 15/04/2013 12:27:26 p.m. ******/
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[proc_nsaPUC_GL10000Insert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
    DROP PROCEDURE [proc_nsaPUC_GL10000Insert];
GO

CREATE PROCEDURE [proc_nsaPUC_GL10000Insert]
(
	@nsa_Nivel_Cuenta char(11),
	@nsa_Descripcion_Nivel char(101),
	@nsa_Codigo char(101),
	@nsa_Descripcion_Codigo char(101),
	@DEX_ROW_ID int = NULL output
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	INSERT
	INTO [nsaPUC_GL10000]
	(
		[nsa_Nivel_Cuenta],
		[nsa_Descripcion_Nivel],
		[nsa_Codigo],
		[nsa_Descripcion_Codigo]
	)
	VALUES
	(
		@nsa_Nivel_Cuenta,
		@nsa_Descripcion_Nivel,
		@nsa_Codigo,
		@nsa_Descripcion_Codigo
	)

	SET @Err = @@Error

	SELECT @DEX_ROW_ID = SCOPE_IDENTITY()

	RETURN @Err
END
GO


-- Display the status of Proc creation
IF (@@Error = 0) PRINT 'Procedure Creation: proc_nsaPUC_GL10000Insert Succeeded'
ELSE PRINT 'Procedure Creation: proc_nsaPUC_GL10000Insert Error on Creation'
GO

/****** Object:  StoredProcedure [proc_nsaPUC_GL10000Delete]    Script Date: 15/04/2013 12:27:26 p.m. ******/
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[proc_nsaPUC_GL10000Delete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
    DROP PROCEDURE [proc_nsaPUC_GL10000Delete];
GO

CREATE PROCEDURE [proc_nsaPUC_GL10000Delete]
(
	@nsa_Codigo char(101)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DELETE
	FROM [nsaPUC_GL10000]
	WHERE
		[nsa_Codigo] = @nsa_Codigo
	SET @Err = @@Error

	RETURN @Err
END
GO


-- Display the status of Proc creation
IF (@@Error = 0) PRINT 'Procedure Creation: proc_nsaPUC_GL10000Delete Succeeded'
ELSE PRINT 'Procedure Creation: proc_nsaPUC_GL10000Delete Error on Creation'
GO
