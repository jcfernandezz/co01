IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spColMediosMagneticos1009SaldosAP' 
)
   DROP PROCEDURE dbo.spColMediosMagneticos1009SaldosAP
GO

--Propѓsito. Obtiene los datos para el layout 1008 de Medios magnщticos
--07/10/19 jcf Creaciѓn
--
CREATE PROCEDURE dbo.spColMediosMagneticos1009SaldosAP
AS
declare @fechaIni datetime, @fechaFin datetime

select @fechaIni = perioddt,
	@fechaFin = perdendt
from nsacoa_gl00001
where nsa_id_periodo = 100

EXEC dbo.spColBaseSaldosAPAgrupadoXProveedor
@fechaFin, 
'', 'ооооооооооооооо', 
'', 'ооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооооо', 
'', 'ооооооооооо', 
'', 'ооооооооооооооооооооо', 
'', 'ооо', 
'', 'ооооооооооооооооооооо', 
0, '1900.01.01', @fechaFin, 
1, 1, 1, 1, 0, 1

--, '$', 1, 0, 0.0000000, 1, 2, 0, @param34 OUT 

GO

IF (@@Error = 0) PRINT 'Creaciѓn exitosa de: spColMediosMagneticos1009SaldosAP'
ELSE PRINT 'Error en la creaciѓn de: spColMediosMagneticos1009SaldosAP'
GO
