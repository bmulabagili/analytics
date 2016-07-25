CREATE PROCEDURE [Transform].[usp_TransformFactEngagement]
	@SourceDataID INT
AS

	IF @SourceDataID = 12
		--WeekendAttendance
		SELECT   
			  TenantID
			, CONVERT(INT, CONVERT(VARCHAR(20), CONVERT(DATE, SUBSTRING(Instance, 0, CHARINDEX(' - ', Instance))), 112)) AS DateID
			, CONVERT(INT, HouseholdID) AS HouseholdIdentifier
			, MAX(HouseholdPosition) AS HouseholdPosition
			, MAX(HouseholdFullName) AS HouseholdFullName
			, CONVERT(INT, IndividualID) AS IndividualIdentifier
			, MAX(Name) AS FullName
			, MAX(SubStatus) AS SubStatus

			, CONVERT(INT, COUNT(*)) AS WeekendAttendanceCount
			, CONVERT(DECIMAL(9,2), NULL) AS GivingCount
			, CONVERT(INT, NULL) AS GivingAmount 
			, CONVERT(INT, NULL) AS SmallGroupCount
			, CONVERT(INT, NULL) AS AwanaAttendanceCount
			, CONVERT(INT, NULL) AS HCAEnrollmentCount
			, CONVERT(INT, NULL) AS VolunteerAssignmentCount
			, CONVERT(INT, NULL) AS VolunteerAttendanceCount
		FROM Extract.FellowshipOne_EngagementAttendance
		WHERE 
			RowNumber <>''
			AND HouseholdID <> ''
			AND IndividualID <> ''
			--Weekend Attendance ONLY
			AND LEFT(RIGHT(RTRIM(SourceFileName),CHARINDEX('\',REVERSE(RTRIM(SourceFileName)))-1), CHARINDEX('_', RIGHT(RTRIM(SourceFileName),CHARINDEX('\',REVERSE(RTRIM(SourceFileName)))-1)) - 1) = 12 
		GROUP BY
			  TenantID
			, CONVERT(INT, CONVERT(VARCHAR(20), CONVERT(DATE, SUBSTRING(Instance, 0, CHARINDEX(' - ', Instance))), 112))
			, CONVERT(INT, HouseholdID)
			, CONVERT(INT, IndividualID)


	IF @SourceDataID = 13
		--13 Awana attendance
		SELECT   
	
			  TenantID
			, CONVERT(INT, CONVERT(VARCHAR(20), CONVERT(DATE, SUBSTRING(Instance, 0, CHARINDEX(' - ', Instance))), 112)) AS DateID
			, CONVERT(INT, HouseholdID) AS HouseholdIdentifier
			, MAX(HouseholdPosition) AS HouseholdPosition
			, MAX(HouseholdFullName) AS HouseholdFullName
			, CONVERT(INT, IndividualID) AS IndividualIdentifier
			, MAX(Name) AS FullName
			, MAX(SubStatus) AS SubStatus

			, CONVERT(INT, NULL) AS WeekendAttendanceCount
			, CONVERT(INT, NULL) AS GivingCount
			, CONVERT(DECIMAL(9,2), NULL) AS GivingAmount 
			, CONVERT(INT, NULL) AS SmallGroupCount
			, COUNT(*) AS AwanaAttendanceCount
			, CONVERT(INT, NULL) AS HCAEnrollmentCount
			, CONVERT(INT, NULL) AS VolunteerAssignmentCount
			, CONVERT(INT, NULL) AS VolunteerAttendanceCount
		FROM Extract.FellowshipOne_EngagementAttendance
		WHERE 
			RowNumber <>''
			AND HouseholdID <> ''
			AND IndividualID <> ''
			--AWANA Attendance ONLY
			AND LEFT(RIGHT(RTRIM(SourceFileName),CHARINDEX('\',REVERSE(RTRIM(SourceFileName)))-1), CHARINDEX('_', RIGHT(RTRIM(SourceFileName),CHARINDEX('\',REVERSE(RTRIM(SourceFileName)))-1)) - 1) = 13
		GROUP BY
			  TenantID
			, CONVERT(INT, CONVERT(VARCHAR(20), CONVERT(DATE, SUBSTRING(Instance, 0, CHARINDEX(' - ', Instance))), 112)) 
			, CONVERT(INT, HouseholdID)
			, CONVERT(INT, IndividualID)


	IF @SourceDataID = 14
		--14 Volunteer Participation		
		SELECT   
			  TenantID
			, CONVERT(INT, CONVERT(VARCHAR(20), CONVERT(DATE, SUBSTRING(Instance, 0, CHARINDEX(' - ', Instance))), 112)) AS DateID
			, CONVERT(INT, HouseholdID) AS HouseholdIdentifier
			, MAX(HouseholdPosition) AS HouseholdPosition
			, MAX(HouseholdFullName) AS HouseholdFullName
			, CONVERT(INT, IndividualID) AS IndividualIdentifier
			, MAX(Name) AS FullName
			, MAX(SubStatus) AS SubStatus

			, CONVERT(INT, NULL) AS WeekendAttendanceCount
			, CONVERT(INT, NULL) AS GivingCount
			, CONVERT(DECIMAL(9,2), NULL) AS GivingAmount 
			, CONVERT(INT, NULL) AS SmallGroupCount
			, CONVERT(INT, NULL) AS AwanaAttendanceCount
			, CONVERT(INT, NULL) AS HCAEnrollmentCount
			, CONVERT(INT, NULL) AS VolunteerAssignmentCount
			, COUNT(*) AS VolunteerAttendanceCount
		FROM Extract.FellowshipOne_EngagementAttendance
		WHERE 
			RowNumber <>''
			AND HouseholdID <> ''
			AND IndividualID <> ''
			--Volunteer Attendance ONLY
			AND LEFT(RIGHT(RTRIM(SourceFileName),CHARINDEX('\',REVERSE(RTRIM(SourceFileName)))-1), CHARINDEX('_', RIGHT(RTRIM(SourceFileName),CHARINDEX('\',REVERSE(RTRIM(SourceFileName)))-1)) - 1) = 14
		GROUP BY
			  TenantID
			, CONVERT(INT, CONVERT(VARCHAR(20), CONVERT(DATE, SUBSTRING(Instance, 0, CHARINDEX(' - ', Instance))), 112))
			, CONVERT(INT, HouseholdID) 
			, CONVERT(INT, IndividualID) 

	IF @SourceDataID = 15
		--15 Small Group Activity	
		SELECT 
			  TenantID
			, CONVERT(INT, CONVERT(VARCHAR(20), CONVERT(DATE, SUBSTRING(Instance, 0, CHARINDEX(' - ', Instance))), 112)) AS DateID
			, CONVERT(INT, HouseholdID) AS HouseholdIdentifier
			, MAX(HouseholdPosition) AS HouseholdPosition
			, MAX(HouseholdFullName) AS HouseholdFullName
			, CONVERT(INT, IndividualID) AS IndividualIdentifier
			, MAX(Name) AS FullName
			, MAX(SubStatus) AS SubStatus

			, CONVERT(INT, NULL) AS WeekendAttendanceCount
			, CONVERT(INT, NULL) AS GivingCount
			, CONVERT(DECIMAL(9,2), NULL) AS GivingAmount 
			, COUNT(*) AS SmallGroupCount 
			, CONVERT(INT, NULL) AS AwanaAttendanceCount
			, CONVERT(INT, NULL) AS HCAEnrollmentCount
			, CONVERT(INT, NULL) AS VolunteerAssignmentCount
			, CONVERT(INT, NULL) AS VolunteerAttendanceCount
		FROM [Extract].[FellowshipOne_SmallGroupAttendance]
		WHERE 
			RowNumber <>''
			AND HouseholdID <> ''
			AND IndividualID <> ''
			AND Instance <> ''
		GROUP BY
			 TenantID
			, CONVERT(INT, CONVERT(VARCHAR(20), CONVERT(DATE, SUBSTRING(Instance, 0, CHARINDEX(' - ', Instance))), 112))
			, CONVERT(INT, HouseholdID) 
			, CONVERT(INT, IndividualID) 

	IF @SourceDataID = 16
		--16 Giving
		SELECT DISTINCT 
			  TenantID
			, CONVERT(INT, CONVERT(VARCHAR(20), CONVERT(DATE, receivedDate), 112)) AS DateID
			, CONVERT(INT, GivingUnitID) AS HouseholdID
			, MAX(ContributorType) AS HouseholdPosition
			, MAX(GivingUnitName) AS HouseholdFullName
			, CONVERT(INT, ContributorID) AS IndividualID
			, MAX(ContributorName) AS FullName
			, MAX(SubStatus) AS SubStatus

			, CONVERT(INT, NULL) AS WeekendAttendanceCount
			, SUM(CONVERT(INT, Transactions)) AS GivingCount
			, SUM(CONVERT(DECIMAL(9,2), REPLACE(Amount, '$',''))) AS GivingAmount
			, CONVERT(INT, NULL) AS SmallGroupCount 
			, CONVERT(INT, NULL) AS AwanaAttendanceCount
			, CONVERT(INT, NULL) AS HCAEnrollmentCount
			, CONVERT(INT, NULL) AS VolunteerAssignmentCount
			, CONVERT(INT, NULL) AS VolunteerAttendanceCount
		FROM Extract.FellowshipOne_EngagementGiving
		WHERE 
			RowNumber <> ''
			AND TRY_CONVERT(INT, RowNumber) > 0 -- skip the header rows
			AND receivedDate <> ''
			AND Transactions <> ''
			AND Amount <> ''
			AND TRY_CONVERT(DECIMAL(9,2), REPLACE(Amount, '$','')) IS NOT NULL
		GROUP BY
			  TenantID
			, CONVERT(INT, CONVERT(VARCHAR(20), CONVERT(DATE, receivedDate), 112))
			, CONVERT(INT, GivingUnitID) 
			, CONVERT(INT, ContributorID) 

	--Catch all for bad parameters / not yet defined sources
	IF @SourceDataID NOT IN (12, 13, 14, 15, 16)
		SELECT DISTINCT 
			  CONVERT(INT, NULL) TenantID
			, CONVERT(INT, NULL) AS DateID
			, CONVERT(INT, NULL) HouseholdID
			, CONVERT(VARCHAR(255), NULL) AS HouseholdPosition
			, CONVERT(VARCHAR(255), NULL) AS HouseholdFullName
			, CONVERT(INT, NULL) AS IndividualID
			, CONVERT(VARCHAR(255), NULL) AS FullName
			, CONVERT(VARCHAR(255), NULL) AS SubStatus

			, CONVERT(INT, NULL) AS WeekendAttendanceCount
			, CONVERT(INT, NULL) AS GivingCount
			, CONVERT(DECIMAL(9,2), NULL) AS GivingAmount
			, CONVERT(INT, NULL) AS SmallGroupCount 
			, CONVERT(INT, NULL) AS AwanaAttendanceCount
			, CONVERT(INT, NULL) AS HCAEnrollmentCount
			, CONVERT(INT, NULL) AS VolunteerAssignmentCount
			, CONVERT(INT, NULL) AS VolunteerAttendanceCount
GO


