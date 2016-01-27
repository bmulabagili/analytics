CREATE TABLE [Transform].[FactFirstTimeGiver]
(
	FirstTimeGiverID INT NOT NULL 
  , TenantID INT NOT NULL
  , CampusID INT NOT NULL
  , CalendarMonth INT NOT NULL
  , CalendarYear INT NOT NULL
  , FirstTimeGiverCount INT NOT NULL
	   --ETL Specific Columns
  , ExecutionID        VARCHAR(50) NOT NULL
  , ETLActionID        INT NOT NULL
  , InsertedDateTime   DATETIME DEFAULT(GETUTCDATE())
  , UpdatedDateTime    DATETIME DEFAULT(GETUTCDATE())
  , Hashvalue          NVARCHAR(64) NOT NULL
   
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_TransformFirstTimeGiver__FirstTimeGiverID_TenantID] 
	   PRIMARY KEY CLUSTERED(FirstTimeGiverID, TenantID)
  , CONSTRAINT [FK_TransformFactFirstTimeGiver_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID]) 
)
