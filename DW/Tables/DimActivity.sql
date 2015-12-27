CREATE TABLE [DW].[DimActivity]
(
    ActivityID       INT NOT NULL
  , TenantID         INT NOT NULL
  , Name             NVARCHAR(255) NOT NULL
  , MinistryID       INT NOT NULL
  , CampusID         INT NOT NULL 

  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETUTCDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETUTCDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWDimActivity__ActivityID_TenantID] 
	   PRIMARY KEY CLUSTERED(ActivityID, TenantID)
  , CONSTRAINT [FK_DWDimActivity_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
