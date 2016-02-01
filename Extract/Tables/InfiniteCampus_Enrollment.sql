CREATE TABLE [Extract].InfiniteCampus_Enrollment
(
    SchoolName NVARCHAR(255)
  , CalendarMonth INT
  , CalendarYear INT
  , SchoolEndYear INT
  , StaffKids NVARCHAR(255)
  , RetainedKids  NVARCHAR(255)	  
  , EnrollmentCount INT

  , TenantID            INT NOT NULL
  --ETL Columns
  , [ExecutionID]       VARCHAR(50) NOT NULL
  , [InsertedDateTime]  DATETIME DEFAULT(GETUTCDATE())
                                 NULL
);
GO

CREATE CLUSTERED INDEX [CIX_ExtractInfiniteCampus_Enrollment_ExecutionID] ON [Extract].InfiniteCampus_Enrollment([ExecutionID] ASC);
GO