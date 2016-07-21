CREATE PROCEDURE [DW].[usp_Engagement_ExecutiveDashboard]
	  @CampusList NVARCHAR(255)
	, @StartDate DATE
	, @EndDate DATE
AS
	
	;WITH AdultStats AS (
	SELECT
		  CalendarYear
		, CalendarMonth
		, HouseholdIdentifier
		, IndividualIdentifier
		, Dimcampus.Code
		, SUM(WeekendAttendanceCount) AS WeekendAttendanceCount
		, SUM(GivingCount) AS GivingCount
		, SUM(GivingAmount) AS GivingAmount
		, SUM(SmallGroupCount) AS SmallGroupCount
		, SUM(VolunteerAttendanceCount) AS VolunteerAttendanceCount
	FROM dw.FactEngagement
	INNER JOIN DW.DimDate
		ON FactEngagement.DateID = DimDate.DateID	
	INNER JOIN DW.DimCampus
		ON FactEngagement.CampusID = DimCampus.CampusID
	WHERE
		HouseholdPosition IN ('Head','Spouse')
		AND DimCampus.Code IN (SELECT Item FROM dbo.fnSplit(@CampusList, ','))
		AND ActualDate BETWEEN @StartDate AND @EndDate
	GROUP BY
		  CalendarYear
		, CalendarMonth
		, HouseholdIdentifier
		, IndividualIdentifier
		, DimCampus.Code
), ChildStats AS (
	SELECT
		  CalendarYear
		, CalendarMonth
		, HouseholdIdentifier
		--, IndividualIdentifier
		--, HouseholdPosition
		, COUNT(DISTINCT IndividualIdentifier) AS ChildCount
		, SUM(WeekendAttendanceCount) AS WeekendAttendanceCount
		, SUM(AwanaAttendanceCount) AS AwanaAttendanceCount
		, SUM(HCAEnrollmentCount) AS HCAEnrollmentCount
		, SUM(VolunteerAttendanceCount) AS VolunteerAttendanceCount
	FROM dw.FactEngagement
	INNER JOIN DW.DimDate
		ON FactEngagement.DateID = DimDate.DateID	
	INNER JOIN DW.DimCampus
		ON FactEngagement.CampusID = DimCampus.CampusID
	WHERE
		HouseholdPosition NOT IN ('Head','Spouse')
		--this should leave child, other, visitor
		AND DimCampus.Code IN (SELECT Item FROM dbo.fnSplit(@CampusList, ','))
		AND ActualDate BETWEEN @StartDate AND @EndDate
	GROUP BY
		  CalendarYear
		, CalendarMonth
		, HouseholdIdentifier
		--, IndividualIdentifier
		--, HouseholdPosition
), Scored AS (
	SELECT 
		  AdultStats.CalendarYear
		, AdultStats.CalendarMonth
		, AdultStats.HouseholdIdentifier
		, AdultStats.IndividualIdentifier
		, AdultStats.Code AS CampusCode
		, AdultStats.WeekendAttendanceCount
		, AdultStats.GivingCount
		, AdultStats.GivingAmount
		, AdultStats.SmallGroupCount
		, AdultStats.VolunteerAttendanceCount
		, ChildStats.ChildCount
		, ChildStats.WeekendAttendanceCount AS ChildWeekendAttendance
		, ChildStats.AwanaAttendanceCount
		, ChildStats.HCAEnrollmentCount
		, ChildStats.VolunteerAttendanceCount AS ChildVolunteerAttendanceCount
		, CASE WHEN AdultStats.WeekendAttendanceCount >= 2 THEN 1 ELSE 0 END AS  WorshipAttendanceFactor
		--for giving we have to define the threshold
		, CASE WHEN AdultStats.GivingCount >= 2 THEN 1 ELSE 0 END AS  WorshipGivingFactor
		--maybe the kids score should be a factor only when ChildCount > 0 or NOT NULL
		, CASE WHEN ChildStats.WeekendAttendanceCount >= 2 THEN 1 ELSE 0 END AS  WorshipKidsFactor
		, CASE WHEN AdultStats.SmallGroupCount >= 2 THEN 1 ELSE 0 END AS  WalkSmallGroupFactor
		--again, maybe only count awana if they have a child?
		, CASE WHEN ChildStats.AwanaAttendanceCount >= 1 THEN 1 ELSE 0 END AS  WalkAwanaFactor
		--currently we are not processing HCA enrollments
		, CASE WHEN ChildStats.HCAEnrollmentCount > 0 THEN 1 ELSE 0 END AS  WalkHCAFactor
		, CASE WHEN AdultStats.VolunteerAttendanceCount > 0 THEN 1 ELSE 0 END AS WorkFactor
		-- and for those in the group you are interested in, do the API call to get contact information
		, CASE WHEN AdultStats.WeekendAttendanceCount >= 2 THEN 1 ELSE 0 END
			+ CASE WHEN AdultStats.GivingCount >= 2 THEN 1 ELSE 0 END
			+ CASE WHEN ChildStats.WeekendAttendanceCount >= 2 THEN 1 ELSE 0 END
			+ CASE WHEN AdultStats.SmallGroupCount >= 2 THEN 1 ELSE 0 END
			+ CASE WHEN ChildStats.AwanaAttendanceCount >= 1 THEN 1 ELSE 0 END
			+ CASE WHEN ChildStats.HCAEnrollmentCount > 0 THEN 1 ELSE 0 END
			+ CASE WHEN AdultStats.VolunteerAttendanceCount > 0 THEN 1 ELSE 0 END AS TotalScore
	FROM AdultStats
	LEFT JOIN ChildStats 
		ON  AdultStats.CalendarYear		   = ChildStats.CalendarYear
		AND AdultStats.CalendarMonth	   = ChildStats.CalendarMonth
		AND AdultStats.HouseholdIdentifier = ChildStats.HouseholdIdentifier
), Details AS (
	SELECT 
		*
		, CASE WHEN TotalScore >= 5 AND WorshipAttendanceFactor = 1 AND WalkSmallGroupFactor = 1 AND WorkFactor = 1 AND WorshipGivingFactor = 1 
			THEN 'Engaged Plus Member' ELSE	
				CASE WHEN TotalScore >= 3 AND WorshipAttendanceFactor = 1 AND WalkSmallGroupFactor = 1
					THEN 'Engaged Member' ELSE
						CASE WHEN TotalScore >= 2 AND WorshipAttendanceFactor = 1 
							THEN 'Somewhat Engaged' ELSE
								CASE WHEN WorshipAttendanceFactor = 1 
									THEN 'Not Engaged' ELSE 'Lost' 
								END
						END
				END
		END AS Classification
	FROM Scored
)
SELECT 
	  CalendarYear
	, CalendarMonth
	, CampusCode
	, Classification
	, COUNT(*) AS ClassificationCount
FROM Details
GROUP BY
	  CalendarYear
	, CalendarMonth
	, CampusCode
	, Classification
ORDER BY
	CampusCode, CalendarYear, CalendarMonth

