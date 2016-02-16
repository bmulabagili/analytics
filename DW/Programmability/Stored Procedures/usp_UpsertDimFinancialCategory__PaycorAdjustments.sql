CREATE PROCEDURE [DW].[usp_UpsertDimFinancialCategory__PaycorAdjustments]
AS
	BEGIN TRAN
--Parameters
DECLARE @CalendarMonth INT = 12
	, @CalendarYear INT = 2015

--Internal Variables
DECLARE @MonthlyMIPCompensationTotal DECIMAL(9,2)
	,  @MonthlyPaycorTotal DECIMAL(9,2)
	, @LastDayOfMonthDateID INT
	, @MaxFactExpenseID INT;

DECLARE @insertedExpenses TABLE (ExpenseID INT, TenantID INT)

SELECT @LastDayOfMonthDateID = MAX(DateID)
FROM DW.DimDate
WHERE 
	DimDate.CalendarMonth = @CalendarMonth
	AND DimDate.CalendarYear = @CalendarYear
	
--SELECT @LastDayOfMonthDateID
select @MaxFactExpenseID = MAX(ExpenseID) from dw.FactExpense;

SELECT @MonthlyMIPCompensationTotal = SUM(Amount)
FROM DW.FactExpense
INNER JOIN DW.DimEntity
	ON FactExpense.EntityID = DimEntity.EntityID
	AND FactExpense.TenantID = DimEntity.TenantID
INNER JOIN DW.DimFinancialCategory
	ON FactExpense.FinancialCategoryID = DimFinancialCategory.FinancialCategoryID
	AND FactExpense.TenantID = DimFinancialCategory.TenantID
INNER JOIN DW.DimDate
	ON FactExpense.DateID = DimDate.DateID
--also include the EFS mapping
INNER JOIN dbo.GLReportGrouping
	ON DimFinancialCategory.GLCode = GLReportGrouping.GLCode
	AND DimFinancialCategory.EntityCode = GLReportGrouping.EntityCode
	AND GLReportGrouping.Category = 'Expense'
WHERE
	DimEntity.Code = 'HBC'
	AND FundCode = '025'
	AND DimFinancialCategory.CategoryName = 'Personnel'
	AND GLReportGrouping.GroupID = 1 --Personnel
	AND DimDate.CalendarMonth = @CalendarMonth
	AND DimDate.CalendarYear = @CalendarYear;

SELECT @MonthlyPaycorTotal = 
SUM(CONVERT(DECIMAL(9,2), ISNULL(REPLACE(DebitAmount,',',''), 0)) - CONVERT(DECIMAL(9,2), ISNULL(REPLACE(CreditAmount,',',''), 0)))
FROM Extract.Paycor
LEFT JOIN Paycor_MIP_Mapping
	ON Paycor.GLOrgCode = Paycor_MIP_Mapping.GLOrgCode
WHERE
	LTRIM(RTRIM(Paycor.GLOrgCode)) IN (
		  '11002004', '11001004', '11004004', '18999000', '21999000', '11002000', '11002001', '11002002'
		, '11002003', '11001000', '11001001', '11001002', '11001003', '27999000', '11003000', '11003001'
		, '11003003', '11004000', '11004002', '11006000', '11006003', '11005000', '11005001', '11005002'
		, '11005003', '11007000', '28999000', '5221025' , '17999000', '23999000', '26999000', '20999000'
		, '18999000', '19999026', '19999027', '19999028', '15999000')
	and LTRIM(RTRIM(Paycor.GLAccountNumber)) IN (
		  '025-CS-PER1-4016-40013'
		, '025-CS-PER1-4016-40090'
		, '11')

--SELECT 
--	  @MonthlyMIPCompensationTotal AS MIPCompensationTotal
--	, @MonthlyPaycorTotal AS PaycorTotal
--	, @MonthlyMIPCompensationTotal - @MonthlyPaycorTotal AS TargetMIPAfterAdjustment
--	, @MaxFactExpenseID AS MaxFactExpenseID
--1,056,281.15 - 942,620.60 = 113,660.55

INSERT INTO DW.FactExpense
(ExpenseID, TenantID, DateID, EntityID, FinancialCategoryID, CampusID, Amount, ExecutionID, InsertedDateTime, UpdatedDateTime,	Hashvalue)
OUTPUT inserted.ExpenseID, inserted.TenantID
INTO @insertedExpenses
SELECT
	ROW_NUMBER() OVER (PARTITION BY FactExpense.TenantID ORDER BY  FactExpense.EntityID, (@MonthlyPaycorTotal * -1)  * (SUM(Amount) / @MonthlyMIPCompensationTotal)) + @MaxFactExpenseID
	, FactExpense.TenantID
    , @LastDayOfMonthDateID AS DateID
	, FactExpense.EntityID
	--, DimFinancialCategory.FundCode 
	--, DimFinancialCategory.GLCode
	--, DimFinancialCategory.GLName
	, MIN(DimFinancialCategory.FinancialCategoryID) AS FinancialCategoryID
	, -1 AS CampusID -- just for the factExpense record... Look at the DIM
	--, SUM(Amount) AS Expense 
	--, SUM(Amount) / @MonthlyMIPCompensationTotal AS CompensationPercent
	-- The adjustment amount should be in proportion to the glcode's percent of total comp expenses,
	, (@MonthlyPaycorTotal * -1)  * (SUM(Amount) / @MonthlyMIPCompensationTotal) AS Amount
	, 'Paycor Adjustment' AS ExecutionID
	, GETDATE() AS InsertedDateTime
	, GETDATE() AS UpdatedDateTime
	, '' AS Hashvalue
FROM DW.FactExpense
INNER JOIN DW.DimEntity
	ON FactExpense.EntityID = DimEntity.EntityID
	AND FactExpense.TenantID = DimEntity.TenantID
INNER JOIN DW.DimFinancialCategory
	ON FactExpense.FinancialCategoryID = DimFinancialCategory.FinancialCategoryID
	AND FactExpense.TenantID = DimFinancialCategory.TenantID
	AND FactExpense.EntityID = DimFinancialCategory.EntityID
--also include the EFS mapping
INNER JOIN dbo.GLReportGrouping
	ON DimFinancialCategory.GLCode = GLReportGrouping.GLCode
	AND DimFinancialCategory.EntityCode = GLReportGrouping.EntityCode
	AND GLReportGrouping.Category = 'Expense'
INNER JOIN DW.DimDate
	ON FactExpense.DateID = DimDate.DateID
WHERE
	DimEntity.Code = 'HBC'
	AND FundCode = '025'
	AND DimFinancialCategory.CategoryName = 'Personnel'
	AND GLReportGrouping.GroupID = 1 --Personnel
	AND DimDate.CalendarMonth = @CalendarMonth
	AND DimDate.CalendarYear = @CalendarYear
GROUP BY
	  FactExpense.TenantID
    , FactExpense.EntityID
	, DimFinancialCategory.FundCode 
	, DimFinancialCategory.GLCode
	, DimFinancialCategory.GLName

--SELECT  SUM(Amount) AS AdjustedPayrollTotal
--FROM DW.FactExpense
--INNER JOIN DW.DimEntity
--	ON FactExpense.EntityID = DimEntity.EntityID
--	AND FactExpense.TenantID = DimEntity.TenantID
--INNER JOIN DW.DimFinancialCategory
--	ON FactExpense.FinancialCategoryID = DimFinancialCategory.FinancialCategoryID
--	AND FactExpense.TenantID = DimFinancialCategory.TenantID
--INNER JOIN DW.DimDate
--	ON FactExpense.DateID = DimDate.DateID
----also include the EFS mapping
--INNER JOIN dbo.GLReportGrouping
--	ON DimFinancialCategory.GLCode = GLReportGrouping.GLCode
--	AND DimFinancialCategory.EntityCode = GLReportGrouping.EntityCode
--	AND GLReportGrouping.Category = 'Expense'
--WHERE
--	DimEntity.Code = 'HBC'
--	AND FundCode = '025'
--	AND DimFinancialCategory.CategoryName = 'Personnel'
--	AND GLReportGrouping.GroupID = 1 --Personnel
--	AND DimDate.CalendarMonth = @CalendarMonth
--	AND DimDate.CalendarYear = @CalendarYear


--fix campusid
UPDATE FactExpense SET
	FactExpense.CampusID = DimCampus.CampusID
FROM DW.FactExpense
INNER JOIN @insertedExpenses ie
	ON FactExpense.ExpenseID = ie.ExpenseID
	AND FactExpense.TenantID = ie.TenantID
INNER JOIN DW.DimFinancialCategory
	ON FactExpense.FinancialCategoryID = DimFinancialCategory.FinancialCategoryID
	AND FactExpense.TenantID = DimFinancialCategory.TenantID
INNER JOIN DW.DimCampus
	ON DimFinancialCategory.CampusCode = DimCampus.Code
	AND DimFinancialCategory.TenantID = DimCampus.TenantID

--SELECT FactExpense.*
--FROM DW.FactExpense
--INNER JOIN @insertedExpenses ie
--	ON FactExpense.ExpenseID = ie.ExpenseID
--	AND FactExpense.TenantID = ie.TenantID


--update the max id again (we're going to put more rows in )
select @MaxFactExpenseID = MAX(ExpenseID) from dw.FactExpense;

--INSERT Paycor values
INSERT INTO DW.FactExpense
SELECT 
	ROW_NUMBER() OVER (ORDER BY  DimFinancialCategory.FinancialCategoryID, ISNULL(DimCampus.CampusID, -1)) + @MaxFactExpenseID
	, 3 AS TenantID
    , @LastDayOfMonthDateID AS DateID
	, 3 AS EntityID
	, DimFinancialCategory.FinancialCategoryID
	, ISNULL(DimCampus.CampusID, -1) AS CampusID
	, SUM(CONVERT(DECIMAL(9,2), ISNULL(REPLACE(DebitAmount,',',''), 0)) - CONVERT(DECIMAL(9,2), ISNULL(REPLACE(CreditAmount,',',''), 0))) AS Amount
	, 'Paycor Adjustment' AS ExecutionID
	, GETDATE() AS InsertedDateTime
	, GETDATE() AS UpdatedDateTime
	, '' AS Hashvalue
FROM Extract.Paycor
INNER JOIN Paycor_MIP_Mapping
	ON Paycor.GLOrgCode = Paycor_MIP_Mapping.GLOrgCode
INNER JOIN DW.DimFinancialCategory
	ON DimFinancialCategory.TenantID = 3
	AND DimFinancialCategory.GLCode = paycor_MIP_Mapping.GLOrgCode
	AND DimFinancialCategory.GLName = 'Paycor'
	AND DimFinancialCategory.GLType = 'EXP'
	AND Paycor_MIP_Mapping.CampusCode = DimFinancialCategory.CampusCode
	AND Paycor_MIP_Mapping.AccountingCode9 = DimFinancialCategory.AccountingCode9
	AND Paycor_MIP_Mapping.AccountingName9 = DimFinancialCategory.AccountingName9
--also include the EFS mapping
INNER JOIN dbo.GLReportGrouping
	ON DimFinancialCategory.GLCode = GLReportGrouping.GLCode
	AND DimFinancialCategory.EntityCode = GLReportGrouping.EntityCode
	AND GLReportGrouping.Category = 'Expense'
LEFT JOIN DW.DimCampus
	ON Paycor_MIP_Mapping.CampusCode = DimCampus.Code
	AND DimCampus.TenantID = 3
WHERE
	LTRIM(RTRIM(Paycor.GLOrgCode)) IN (
		  '11002004', '11001004', '11004004', '18999000', '21999000', '11002000', '11002001', '11002002'
		, '11002003', '11001000', '11001001', '11001002', '11001003', '27999000', '11003000', '11003001'
		, '11003003', '11004000', '11004002', '11006000', '11006003', '11005000', '11005001', '11005002'
		, '11005003', '11007000', '28999000', '5221025' , '17999000', '23999000', '26999000', '20999000'
		, '18999000', '19999026', '19999027', '19999028', '15999000')
	and LTRIM(RTRIM(Paycor.GLAccountNumber)) IN (
		  '025-CS-PER1-4016-40013'
		, '025-CS-PER1-4016-40090'
		, '11')
	AND GLReportGrouping.GroupID = 1 --Personnel
GROUP BY
	  DimFinancialCategory.FinancialCategoryID
	, ISNULL(DimCampus.CampusID, -1)

--SELECT  SUM(Amount) AS NewMIPCompensationTotal
--FROM DW.FactExpense
--INNER JOIN DW.DimEntity
--	ON FactExpense.EntityID = DimEntity.EntityID
--	AND FactExpense.TenantID = DimEntity.TenantID
--INNER JOIN DW.DimFinancialCategory
--	ON FactExpense.FinancialCategoryID = DimFinancialCategory.FinancialCategoryID
--	AND FactExpense.TenantID = DimFinancialCategory.TenantID
--INNER JOIN DW.DimDate
--	ON FactExpense.DateID = DimDate.DateID
----also include the EFS mapping
--INNER JOIN dbo.GLReportGrouping
--	ON DimFinancialCategory.GLCode = GLReportGrouping.GLCode
--	AND DimFinancialCategory.EntityCode = GLReportGrouping.EntityCode
--	AND GLReportGrouping.Category = 'Expense'
--WHERE
--	DimEntity.Code = 'HBC'
--	AND FundCode = '025'
--	AND DimFinancialCategory.CategoryName = 'Personnel'
--	AND GLReportGrouping.GroupID = 1 --Personnel
--	AND DimDate.CalendarMonth = @CalendarMonth
--	AND DimDate.CalendarYear = @CalendarYear;

--1,056,281.15 - 942,620.60 = 113,660.55

--select distinct DimFinancialCategory.EntityCode, DimFinancialCategory.GLCode, DimFinancialCategory.GLName, DimFinancialCategory.CategoryCode
--	, GLReportGrouping.GroupID
--	, CASE GroupID 
--			WHEN 1 THEN 'Compensation'
--			WHEN 2 THEN 'Allocated Overhead'
--			WHEN 3 THEN 'Admin/IT'
--			WHEN 4 THEN 'Facilities'
--			WHEN 5 THEN 'Ministry Expense'
--			WHEN 6 THEN 'Broadcast Expense'
--			WHEN 7 THEN 'Depreciation and Amortization'
--			ELSE 'Other (less than 5% of Overall expense)' END AS GroupName
--from dw.FactExpense
--INNER JOIN DW.DimFinancialCategory
--	ON FactExpense.FinancialCategoryID = DimFinancialCategory.FinancialCategoryID
--	AND FactExpense.TenantID = DimFinancialCategory.TenantID
--LEFT JOIN GLReportGrouping
--	ON DimFinancialCategory.GLCode = GLReportGrouping.GLCode
--	AND DimFinancialCategory.EntityCode = GLReportGrouping.EntityCode
--	AND GLReportGrouping.Category = 'expense'
--where factexpense.executionid = 'Paycor Adjustment'
	RETURN 0
