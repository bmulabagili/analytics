CREATE TABLE [DW].FactHCAMetric
(
    HCAMetricID INT NOT NULL 
  , TenantID INT NOT NULL
  , SectionName NVARCHAR(255) NULL
  , MetricName NVARCHAR(255) NOT NULL
  , CalendarMonth INT NOT NULL
  , CalendarYear INT NOT NULL
  , HCAMetricAmount INT NOT NULL
  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWFactHCAMetric__HCAMetricID_TenantID] 
	   PRIMARY KEY CLUSTERED(HCAMetricID, TenantID)
  , CONSTRAINT [FK_DWFactHCAMetric_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
