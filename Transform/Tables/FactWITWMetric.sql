CREATE TABLE [Transform].[FactWITWMetric]
(
	WITWMetricID INT NOT NULL 
  , TenantID INT NOT NULL
  , SectionName NVARCHAR(255) NULL
  , MetricName NVARCHAR(255) NOT NULL
  , CalendarMonth INT NOT NULL
  , CalendarYear INT NOT NULL
  , WITWMetricAmount INT NOT NULL
	   --ETL Specific Columns
  , ExecutionID        VARCHAR(50) NOT NULL
  , ETLActionID        INT NOT NULL
  , InsertedDateTime   DATETIME DEFAULT(GETDATE())
  , UpdatedDateTime    DATETIME DEFAULT(GETDATE())
  , Hashvalue          NVARCHAR(64) NOT NULL
   
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_TransformWITWMetric__WITWMetricID_TenantID] 
	   PRIMARY KEY CLUSTERED(WITWMetricID, TenantID)
  , CONSTRAINT [FK_TransformFactWITWMetric_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID]) 
)
