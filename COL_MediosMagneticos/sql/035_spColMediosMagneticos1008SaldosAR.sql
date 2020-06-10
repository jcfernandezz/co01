IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spColMediosMagneticos1008SaldosAR' 
)
   DROP PROCEDURE dbo.spColMediosMagneticos1008SaldosAR
GO

--Prop�sito. Obtiene los datos para el layout 1008 de Medios magn�ticos
--21/08/19 jcf Creaci�n
--
CREATE PROCEDURE dbo.spColMediosMagneticos1008SaldosAR
AS
declare @fechaIni datetime, @fechaFin datetime

select @fechaIni = perioddt,
	@fechaFin = perdendt
from nsacoa_gl00001
where nsa_id_periodo = 100

EXEC dbo.spColBaseSaldosARAgrupadoXCliente @fechaFin, '', 
'���������������', 
'', 
'�����������������������������������������������������������������', 
'', 
'���������������', 
'', 
'���������������', 
'', 
'���������������', 
'', 
'���������������', 
'', 
'�����������������������������', 
'', 
'�����������', 
'', 
'���������������������', 
'', 
'���������������������', 
1,
'1900.01.01', 
@fechaFin,
0, 
1, 
1, 
1, 
1, 
0, 
1, 
0

GO

IF (@@Error = 0) PRINT 'Creaci�n exitosa de: spColMediosMagneticos1008SaldosAR'
ELSE PRINT 'Error en la creaci�n de: spColMediosMagneticos1008SaldosAR'
GO
