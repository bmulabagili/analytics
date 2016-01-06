CREATE TABLE [DW].FactSmallGroup
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
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETUTCDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETUTCDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWFactSmallGroup__SmallGroupID_TenantID] 
	   PRIMARY KEY CLUSTERED(SmallGroupID, TenantID)
  , CONSTRAINT [FK_DWFactSmallGroup_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
