CREATE TABLE Transform.DimLifeEventType(
    LifeEventTypeID    INT NOT NULL
  , TenantID           INT NOT NULL
  , Name               NVARCHAR(255) NOT NULL

    --ETL Specific Columns
  , ExecutionID        VARCHAR(50) NOT NULL
  , ETLActionID        INT NOT NULL
  , InsertedDateTime   DATETIME DEFAULT(GETDATE())
  , UpdatedDateTime    DATETIME DEFAULT(GETDATE())
  , Hashvalue          NVARCHAR(64) NOT NULL
    
    --Keys should get enforced at this point.

  , CONSTRAINT [pk_TransformDimLifeEventType__CampusID] PRIMARY KEY CLUSTERED(LifeEventTypeID, TenantID)
  , CONSTRAINT [FK_TransformDimLifeEventType_Tenant__TenantID] FOREIGN KEY([TenantID]) REFERENCES [dbo].[Tenant](
                                                                                    [TenantID])
);
GO