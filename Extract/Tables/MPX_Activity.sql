CREATE TABLE Extract.MPX_Activity
(
	SourceDatabase		NVARCHAR(255)
  , EntityID			INT
  , AddDate				DATE
  , Active				INT
  , ChgDate				DATE
  , SourceCodeValue		NVARCHAR(255)
  , PartnerCodeValue	NVARCHAR(255)
  , TransactionDate		DATE
  , MotivationCode		NVARCHAR(255)
  , MediaCode			NVARCHAR(255)
  , Amount				DECIMAL(9,2)
  , MaxExtractDate		DATE

  , TenantID            INT NOT NULL
  --ETL Columns
  , [ExecutionID]       VARCHAR(50) NOT NULL
  , [InsertedDateTime]  DATETIME DEFAULT(GETDATE())
                                 NULL
);
GO

CREATE CLUSTERED INDEX [CIX_ExtractMPXActivity_ExecutionID] ON [Extract].MPX_Activity([ExecutionID] ASC);
GO