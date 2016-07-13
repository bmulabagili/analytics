CREATE TABLE [Transform].[FactEngagement]
(
      EngagementID INT NOT NULL
	, TenantID INT NOT NULL
	, DateID INT NOT NULL
	, HouseholdIdentifier INT NOT NULL
	, HouseholdPosition NVARCHAR(255) NULL
	, IndividualIdentifier INT NOT NULL
	, WeekendAttendanceCount INT NULL
	, GivingCount INT NULL
	, GivingAmount DECIMAL(9,2) NULL
	, SmallGroupCount INT NULL
	, AwanaAttendanceCount INT NULL
	, HCAEnrollmentCount INT NULL
	, VolunteerAssignmentCount INT NULL
	, VolunteerAttendanceCount INT NULL
	--ETL Specific Columns
	, ExecutionID        VARCHAR(50) NOT NULL
	, ETLActionID        INT NOT NULL
	, InsertedDateTime   DATETIME DEFAULT(GETDATE())
	, UpdatedDateTime    DATETIME DEFAULT(GETDATE())
	, Hashvalue          NVARCHAR(64) NOT NULL
    --Keys should get enforced at this point.
  , CONSTRAINT [PK_TransformFactEngagement__EngagementID_TenantID] 
	   PRIMARY KEY CLUSTERED(EngagementID, TenantID)
  , CONSTRAINT [FK_TransformFactEngagement_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);