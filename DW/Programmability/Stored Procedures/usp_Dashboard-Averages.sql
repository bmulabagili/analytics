CREATE PROCEDURE [dbo].[usp_Dashboard-Averages]
AS
	WITH WeeklyGiving AS (
		SELECT
			  DimDate.CalendarYear
			, COUNT(DISTINCT DimDate.CalendarWeek) AS WeekCount
			, SUM(FactRevenue.Amount) AS Amount
			, SUM(FactRevenue.Amount) / COUNT(DISTINCT DimDate.CalendarWeek) AS AverageWeeklyGiving
		FROM DW.FactRevenue
		INNER JOIN DW.DimFinancialCategory
			ON FactRevenue.FinancialCategoryID = DimFinancialCategory.FinancialCategoryID
		INNER JOIN DW.DimDate
			ON FactRevenue.DateID = DimDate.DateID
		WHERE
			DimFinancialCategory.EntityCode = 'HBC'
			AND GLName IN ('CN Income-General Of', 'CN Income-General Offering')
			AND DimDate.CalendarYear >= YEAR(GETDATE()) - 1
		GROUP BY
			  DimDate.CalendarYear
	), WeeklyAdultAttendance AS (
		SELECT 
			  CalendarYear
			, COUNT(DISTINCT DimDate.CalendarWeek) AS WeekCount
			, SUM(AttendanceCount) AS AttendanceCount
			, SUM(AttendanceCount) / COUNT(DISTINCT DimDate.CalendarWeek) AS AverageWeeklyAdultAttendance
		FROM DW.FactAttendance 
		INNER JOIN DW.DimActivity
			ON FactAttendance.ActivityID = DimActivity.ActivityID
		INNER JOIN DW.DimDate
			ON FactAttendance.InstanceDateID = DimDate.DateID
		WHERE
			DimDate.CalendarYear >= YEAR(GETDATE()) - 1
			AND DimActivity.Name LIKE '%Worship%' -- FROM HBC Lag Definition
		GROUP BY
			  CalendarYear
	)
	SELECT 
		  WeeklyGiving.CalendarYear
		, AverageWeeklyGiving
		, AverageWeeklyAdultAttendance
		, AverageWeeklyGiving / AverageWeeklyAdultAttendance AS WeeklyGivingPerAdult
	FROM WeeklyGiving
	INNER JOIN 	WeeklyAdultAttendance
		ON 	WeeklyGiving.CalendarYear = WeeklyAdultAttendance.CalendarYear
