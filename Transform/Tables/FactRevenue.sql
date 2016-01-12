CREATE TABLE [Transform].FactRevenue
(
    RevenueID				INT NOT NULL
  , TenantID				INT NOT NULL
  , DateID					INT NOT NULL
  , EntityID				INT NOT NULL -- for now Hardcoded to HBC, HBF, HCA, WITW in post deploy
  , FinancialCategoryID		INT NOT NULL -- covers all the SCodes except 2
  , CampusID				INT NOT NULL
  , Amount					MONEY NOT NULL
  
    --ETL Specific Columns
  , ExecutionID				VARCHAR(50) NOT NULL
  , ETLActionID				INT NOT NULL
  , InsertedDateTime		DATETIME DEFAULT(GETUTCDATE())
  , UpdatedDateTime			DATETIME DEFAULT(GETUTCDATE())
  , Hashvalue				NVARCHAR(64) NOT NULL
    
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_TransformFactRevenue__RevenueID_TenantID] 
	   PRIMARY KEY CLUSTERED(RevenueID, TenantID)
  , CONSTRAINT [FK_TransformFactRevenue_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);