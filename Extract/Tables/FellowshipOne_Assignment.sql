CREATE TABLE [Extract].[FellowshipOne_Assignment]
(
	  AssignmentStatus			NVARCHAR(255) NULL
	, Assigned					NVARCHAR(255) NULL
	, IndividualID				NVARCHAR(255) NULL
	, Name						NVARCHAR(255) NULL
	, StaffType					NVARCHAR(255) NULL
	, Job						NVARCHAR(255) NULL
	, JobAttributes				NVARCHAR(255) NULL
	, MaritalStatus				NVARCHAR(255) NULL
	, Age						NVARCHAR(255) NULL
	, [Status]					NVARCHAR(255) NULL
	, SubStatus					NVARCHAR(255) NULL
	, HouseholdID				NVARCHAR(255) NULL
	, Position					NVARCHAR(255) NULL
	, PostalCode				NVARCHAR(255) NULL
	, Ministry					NVARCHAR(255) NULL
	, Activity					NVARCHAR(255) NULL
	, VolunteerStaffSchedule	NVARCHAR(255) NULL
	, Roster    				NVARCHAR(255) NULL

	, TenantID					INT NOT NULL
	, [ExecutionID]				VARCHAR(50) NOT NULL
	, [InsertedDateTime]		DATETIME DEFAULT(GETDATE())
)
GO

CREATE CLUSTERED INDEX [CIX_ExtractFellowshipOneAssignment__ExecutionID] 
	ON [Extract].[FellowshipOne_Assignment]([ExecutionID] ASC);
GO
