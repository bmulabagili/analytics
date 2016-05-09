CREATE TABLE [Extract].[FellowshipOne_PersonStatus](
    PersonStatusID   INT NOT NULL
  , TenantID         INT
  , Name             NVARCHAR

    --ETL Specific Columns
  , ExecutionID      VARCHAR(50) NOT NULL
    --, ETLActionID INT NOT NULL -- not needed
  , InsertedDateTime DATETIME DEFAULT(GETDATE())
--, UpdatedDateTime DATETIME DEFAULT(GETDATE()) -- not needed
--, Hashvalue VNVARCHAR(64) NOT NULL --not needed


);
GO

CREATE CLUSTERED INDEX CIX_ExtractFellowshipOnePersonStatus__PersonStatusID_TenantID ON [Extract].FellowshipOne_PersonStatus(PersonStatusID, TenantID);