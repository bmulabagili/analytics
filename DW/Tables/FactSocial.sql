CREATE TABLE [DW].FactSocial
(
    SocialID INT NOT NULL 
  , TenantID INT NOT NULL
  , CalendarMonth INT NOT NULL
  , CalendarYear INT NOT NULL
  , SocialType NVARCHAR(255)
  , SocialAmount INT NOT NULL
  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETUTCDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETUTCDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWFactSocial__SocialID_TenantID] 
	   PRIMARY KEY CLUSTERED(SocialID, TenantID)
  , CONSTRAINT [FK_DWFactSocial_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
