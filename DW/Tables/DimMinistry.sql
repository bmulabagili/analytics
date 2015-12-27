CREATE TABLE [DW].DimMinistry(
    MinistryID       INT NOT NULL
  , TenantID         INT NOT NULL
  , Name             NVARCHAR(255) NOT NULL
  , CampusID         INT NOT NULL

  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETUTCDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETUTCDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
    , CONSTRAINT [pk_DWDimMinistry__MinistryID_TenantID] 
	   PRIMARY KEY CLUSTERED(MinistryID, TenantID)
  , CONSTRAINT [FK_DWDimMinistry_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]([TenantID])
);
GO