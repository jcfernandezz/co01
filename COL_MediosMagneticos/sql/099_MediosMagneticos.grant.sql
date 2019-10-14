--Localización Andina
--Propósito. Dar acceso al usuario col_contador a las vistas de medios magnéticos
--14/10/19 JCF  Creación

--Creación del rol y asignación de privilegios
---------------------------------------------------------------------------
--use gcol;
IF DATABASE_PRINCIPAL_ID('rol_colcontador') IS NULL
	create role rol_colcontador;

GRANT select ON dbo.vwColMediosMagneticos1001PagosEnCuentaYRetenciones TO rol_colcontador; 
grant exec on dbo.spColMediosMagneticos1008SaldosAR to rol_colcontador;
grant exec on dbo.spColMediosMagneticos1009SaldosAP to rol_colcontador;

go


