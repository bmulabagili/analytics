CREATE TABLE Transform.[DimRoster](
    RosterID         INT NOT NULL
  , TenantID         INT NOT NULL
  , RosterFolder     NVARCHAR(255)
  , Roster           NVARCHAR(255)
  , BreakoutGroup    NVARCHAR(255)

    --ETL Specific Columns
  , ExecutionID      VARCHAR(50) NOT NULL
  , ETLActionID      INT NOT NULL
  , InsertedDateTime DATETIME DEFAULT(GETUTCDATE())
  , UpdatedDateTime  DATETIME DEFAULT(GETUTCDATE())
  , Hashvalue        NVARCHAR(64) NOT NULL
    
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_TransformDimRoster__RosterID_TenantID] 
	   PRIMARY KEY CLUSTERED(RosterID, TenantID)
  , CONSTRAINT [FK_TransformDimRoster_Tenant__TenantID] 
  FOREIGN KEY([TenantID]) 
  REFERENCES [dbo].[Tenant]( [TenantID])
);