CREATE TABLE [Transform].[FactStewardshipBudget]
(
	StewardshipBudgetID INT NOT NULL 
  , TenantID INT NOT NULL
  , CampusID INT NOT NULL
  , CalendarMonth INT NOT NULL
  , CalendarYear INT NOT NULL
  , StewardshipBudgetAmount INT NOT NULL
	   --ETL Specific Columns
  , ExecutionID        VARCHAR(50) NOT NULL
  , ETLActionID        INT NOT NULL
  , InsertedDateTime   DATETIME DEFAULT(GETUTCDATE())
  , UpdatedDateTime    DATETIME DEFAULT(GETUTCDATE())
  , Hashvalue          NVARCHAR(64) NOT NULL
   
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_TransformStewardshipBudget__StewardshipBudgetID_TenantID] 
	   PRIMARY KEY CLUSTERED(StewardshipBudgetID, TenantID)
  , CONSTRAINT [FK_TransformFactStewardshipBudget_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID]) 
)
