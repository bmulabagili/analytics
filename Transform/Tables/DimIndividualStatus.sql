CREATE TABLE [Transform].[DimIndividualStatus]
(
      IndividualStatusID INT NOT NULL
    , TenantID INT NOT NULL
    , [Status] NVARCHAR(255)
    , [SubStatus] NVARCHAR(255)
    , CampusID INT
    --ETL Specific Columns
  , ExecutionID      VARCHAR(50) NOT NULL
  , ETLActionID      INT NOT NULL
  , InsertedDateTime DATETIME DEFAULT(GETUTCDATE())
  , UpdatedDateTime  DATETIME DEFAULT(GETUTCDATE())
  , Hashvalue        NVARCHAR(64) NOT NULL
    
    --Keys should get enforced at this point.

  , CONSTRAINT [pk_TransformDimIndividualStatus__IndividualStatusID_TenantID] 
	   PRIMARY KEY CLUSTERED(IndividualStatusID, TenantID)
  , CONSTRAINT [FK_TransformDimIndividualStatus_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]([TenantID])
);