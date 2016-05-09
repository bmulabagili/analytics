CREATE TABLE [DW].FactSocialContact
(
    SocialContactID		INT NOT NULL 
  , TenantID			INT NOT NULL
  , SocialNetwork		NVARCHAR(255)
  , CalendarMonth		INT NOT NULL
  , CalendarYear		INT NOT NULL
  , SocialContactAmount INT NOT NULL

  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWFactSocialContact__SocialContactID_TenantID] 
	   PRIMARY KEY CLUSTERED(SocialContactID, TenantID)
  , CONSTRAINT [FK_DWFactSocialContact_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
