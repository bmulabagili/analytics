CREATE PROCEDURE [DW].[usp_Dashboard-ActualVBudgetedRevenue]
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
			, SUM(FactRevenue.Amount) AS Amount
		FROM dw.FactRevenue
		INNER JOIN dw.DimDate
			ON FactRevenue.DateID = DimDate.DateID
		INNER JOIN dw.DimEntity
			ON FactRevenue.EntityID = DimEntity.EntityID
			AND FactRevenue.TenantID = DimEntity.TenantID
		INNER JOIN dw.DimFinancialCategory
			ON FactRevenue.FinancialCategoryID = DimFinancialCategory.FinancialCategoryID
			AND FactRevenue.TenantID = DimFinancialCategory.TenantID
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
			  FactBudgetRevenue.BudgetYear AS CalendarYear
			, FactBudgetRevenue.BudgetMonth AS CalendarMonth
			, DimEntity.Code AS EntityCode
			, SUM(FactBudgetRevenue.Amount) AS Amount
		FROM dw.FactBudgetRevenue
		INNER JOIN dw.DimEntity
			ON FactBudgetRevenue.EntityID = DimEntity.EntityID
			AND FactBudgetRevenue.TenantID = DimEntity.TenantID
		INNER JOIN dw.DimFinancialCategory
			ON FactBudgetRevenue.FinancialCategoryID = DimFinancialCategory.FinancialCategoryID
			AND FactBudgetRevenue.TenantID = DimFinancialCategory.TenantID
		INNER JOIN Calendar
			ON FactBudgetRevenue.BudgetYear = Calendar.CalendarYear
			AND FactBudgetRevenue.BudgetMonth = Calendar.CalendarMonth
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
			FactBudgetRevenue.BudgetYear
			, FactBudgetRevenue.BudgetMonth
			, DimEntity.Code
	)
	SELECT 
		  ROW_NUMBER() OVER (ORDER BY 
			  ISNULL(Actuals.EntityCode, Budgeted.EntityCode)
			, ISNULL(Actuals.CalendarYear, Budgeted.CalendarYear)
			, ISNULL(Actuals.CalendarMonth, Budgeted.CalendarMonth) ) AS RowNum
		,  ISNULL(Actuals.EntityCode, Budgeted.EntityCode) AS EntityCode
		, ISNULL(Actuals.CalendarYear, Budgeted.CalendarYear) AS CalendarYear
		, ISNULL(Actuals.CalendarMonth, Budgeted.CalendarMonth) AS CalendarMonth
		, SUM(ISNULL(Budgeted.Amount, 0)) AS BudgetAmount
		, SUM(ISNULL(Actuals.Amount, 0)) AS ActualAmount
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
