CREATE TABLE [Transform].FactFinancialOther
(
    FinancialOtherID			INT NOT NULL
  , TenantID			INT NOT NULL
  , DateID				INT NOT NULL
  , EntityID			INT NOT NULL -- for now Hardcoded to HBC, HBF, HCA, WITW in post deploy
  , GLType				NVARCHAR(3) NULL -- Since we have multiple types (APO, FAO Etc) we moved this up to this table.
  , FinancialCategoryID INT NOT NULL -- covers all the SCodes except 2
  , CampusID			INT NOT NULL
  , Amount			    MONEY NOT NULL
  
    --ETL Specific Columns
  , ExecutionID			VARCHAR(50) NOT NULL
  , ETLActionID			INT NOT NULL
  , InsertedDateTime	DATETIME DEFAULT(GETDATE())
  , UpdatedDateTime		DATETIME DEFAULT(GETDATE())
  , Hashvalue			NVARCHAR(64) NOT NULL
    
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_TransformFactFinancialOther__FinancialOtherID_TenantID] 
	   PRIMARY KEY CLUSTERED(FinancialOtherID, TenantID)
  , CONSTRAINT [FK_TransformFactFinancialOther_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);