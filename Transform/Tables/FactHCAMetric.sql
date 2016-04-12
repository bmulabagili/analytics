CREATE TABLE [Transform].[FactHCAMetric]
(
	HCAMetricID INT NOT NULL 
  , TenantID INT NOT NULL
  , SectionName NVARCHAR(255) NULL
  , MetricName NVARCHAR(255) NOT NULL
  , CalendarMonth INT NOT NULL
  , CalendarYear INT NOT NULL
  , HCAMetricAmount INT NOT NULL
	   --ETL Specific Columns
  , ExecutionID        VARCHAR(50) NOT NULL
  , ETLActionID        INT NOT NULL
  , InsertedDateTime   DATETIME DEFAULT(GETUTCDATE())
  , UpdatedDateTime    DATETIME DEFAULT(GETUTCDATE())
  , Hashvalue          NVARCHAR(64) NOT NULL
   
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_TransformHCAMetric__HCAMetricID_TenantID] 
	   PRIMARY KEY CLUSTERED(HCAMetricID, TenantID)
  , CONSTRAINT [FK_TransformFactHCAMetric_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID]) 
)
