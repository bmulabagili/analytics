CREATE TABLE [dbo].Paycor_MIP_Mapping
(
	  GLOrgCode			NVARCHAR(255)
	, GLAccountNumber   NVARCHAR(255)
	, GLCode			NVARCHAR(20)
	, FundCode			NVARCHAR(20)
	, EntityCode		NVARCHAR(20)
	, CampusCode		NVARCHAR(20)
	, CategoryCode		NVARCHAR(20)
	, AccountingCode9	NVARCHAR(20)
	, AccountingName9	NVARCHAR(100)

	, CONSTRAINT PK_PaycorMIPMapping__GLOrgCode_GLAccountNumber
		PRIMARY KEY (GLOrgCode, GLAccountNumber)

)
