CREATE TABLE [Transform].[FactSocialContact]
(
	SocialContactID		INT NOT NULL 
  , TenantID			INT NOT NULL
  , SocialNetwork		NVARCHAR(255)
  , CalendarMonth		INT NOT NULL
  , CalendarYear		INT NOT NULL
  , SocialContactAmount INT NOT NULL
	   --ETL Specific Columns
  , ExecutionID        VARCHAR(50) NOT NULL
  , ETLActionID        INT NOT NULL
  , InsertedDateTime   DATETIME DEFAULT(GETDATE())
  , UpdatedDateTime    DATETIME DEFAULT(GETDATE())
  , Hashvalue          NVARCHAR(64) NOT NULL
   
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_TransformSocialContact__SocialContactID_TenantID] 
	   PRIMARY KEY CLUSTERED(SocialContactID, TenantID)
  , CONSTRAINT [FK_TransformFactSocialContact_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID]) 
)


