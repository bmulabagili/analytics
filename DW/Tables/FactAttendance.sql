﻿CREATE TABLE [DW].[FactAttendance]
(
    AttendanceID       INT NOT NULL
  , TenantID           INT NOT NULL
  , CampusID           INT NOT NULL
  , MinistryID         INT NOT NULL
  , ActivityID         INT NOT NULL
  , RosterID           INT NOT NULL
  , AttendanceTypeID   INT NOT NULL
  , Age                INT NULL
  , MaritalStatusID    INT NULL
  , IndividualStatusID INT NULL
  , AttendeeZipCode	   INT NULL
  , InstanceDateID     INT NOT NULL
  , InstanceTimeID     INT NOT NULL
  , AttendanceCount    INT NOT NULL
  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWFactAttendance__AttendanceID_TenantID] 
	   PRIMARY KEY CLUSTERED(AttendanceID, TenantID)
  , CONSTRAINT [FK_DWFactAttendance_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
