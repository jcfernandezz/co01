IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spColBaseSaldosAPAgrupadoXProveedor' 
)
   DROP PROCEDURE dbo.spColBaseSaldosAPAgrupadoXProveedor
GO

--Propósito. Obtiene saldos AR
--07/10/19 jcf Creación
--
CREATE PROCEDURE dbo.spColBaseSaldosAPAgrupadoXProveedor
 @I_dAgingDate datetime     = NULL,   @I_cStartVendorID char(15)    = NULL,   @I_cEndVendorID char(15)    = NULL,   @I_cStartVendorName char(65)   = NULL,   @I_cEndVendorName char(65)    = NULL,   @I_cStartClassID char(15)    = NULL,   
 @I_cEndClassID char(15)    = NULL,   @I_cStartUserDefined char(15)   = NULL,   @I_cEndUserDefined char(15)   = NULL,   @I_cStartPaymentPriority char(3)  = NULL,   @I_cEndPaymentPriority char(3)   = NULL,   @I_cStartDocumentNumber char(21)  = NULL,   
 @I_cEndDocumentNumber char(21)   = NULL,   
 @I_tUsingDocumentDate tinyint   = NULL,   @I_dStartDate datetime     = NULL,   @I_dEndDate datetime     = NULL,   
 @I_tExcludeNoActivity tinyint   = NULL,   @I_tExcludeMultiCurrency tinyint  = NULL,   
 @I_tExcludeZeroBalanceVendors tinyint  = NULL,   @I_tExcludeFullyPaidTrxs tinyint  = NULL,   @I_tExcludeCreditBalance tinyint  = NULL,   @I_tExcludeUnpostedAppldCrDocs tinyint = NULL 
 as  
 
 declare @X int, @VENDORID char (15), @CNTRLNUM char (21), @DOCNUMBR char (21), @DOCAMNT numeric (19, 5) , @MIN_DEX_ROW_ID int 
 set @X = 0 
   CREATE TABLE #PMATBVEN( [VENDORID] [char](15) NOT NULL, [VENDNAME] [char](65) NOT NULL, [VNDCLSID] [char](11) NOT NULL, [USERDEF1] [char](21) NOT NULL, [PYMNTPRI] [char](3) NOT NULL, [KEYSOURC] [char](41) NOT NULL, [DEX_ROW_ID] [int] IDENTITY(1, 1) NOT NULL ) CREATE UNIQUE NONCLUSTERED INDEX [PK # PMATBVEN] 
   ON #PMATBVEN ( [VENDORID] ASC ) 
   CREATE UNIQUE NONCLUSTERED INDEX [AK2#PMATBVEN] 
   ON #PMATBVEN ( [VENDNAME] ASC, [VENDORID] ASC ) 
   CREATE UNIQUE NONCLUSTERED INDEX [AK3#PMATBVEN] 
   ON #PMATBVEN ( [VNDCLSID] ASC, [VENDORID] ASC ) 
   CREATE UNIQUE NONCLUSTERED INDEX [AK4#PMATBVEN] 
   ON #PMATBVEN ( [USERDEF1] ASC, [VENDORID] ASC ) 
   CREATE UNIQUE NONCLUSTERED INDEX [AK5#PMATBVEN] 
   ON #PMATBVEN ( [PYMNTPRI] ASC, [VENDORID] ASC ) 
   CREATE TABLE #PMATBAPP( [APTVCHNM] [char](21) NOT NULL, [APTODCTY] [smallint] NOT NULL, [VCHRNMBR] [char](21) NOT NULL, [DOCTYPE] [smallint] NOT NULL, [APAMAGPR_1] [numeric](19, 5) NOT NULL, [APAMAGPR_2] [numeric](19, 5) NOT NULL, [APAMAGPR_3] [numeric](19, 5) NOT NULL, [APAMAGPR_4] [numeric](19, 5) NOT NULL, [APAMAGPR_5] [numeric](19, 5) NOT NULL, [APAMAGPR_6] [numeric](19, 5) NOT NULL, [APAMAGPR_7] [numeric](19, 5) NOT NULL, [APPLDAMT] [numeric](19, 5) NOT NULL, [POSTED] [tinyint] NOT NULL, [CURNCYID] [char](15) NOT NULL, [CURRNIDX] [smallint] NOT NULL, [XCHGRATE] [numeric](19, 7) NOT NULL, [ORAPPAMT] [numeric](19, 5) NOT NULL, [OAGPRAMT_1] [numeric](19, 5) NOT NULL, [OAGPRAMT_2] [numeric](19, 5) NOT NULL, [OAGPRAMT_3] [numeric](19, 5) NOT NULL, [OAGPRAMT_4] [numeric](19, 5) NOT NULL, [OAGPRAMT_5] [numeric](19, 5) NOT NULL, [OAGPRAMT_6] [numeric](19, 5) NOT NULL, [OAGPRAMT_7] [numeric](19, 5) NOT NULL, [RLGANLOS] [numeric](19, 5) NOT NULL, [DENXRATE] [numeric](19, 7) NOT NULL, [MCTRXSTT] [smallint] NOT NULL, [DEX_ROW_ID] [int] IDENTITY(1, 1) NOT NULL ) 
   CREATE UNIQUE NONCLUSTERED INDEX [PK#PMATBAPP] 
   ON #PMATBAPP ( [APTVCHNM] ASC, [APTODCTY] ASC, [VCHRNMBR] ASC, [DOCTYPE] ASC ) 
   CREATE UNIQUE NONCLUSTERED INDEX [AK2#PMATBAPP] 
   ON #PMATBAPP ( [VCHRNMBR] ASC, [DOCTYPE] ASC, [APTVCHNM] ASC, [APTODCTY] ASC ) 
   CREATE TABLE #PMATBDOC( [VENDORID] [char](15) NOT NULL, [CNTRLNUM] [char](21) NOT NULL, [CNTRLTYP] [smallint] NOT NULL, [DOCNUMBR] [char](21) NOT NULL, [DOCTYPE] [smallint] NOT NULL, [DOCAMNT] [numeric](19, 5) NOT NULL, [DISTKNAM] [numeric](19, 5) NOT NULL, [DOCDATE] [datetime] NOT NULL, [DUEDATE] [datetime] NOT NULL, [DISCDATE] [datetime] NOT NULL, [TRXSORCE] [char](13) NOT NULL, [CURTRXAM] [numeric](19, 5) NOT NULL, [EAMAGPER_1] [numeric](19, 5) NOT NULL, [EAMAGPER_2] [numeric](19, 5) NOT NULL, [EAMAGPER_3] [numeric](19, 5) NOT NULL, [EAMAGPER_4] [numeric](19, 5) NOT NULL, [EAMAGPER_5] [numeric](19, 5) NOT NULL, [EAMAGPER_6] [numeric](19, 5) NOT NULL, [EAMAGPER_7] [numeric](19, 5) NOT NULL, [DISAMTAV] [numeric](19, 5) NOT NULL, [PERIODID] [smallint] NOT NULL, [WROFAMNT] [numeric](19, 5) NOT NULL, [KEYSOURC] [char](41) NOT NULL, [DINVPDOF] [datetime] NOT NULL, [PSTGDATE] [datetime] NOT NULL, [CURNCYID] [char](15) NOT NULL, [CURRNIDX] [smallint] NOT NULL, [XCHGRATE] [numeric](19, 7) NOT NULL, [ORDOCAMT] [numeric](19, 5) NOT NULL, [ORDISTKN] [numeric](19, 5) NOT NULL, [ORCTRXAM] [numeric](19, 5) NOT NULL, [OAGPRAMT_1] [numeric](19, 5) NOT NULL, [OAGPRAMT_2] [numeric](19, 5) NOT NULL, [OAGPRAMT_3] [numeric](19, 5) NOT NULL, [OAGPRAMT_4] [numeric](19, 5) NOT NULL, [OAGPRAMT_5] [numeric](19, 5) NOT NULL, [OAGPRAMT_6] [numeric](19, 5) NOT NULL, [OAGPRAMT_7] [numeric](19, 5) NOT NULL, [ODISAMTAV] [numeric](19, 5) NOT NULL, [ORWROFAM] [numeric](19, 5) NOT NULL, [DENXRATE] [numeric](19, 7) NOT NULL, [MCTRXSTT] [smallint] NOT NULL, [DEX_ROW_ID] [int] IDENTITY(1, 1) NOT NULL ) 
   CREATE UNIQUE NONCLUSTERED INDEX [PK#PMATBDOC] 
   ON #PMATBDOC ( [VENDORID] ASC, [CURNCYID] ASC, [CNTRLNUM] ASC, [CNTRLTYP] ASC, [KEYSOURC] ASC ) 
   CREATE UNIQUE NONCLUSTERED INDEX [AK2#PMATBDOC] 
   ON #PMATBDOC ( [CURNCYID] ASC, [DEX_ROW_ID] ASC ) 
   
   exec pmHistoricalAgedTrialBalance '#PMATBVEN', '#PMATBDOC', '#PMATBAPP', '', @I_dAgingDate, @I_cStartVendorID, @I_cEndVendorID, @I_cStartVendorName, @I_cEndVendorName, @I_cStartClassID, @I_cEndClassID, @I_cStartUserDefined, @I_cEndUserDefined, @I_cStartPaymentPriority, @I_cEndPaymentPriority, @I_cStartDocumentNumber, @I_cEndDocumentNumber, @I_tUsingDocumentDate, @I_dStartDate, @I_dEndDate, @I_tExcludeNoActivity, @I_tExcludeMultiCurrency, @I_tExcludeZeroBalanceVendors, @I_tExcludeFullyPaidTrxs, @I_tExcludeCreditBalance, @I_tExcludeUnpostedAppldCrDocs, '', 0, 0, 1, 0, 2, 0 

   Select
      HATB.* Into ##pmHATB 
   FROM
      (
         select
            isnull([V].[VENDORID], '') as [VENDORID],
            isnull(V.[VENDNAME], '') as [VENDNAME],
            isnull(V.[VNDCLSID], '') as [VNDCLSID],
			isnull(pm.address1, '') ADDRESS1,
		    isnull(datosp.cityCode, '') cityCode,
		    isnull(datosp.dptoCode, '') dptoCode,
		    isnull(pm.[COUNTRY], '') country,
            isnull(datosp.nsaif_type_nit, '') nsaif_type_nit,
		    isnull(datosp.nsaIfNitSinDV, '') nsaIfNitSinDV,
		    isnull(datosp.digitoVerificador, '') digitoVerificador,
		    isnull(datosp.nsaIfnit, '') nsaIfnit, 
		    isnull(datosp.Fname, '') Fname,
		    isnull(datosp.Oname, '') Oname, 
		    isnull(datosp.Fsurname, '') Fsurname,
		    isnull(datosp.Ssurname, '') Ssurname,

            isnull(V.[USERDEF1], '') as [USERDEF1],
            isnull(V.[PYMNTPRI], '') as [PYMNTPRI],
            isnull([V].[KEYSOURC], '') as [VEN_KEYSOURC],
            isnull([APTVCHNM], '') as [APTVCHNM],
            isnull([APTODCTY], 0) as [APTODCTY],
            isnull([VCHRNMBR], '') as [VCHRNMBR],
            isnull([A].[DOCTYPE], 0) as APP_DOCTYPE,
            isnull([APAMAGPR_1], 0) as [APAMAGPR_1],
            isnull([APAMAGPR_2], 0) as [APAMAGPR_2],
            isnull([APAMAGPR_3], 0) as [APAMAGPR_3],
            isnull([APAMAGPR_4], 0) as [APAMAGPR_4],
            isnull([APAMAGPR_5], 0) as [APAMAGPR_5],
            isnull([APAMAGPR_6], 0) as [APAMAGPR_6],
            isnull([APAMAGPR_7], 0) as [APAMAGPR_7],
            isnull([APPLDAMT], 0) as [APPLDAMT],
            isnull([POSTED], 0) as [POSTED],
            isnull([ORAPPAMT], 0) as [ORAPPAMT],
            isnull([A].[OAGPRAMT_1], 0) as [APP_OAGPRAMT_1],
            isnull([A].[OAGPRAMT_2], 0) as [APP_OAGPRAMT_2],
            isnull([A].[OAGPRAMT_3], 0) as [APP_OAGPRAMT_3],
            isnull([A].[OAGPRAMT_4], 0) as [APP_OAGPRAMT_4],
            isnull([A].[OAGPRAMT_5], 0) as [APP_OAGPRAMT_5],
            isnull([A].[OAGPRAMT_6], 0) as [APP_OAGPRAMT_6],
            isnull([A].[OAGPRAMT_7], 0) as [APP_OAGPRAMT_7],
            isnull([CNTRLNUM], '') as [CNTRLNUM],
            isnull([CNTRLTYP], 0) as [CNTRLTYP],
            isnull([DOCNUMBR], '') as [DOCNUMBR],
            isnull([D].[DOCTYPE], 0) as DOC_DOCTYPE,
            isnull([DOCAMNT], 0) as [DOCAMNT],
            isnull([DISTKNAM], 0) as [DISTKNAM],
            isnull([DOCDATE], '1900-01-01') as [DOCDATE],
            isnull([DUEDATE], '1900-01-01') as [DUEDATE],
            isnull([DISCDATE], '1900-01-01') as [DISCDATE],
            isnull([TRXSORCE], '') as [TRXSORCE],
            isnull([CURTRXAM], 0) as [CURTRXAM],
            isnull([EAMAGPER_1], 0) as [EAMAGPER_1],
            isnull([EAMAGPER_2], 0) as [EAMAGPER_2],
            isnull([EAMAGPER_3], 0) as [EAMAGPER_3],
            isnull([EAMAGPER_4], 0) as [EAMAGPER_4],
            isnull([EAMAGPER_5], 0) as [EAMAGPER_5],
            isnull([EAMAGPER_6], 0) as [EAMAGPER_6],
            isnull([EAMAGPER_7], 0) as [EAMAGPER_7],
            isnull([DISAMTAV], 0) as [DISAMTAV],
            isnull([PERIODID], 0) as [PERIODID],
            isnull([WROFAMNT], 0) as [WROFAMNT],
            isnull([D].[KEYSOURC], '') as [DOC_KEYSOURC],
            isnull([DINVPDOF], '1900-01-01') as [DINVPDOF],
            isnull([PSTGDATE], '1900-01-01') as [PSTGDATE],
            isnull([ORDOCAMT], 0) as [ORDOCAMT],
            isnull([ORDISTKN], 0) as [ORDISTKN],
            isnull([ORCTRXAM], 0) as [ORCTRXAM],
            isnull([D].[OAGPRAMT_1], 0) as [DOC_OAGPRAMT_1],
            isnull([D].[OAGPRAMT_2], 0) as [DOC_OAGPRAMT_2],
            isnull([D].[OAGPRAMT_3], 0) as [DOC_OAGPRAMT_3],
            isnull([D].[OAGPRAMT_4], 0) as [DOC_OAGPRAMT_4],
            isnull([D].[OAGPRAMT_5], 0) as [DOC_OAGPRAMT_5],
            isnull([D].[OAGPRAMT_6], 0) as [DOC_OAGPRAMT_6],
            isnull([D].[OAGPRAMT_7], 0) as [DOC_OAGPRAMT_7],
            isnull([ODISAMTAV], 0) as [ODISAMTAV],
            isnull([ORWROFAM], 0) as [ORWROFAM],
            1 as DEX_ROW_ID 
         from
            #PMATBVEN V 
            left join
               #PMATBDOC D 
               on V.VENDORID = D.VENDORID 
            left join
               #PMATBAPP A 
               on D.CNTRLNUM = A.APTVCHNM 
               and D.DOCTYPE = A.APTODCTY 
			left join pm00200 pm
				on pm.VENDORID = V.VENDORID
			OUTER APPLY dbo.fnColMediosMagneticosDatosComprobanteAP(0, '', V.VENDORID, pm.CITY, pm.[STATE]) datosp
      )
      as HATB 

      update
         tempdb.. ##pmHATB 
      set
         DEX_ROW_ID = @X,
         @X = @X + 1 
         declare AMOUNT cursor for 
         select
            VENDORID,
            CNTRLNUM,
            DOCNUMBR,
            DOCAMNT,
            Min(DEX_ROW_ID)as MIN_DEX_ROW_ID 
         from
            ##pmHATB 
         group by
            VENDORID,
            CNTRLNUM,
            DOCNUMBR,
            DOCAMNT 
         having
            count(*) > 1 OPEN AMOUNT FETCH NEXT 
         FROM
            AMOUNT INTO @VENDORID,
            @CNTRLNUM,
            @DOCNUMBR,
            @DOCAMNT,
            @MIN_DEX_ROW_ID 
		WHILE @@FETCH_STATUS = 0 
            BEGIN
               update
                  tempdb.. ##pmHATB 
               set
                  CURTRXAM = 0.00000,
                  EAMAGPER_1 = 0.00000,
                  EAMAGPER_2 = 0.00000,
                  EAMAGPER_3 = 0.00000,
                  EAMAGPER_4 = 0.00000,
                  EAMAGPER_5 = 0.00000,
                  EAMAGPER_6 = 0.00000,
                  EAMAGPER_7 = 0.00000 
               where
                  DEX_ROW_ID > @MIN_DEX_ROW_ID 
                  and VENDORID = @VENDORID 
                  and CNTRLNUM = @CNTRLNUM 
                  and DOCNUMBR = @DOCNUMBR 
                  and DOCAMNT = @DOCAMNT FETCH NEXT 
               FROM
                  AMOUNT INTO @VENDORID,
                  @CNTRLNUM,
                  @DOCNUMBR,
                  @DOCAMNT,
                  @MIN_DEX_ROW_ID 
            end
            CLOSE AMOUNT DEALLOCATE AMOUNT 

		select 	nsaif_type_nit [Tipo de Documento],
          nsaIfNitSinDV [Número Identificación],
		  digitoVerificador [DV],
		  Fsurname [Primer apellido],
		  Ssurname [Segundo apellido],  
		  Fname [Primer nombre],
		  Oname [Otros nombres],
          [VENDNAME] [Razón Social],
		  ADDRESS1 [Dirección],
		  dptoCode [Código dpto.],
		  cityCode [Código mcp.],
		  country [País],
		  sum(CURTRXAM) Saldo
            FROM ##pmHATB 
			group by 
				[VENDNAME],
				ADDRESS1,
				cityCode,
				dptoCode,
				country,
				nsaif_type_nit,
				nsaIfNitSinDV,
				digitoVerificador,
				Fname,
				Oname, 
				Fsurname,
				Ssurname
			   
			DROP TABLE ##pmHATB

GO

IF (@@Error = 0) PRINT 'Creación exitosa de: spColBaseSaldosAPAgrupadoXProveedor'
ELSE PRINT 'Error en la creación de: spColBaseSaldosAPAgrupadoXProveedor'
GO


