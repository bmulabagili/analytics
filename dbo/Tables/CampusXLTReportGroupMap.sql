CREATE TABLE [dbo].[CampusXLTReportGroupMap]
(
	  FinancialCategoryID INT
	, CampusReportGroupID INT
)
GO
CREATE CLUSTERED INDEX CampusXLTReportGroupMap__FinancialCategoryID_CampusReportGroupID
	ON CampusXLTReportGroupMap(FinancialCategoryID, CampusReportGroupID)

