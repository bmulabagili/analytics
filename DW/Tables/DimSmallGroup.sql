CREATE TABLE [DW].[DimSmallGroup]
(
      SmallGroupID INT NOT NULL
    , TenantID INT NOT NULL
    , CampusID INT NULL
    , GroupType NVARCHAR(255) NULL
    , GroupName NVARCHAR(255) NOT NULL
    , ZipCode INT NULL
    , Latitude FLOAT NULL
    , Longitude FLOAT NULL
    , LocationGeography GEOGRAPHY NULL
    

  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETUTCDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETUTCDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWDimSmallGroup__SmallGroupID_TenantID] 
	   PRIMARY KEY CLUSTERED(SmallGroupID, TenantID)
  , CONSTRAINT [FK_DWDimSmallGroup_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
