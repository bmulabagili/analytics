CREATE TABLE [dbo].[GLReportGrouping]
(
	  GroupID INT NOT NULL 
	, GLCode NVARCHAR(10) NOT NULL
	, Category NVARCHAR(10) NOT NULL -- Revenue or Expense
)
GO 
CREATE CLUSTERED INDEX CIX_GLReportGrouping__GroupID_GLCode
	ON GLReportGrouping(GroupID, GLCode)
