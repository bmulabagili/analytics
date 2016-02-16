CREATE TABLE [dbo].Paycor_MIP_Mapping
(
	  GLOrgCode			NVARCHAR(255)
	, CampusCode		NVARCHAR(20)
	, AccountingCode9	NVARCHAR(20)
	, AccountingName9	NVARCHAR(100)

	, CONSTRAINT PK_PaycorMIPMapping__GLOrgCode_GLAccountNumber
		PRIMARY KEY (GLOrgCode)

)
