CREATE TABLE [DW].FactBudgetExpense
(
    BudgetExpenseID     INT NOT NULL
  , TenantID			INT NOT NULL
  , BudgetYear			INT NOT NULL
  , BudgetMonth			INT NOT NULL
  , EntityID			INT NOT NULL -- for now Hardcoded to HBC, HBF, HCA, WITW in post deploy
  , FinancialCategoryID INT NOT NULL -- covers all the SCodes except 2
  , CampusID			INT NOT NULL
  , Amount				MONEY NOT NULL

  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWFactBudgetExpense__BudgetExpenseID_TenantID] 
	   PRIMARY KEY CLUSTERED(BudgetExpenseID, TenantID)
  , CONSTRAINT [FK_DWFactBudgetExpense_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
