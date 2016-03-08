CREATE PROCEDURE [DW].[usp_Dashboard-56weekAttendance]
AS

IF OBJECT_ID('tempdb..#Attendance') is not null
DROP TABLE #Attendance;

SELECT 
	  CalendarYear
	, CalendarWeek
	, MIN(ActualDate) AS WeekStartDate
	, MAX(ActualDate) AS WeekEndDate
	, SUM(AttendanceCount) AS AttendanceCount
INTO #Attendance
FROM DW.FactAttendance 
INNER JOIN DW.DimDate
	ON FactAttendance.InstanceDateID = DimDate.DateID
WHERE
	ActualDate >= DATEADD(WEEK, -56, GETDATE())
GROUP BY
	  CalendarYear
	, CalendarWeek;

SELECT AVG(AttendanceCount) AS AttendanceAverage
FROM #Attendance

SELECT 
	  CalendarYear 
	, CalendarWeek
	, WeekStartDate
	, WeekEndDate
	, AttendanceCount
FROM #Attendance
ORDER BY 1,2;