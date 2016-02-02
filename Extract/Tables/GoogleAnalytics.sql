CREATE TABLE Extract.[GoogleAnalytics]
(
	SiteID				NVARCHAR(255)
  , CalendarMonth		NVARCHAR(2)
  , CalendarYear        NVARCHAR(4)
  , SessionSource		NVARCHAR(255)
  , Bounces			    INT
  , BounceRate			REAL
  , TimeOnSite          REAL
  , AverageTimeOnSite   REAL
  , Visitors			INT
  , Visits				INT
  , PageViews			REAL

  , TenantID            INT NOT NULL
  --ETL Columns
  , [ExecutionID]       VARCHAR(50) NOT NULL
  , [InsertedDateTime]  DATETIME DEFAULT(GETUTCDATE())
                                 NULL
);
GO

CREATE CLUSTERED INDEX [CIX_ExtractGoogleAnalytics_ExecutionID] ON [Extract].GoogleAnalytics([ExecutionID] ASC);
GO