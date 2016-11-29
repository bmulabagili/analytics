USE [Analytics]
GO

--drop table [Transform].[FactKidsAttendanceSummary]

/****** Object:  Table [Transform].[FactKidsAttendanceSummary]    Script Date: 11/29/2016 9:54:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [Transform].[FactKidsAttendanceSummary](
	[KidsAttendanceSummaryID] [int] NOT NULL,
	[TenantID] [int] NOT NULL,
	[CampusID] [int] NOT NULL,
	[ActivityID] [int] NOT NULL,
	[InstanceDateID] [int] NOT NULL,
	[AttendanceCount] [int] NOT NULL,
	[ExecutionID] [varchar](50) NOT NULL,
	[ETLActionID] [int] NULL,
	[InsertedDateTime] [datetime] NULL,
	[UpdatedDateTime] [datetime] NULL,
	[Hashvalue] [nvarchar](64) NOT NULL,

 CONSTRAINT [PK_TransformFactKidsAttendanceSummary__AttendanceID_TenantID] PRIMARY KEY CLUSTERED 
(
	[KidsAttendanceSummaryID] ASC,
	[TenantID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING ON
GO

ALTER TABLE [Transform].[FactKidsAttendanceSummary] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO

ALTER TABLE [Transform].[FactKidsAttendanceSummary] ADD  DEFAULT (getdate()) FOR [UpdatedDateTime]
GO

ALTER TABLE [Transform].[FactKidsAttendanceSummary]  WITH NOCHECK ADD  CONSTRAINT [FK_TransformFactKidsAttendanceSummary_Tenant__TenantID] FOREIGN KEY([TenantID])
REFERENCES [dbo].[Tenant] ([TenantID])
GO

ALTER TABLE [Transform].[FactKidsAttendanceSummary] CHECK CONSTRAINT [FK_TransformFactKidsAttendanceSummary_Tenant__TenantID]
GO


