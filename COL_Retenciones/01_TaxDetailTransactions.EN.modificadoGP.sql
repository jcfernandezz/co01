USE [OEFC]
GO

/****** Object:  View [dbo].[TaxDetailTransactions]    Script Date: 7/11/2019 3:46:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

ALTER VIEW [dbo].[TaxDetailTransactions] AS 
SELECT rtrim(['Tax History'].[TAXDTLID]) AS 'Tax Detail ID',
       rtrim(['Sales/Purchases Tax Master'].[TXDTLDSC]) AS 'Tax Detail Description',
       'Tax Detail Type' = dbo.DYN_FUNC_Tax_Detail_Type(['Sales/Purchases Tax Master'].[TXDTLTYP]),
       rtrim(['Tax History'].[DOCNUMBR]) AS 'Document Number',
       rtrim(['Tax History'].[CustomerVendor_ID]) AS 'Customer/Vendor ID',
       CASE ISNULL(['PM Vendor Master File'].[VENDORID], 'empty')
           WHEN 'empty' THEN rtrim(['RM Customer MSTR'].[CUSTNAME])
           ELSE rtrim(['PM Vendor Master File'].[VENDNAME])
       END AS 'Customer/Vendor Name',
       ['Tax History'].[DOCDATE] AS 'Document Date',
       ['Tax History'].[PSTGDATE] AS 'Posting Date',
       ['Tax History'].[DOCAMNT] AS 'Total Sales/Purchases',
       ['Tax History'].[Taxable_Amount] AS 'Taxable Sales/Purchases',
       ['Tax History'].[TAXAMNT] AS 'Tax Amount',

  (SELECT rtrim([ACTNUMST])
   FROM [GL00105] AS ['Account Index Master']
   WHERE ['Account Index Master'].[ACTINDX] = ['Tax History'].[ACTINDX]) AS 'Account Number',
       ['Tax History'].[CURRNIDX] AS 'Currency Index',
       rtrim(['RM Customer MSTR'].[CUSTNAME]) AS 'Customer Name',
       rtrim(['RM Customer MSTR'].[CUSTNMBR]) AS 'Customer Number',
       'Document Type' = dbo.DYN_FUNC_Document_Type_Tax_Detail_Trx(['Tax History'].[DOCTYPE]),
       'EC Transaction' = dbo.DYN_FUNC_Boolean_All(['Tax History'].[ECTRX]),
       'Included On Return' = dbo.DYN_FUNC_Boolean_All(['Tax History'].[Included_On_Return]),
       ['Tax History'].[ORTAXAMT] AS 'Originating Tax Amount',
       ['Tax History'].[Originating_Taxable_Amt] AS 'Originating Taxable Sales/Purchases',
       ['Tax History'].[ORDOCAMT] AS 'Originating Total Sales/Purchases',
       'Series' = dbo.DYN_FUNC_Series_Tax_Detail_Trx(['Tax History'].[SERIES]),
       ['Tax History'].[Tax_Date] AS 'Tax Date',
       ['Sales/Purchases Tax Master'].[TXDTLAMT] AS 'Tax Detail Amount',
       ['Sales/Purchases Tax Master'].[TXDTLBSE] AS 'Tax Detail Base',
       ['Sales/Purchases Tax Master'].[TXDTLPCT] AS 'Tax Detail Percent',
       rtrim(['Tax History'].[Tax_Return_ID]) AS 'Tax Return ID',
       rtrim(['PM Vendor Master File'].[VENDORID]) AS 'Vendor ID',
       rtrim(['PM Vendor Master File'].[VENDNAME]) AS 'Vendor Name',
       'Voided' = dbo.DYN_FUNC_Voided(['Tax History'].[VOIDSTTS]),
       'Account Number For Drillback' = 'dgpp://DGPB/?Db=&Srv=OEF-SQL1&Cmp=OEFC&Prod=0' +dbo.dgppAccountIndex(1, ['Tax History'].[ACTINDX]),
       'Customer Number For Drillback' = 'dgpp://DGPB/?Db=&Srv=OEF-SQL1&Cmp=OEFC&Prod=0' +dbo.dgppCustomerID(1, ['RM Customer MSTR'].[CUSTNMBR]),
       'Vendor ID For Drillback' = 'dgpp://DGPB/?Db=&Srv=OEF-SQL1&Cmp=OEFC&Prod=0' +dbo.dgppVendorID(1, ['PM Vendor Master File'].[VENDORID]),
	   ['Sales/Purchases Tax Master'].TXDTLPCH
FROM [TX30000] AS ['Tax History'] WITH (NOLOCK)
LEFT OUTER JOIN [TX00201] AS ['Sales/Purchases Tax Master'] WITH (NOLOCK) ON ['Tax History'].[TAXDTLID] = ['Sales/Purchases Tax Master'].[TAXDTLID]
LEFT OUTER JOIN [PM00200] AS ['PM Vendor Master File'] WITH (NOLOCK) ON ['Tax History'].[CustomerVendor_ID] = ['PM Vendor Master File'].[VENDORID]
LEFT OUTER JOIN [RM00101] AS ['RM Customer MSTR'] WITH (NOLOCK) ON ['Tax History'].[CustomerVendor_ID] = ['RM Customer MSTR'].[CUSTNMBR]

go



