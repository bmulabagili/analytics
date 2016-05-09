CREATE TABLE [DW].FactFirstTimeGiver
(
    FirstTimeGiverID INT NOT NULL 
  , TenantID INT NOT NULL
  , CampusID INT NOT NULL
  , CalendarMonth INT NOT NULL
  , CalendarYear INT NOT NULL
  , FirstTimeGiverCount INT NOT NULL
  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWFactFirstTimeGiver__FirstTimeGiverID_TenantID] 
	   PRIMARY KEY CLUSTERED(FirstTimeGiverID, TenantID)
  , CONSTRAINT [FK_DWFactFirstTimeGiver_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
