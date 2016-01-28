CREATE TABLE [DW].FactHBFMetric
(
    HBFMetricID INT NOT NULL 
  , TenantID INT NOT NULL
  , SectionName NVARCHAR(255) NULL
  , MetricName NVARCHAR(255) NOT NULL
  , CalendarMonth INT NOT NULL
  , CalendarYear INT NOT NULL
  , HBFMetricAmount INT NOT NULL
  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETUTCDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETUTCDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWFactHBFMetric__HBFMetricID_TenantID] 
	   PRIMARY KEY CLUSTERED(HBFMetricID, TenantID)
  , CONSTRAINT [FK_DWFactHBFMetric_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
