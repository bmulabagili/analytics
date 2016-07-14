CREATE TABLE [DW].[FactEngagement]
(
	  EngagementID INT NOT NULL
	, TenantID INT NOT NULL
	, DateID INT NOT NULL
	, HouseholdIdentifier INT NOT NULL
	, HouseholdPosition NVARCHAR(255) NULL
	, IndividualIdentifier INT NOT NULL
	, CampusID INT NULL
	, WeekendAttendanceCount INT NULL
	, GivingCount INT NULL
	, GivingAmount DECIMAL(9,2) NULL
	, SmallGroupCount INT NULL
	, AwanaAttendanceCount INT NULL
	, HCAEnrollmentCount INT NULL
	, VolunteerAssignmentCount INT NULL
	, VolunteerAttendanceCount INT NULL
	--ETL Specific Columns
	, [ExecutionID]      VARCHAR(50) NOT NULL
	, [InsertedDateTime] DATETIME DEFAULT(GETDATE()) NULL
	, [UpdatedDateTime]  DATETIME DEFAULT(GETDATE()) NULL
	, [Hashvalue]        NVARCHAR(64) NOT NULL
	, CONSTRAINT [pk_DWFactEngagement__EngagementID_TenantID] 
		PRIMARY KEY CLUSTERED(EngagementID, TenantID)
	, CONSTRAINT [FK_DWFactEngagement_Tenant__TenantID] 
		FOREIGN KEY([TenantID]) 
		REFERENCES [dbo].[Tenant]( [TenantID])
)
