CREATE TABLE [dbo].[CampusXLTReportGroup_CampusTabMap]
(
	  FinancialCategoryID INT
	, CampusReportGroupID INT
)
GO
CREATE CLUSTERED INDEX CampusXLTReportGroupCampusTabMap__FinancialCategoryID_CampusReportGroupID
	ON CampusXLTReportGroup_CampusTabMap(FinancialCategoryID, CampusReportGroupID)

