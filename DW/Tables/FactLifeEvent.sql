CREATE TABLE [DW].FactLifeEvent
(
    LifeEventID       INT NOT NULL
  , TenantID           INT NOT NULL
  , LifeEventTypeID    INT NOT NULL
  , CampusID           INT NOT NULL
  , MinistryID         INT NOT NULL
  , ActivityID         INT NOT NULL
  , RosterID           INT NOT NULL
  --, AttendanceTypeID   INT NOT NULL -- the source report is limited to participant
  , Age                INT NULL
  , Gender		   NCHAR(1) NULL
  , MaritalStatusID    INT NULL
  , IndividualStatusID INT NULL
  , AttendeeZipCode	   INT NULL
  , InstanceDateID     INT NOT NULL
  , InstanceTimeID     INT NOT NULL
  , LifeEventCount    INT NOT NULL
  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWFactLifeEvent__LifeEventID_TenantID] 
	   PRIMARY KEY CLUSTERED(LifeEventID, TenantID)
  , CONSTRAINT [FK_DWFactLifeEvent_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
