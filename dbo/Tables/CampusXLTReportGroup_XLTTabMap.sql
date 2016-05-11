CREATE TABLE [dbo].[CampusXLTReportGroup_XLTTabMap]
(
	  FinancialCategoryID INT
	, CampusXLTReportGroupID INT
)
GO
CREATE CLUSTERED INDEX CampusXLTReportGroupXLTTabMap__FinancialCategoryID_CampusXLTReportGroupID
	ON CampusXLTReportGroup_XLTTabMap(FinancialCategoryID, CampusXLTReportGroupID)

