CREATE PROCEDURE [dbo].[usp_Dashboard-WeeklyBudget]
AS
	

WITH Actuals AS (
	SELECT 
		SUM(FactExpense.Amount) AS Amount
	FROM DW.FactExpense
	INNER JOIN DW.DimDate
		ON FactExpense.DateID = DimDate.DateID
	INNER JOIN DW.DimEntity
		ON FactExpense.EntityID = DimEntity.EntityID
		AND FactExpense.TenantID = DimEntity.TenantID
	INNER JOIN DW.DimFinancialCategory
		ON FactExpense.FinancialCategoryID = DimFinancialCategory.FinancialCategoryID
		AND FactExpense.TenantID = DimFinancialCategory.TenantID
	WHERE
		DimEntity.Code = 'HBC' 
		AND DimFinancialCategory.FundCode = '025'
		AND DimDate.CalendarYear = YEAR(GETDATE())
), CurrentMonthActuals AS (
	SELECT 
		SUM(FactExpense.Amount) AS Amount
	FROM DW.FactExpense
	INNER JOIN DW.DimDate
		ON FactExpense.DateID = DimDate.DateID
	INNER JOIN DW.DimEntity
		ON FactExpense.EntityID = DimEntity.EntityID
		AND FactExpense.TenantID = DimEntity.TenantID
	INNER JOIN DW.DimFinancialCategory
		ON FactExpense.FinancialCategoryID = DimFinancialCategory.FinancialCategoryID
		AND FactExpense.TenantID = DimFinancialCategory.TenantID
	WHERE
		DimEntity.Code = 'HBC' 
		AND DimFinancialCategory.FundCode = '025'
		AND DimDate.CalendarYear = YEAR(GETDATE())
		AND DimDate.CalendarMonth = MONTH(GETDATE())
	) 
	, Budgeted AS (
	SELECT 
		SUM(FactBudgetExpense.Amount) AS Amount
	FROM DW.FactBudgetExpense
	INNER JOIN DW.DimEntity
		ON FactBudgetExpense.EntityID = DimEntity.EntityID
		AND FactBudgetExpense.TenantID = DimEntity.TenantID
	INNER JOIN DW.DimFinancialCategory
		ON FactBudgetExpense.FinancialCategoryID = DimFinancialCategory.FinancialCategoryID
		AND FactBudgetExpense.TenantID = DimFinancialCategory.TenantID
	WHERE
		DimEntity.Code = 'HBC' 
		AND DimFinancialCategory.FundCode = '025'
		AND BudgetYear = YEAR(GETDATE())
)
	SELECT 
		  Budgeted.Amount / 52 AS WeeklyBudgetAmount
		, Actuals.Amount / (SELECT COUNT(DISTINCT CalendarWeek) FROM DW.DimDate WHERE ActualDate <= GETDATE())  AS YTDBurnAmount
		, (Budgeted.Amount / 52) - (Actuals.Amount / (SELECT COUNT(DISTINCT CalendarWeek) FROM DW.DimDate WHERE ActualDate <= GETDATE())) SurplusAmount
		, CurrentMonthActuals.Amount AS CurrentMonthBurn
	FROM Actuals, Budgeted, CurrentMonthActuals
	