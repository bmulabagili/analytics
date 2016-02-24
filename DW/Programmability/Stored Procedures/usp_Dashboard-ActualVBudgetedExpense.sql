CREATE PROCEDURE [DW].[usp_Dashboard-ActualVBudgetedExpense]
	  @StartCalendarMonth INT  
	, @StartCalendarYear INT 
	, @NumberOfMonths INT 
	, @EntityCSVList NVARCHAR(20) 
AS

	WITH Calendar AS (
		SELECT DISTINCT TOP (@NumberOfMonths) 
			  CalendarYear	
			, CalendarMonth
		FROM DW.DimDate
		WHERE
			ActualDate >= CONVERT(DATE, CONVERT(VARCHAR(2), @StartCalendarMonth) + '/1/' +  CONVERT(VARCHAR(4), @StartCalendarYear) )
	), Actuals AS (
		SELECT 
			  DimDate.CalendarYear
			, DimDate.CalendarMonth
			, DimEntity.Code AS EntityCode
			, SUM(FactExpense.Amount) AS Amount
		FROM dw.FactExpense
		INNER JOIN dw.DimDate
			ON FactExpense.DateID = DimDate.DateID
		INNER JOIN dw.DimEntity
			ON FactExpense.EntityID = DimEntity.EntityID
			AND FactExpense.TenantID = DimEntity.TenantID
		INNER JOIN dw.DimFinancialCategory
			ON FactExpense.FinancialCategoryID = DimFinancialCategory.FinancialCategoryID
			AND FactExpense.TenantID = DimFinancialCategory.TenantID
		INNER JOIN Calendar
			ON DimDate.CalendarYear = Calendar.CalendarYear
			AND DimDate.CalendarMonth = Calendar.CalendarMonth
		WHERE
			(
				DimEntity.Code IN ('HCA')
				OR --HBC only reports fund 025
				(DimEntity.Code = 'HBC' AND DimFinancialCategory.FundCode = '025')
				OR --HBF Is now only fund 025
				(DimEntity.Code = 'HBF' AND DimFinancialCategory.FundCode = '025')
				OR --WITW excludes funds 084 and 088
				(DimEntity.Code = 'WITW' AND DimFinancialCategory.FundCode NOT IN ('084','088') )
			)
			AND DimEntity.Code IN (SELECT Item FROM dbo.fnSplit( @EntityCSVList, ',')) 
		GROUP BY
			  DimDate.CalendarYear
			, DimDate.CalendarMonth
			, DimEntity.Code
	)
	, Budgeted AS (
		SELECT 
			  FactBudgetExpense.BudgetYear AS CalendarYear
			, FactBudgetExpense.BudgetMonth AS CalendarMonth
			, DimEntity.Code AS EntityCode
			, SUM(FactBudgetExpense.Amount) AS Amount
		FROM dw.FactBudgetExpense
		INNER JOIN dw.DimEntity
			ON FactBudgetExpense.EntityID = DimEntity.EntityID
			AND FactBudgetExpense.TenantID = DimEntity.TenantID
		INNER JOIN dw.DimFinancialCategory
			ON FactBudgetExpense.FinancialCategoryID = DimFinancialCategory.FinancialCategoryID
			AND FactBudgetExpense.TenantID = DimFinancialCategory.TenantID
		INNER JOIN Calendar
			ON FactBudgetExpense.BudgetYear = Calendar.CalendarYear
			AND FactBudgetExpense.BudgetMonth = Calendar.CalendarMonth
		WHERE
			(
				DimEntity.Code IN ('HCA')
				OR --HBC only reports fund 025
				(DimEntity.Code = 'HBC' AND DimFinancialCategory.FundCode = '025')
				OR --HBF Is now only fund 025
				(DimEntity.Code = 'HBF' AND DimFinancialCategory.FundCode = '025')
				OR --WITW excludes funds 084 and 088
				(DimEntity.Code = 'WITW' AND DimFinancialCategory.FundCode NOT IN ('084','088') )
			)
			AND DimEntity.Code IN (SELECT Item FROM dbo.fnSplit( @EntityCSVList, ','))
		GROUP BY
			FactBudgetExpense.BudgetYear
			, FactBudgetExpense.BudgetMonth
			, DimEntity.Code
	)
	SELECT 
		  ISNULL(Actuals.EntityCode, Budgeted.EntityCode) AS EntityCode
		, ISNULL(Actuals.CalendarYear, Budgeted.CalendarYear) AS CalendarYear
		, ISNULL(Actuals.CalendarMonth, Budgeted.CalendarMonth) AS CalendarMonth
		, SUM(ISNULL(Budgeted.Amount, 0)) AS BudgetAmount
		, SUM(ISNULL(Actuals.Amount, 0)) AS AcutalAmount
	FROM Actuals
	FULL OUTER JOIN Budgeted
		ON Actuals.EntityCode = Budgeted.EntityCode
	GROUP BY
		  ISNULL(Actuals.EntityCode, Budgeted.EntityCode)
		, ISNULL(Actuals.CalendarYear, Budgeted.CalendarYear)
		, ISNULL(Actuals.CalendarMonth, Budgeted.CalendarMonth) 
	ORDER BY 
		1,2,3
	

	RETURN 0
