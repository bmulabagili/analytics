CREATE TABLE [Transform].FactWebActivity
(
    WebActivityID       INT NOT NULL
  , TenantID			INT NOT NULL
  , ReportingSection	NVARCHAR(255)
  , CalendarMonth		INT
  , CalendarYear		INT
  , SessionCount		INT
  , UniqueUserCount     INT
  , BounceCount			INT
  , SecondsOnSite		INT
  , PageViewCount		INT
  , SocialVisits		INT

    --ETL Specific Columns
  , ExecutionID			VARCHAR(50) NOT NULL
  , ETLActionID			INT NOT NULL
  , InsertedDateTime	DATETIME DEFAULT(GETDATE())
  , UpdatedDateTime		DATETIME DEFAULT(GETDATE())
  , Hashvalue			NVARCHAR(64) NOT NULL
    
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_TransformWebActivity__WebActivityID_TenantID] 
	   PRIMARY KEY CLUSTERED(WebActivityID, TenantID)
  , CONSTRAINT [FK_TransformFactWebActivity_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);