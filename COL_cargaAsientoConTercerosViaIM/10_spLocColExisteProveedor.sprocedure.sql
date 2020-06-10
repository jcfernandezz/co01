if exists (select * from dbo.sysobjects where id = 
    Object_id('dbo.spLocColExisteProveedor') and type = 'P')
begin
    drop proc dbo.spLocColExisteProveedor
end
go
--Propósito. Valida la existencia de un tercero de localización andina
--26/08/19 JCF Creación
--
create procedure dbo.spLocColExisteProveedor
	@IdTercero as char(15),
	@Tipo as char(1),
	@p_fila int
as

BEGIN TRY
declare
	@l_ERROR AS nvarchar(500),
	@l_vendorid as varchar(15), @l_vendname as varchar(65)

select @l_ERROR = '', @l_vendorid = 'No existe'

--Verifica la existencia del tercero
SELECT	@l_vendorid = vendorid, @l_vendname = vendname
FROM	pm00200
WHERE	vendorid = @IdTercero

IF isnull(@l_vendorid, 'No existe') = 'No existe'
BEGIN
	SET @l_ERROR = '[Fila:'+convert(varchar(6), @p_fila) + '] El tercero ' + LTRIM(RTRIM(@IdTercero)) + ' no existe. Puede crearlo en Tarjetas / Compras / Proveedor.'
	raiserror(@l_ERROR, 16, 1)
END


END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState );

END CATCH

go

grant execute on dbo.spLocColExisteProveedor to DYNGRP 
go

