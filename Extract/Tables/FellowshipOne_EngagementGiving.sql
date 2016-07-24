CREATE TABLE [Extract].[FellowshipOne_EngagementGiving](
    [RowNumber]         NVARCHAR(255) NULL  
  , [TransactionID]		NVARCHAR(255) NULL 
  , [ContributorType]	NVARCHAR(255) NULL 
  , [GivingUnitID]		NVARCHAR(255) NULL 
  , [GivingUnitName]	NVARCHAR(255) NULL
  , [ContributorID]		NVARCHAR(255) NULL 
  , [ContributorName]	NVARCHAR(255) NULL 
  , SubStatus			NVARCHAR(255) NULL
  , [FundType]			NVARCHAR(255) NULL 
  , [ReceivedDate]		NVARCHAR(255) NULL 
  , [ReceivedTime]		NVARCHAR(255) NULL 
  , [Type]				NVARCHAR(255) NULL 
  , [Amount]			NVARCHAR(255) NULL 
  , [TrueValue]			NVARCHAR(255) NULL 
  , [Contributors]		NVARCHAR(255) NULL 
  , [GivingUnits]		NVARCHAR(255) NULL 
  , [Gifts]				NVARCHAR(255) NULL 
  , [Transactions]		NVARCHAR(255) NULL 

  --ETL Columns
  , TenantID            INT NOT NULL
  , [ExecutionID]       VARCHAR(50) NOT NULL
  , [InsertedDateTime]  DATETIME DEFAULT(GETDATE())
  , [SourceFileName]    NVARCHAR(255) NULL
);
GO

CREATE CLUSTERED INDEX [CIX_ExtractFellowshipOneEngagementGiving__ExecutionID] 
	ON [Extract].[FellowshipOne_EngagementGiving]([ExecutionID] ASC);
GO