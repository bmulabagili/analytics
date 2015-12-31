CREATE TABLE [DW].DimLifeEventType(
    LifeEventTypeID    INT NOT NULL
  , TenantID           INT NOT NULL
  , Name               NVARCHAR(255) NOT NULL
    --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETUTCDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETUTCDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWDimLifeEventType__LifeEventTypeID_TenantID] 
  PRIMARY KEY CLUSTERED(LifeEventTypeID, TenantID)
  , CONSTRAINT [FK_DWDimLifeEventType_Tenant__TenantID] 
  FOREIGN KEY([TenantID]) 
  REFERENCES [dbo].[Tenant]([TenantID])
);