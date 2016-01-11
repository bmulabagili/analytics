CREATE TABLE [Extract].MIP_Budget
(
      dtmLastModified   DATETIME
	, dtmWorksheetStart DATETIME
	, dtmWorksheetEnd   DATETIME
	, sWorksheetCycle   VARCHAR(25)
	, nNumCycles        INT
	, sColumnHeading    VARCHAR(70)
	, dtmFrom           DATETIME
	, dtmTo             DATETIME
	, sCodeIDf_0					VARCHAR(6)
	, AccountingCode0				VARCHAR(100)			
	, AccountingType0				CHAR(3)
	, AccountingDesignationCode0	CHAR(3)
	, sCodeIDf_1					VARCHAR(6)
	, AccountingCode1				VARCHAR(100)
	, AccountingType1				CHAR(3)
	, AccountingDesignationCode1	CHAR(3)
	, sCodeIDf_2					VARCHAR(6)
	, AccountingCode2				VARCHAR(100)
	, AccountingType2				CHAR(3)
	, AccountingDesignationCode2	CHAR(3)
	, sCodeIDf_3					VARCHAR(6)
	, AccountingCode3				VARCHAR(100)
	, AccountingType3				CHAR(3)
	, AccountingDesignationCode3	CHAR(3)
	, sCodeIDf_4					VARCHAR(6)
	, AccountingCode4				VARCHAR(100)
	, AccountingType4				CHAR(3)
	, AccountingDesignationCode4	CHAR(3)
	, sCodeIDf_5					VARCHAR(6)
	, AccountingCode5				VARCHAR(100)
	, AccountingType5				CHAR(3)
	, AccountingDesignationCode5	CHAR(3)
	, sCodeIDf_6					VARCHAR(6)
	, AccountingCode6				VARCHAR(100)
	, AccountingType6				CHAR(3)
	, AccountingDesignationCode6	CHAR(3)
	, sCodeIDf_7					VARCHAR(6)
	, AccountingCode7				VARCHAR(100)
	, AccountingType7				CHAR(3)
	, AccountingDesignationCode7	CHAR(3)
	, sCodeIDf_8					VARCHAR(6)
	, AccountingCode8				VARCHAR(100)
	, AccountingType8				CHAR(3)
	, AccountingDesignationCode8	CHAR(3)
	, sCodeIDf_9					VARCHAR(6)
	, AccountingCode9				VARCHAR(100)
	, AccountingType9				CHAR(3)
	, AccountingDesignationCode9	CHAR(3)
	, sCodeIDf_10					VARCHAR(6)
	, curAmount         MONEY
	, dAmount           FLOAT
	, sDescription      VARCHAR(100)

  , TenantID            INT NOT NULL
  --ETL Columns
  , [ExecutionID]       VARCHAR(50) NOT NULL
  , [InsertedDateTime]  DATETIME DEFAULT(GETUTCDATE())
                                 NULL
);
GO

CREATE CLUSTERED INDEX [CIX_ExtractMIP_Budget_ExecutionID] ON [Extract].MIP_Budget([ExecutionID] ASC);