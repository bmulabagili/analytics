CREATE TABLE [dbo].[CampusXLTReportGroup]
(
	  CampusXLTReportGroupID INT NOT NULL 
	, Heading NVARCHAR(255)
	, Detail NVARCHAR(255)
	, Manager NVARCHAR(255)

	, CONSTRAINT PK_CampusXLTReportGroup__CampusXLTReportGroupID
		PRIMARY KEY(CampusXLTReportGroupID)
)
