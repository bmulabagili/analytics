CREATE PROCEDURE [DW].[usp_Dashboard-ActualRevenueVActualExpense]
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
	), ActualRevenue AS (
		SELECT 
			  DimDate.CalendarYear
			, DimDate.CalendarMonth
			, DimEntity.Code AS EntityCode
			, SUM(FactRevenue.Amount) AS Amount
		FROM DW.FactRevenue
		INNER JOIN DW.DimDate
			ON FactRevenue.DateID = DimDate.DateID
		INNER JOIN DW.DimEntity
			ON FactRevenue.EntityID = DimEntity.EntityID
			AND FactRevenue.TenantID = DimEntity.TenantID
		INNER JOIN DW.DimFinancialCategory
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
	), ActualExpense AS (
		SELECT 
			  DimDate.CalendarYear
			, DimDate.CalendarMonth
			, DimEntity.Code AS EntityCode
			, SUM(FactExpense.Amount) AS Amount
		FROM DW.FactExpense
		INNER JOIN DW.DimDate
			ON FactExpense.DateID = DimDate.DateID
		INNER JOIN DW.DimEntity
			ON FactExpense.EntityID = DimEntity.EntityID
			AND FactExpense.TenantID = DimEntity.TenantID
		INNER JOIN DW.DimFinancialCategory
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
	SELECT 
	      ROW_NUMBER() OVER (ORDER BY 
			  ISNULL(ActualRevenue.EntityCode, ActualExpense.EntityCode)
			, ISNULL(ActualRevenue.CalendarYear, ActualExpense.CalendarYear)
			, ISNULL(ActualRevenue.CalendarMonth, ActualExpense.CalendarMonth) ) AS RowNum
		, ISNULL(ActualRevenue.EntityCode, ActualExpense.EntityCode) AS EntityCode
		, ISNULL(ActualRevenue.CalendarYear, ActualExpense.CalendarYear) AS CalendarYear
		, ISNULL(ActualRevenue.CalendarMonth, ActualExpense.CalendarMonth) AS CalendarMonth
		, SUM(ISNULL(ActualRevenue.Amount, 0)) AS ActualRevenue
		, SUM(ISNULL(ActualExpense.Amount, 0)) AS ActualExpense
	FROM ActualRevenue
	FULL OUTER JOIN ActualExpense
		ON ActualRevenue.EntityCode = ActualExpense.EntityCode
		AND ActualRevenue.CalendarMonth = ActualExpense.CalendarMonth
		AND ActualRevenue.CalendarYear = ActualExpense.CalendarYear
	GROUP BY
		  ISNULL(ActualRevenue.EntityCode, ActualExpense.EntityCode)
		, ISNULL(ActualRevenue.CalendarYear, ActualExpense.CalendarYear)
		, ISNULL(ActualRevenue.CalendarMonth, ActualExpense.CalendarMonth) 
	ORDER BY 
		1,2,3	

	RETURN 0
