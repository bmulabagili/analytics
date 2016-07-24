﻿CREATE PROCEDURE [DW].[usp_Engagement_ForClassificationAndCampusList]
	  @Classification NVARCHAR(255)
	, @CampusList NVARCHAR(255)
	, @EndDate DATE
	, @NumberOfMonthsBack INT
AS
	DECLARE @Details TABLE (
		  CalendarYear INT
		, CalendarMonth INT
		, HouseholdIdentifier INT
		, HouseholdName NVARCHAR(255)
		, HouseholdPosition NVARCHAR(255)
		, IndividualIdentifier INT
		, IndividualName NVARCHAR(255)
		, CampusCode CHAR(2)
		, [WeekendAttendanceCount] INT
		, [GivingCount] INT
		, [GivingAmount] DECIMAL(9,2)
		, [SmallGroupCount] INT
		, [VolunteerAttendanceCount] INT
		, [ChildCount] INT
		, [AwanaAttendanceCount] INT
		, [HCAEnrollmentCount] INT
		, [ChildWeekendAttendance] INT
		, [ChildVolunteerAttendanceCount] INT
		, [WorshipAttendanceFactor] INT
		, [WorshipGivingFactor] INT
		, [WorshipKidsFactor] INT
		, [WalkSmallGroupFactor] INT
		, [WalkAwanaFactor] INT
		, [WalkHCAFactor] INT
		, [WorkFactor] INT
		, [TotalScore] INT
		, Classification NVARCHAR(255)
	)
	--always get whole months
	SET @EndDate = DATEADD(DAY, -1, CONVERT(DATE, CONVERT(VARCHAR(2), MONTH(DATEADD(MONTH, 1, @EndDate))) + '/1/' + CONVERT(VARCHAR(4), YEAR(@EndDate))));

	IF YEAR(@EndDate) = YEAR(GETDATE()) AND MONTH(@EndDate) = MONTH(GETDATE())
		SET @EndDate = DATEADD(DAY, -1, CONVERT(DATE, CONVERT(VARCHAR(2), MONTH(@EndDate)) + '/1/' + CONVERT(VARCHAR(4), YEAR(@EndDate))));


	;WITH AdultStats AS (
		SELECT
			  CalendarYear
			, CalendarMonth
			, HouseholdIdentifier
			, HouseholdPosition
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
			AND ActualDate BETWEEN CONVERT(VARCHAR(2), MONTH(DATEADD(MONTH, (-1 * @NumberOfMonthsBack), @EndDate ))) + '/1/' + CONVERT(VARCHAR(4), YEAR(DATEADD(MONTH, (-1 * @NumberOfMonthsBack), @EndDate ))) AND @EndDate
		GROUP BY
			  CalendarYear
			, CalendarMonth
			, HouseholdIdentifier
			, HouseholdPosition
			, IndividualIdentifier
			, DimCampus.Code
	), ChildStats AS (
		SELECT
			  CalendarYear
			, CalendarMonth
			, HouseholdIdentifier
			, HouseholdPosition
			, IndividualIdentifier
			, IndividualName
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
			AND ActualDate BETWEEN CONVERT(VARCHAR(2), MONTH(DATEADD(MONTH, (-1 * @NumberOfMonthsBack), @EndDate ))) + '/1/' + CONVERT(VARCHAR(4), YEAR(DATEADD(MONTH, (-1 * @NumberOfMonthsBack), @EndDate ))) AND @EndDate
		GROUP BY
			  CalendarYear
			, CalendarMonth
			, HouseholdIdentifier
			, HouseholdPosition
			, IndividualIdentifier
			, IndividualName
	), Scored AS (
		SELECT 
			  DENSE_RANK() OVER (ORDER BY AdultStats.CalendarYear, AdultStats.CalendarMonth) AS MonthNumber
			, AdultStats.CalendarYear
			, AdultStats.CalendarMonth
			, AdultStats.HouseholdIdentifier
			, AdultStats.HouseholdPosition
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
	)
	INSERT INTO @Details
	SELECT 
		  [CalendarYear], [CalendarMonth]
		  , [HouseholdIdentifier]
		  , 'Household ' + CONVERT(VARCHAR(255), [HouseholdIdentifier]) AS HouseholdName
		  , HouseholdPosition
		  , [IndividualIdentifier]
		  , 'Individual ' + CONVERT(VARCHAR(255), [IndividualIdentifier]) AS IndividualName
		, [CampusCode], [WeekendAttendanceCount], [GivingCount], [GivingAmount]
		, [SmallGroupCount], [VolunteerAttendanceCount], [ChildCount]
		, [AwanaAttendanceCount], [HCAEnrollmentCount]
		, [ChildWeekendAttendance], [ChildVolunteerAttendanceCount]
		, [WorshipAttendanceFactor], [WorshipGivingFactor], [WorshipKidsFactor]
		, [WalkSmallGroupFactor], [WalkAwanaFactor], [WalkHCAFactor], [WorkFactor], [TotalScore]
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
	WHERE 
		MonthNumber IN (SELECT DISTINCT TOP (@NumberOfMonthsBack) MonthNumber FROM Scored ORDER BY MonthNumber DESC)
		AND CASE WHEN TotalScore >= 5 AND WorshipAttendanceFactor = 1 AND WalkSmallGroupFactor = 1 AND WorkFactor = 1 AND WorshipGivingFactor = 1 
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
		END = @Classification
	ORDER BY
		CalendarYear, CalendarMonth, HouseholdIdentifier, IndividualIdentifier;


	SELECT * FROM @Details;

	SELECT 
		  CalendarYear
		, CalendarMonth
		, SUM(ISNULL(WeekendAttendanceCount, 0) 
			+ ISNULL(HCAEnrollmentCount, 0) 
			+ ISNULL(SmallGroupCount, 0)
			+ ISNULL(VolunteerAttendanceCount, 0) 
			+ ISNULL(AwanaAttendanceCount, 0)) AS EngagementTotal
		, SUM(ISNULL(WeekendAttendanceCount,0)) AS WeekendAttendanceCount
		, SUM(ISNULL(HCAEnrollmentCount, 0)) AS HCAEnrollmentCount
		, SUM(ISNULL(SmallGroupCount, 0)) AS SmallGroupCount
		, SUM(ISNULL(VolunteerAttendanceCount, 0)) AS VolunteerAttendanceCount
		, SUM(ISNULL(AwanaAttendanceCount,0)) AS AwanaAttendanceCount
	FROM @Details
	GROUP BY
		  CalendarYear
		, CalendarMonth;

