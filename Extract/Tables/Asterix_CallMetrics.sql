CREATE TABLE Extract.Asterix_CallMetrics
(
	CalendarYear		INT
  , CalendarMonth		INT
  , DonationCalls		INT
  , PrayerCalls			INT

  , TenantID            INT NOT NULL
  --ETL Columns
  , [ExecutionID]       VARCHAR(50) NOT NULL
  , [InsertedDateTime]  DATETIME DEFAULT(GETDATE())
                                 NULL
);
GO

CREATE CLUSTERED INDEX [CIX_ExtractAsterixCallMetrics_ExecutionID] ON [Extract].Asterix_CallMetrics([ExecutionID] ASC);
GO