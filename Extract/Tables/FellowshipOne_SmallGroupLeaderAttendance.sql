CREATE TABLE [Extract].[FellowshipOne_SmallGroupLeaderAttendance](
    [RowNumber]         NVARCHAR(255) NULL 
  , [SpanofCare]		NVARCHAR(255) NULL
  , [SOCOwners]			NVARCHAR(255) NULL
  , [GroupType]			NVARCHAR(255) NULL
  , [GroupName]			NVARCHAR(255) NULL
  , [GroupLeaders]		NVARCHAR(255) NULL
  , [GroupRole]			NVARCHAR(255) NULL
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
  , [Instance]          NVARCHAR(255) NULL
  --ETL Columns
  , TenantID            INT NOT NULL
  , [ExecutionID]       VARCHAR(50) NOT NULL
  , [InsertedDateTime]  DATETIME DEFAULT(GETDATE())
  , [SourceFileName]    NVARCHAR(255) NULL
);
GO

CREATE CLUSTERED INDEX [CIX_ExtractFellowshipOneSmallGroupLeaderAttendance__ExecutionID] 
	ON [Extract].[FellowshipOne_SmallGroupLeaderAttendance]([ExecutionID] ASC);
GO