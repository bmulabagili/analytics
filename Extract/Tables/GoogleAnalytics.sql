CREATE TABLE Extract.[GoogleAnalytics]
(
	AccountID			NVARCHAR(255)
  , WebProperty			NVARCHAR(255)
  , ProfileID			NVARCHAR(255)
  , ReportingSection	NVARCHAR(255)
  , CalendarMonth		NVARCHAR(2)
  , CalendarYear        NVARCHAR(4)
  , SessionSource		NVARCHAR(255)
  , Bounces			    INT
  , BounceRate			FLOAT
  , TimeOnSite          FLOAT
  , AverageTimeOnSite   FLOAT
  , Visitors			INT
  , Visits				INT
  , PageViews			FLOAT

  , TenantID            INT NOT NULL
  --ETL Columns
  , [ExecutionID]       VARCHAR(50) NOT NULL
  , [InsertedDateTime]  DATETIME DEFAULT(GETUTCDATE())
                                 NULL
);
GO

CREATE CLUSTERED INDEX [CIX_ExtractGoogleAnalytics_ExecutionID] ON [Extract].GoogleAnalytics([ExecutionID] ASC);
GO