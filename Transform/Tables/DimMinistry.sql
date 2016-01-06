CREATE TABLE [Transform].[DimMinistry](
    MinistryID       INT NOT NULL
  , TenantID         INT NOT NULL
  , Name             NVARCHAR(255) NOT NULL
  , CampusID         INT NOT NULL
  , StartDateTime    DATETIME NOT NULL
  , EndDateTime      DATETIME NULL
  , Active           BIT NOT NULL

    --ETL Specific Columns
  , ExecutionID      VARCHAR(50) NOT NULL
  , ETLActionID      INT NOT NULL
  , InsertedDateTime DATETIME DEFAULT(GETUTCDATE())
  , UpdatedDateTime  DATETIME DEFAULT(GETUTCDATE())
  , Hashvalue        NVARCHAR(64) NOT NULL
    
    --Keys should get enforced at this point.

  , CONSTRAINT [pk_TransformDimMinistry__MinistryID_TenantID] 
	   PRIMARY KEY CLUSTERED(MinistryID, TenantID)
  , CONSTRAINT [FK_TransformDimMinistry_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]([TenantID])
);