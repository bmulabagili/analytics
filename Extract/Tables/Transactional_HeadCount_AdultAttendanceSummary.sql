USE [Analytics]
GO

--drop TABLE [Extract].[Transactional_HeadCount_AdultAttendanceSummary]

/****** Object:  Table [Extract].[Transactional_HeadCount_AdultAttendanceSummary]    Script Date: 11/18/2016 3:12:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [Extract].[Transactional_HeadCount_AdultAttendanceSummary](
	[MinistryName] [nvarchar](255) NOT NULL,
	[RecordedValue] [int] NOT NULL,
	[InstanceDateTime] [datetime] NOT NULL,
	[TenantID] [int] NOT NULL,
	[ExecutionID] [varchar](50) NOT NULL,
	[InsertedDateTime] [datetime] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING ON
GO

ALTER TABLE [Extract].[Transactional_HeadCount_AdultAttendanceSummary] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO


