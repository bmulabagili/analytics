CREATE TABLE [Transform].FactLifeEvent
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
  , ExecutionID        VARCHAR(50) NOT NULL
  , ETLActionID        INT NOT NULL
  , InsertedDateTime   DATETIME DEFAULT(GETDATE())
  , UpdatedDateTime    DATETIME DEFAULT(GETDATE())
  , Hashvalue          NVARCHAR(64) NOT NULL
    
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_TransformLifeEvent__LifeEventID_TenantID] 
	   PRIMARY KEY CLUSTERED(LifeEventID, TenantID)
  , CONSTRAINT [FK_TransformFactLifeEvent_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);