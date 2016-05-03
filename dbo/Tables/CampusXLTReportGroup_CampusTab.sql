CREATE TABLE [dbo].[CampusXLTReportGroup_CampusTab]
(
	  CampusXLTReportGroupID INT NOT NULL 
	  --for the campus tab
	, CampusHeading NVARCHAR(255)
	, CampusDetail NVARCHAR(255)
	, CampusDetailSortOrder INT
	, CampusCode NVARCHAR(255)
	, CampusCodeSortOrder INT
	, AllocateByAttendancePercentage BIT

	, CONSTRAINT PK_CampusXLTReportGroupCampusTab__CampusXLTReportGroupID
		PRIMARY KEY(CampusXLTReportGroupID)
)
