CREATE TABLE [DW].FactEnrollment
(
    EnrollmentID			INT NOT NULL
  , TenantID				INT NOT NULL
  , SchoolName				NVARCHAR(255) NOT NULL
  , SchoolEndYear			INT NOT NULL
  , StaffKids				NVARCHAR(255) NOT NULL
  , RetainedKids			NVARCHAR(255) NOT NULL
  , CalendarYear			INT NOT NULL
  , CalendarMonth			INT NOT NULL
  , EnrollmentCount			INT NOT NULL

  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETUTCDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETUTCDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWFactEnrollment__EnrollmentID_TenantID] 
	   PRIMARY KEY CLUSTERED(EnrollmentID, TenantID)
  , CONSTRAINT [FK_DWFactEnrollment_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
