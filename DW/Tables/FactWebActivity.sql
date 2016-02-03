CREATE TABLE [DW].[FactWebActivity]
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

  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETUTCDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETUTCDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWFactWebActivity__WebActivityID_TenantID] 
	   PRIMARY KEY CLUSTERED(WebActivityID, TenantID)
  , CONSTRAINT [FK_DWFactWebActivity_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
