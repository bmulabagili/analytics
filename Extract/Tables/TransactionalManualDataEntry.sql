CREATE TABLE [Extract].[TransactionalManualDataEntry]
(
	  ReportName NVARCHAR(255) NOT NULL
	, SectionName NVARCHAR(255) NULL
	, CategoryName NVARCHAR(255) NOT NULL
	, CalendarMonth INT NULL
	, CalendarYear INT NOT NULL
	, Value NVARCHAR(MAX) NOT NULL
	, TenantID INT NOT NULL
	--ETL Columns
  , [ExecutionID]       VARCHAR(50) NOT NULL
  , [InsertedDateTime]  DATETIME DEFAULT(GETDATE())
                                 NULL
);
GO
CREATE CLUSTERED INDEX [CIX_ExtractTransactionalManualDataEntry_ExecutionID] ON [Extract].[TransactionalManualDataEntry]([ExecutionID] ASC);

