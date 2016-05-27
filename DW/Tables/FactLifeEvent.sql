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
	, CONSTRAINT FK_DWFactLifeEvent_DWDimLifeEvent__LifeEventTypeID_TenantID
		FOREIGN KEY (LifeEventTypeID, TenantID)
		REFERENCES DW.DimLifeEventType(LifeEventTypeID, TenantID)
	, CONSTRAINT FK_DWFactLifeEventType_DWDimCampus__CampusID_TenantID
		FOREIGN KEY (CampusID, TenantID)
		REFERENCES DW.DimCampus(CampusID, TenantID)
	, CONSTRAINT FK_DWFactLifeEvent_DWDimMinistry__MinistryID_TenantID
		FOREIGN KEY(MinistryID, TenantID)
		REFERENCES DW.DimMinistry(MinistryID, TenantID)
	, CONSTRAINT FK_DWFactLifeEvent_DWDimActivity__ActivityID_TenantID
		FOREIGN KEY(ActivityID, TenantID)
		REFERENCES DW.DimActivity(ActivityID, TenantID)
	, CONSTRAINT FK_DWFactLifeEvent_DWDimRoster__RosterID_TenantID
		FOREIGN KEY(RosterID, TenantID)
		REFERENCES DW.DimRoster(RosterID, TenantID)
	, CONSTRAINT FK_DWFactLifeEvent_DWDimMaritalStatus__MaritalStatusID_TenantID
		FOREIGN KEY(MaritalStatusID, TenantID)
		REFERENCES DW.DimMaritalStatus(MaritalStatusID, TenantID)
	, CONSTRAINT FK_DWFactLifeEvent_DWDimIndividualStatus__IndividualStatusID_TenantID
		FOREIGN KEY(IndividualStatusID, TenantID)
		REFERENCES DW.DimIndividualStatus(IndividualStatusID, TenantID)
	, CONSTRAINT FK_DWFactLifeEvent_DWDimDate__InstanceDateID_DateID
		FOREIGN KEY(InstanceDateID)
		REFERENCES DW.DimDate(DateID)

);
