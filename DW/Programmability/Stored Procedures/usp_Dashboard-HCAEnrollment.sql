CREATE PROCEDURE [DW].[usp_Dashboard-HCAEnrollment]
AS
	SELECT
	      ROW_NUMBER() OVER (ORDER BY SchoolYear) AS RowNumber
		, SchoolYear
		, MAX(EnrollmentCount) AS EnrollmentCount
	FROM (
		SELECT 
			  CONVERT(VARCHAR(4), SchoolEndYear - 1) + '-' + CONVERT(VARCHAR(4), SchoolEndYear) AS SchoolYear
			  , CalendarMonth
			, SUM(EnrollmentCount) AS EnrollmentCount
		FROM DW.FactEnrollment
		GROUP BY
			CONVERT(VARCHAR(4), SchoolEndYear - 1) + '-' + CONVERT(VARCHAR(4), SchoolEndYear)
			, CalendarMonth) src
	GROUP BY 
		SchoolYear
	ORDER BY 
		1
	
	
	RETURN 0
