CREATE TABLE [dbo].[CampusXLTReportGroup_XLTTab]
(
	  CampusXLTReportGroupID INT NOT NULL 
	--for the xlt tab
	, XLTHeading NVARCHAR(255)
	, XLTDetail NVARCHAR(255)
	, XLTDetailSortOrder INT
	, Manager NVARCHAR(255)
	, ManagerSortOrder INT

	, CONSTRAINT PK_CampusXLTReportGroupXLTTab__CampusXLTReportGroupID
		PRIMARY KEY(CampusXLTReportGroupID)
)
