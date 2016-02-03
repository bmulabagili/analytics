CREATE TABLE [dbo].[GoogleImportConfig]
(
	  GoogleImportConfigID INT NOT NULL PRIMARY KEY
	, AccountID NVARCHAR(255)
	, WebProperty NVARCHAR(255)
	, ProfileID NVARCHAR(255)
	, ReportingSection NVARCHAR(255)

)
