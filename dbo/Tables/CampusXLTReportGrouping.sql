CREATE TABLE [dbo].[CampusXLTReportGroupMap]
(
	  FinancialCategoryID INT
	, CampusXLTReportGroupID INT
)
GO
CREATE CLUSTERED INDEX CampusXLTReportGroupMap__FinancialCategoryID_CampusXLTReportGroupID
	ON CampusXLTReportGroupMap(FinancialCategoryID, CampusXLTReportGroupID)

