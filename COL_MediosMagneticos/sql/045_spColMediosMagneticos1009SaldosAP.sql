IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spColMediosMagneticos1009SaldosAP' 
)
   DROP PROCEDURE dbo.spColMediosMagneticos1009SaldosAP
GO

--Prop�sito. Obtiene los datos para el layout 1008 de Medios magn�ticos
--07/10/19 jcf Creaci�n
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
'', '���������������', 
'', '�����������������������������������������������������������������', 
'', '�����������', 
'', '���������������������', 
'', '���', 
'', '���������������������', 
0, '1900.01.01', @fechaFin, 
1, 1, 1, 1, 0, 1

--, '$', 1, 0, 0.0000000, 1, 2, 0, @param34 OUT 

GO

IF (@@Error = 0) PRINT 'Creaci�n exitosa de: spColMediosMagneticos1009SaldosAP'
ELSE PRINT 'Error en la creaci�n de: spColMediosMagneticos1009SaldosAP'
GO
