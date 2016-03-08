CREATE PROCEDURE [DW].[usp_Dashboard-ContributionsAttendancePercent]
	@CalendarYear INT 
AS
	
WITH Contributions AS (
	SELECT 
		  DimFinancialCategory.CampusCode
		, SUM(Amount) AS Amount
	FROM dw.FactRevenue
	INNER JOIN dw.DimFinancialCategory
		ON FactRevenue.FinancialCategoryID = DimFinancialCategory.FinancialCategoryID
	INNER JOIN dw.DimDate
		ON FactRevenue.DateID = DimDate.DateID
	WHERE
		DimFinancialCategory.EntityCode = 'HBC'
		AND GLName IN ('CN Income-General Of')
		AND CalendarYear = @CalendarYear
	GROUP BY
		  DimFinancialCategory.CampusCode
), Attendance AS (
	SELECT 
		  DimCampus.Name
		, DimCampus.Code
		, SUM(AttendanceCount) AS AttendanceCount
	FROM DW.FactAttendance 
	INNER JOIN DW.DimDate
		ON FactAttendance.InstanceDateID = DimDate.DateID
	INNER JOIN DW.DimCampus
		ON FactAttendance.CampusID = DimCampus.CampusID
	WHERE
		CalendarYear = @CalendarYear
		AND FactAttendance.CampusID > 0
	GROUP BY
		  DimCampus.Name
		, DimCampus.Code
), TotalContributions AS (
	SELECT SUM(Amount) AS Amount
	FROM Contributions
), TotalAttendance AS (
	SELECT SUM(AttendanceCount) AS AttendanceCount 
	FROM Attendance
)
SELECT
	  Contributions.CampusCode
    , Attendance.Name
	, Contributions.Amount
	, TotalContributions.Amount AS TotalContributions
	, CONVERT(DECIMAL(9,4), (Contributions.Amount / TotalContributions.Amount)) AS ContributionPercent
	, Attendance.AttendanceCount
	, TotalAttendance.AttendanceCount AS TotalAttendance
	, CONVERT(DECIMAL(9,4), (Attendance.AttendanceCount * 1.0) / (TotalAttendance.AttendanceCount * 1.0)) AS AttendancePercent
FROM Contributions
INNER JOIN Attendance
	ON Contributions.CampusCode = Attendance.Code
INNER JOIN TotalContributions 
	ON 1=1
INNER JOIN TotalAttendance
	ON 1=1