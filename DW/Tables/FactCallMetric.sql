CREATE TABLE [DW].[FactCallMetric]
(
      CallMetricID			INT NOT NULL
	, TenantID						INT NOT NULL
	, CalendarYear					INT
	, CalendarMonth					INT
	, DonationCalls					INT
	, PrayerCalls					INT

  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETUTCDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETUTCDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWFactCallMetric__CallMetricID_TenantID] 
	   PRIMARY KEY CLUSTERED(CallMetricID, TenantID)
  , CONSTRAINT [FK_DWFactCallMetric_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
