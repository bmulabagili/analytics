CREATE TABLE [Extract].[f1_SubFund]
(
    --Source Specific Columns
	 SubFundID INT NOT NULL 
    , TenantID INT
    , ParentFundID INT
    , ParentFundName NVARCHAR(255)
    , SubFundName NVARCHAR(255)
    , GeneralLedger NVARCHAR(255)
    , SubFundCode NVARCHAR(255)
    , IsWebEnabled NVARCHAR(255)
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
CREATE CLUSTERED INDEX CIX_Extractf1SubFund__SubFundID_TenantID
    ON [Extract].f1_SubFund(SubFundID, TenantID)

