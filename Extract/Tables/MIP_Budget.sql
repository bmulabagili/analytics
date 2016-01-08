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
	, sCodeIDf_0        VARCHAR(6)
	, sCodeIDf_1        VARCHAR(6)
	, sCodeIDf_2		VARCHAR(6)
	, sCodeIDf_3		VARCHAR(6)
	, sCodeIDf_4		VARCHAR(6)
	, sCodeIDf_5		VARCHAR(6)
	, sCodeIDf_6		VARCHAR(6)
	, sCodeIDf_7		VARCHAR(6)
	, sCodeIDf_8		VARCHAR(6)
	, sCodeIDf_9		VARCHAR(6)
	, sCodeIDf_10		VARCHAR(6)
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