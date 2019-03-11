--Propósito. Objetos sql para Colombia PUC
--Requisitos. 
--11/03/19 jcf Creación
--
--use [compañía]

PRINT 'Creando objetos para Colombia PUC...'
:setvar workpath C:\jcTii\Desarrollo\COL_Localizacion\co01\COL_puc\LAndinasql

--Objetos base 
--

--Objetos Libros sunat
:r $(workpath)\01_tii_mapeo_PUC.table.view.sql
:On Error exit
:r $(workpath)\08_ActivaMapeo.sprocedure.sql
:On Error exit
:r $(workpath)\12_nsaPUC_GL10000.sql
:On Error exit
:r $(workpath)\13_tii_mapeo_puc.spDoodads.sql
:On Error exit
:r $(workpath)\90_daPermisosARol_LAndinaMapeo.grant.sql
:On Error exit

PRINT 'Objetos creados satisfactoriamente.'
GO
-------------------------------------------------------------------------------------------


