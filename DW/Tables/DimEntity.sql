CREATE TABLE [DW].DimEntity
(
    EntityID       INT NOT NULL
  , TenantID       INT NOT NULL
  , Code           NVARCHAR(10) NOT NULL
  , Name           NVARCHAR(255) NOT NULL
  
  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETUTCDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETUTCDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWDimEntity__EntityID_TenantID] 
	   PRIMARY KEY CLUSTERED(EntityID, TenantID)
  , CONSTRAINT [FK_DWDimEntity_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
