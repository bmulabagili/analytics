CREATE TABLE [Extract].[FellowshipOne_ContributionType](
    --Source Specific Columns
    ContributionTypeID INT NOT NULL
  , TenantID           INT NOT NULL
  , Name               NVARCHAR(255) NOT NULL

    --ETL Specific Columns
  , ExecutionID        VARCHAR(50) NOT NULL
    --, ETLActionID INT NOT NULL -- not needed
  , InsertedDateTime   DATETIME DEFAULT(GETUTCDATE())
--, UpdatedDateTime DATETIME DEFAULT(GETUTCDATE()) -- not needed
--, Hashvalue VNVARCHAR(64) NOT NULL --not needed


    
);
GO

CREATE CLUSTERED INDEX CIX_Extractf1ContributionType__ContributionTypeID_TenantID ON [Extract].[FellowshipOne_ContributionType](ContributionTypeID, TenantID);