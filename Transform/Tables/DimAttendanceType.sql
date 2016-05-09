CREATE TABLE [Transform].[DimAttendanceType]
(
    AttendanceTypeID   INT NOT NULL
  , TenantID           INT NOT NULL
  , Category           NVARCHAR(255) NOT NULL
  , Job                NVARCHAR(255) NULL
  , VolStaffSchedule   NVARCHAR(255)
    --ETL Specific Columns
  , ExecutionID        VARCHAR(50) NOT NULL
  , ETLActionID        INT NOT NULL
  , InsertedDateTime   DATETIME DEFAULT(GETDATE())
  , UpdatedDateTime    DATETIME DEFAULT(GETDATE())
  , Hashvalue          NVARCHAR(64) NOT NULL
    --Keys should get enforced at this point.
  , CONSTRAINT [PK_TransformDimAttendanceType__AttendanceTypeID] PRIMARY KEY CLUSTERED(AttendanceTypeID ASC)
  , CONSTRAINT FK_TransformDimAttendanceType_Tenant__TenantID 
	   FOREIGN KEY(TenantID) 
	   REFERENCES Tenant(TenantID)
);

