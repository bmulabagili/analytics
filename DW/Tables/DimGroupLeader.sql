CREATE TABLE DW.[DimGroupLeader](
    GroupLeaderID       INT NOT NULL
  , TenantID         INT NOT NULL
  , Name             NVARCHAR(255) NOT NULL

    --ETL Specific Columns
  , ExecutionID      VARCHAR(50) NOT NULL
  , InsertedDateTime DATETIME DEFAULT(GETDATE())
  , UpdatedDateTime  DATETIME DEFAULT(GETDATE())
  , Hashvalue        NVARCHAR(64) NOT NULL
    
    --Keys should get enforced at this point.
  , CONSTRAINT [PK_DWDimGroupLeader__GroupLeaderID_TenantID] 
	   PRIMARY KEY CLUSTERED(GroupLeaderID, TenantID)
  , CONSTRAINT [FK_DWDimGroupLeader_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]([TenantID])
);