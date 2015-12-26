CREATE TABLE Transform.[DimCampus](
    [CampusID]         INT NOT NULL
  , [TenantID]         INT NOT NULL
  , [Code]             NVARCHAR(255) NOT NULL
  , [Name]             NVARCHAR(255) NOT NULL
  , Zipcode            INT NULL
  , Latitude           FLOAT NULL
  , Longitude          FLOAT NULL
  , LocationGeographgy GEOGRAPHY NULL
  , [StartDateTime]    DATETIME NOT NULL
  , [EndDateTime]      DATETIME NULL
  , [Active]           BIT NOT NULL

    --ETL Specific Columns
  , ExecutionID        VARCHAR(50) NOT NULL
  , ETLActionID        INT NOT NULL
  , InsertedDateTime   DATETIME DEFAULT(GETUTCDATE())
  , UpdatedDateTime    DATETIME DEFAULT(GETUTCDATE())
  , Hashvalue          NVARCHAR(64) NOT NULL
    
    --Keys should get enforced at this point.

  , CONSTRAINT [pk_DWDimCampus__CampusID] PRIMARY KEY CLUSTERED([CampusID] ASC)
  , CONSTRAINT [FK_DWDimCampus_Tenant__TenantID] FOREIGN KEY([TenantID]) REFERENCES [dbo].[Tenant](
                                                                                    [TenantID])
);
GO