CREATE TABLE [Extract].[Paycor]
(
	  ClientID NVARCHAR(255)
	, ClientName NVARCHAR(255)
	, GLCheckDate NVARCHAR(255)
	, GLOrgDescription NVARCHAR(255)
	, GLOrgCode NVARCHAR(255)
	, GLAccountName NVARCHAR(255)
	, GLAccountNumber NVARCHAR(255)
	, DebitAmount	 NVARCHAR(255)
	, CreditAmount NVARCHAR(255)

	, TenantID          INT NOT NULL
	 --ETL Specific Columns
	, ExecutionID       VARCHAR(50) NOT NULL
	 --, ETLActionID INT NOT NULL -- not needed
	, InsertedDateTime  DATETIME DEFAULT(GETUTCDATE())
	--, UpdatedDateTime DATETIME DEFAULT(GETUTCDATE()) -- not needed
	--, Hashvalue VNVARCHAR(64) NOT NULL --not needed
)
GO
CREATE CLUSTERED INDEX CIX_ExtractPaycor__ExecutionID_TenantID 
ON [Extract].Paycor(ExecutionID, TenantID);

