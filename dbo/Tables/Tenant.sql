CREATE TABLE [dbo].[Tenant] (
      TenantID INT NOT NULL -- not an identity column in DW
    , TenantName NVARCHAR (255) NOT NULL
    , IsActive INT DEFAULT ((0)) NOT NULL -- need to import this when I get back
    , ConnectionStringID INT NULL 
    --the extra columns from the tranactional aren't currently needed

    --ETL Specific Columns
    ,[ExecutionID] VARCHAR (50)   NOT NULL
    --ETLActionID Not needed at this point
    , InsertedDateTime DATETIME DEFAULT(GETUTCDATE())
    , UpdatedDateTime DATETIME DEFAULT(GETUTCDATE())
    , Hashvalue NVARCHAR(64) NOT NULL

    , CONSTRAINT [PK_Tenant__TenantID] 
		PRIMARY KEY CLUSTERED ([TenantID] ASC)
    , CONSTRAINT FK_Tenant_ConnectionString__ConnectionStringID
		FOREIGN KEY (ConnectionStringID)
		REFERENCES ConnectionString(ConnectionStringID)
    --, CONSTRAINT FK_Tenant_SSISPackageExecutionLog
);


