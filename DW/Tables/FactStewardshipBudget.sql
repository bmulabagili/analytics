CREATE TABLE [DW].FactStewardshipBudget
(
    StewardshipBudgetID INT NOT NULL 
  , TenantID INT NOT NULL
  , CampusID INT NOT NULL
  , CalendarMonth INT NOT NULL
  , CalendarYear INT NOT NULL
  , StewardshipBudgetAmount INT NOT NULL
  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETUTCDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETUTCDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWFactStewardshipBudget__FirstTimeGiverID_TenantID] 
	   PRIMARY KEY CLUSTERED(StewardshipBudgetID, TenantID)
  , CONSTRAINT [FK_DWFactStewardshipBudget_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
