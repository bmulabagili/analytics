﻿CREATE TABLE [Transform].[FactEngagement]
(
      EngagementID INT NOT NULL
	, TenantID INT NOT NULL
	, CalendarYear INT NOT NULL
	, CalendarMonth INT NOT NULL
	, HouseholdID INT NOT NULL
	, HouseholdPosition NVARCHAR(255) NULL
	, IndividualIdentifier INT NOT NULL
	, FullName NVARCHAR(255) NULL
	, WeekendAttendanceCount INT NOT NULL DEFAULT(0)
	, FirstWeekendAttendeeInstanceDateID INT NULL 
	, FirstWeekendAttendeeInstanceActualDate DATE NULL 
	, LastWeekendAttendeeInstanceDateID INT NULL 
	, LastWeekendAttendeeInstanceActualDate DATE NULL 
	, GivingCount INT NULL
	, GivingAmount DECIMAL(9,2)
	, FirstGivingDateID INT NULL
	, FirstGivingActualDate DATE NULL
	, LastGivingDateID INT NULL
	, LastGivingActualDate DATE NULL
	, SmallGroupCount INT NULL
	, FirstSmallGroupDateID INT NULL
	, FirstSmallGroupActualDate DATE NULL
	, LastSmallGroupDateID INT NULL
	, LastSmallGroupActualDate DATE NULL
	, AwanaAttendanceCount INT NULL
	, FirstAwanaInstanceDateID INT NULL
	, FirstAwanaInstanceActualDate DATE NULL
	, LastAwanaInstanceDateID INT NULL
	, LastAwanaInstanceActualDate DATE NULL
	, HCAEnrollmentCount INT NULL
	, VolunteerAssignmentCount INT NULL
	, FirstVolunteerAssignmentDateID INT NULL
	, FirstVolunteerAssignmentActualDate DATE NULL
	, LastVolunteerAssignmentDateID INT NULL
	, LastVolunteerAssignmentActualDate DATE NULL
	, VolunteerAttendanceCount INT NULL
	, FirstVolunteerAttendanceDateID INT NULL
	, FirstVolunteerAttendanceActualDate DATE NULL
	, LastVolunteerAttendanceDateID INT NULL
	, LastVolunteerAttendanceActualDate DATE NULL
    --ETL Specific Columns
  , ExecutionID        VARCHAR(50) NOT NULL
  , ETLActionID        INT NOT NULL
  , InsertedDateTime   DATETIME DEFAULT(GETDATE())
  , UpdatedDateTime    DATETIME DEFAULT(GETDATE())
  , Hashvalue          NVARCHAR(64) NOT NULL
    
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_TransformFactEngagement__EngagementID_TenantID] 
	   PRIMARY KEY CLUSTERED(EngagementID, TenantID)
  , CONSTRAINT [FK_TransformFactEngagement_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);