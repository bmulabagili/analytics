USE [Analytics]
GO

/****** Object:  Table [Extract].[FellowshipOne_KidsAttendanceSummary]    Script Date: 11/29/2016 10:14:30 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [Extract].[FellowshipOne_KidsAttendanceSummary](
	[KidsAttendanceSummaryrownumber] [int] IDENTITY(1,1) NOT NULL,
	[SaturdayAttendance] [nvarchar](255) NULL,
	[SundayAttendance] [nvarchar](255) NULL,
	[Activity] [nvarchar](255) NULL,
	[AttendanceSummary] [nvarchar](255) NULL,
	[TenantID] [int] NULL,
	[ExecutionID] [varchar](50) NULL,
	[InsertedDateTime] [datetime] NULL,
	[SourceFileName] [nvarchar](255) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING ON
GO

ALTER TABLE [Extract].[FellowshipOne_KidsAttendanceSummary] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


