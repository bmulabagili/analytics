CREATE TABLE [Extract].[FellowshipOne_PledgeDrive]
(
    --Source Specific Columns
	   PledgeDriveID INT
	 , TenantID INT
	 , Name NVARCHAR(255)
	 , StartDateTime DATETIME
	 , EndDateTime DATETIME
	 , Goal FLOAT
	 , FundID INT
	 , FundName NVARCHAR (255)
	 , SubFundID INT
	 , SubFundName NVARCHAR(255)
	 , Iswebactive BIT
	 , CreateDateTime DATETIME
	 , LastUpdatedDateTime DATETIME
    
	--ETL Specific Columns
    , ExecutionID VARCHAR (50)   NOT NULL
    --, ETLActionID INT NOT NULL -- not needed
    , InsertedDateTime DATETIME DEFAULT(GETUTCDATE())
    --, UpdatedDateTime DATETIME DEFAULT(GETUTCDATE()) -- not needed
    --, Hashvalue VNVARCHAR(64) NOT NULL --not needed

)
GO
CREATE CLUSTERED INDEX CIX_ExtractFellowshipOnePledgeDrive__PledgeDriveID_TenantID
    ON [Extract].FellowshipOne_PledgeDrive(PledgeDriveID, TenantID)

