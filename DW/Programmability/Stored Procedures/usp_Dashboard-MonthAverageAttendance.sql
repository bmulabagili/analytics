﻿CREATE PROCEDURE [DW].[usp_Dashboard-MonthAverageAttendance]
AS
--Currently this uses Calendar Date instead of "minsistry date" Ministry Date business logic can be added in a future version
IF OBJECT_ID('tempdb..#Attendance') is not null
DROP TABLE #Attendance;

SELECT 
	  CalendarYear
	, CalendarMonth
	, CalendarMonthAbbreviation
	, CalendarMonthLabel
	, CalendarWeek
	, SUM(AttendanceCount) AS AttendanceCount
INTO #Attendance
FROM DW.FactAttendance 
INNER JOIN DW.DimDate 
	ON FactAttendance.InstanceDateID = DimDate.DateID
WHERE
	ActualDate >= DATEADD(YEAR, -3, GETDATE()) --fixed to a three year history
GROUP BY
	  CalendarYear
	, CalendarMonth
	, CalendarMonthAbbreviation
	, CalendarMonthLabel
	, CalendarWeek
ORDER BY 
	1, 2, 5;

SELECT * FROM #Attendance ORDER BY 	1, 2, 5;

SELECT
	  CalendarYear
	, CalendarMonth
	, CalendarMonthAbbreviation
	, CalendarMonthLabel
	, AVG(AttendanceCount) AS AttendanceCount
FROM #Attendance
GROUP BY
	  CalendarYear
	, CalendarMonth
	, CalendarMonthAbbreviation
	, CalendarMonthLabel
ORDER BY
	1, 2;
