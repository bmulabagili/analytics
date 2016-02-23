CREATE TABLE [Transform].FactCallMetric
(
      CallMetricID					INT NOT NULL
	, TenantID						INT NOT NULL
	, CalendarYear					INT
	, CalendarMonth					INT
	, DonationCalls					INT
	, PrayerCalls					INT


    --ETL Specific Columns
  , ExecutionID			VARCHAR(50) NOT NULL
  , ETLActionID			INT NOT NULL
  , InsertedDateTime	DATETIME DEFAULT(GETUTCDATE())
  , UpdatedDateTime		DATETIME DEFAULT(GETUTCDATE())
  , Hashvalue			NVARCHAR(64) NOT NULL
    
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_TransformCallMetric__CallMetricID_TenantID] 
	   PRIMARY KEY CLUSTERED(CallMetricID, TenantID)
  , CONSTRAINT [FK_TransformFactCallMetric_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);