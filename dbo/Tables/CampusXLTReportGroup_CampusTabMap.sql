CREATE TABLE [dbo].[CampusXLTReportGroup_CampusTabMap]
(
	  FinancialCategoryID INT
	, CampusXLTReportGroupID INT
)
GO
CREATE CLUSTERED INDEX CampusXLTReportGroupCampusTabMap__FinancialCategoryID_CampusXLTReportGroupID
	ON CampusXLTReportGroup_CampusTabMap(FinancialCategoryID, CampusXLTReportGroupID)

