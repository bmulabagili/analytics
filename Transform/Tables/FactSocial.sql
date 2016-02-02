CREATE TABLE [Transform].[FactSocial]
(
	SocialID INT NOT NULL 
  , TenantID INT NOT NULL
  , CalendarMonth INT NOT NULL
  , CalendarYear INT NOT NULL
  , SocialType NVARCHAR(255)
  , SocialAmount INT NOT NULL
	   --ETL Specific Columns
  , ExecutionID        VARCHAR(50) NOT NULL
  , ETLActionID        INT NOT NULL
  , InsertedDateTime   DATETIME DEFAULT(GETUTCDATE())
  , UpdatedDateTime    DATETIME DEFAULT(GETUTCDATE())
  , Hashvalue          NVARCHAR(64) NOT NULL
   
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_TransformSocial__SocialID_TenantID] 
	   PRIMARY KEY CLUSTERED(SocialID, TenantID)
  , CONSTRAINT [FK_TransformFactSocial_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID]) 
)
