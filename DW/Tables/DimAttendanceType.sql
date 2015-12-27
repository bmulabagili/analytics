CREATE TABLE [DW].[DimAttendanceType](
    AttendanceTypeID   INT NOT NULL
  , TenantID           INT NOT NULL
  , Category           NVARCHAR(255) NOT NULL
  , Job                NVARCHAR(255) NULL
  , VolStaffSchedule   NVARCHAR(255)
    --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETUTCDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETUTCDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWDimAttendanceType__AttendanceTypeID_TenantID] PRIMARY KEY CLUSTERED(AttendanceTypeID, TenantID)
  , CONSTRAINT [FK_DWDimAttendanceType_Tenant__TenantID] FOREIGN KEY([TenantID]) REFERENCES [dbo].[Tenant](
                                                                                            [TenantID])
);