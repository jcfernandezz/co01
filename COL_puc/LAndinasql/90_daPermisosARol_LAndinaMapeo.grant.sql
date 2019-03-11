--Localización Andina
--Propósito. Dar acceso al rol_colcontador a las vistas de contabilidad que incluyen PUC
--11/03/19 JCF  Creación

--Creación del rol y asignación de privilegios
---------------------------------------------------------------------------
IF DATABASE_PRINCIPAL_ID('rol_colcontador') IS NULL
	create role rol_colcontador;
grant select on gl00105 to rol_colcontador;
grant select on gl00100 to rol_colcontador;
grant select, update, delete on nsaPUC_GL10000 to rol_colcontador;
grant select, update, delete on tii_mapeo_puc to rol_colcontador;
grant execute on proc_nsaPUC_GL10000LoadByPrimaryKey to rol_colcontador;
grant execute on proc_nsaPUC_GL10000LoadAll to rol_colcontador;
grant execute on proc_nsaPUC_GL10000Update to rol_colcontador;
grant execute on proc_nsaPUC_GL10000Insert to rol_colcontador;
grant execute on proc_nsaPUC_GL10000Delete to rol_colcontador;
grant execute on [proc_tii_mapeo_pucLoadByPrimaryKey] to rol_colcontador;
grant execute on [proc_tii_mapeo_pucLoadAll] to rol_colcontador;
grant execute on [proc_tii_mapeo_pucUpdate] to rol_colcontador;
grant execute on [proc_tii_mapeo_pucInsert] to rol_colcontador;
grant execute on [proc_tii_mapeo_pucDelete] to rol_colcontador;
grant execute on [sp_LAndinaActivaMapeo] to rol_colcontador;

go

