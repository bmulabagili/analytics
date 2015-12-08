CREATE TABLE [Extract].[FocusTenant]
(
    --Source Specific Columns
	 TenantID INT
    , TenantName NVARCHAR(255)
    , ConnectionStringID INT
    , isActive INT

    --ETL Specific Columns
    ,ExecutionID VARCHAR (50)   NOT NULL
    --, ETLActionID INT NOT NULL -- not needed
    , InsertedDateTime DATETIME DEFAULT(GETUTCDATE())
    --, UpdatedDateTime DATETIME DEFAULT(GETUTCDATE()) -- not needed
    --, Hashvalue VNVARCHAR(64) NOT NULL --not needed

)
GO
CREATE INDEX CIX_ExtractFocusTenant__TenantID
    ON [Extract].[FocusTenant](TenantID)

