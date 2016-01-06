CREATE TABLE [Transform].[DimSmallGroupDetail]
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
    , StartDateTime DATETIME NOT NULL DEFAULT('1/1/1900')
    , EndDateTime DATETIME NULL
    , Active BIT NOT NULL DEFAULT(1)

    --ETL Specific Columns
    , ExecutionID        VARCHAR(50) NOT NULL
    , ETLActionID        INT NOT NULL
    , InsertedDateTime   DATETIME DEFAULT(GETUTCDATE())
    , UpdatedDateTime    DATETIME DEFAULT(GETUTCDATE())
    , Hashvalue          NVARCHAR(64) NOT NULL
    
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_TransformDimSmallDetailGroup__SmallGroupDetailID_TenantID] 
	   PRIMARY KEY CLUSTERED(SmallGroupDetailID, TenantID)
  , CONSTRAINT [FK_TransformDimSmallGroup_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);