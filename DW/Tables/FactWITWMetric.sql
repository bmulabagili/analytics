CREATE TABLE [DW].FactWITWMetric
(
    WITWMetricID INT NOT NULL 
  , TenantID INT NOT NULL
  , SectionName NVARCHAR(255) NULL
  , MetricName NVARCHAR(255) NOT NULL
  , CalendarMonth INT NOT NULL
  , CalendarYear INT NOT NULL
  , WITWMetricAmount INT NOT NULL
  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWFactWITWMetric__WITWMetricID_TenantID] 
	   PRIMARY KEY CLUSTERED(WITWMetricID, TenantID)
  , CONSTRAINT [FK_DWFactWITWMetric_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
