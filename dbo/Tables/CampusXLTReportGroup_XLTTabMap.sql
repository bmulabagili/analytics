CREATE TABLE [dbo].[CampusXLTReportGroup_XLTTabMap]
(
	  FinancialCategoryID INT
	, XLTReportGroupID INT
)
GO
CREATE CLUSTERED INDEX CampusXLTReportGroupXLTTabMap__FinancialCategoryID_XLTReportGroupID
	ON CampusXLTReportGroup_XLTTabMap(FinancialCategoryID, XLTReportGroupID)

