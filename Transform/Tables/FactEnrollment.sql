CREATE TABLE [Transform].FactEnrollment
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
  , ExecutionID				VARCHAR(50) NOT NULL
  , ETLActionID				INT NOT NULL
  , InsertedDateTime		DATETIME DEFAULT(GETDATE())
  , UpdatedDateTime			DATETIME DEFAULT(GETDATE())
  , Hashvalue				NVARCHAR(64) NOT NULL
    
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_TransformFactEnrollment__EnrollmentID_TenantID] 
	   PRIMARY KEY CLUSTERED(EnrollmentID, TenantID)
  , CONSTRAINT [FK_TransformFactEnrollment_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);