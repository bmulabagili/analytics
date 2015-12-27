CREATE TABLE [DW].[DimCampus](
    [CampusID]         INT NOT NULL
  , [TenantID]         INT NOT NULL
  , [Code]             NVARCHAR(255) NOT NULL
  , [Name]             NVARCHAR(255) NOT NULL
  , Zipcode            INT NULL
  , Latitude		   FLOAT NULL
  , Longitude		   FLOAT NULL
  , LocationGeographgy GEOGRAPHY NULL
  , [StartDateTime]    DATETIME NOT NULL
  , [EndDateTime]      DATETIME NULL
  , [Active]           BIT NOT NULL

  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETUTCDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETUTCDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWDimCampus__CampusID_TenantID] PRIMARY KEY CLUSTERED([CampusID], TenantID)
  , CONSTRAINT [FK_DWDimCampus_Tenant__TenantID] FOREIGN KEY([TenantID]) REFERENCES [dbo].[Tenant](
                                                                                    [TenantID])
);
GO