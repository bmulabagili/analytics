CREATE TABLE [DW].[DimGroupName](
    GroupNameID       INT NOT NULL
  , TenantID         INT NOT NULL
  , Name             NVARCHAR(255) NOT NULL

    --ETL Specific Columns
  , ExecutionID      VARCHAR(50) NOT NULL
  , ETLActionID      INT NOT NULL
  , InsertedDateTime DATETIME DEFAULT(GETDATE())
  , UpdatedDateTime  DATETIME DEFAULT(GETDATE())
  , Hashvalue        NVARCHAR(64) NOT NULL
    
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_DWDimGroupName__GroupNameID_TenantID] 
	   PRIMARY KEY CLUSTERED(GroupNameID, TenantID)
  , CONSTRAINT [FK_DWDimGroupName_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]([TenantID])
);