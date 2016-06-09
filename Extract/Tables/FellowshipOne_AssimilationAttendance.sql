CREATE TABLE [Extract].[FellowshipOne_AssimilationAttendance](
    [RowNumber]         NVARCHAR(255) NULL 
  , [Assigned]          NVARCHAR(255) NULL
  , [ActivityType]      NVARCHAR(255) NULL
  , [Ministry]          NVARCHAR(255) NULL
  , [Activity]          NVARCHAR(255) NULL
  , [RosterFolder]      NVARCHAR(255) NULL
  , [Roster]            NVARCHAR(255) NULL
  , [BreakoutGroup]     NVARCHAR(255) NULL
  , [VolStaffType]      NVARCHAR(255) NULL
  , [VolStaffJob]       NVARCHAR(255) NULL
  , [VolStaffSchedule]  NVARCHAR(255) NULL
  , [IndividualID]      NVARCHAR(255) NULL
  , [Name]              NVARCHAR(255) NULL
  , [FirstName]         NVARCHAR(255) NULL
  , [LastName]          NVARCHAR(255) NULL
  , [DOB]               NVARCHAR(255) NULL
  , [MaritalStatus]     NVARCHAR(255) NULL
  , [Gender]            NVARCHAR(255) NULL
  , [HouseholdPosition] NVARCHAR(255) NULL
  , [Status]            NVARCHAR(255) NULL
  , [SubStatus]         NVARCHAR(255) NULL
  , [School]            NVARCHAR(255) NULL
  , [HouseholdID]       NVARCHAR(255) NULL
  , [HouseholdFullName] NVARCHAR(255) NULL
  , [Address]           NVARCHAR(255) NULL
  , [City]              NVARCHAR(255) NULL
  , [StateProvince]     NVARCHAR(255) NULL
  , [PostalCode]        NVARCHAR(255) NULL
  , [CheckInTagCode]    NVARCHAR(255) NULL
  , [CheckInvPager]     NVARCHAR(255) NULL
  , [CheckInTime]       NVARCHAR(255) NULL
  , [CheckInStation]    NVARCHAR(255) NULL
  , [Instance]          NVARCHAR(255) NULL
  , TenantID            INT NOT NULL
  , [ExecutionID]       VARCHAR(50) NOT NULL
  , [InsertedDateTime]  DATETIME DEFAULT(GETDATE())
  , [SourceFileName]    NVARCHAR(255) NULL
);
GO

CREATE CLUSTERED INDEX [CIX_ExtractFellowshipOneAssimilationAttendance__ExecutionID] 
	ON [Extract].[FellowshipOne_AssimilationAttendance]([ExecutionID] ASC);
GO