CREATE TABLE [Transform].FactPaycor
(
    PaycorID			INT NOT NULL
  , TenantID			INT NOT NULL
  , DateID				INT NOT NULL
  , GLOrgCode			NVARCHAR(255)
  , Amount			    MONEY NOT NULL
  
    --ETL Specific Columns
  , ExecutionID			VARCHAR(50) NOT NULL
  , ETLActionID			INT NOT NULL
  , InsertedDateTime	DATETIME DEFAULT(GETDATE())
  , UpdatedDateTime		DATETIME DEFAULT(GETDATE())
  , Hashvalue			NVARCHAR(64) NOT NULL
    
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_TransformFactPaycor__PaycorID_TenantID] 
	   PRIMARY KEY CLUSTERED(PaycorID, TenantID)
  , CONSTRAINT [FK_TransformFactPaycor_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);