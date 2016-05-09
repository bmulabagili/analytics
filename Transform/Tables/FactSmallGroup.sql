CREATE TABLE [Transform].FactSmallGroup
(
    SmallGroupID       INT NOT NULL
  , TenantID           INT NOT NULL
  , SmallGroupDetailID INT NOT NULL
  , CalendarMonth	   INT NOT NULL
  , CalendarYear	   INT NOT NULL
  , MissingReports     INT NOT NULL
  , DidNotMeets        INT NOT NULL
  , ActualAttendance   INT NOT NULL
  , UniqueAttenders    INT NOT NULL
  , TotalLeaders       INT NOT NULL
  , TotalMembers       INT NOT NULL
  , TotalProspects     INT NOT NULL
  
    --ETL Specific Columns
  , ExecutionID        VARCHAR(50) NOT NULL
  , ETLActionID        INT NOT NULL
  , InsertedDateTime   DATETIME DEFAULT(GETDATE())
  , UpdatedDateTime    DATETIME DEFAULT(GETDATE())
  , Hashvalue          NVARCHAR(64) NOT NULL
    
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_TransformSmallGroup__SmallGroupID_TenantID] 
	   PRIMARY KEY CLUSTERED(SmallGroupID, TenantID)
  , CONSTRAINT [FK_TransformFactSmallGroup_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);