CREATE TABLE [DW].FactBudgetRevenue
(
    BudgetRevenueID     INT NOT NULL
  , TenantID			INT NOT NULL
  , BudgetYear			INT NOT NULL
  , BudgetMonth			TINYINT NOT NULL
  , EntityID			INT NOT NULL -- for now Hardcoded to HBC, HBF, HCA, WITW in post deploy
  , FinancialCategoryID INT NOT NULL -- covers all the SCodes except 2
  , CampusID			INT NOT NULL
  , Amount				MONEY NOT NULL

  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETUTCDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETUTCDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWFactBudgetRevenue__BudgetRevenueID_TenantID] 
	   PRIMARY KEY CLUSTERED(BudgetRevenueID, TenantID)
  , CONSTRAINT [FK_DWFactBudgetRevenue_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
