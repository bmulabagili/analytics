CREATE TABLE [Extract].[FellowshipOne_SmallGroupStatus]
(RowNumber         NVARCHAR(255) NULL,
 GroupType         NVARCHAR(255) NULL,
 GroupName         NVARCHAR(255) NULL,
 GroupLeaders      NVARCHAR(500) NULL,
 Geolocation       NVARCHAR(255) NULL,
 Latitude          NVARCHAR(255) NULL,
 Longitude         NVARCHAR(255) NULL,
 StreetAddress	    NVARCHAR(255) NULL,
 City		    NVARCHAR(255) NULL, 
 Province          NVARCHAR(255) NULL,
 PostalCodeFull    NVARCHAR(255) NULL,
 PostalCode5       NVARCHAR(255) NULL,
 TotalGroups       NVARCHAR(255) NULL,
 MissingReports    NVARCHAR(255) NULL,
 DidNotMeets       NVARCHAR(255) NULL,
 ActualAttendance  NVARCHAR(255) NULL,
 UniqueAttenders   NVARCHAR(255) NULL,
 AverageAttendance NVARCHAR(255) NULL,
 TotalLeaders      NVARCHAR(255) NULL,
 TotalMembers      NVARCHAR(255) NULL,
 TotalProspects    NVARCHAR(255) NULL,
 TenantID          INT NOT NULL,
 --ETL Specific Columns
 ExecutionID       VARCHAR(50) NOT NULL,
 --, ETLActionID INT NOT NULL -- not needed
 InsertedDateTime  DATETIME DEFAULT(GETUTCDATE())
--, UpdatedDateTime DATETIME DEFAULT(GETUTCDATE()) -- not needed
--, Hashvalue VNVARCHAR(64) NOT NULL --not needed

);
GO
CREATE CLUSTERED INDEX CIX_ExtractFellowshipOneSmallGroupStatus__ExecutionID_TenantID ON [Extract].FellowshipOne_SmallGroupStatus(ExecutionID, TenantID);