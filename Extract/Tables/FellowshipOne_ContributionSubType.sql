CREATE TABLE [Extract].[FellowshipOne_ContributionSubType](
    --Source Specific Columns
    ContributionSubTypeID INT NOT NULL
  , TenantID              INT NOT NULL
  , Name                  NVARCHAR(255) NOT NULL
  , ContributionTypeID    INT

    --ETL Specific Columns
  , ExecutionID           VARCHAR(50) NOT NULL
    --, ETLActionID INT NOT NULL -- not needed
  , InsertedDateTime      DATETIME DEFAULT(GETUTCDATE())
--, UpdatedDateTime DATETIME DEFAULT(GETUTCDATE()) -- not needed
--, Hashvalue VNVARCHAR(64) NOT NULL --not needed
   
);
GO

CREATE CLUSTERED INDEX CIX_ExtractFellowshipOneContributionSubType__ContributionSubTypeID_TenantID ON [Extract].[FellowshipOne_ContributionSubType](ContributionSubTypeID, TenantID);