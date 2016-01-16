CREATE TABLE [dbo].[GLExpenseGrouping]
(
	  GroupID INT NOT NULL 
	, GLCode NVARCHAR(10) NOT NULL
)
GO 
CREATE CLUSTERED INDEX CIX_GLExpenseGrouping__GroupID_GLCode
	ON GLExpenseGrouping(GroupID, GLCode)
