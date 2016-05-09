CREATE TABLE [Extract].[FellowshipOne_AssimilationSteps]
(
    [IndividualID]      NVARCHAR(255) NULL
  , [Name]              NVARCHAR(255) NULL
  , [LastName]          NVARCHAR(255) NULL
  , [FirstName]         NVARCHAR(255) NULL
  , [HouseholdPosition] NVARCHAR(255) NULL
  , [Gender]            NVARCHAR(255) NULL
  , [MaritalStatus]     NVARCHAR(255) NULL
  , [DOB]               NVARCHAR(255) NULL
  , [Status]            NVARCHAR(255) NULL
  , [SubStatus]         NVARCHAR(255) NULL
  , [School]            NVARCHAR(255) NULL
  , [HouseholdID]       NVARCHAR(255) NULL
  , [PostalCode]        NVARCHAR(255) NULL
  , MeetDate            NVARCHAR(255) NULL
  , ConnectDate         NVARCHAR(255) NULL
  , BaptismDate         NVARCHAR(255) NULL
  , MembershipDate      NVARCHAR(255) NULL
  , TenantID            INT NOT NULL
  , [ExecutionID]       VARCHAR(50) NOT NULL
  , [InsertedDateTime]  DATETIME DEFAULT(GETDATE())
                                 NULL
);
GO

CREATE CLUSTERED INDEX [CIX_ExtractFellowshipOneAssimilationSteps_ExecutionID] ON [Extract].[FellowshipOne_AssimilationSteps]([ExecutionID] ASC);
GO