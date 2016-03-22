CREATE PROCEDURE [dbo].[usp_Dashboard-WeeklyBudget]
AS
	

WITH Actuals AS (
	SELECT 
		SUM(FactExpense.Amount) AS Amount
	FROM dw.FactExpense
	INNER JOIN dw.DimDate
		ON FactExpense.DateID = DimDate.DateID
	INNER JOIN dw.DimEntity
		ON FactExpense.EntityID = DimEntity.EntityID
		AND FactExpense.TenantID = DimEntity.TenantID
	INNER JOIN dw.DimFinancialCategory
		ON FactExpense.FinancialCategoryID = DimFinancialCategory.FinancialCategoryID
		AND FactExpense.TenantID = DimFinancialCategory.TenantID
	WHERE
		DimEntity.Code = 'HBC' 
		AND DimFinancialCategory.FundCode = '025'
		AND DimDate.Calendaryear = YEAR(GETDATE())
), CurrentMonthActuals AS (
	SELECT 
		SUM(FactExpense.Amount) AS Amount
	FROM dw.FactExpense
	INNER JOIN dw.DimDate
		ON FactExpense.DateID = DimDate.DateID
	INNER JOIN dw.DimEntity
		ON FactExpense.EntityID = DimEntity.EntityID
		AND FactExpense.TenantID = DimEntity.TenantID
	INNER JOIN dw.DimFinancialCategory
		ON FactExpense.FinancialCategoryID = DimFinancialCategory.FinancialCategoryID
		AND FactExpense.TenantID = DimFinancialCategory.TenantID
	WHERE
		DimEntity.Code = 'HBC' 
		AND DimFinancialCategory.FundCode = '025'
		AND DimDate.Calendaryear = YEAR(GETDATE())
		AND DimDate.CalendarMonth = MONTH(GETDATE())
	) 
	, Budgeted AS (
	SELECT 
		SUM(FactBudgetExpense.Amount) AS Amount
	FROM dw.FactBudgetExpense
	INNER JOIN dw.DimEntity
		ON FactBudgetExpense.EntityID = DimEntity.EntityID
		AND FactBudgetExpense.TenantID = DimEntity.TenantID
	INNER JOIN dw.DimFinancialCategory
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
	