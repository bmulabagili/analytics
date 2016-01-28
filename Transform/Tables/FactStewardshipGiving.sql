CREATE TABLE [Transform].[FactStewardshipGiving]
(
	StewardshipGivingID INT NOT NULL 
  , TenantID INT NOT NULL
  , CampusID INT NOT NULL
  , CalendarMonth INT NOT NULL
  , CalendarYear INT NOT NULL
  , StewardshipGivingAmount INT NOT NULL
	   --ETL Specific Columns
  , ExecutionID        VARCHAR(50) NOT NULL
  , ETLActionID        INT NOT NULL
  , InsertedDateTime   DATETIME DEFAULT(GETUTCDATE())
  , UpdatedDateTime    DATETIME DEFAULT(GETUTCDATE())
  , Hashvalue          NVARCHAR(64) NOT NULL
   
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_TransformStewardshipGiving__StewardshipGivingID_TenantID] 
	   PRIMARY KEY CLUSTERED(StewardshipGivingID, TenantID)
  , CONSTRAINT [FK_TransformFactStewardshipGiving_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID]) 
)
