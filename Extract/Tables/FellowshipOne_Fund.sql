CREATE TABLE [Extract].[FellowshipOne_Fund]
(
    --Source Specific Columns
	 FundID INT NOT NULL 
    , TenantID INT
    , Name NVARCHAR(255)
    , FundTypeID INT
    , FundTypeName NVARCHAR(255)
    , FundCode NVARCHAR(255)
    , IsWebEnabled BIT
    , AccountReferenceID NVARCHAR(255)
    , IsActive BIT
    , CreatedDateTime DATETIME
    , LastUpdateDateTime DATETIME
    
	--ETL Specific Columns
    , ExecutionID VARCHAR (50)   NOT NULL
    --, ETLActionID INT NOT NULL -- not needed
    , InsertedDateTime DATETIME DEFAULT(GETUTCDATE())
    --, UpdatedDateTime DATETIME DEFAULT(GETUTCDATE()) -- not needed
    --, Hashvalue VNVARCHAR(64) NOT NULL --not needed

)
GO
CREATE CLUSTERED INDEX CIX_ExtractFellowshipOneFund__FundID_TenantID
    ON [Extract].FellowshipOne_Fund(FundID, TenantID)

