CREATE PROCEDURE [DW].[usp_Dashboard-HBFChurchPlants]
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
	)
	SELECT
	      ROW_NUMBER() OVER (ORDER BY FactHBFMetric.CalendarYear, FactHBFMetric.CalendarMonth)
		, FactHBFMetric.CalendarYear
		, FactHBFMetric.CalendarMonth
		, SUM(HBFMetricAmount) AS ChurchPlants
	FROM DW.FactHBFMetric
	INNER JOIN Calendar
		ON FactHBFMetric.CalendarYear = Calendar.CalendarYear
		AND FactHBFMetric.CalendarMonth = Calendar.CalendarMonth
	WHERE
		MetricName LIKE 'New Plants%'
	GROUP BY
		  FactHBFMetric.CalendarYear
		, FactHBFMetric.CalendarMonth

	
	
		RETURN 0
