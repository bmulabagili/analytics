CREATE PROCEDURE [DW].[usp_Dashboard-Contributions]
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
		, ISNULL(GroupID, 3) AS GroupID
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
	LEFT JOIN GLReportGrouping glrg --Check out the ones that DON'T map!
		ON DimFinancialCategory.GLCode = glrg.GLCode
		AND glrg.Category = 'Revenue'
		AND DimEntity.Code = glrg.EntityCode 
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
		, ISNULL(GroupID, 3)
)
SELECT
	  CalendarYear
	, CalendarMonth
	, EntityCode
	, SUM(Amount) Amount
FROM ActualRevenue
WHERE
	GroupID = 1 --WHEN 1 THEN 'Unrestricted Donations'
			    --WHEN 2 THEN 'Restricted Donations'
GROUP BY
	CalendarYear
	, CalendarMonth
	, EntityCode
ORDER BY
	1,2
;

	RETURN 0
