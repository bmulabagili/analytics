CREATE TABLE [DW].[DimSmallGroupDetail]
(
      SmallGroupDetailID INT NOT NULL
    , TenantID INT NOT NULL
    , CampusID INT NULL
    , GroupType NVARCHAR(255) NULL
    , GroupName NVARCHAR(255) NOT NULL
    , ZipCode INT NULL
    , Latitude FLOAT NULL
    , Longitude FLOAT NULL
    , LocationGeography GEOGRAPHY NULL
    , StartDateTime    DATETIME NOT NULL
    , EndDateTime      DATETIME NULL
    , Active           BIT NOT NULL 

  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWDimSmallGroupDetail__SmallGroupDetailID_TenantID] 
	   PRIMARY KEY CLUSTERED(SmallGroupDetailID, TenantID)
  , CONSTRAINT [FK_DWDimSmallGroup_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
