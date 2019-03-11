--Colombia
--Propósito. Objetos sql para reportes PUC de Colombia.
--Requisitos. 
--6/4/17 jcf Creación
--
SET NOCOUNT ON
GO

PRINT 'Creando objetos para localización Colombiana'
:setvar workpath C:\jcTii\Desarrollo\COL_Localizacion\E_Implementation\COL_reportesPUC\sqlScripts

:r C:\jcTii\GPRelational\glVwDetalleAsientosTodos.views.sql
:On Error exit

:r $(workpath)\07_trgCreaRegistroImpositivo.create.sql
:On Error exit
:r $(workpath)\10_vwGLCuentasPucyGP.sql
:On Error exit
:r $(workpath)\20_vwTransaccionesContablesLocColombia.sql
:On Error exit
:r $(workpath)\30_vwAndinaGLBalanceComprobacion.sql
:On Error exit
:r $(workpath)\40_LocAndinaGL.grant.sql
:On Error exit

PRINT 'Objetos creados satisfactoriamente'
GO
