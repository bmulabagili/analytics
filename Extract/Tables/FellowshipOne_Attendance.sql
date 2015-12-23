CREATE TABLE [Extract].[FellowshipOne_Attendance](
    [RowNumber]         INT NULL
  , [Assigned]          NVARCHAR(20) NULL
  , [ActivityType]      NVARCHAR(100) NULL
  , [Ministry]          NVARCHAR(100) NULL
  , [Activity]          NVARCHAR(100) NULL
  , [RosterFolder]      NVARCHAR(100) NULL
  , [Roster]            NVARCHAR(100) NULL
  , [BreakoutGroup]     NVARCHAR(100) NULL
  , [VolStaffType]      NVARCHAR(100) NULL
  , [VolStaffJob]       NVARCHAR(100) NULL
  , [VolStaffSchedule]  NVARCHAR(100) NULL
  , [IndividualID]      NVARCHAR(100) NULL
  , [Name]              NVARCHAR(100) NULL
  , [FirstName]         NVARCHAR(100) NULL
  , [LastName]          NVARCHAR(100) NULL
  , [DOB]               NVARCHAR(100) NULL
  , [MaritalStatus]     NVARCHAR(100) NULL
  , [Gender]            NVARCHAR(100) NULL
  , [HouseholdPosition] NVARCHAR(100) NULL
  , [Status]            NVARCHAR(100) NULL
  , [SubStatus]         NVARCHAR(100) NULL
  , [School]            NVARCHAR(100) NULL
  , [HouseholdID]       NVARCHAR(100) NULL
  , [HouseholdFullName] NVARCHAR(100) NULL
  , [Address]           NVARCHAR(100) NULL
  , [City]              NVARCHAR(100) NULL
  , [StateProvince]     NVARCHAR(100) NULL
  , [PostalCode]        NVARCHAR(100) NULL
  , [CheckInTagCode]    NVARCHAR(100) NULL
  , [CheckInvPager]     NVARCHAR(100) NULL
  , [CheckInTime]       NVARCHAR(100) NULL
  , [CheckInStation]    NVARCHAR(100) NULL
  , [Instance]          NVARCHAR(100) NULL
  , TenantID            INT NOT NULL
  , [ExecutionID]       VARCHAR(50) NOT NULL
  , [InsertedDateTime]  DATETIME DEFAULT(GETUTCDATE())
                                 NULL
);
GO

CREATE CLUSTERED INDEX [CIX_ExtractFellowshipOneAttendance__ExecutionID] ON [Extract].[FellowshipOne_Attendance]([ExecutionID] ASC);
GO