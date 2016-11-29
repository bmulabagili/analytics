USE [Analytics]
GO

-- drop TABLE [Transform].[FactAdultsAttendanceSummary]

/****** Object:  Table [Transform].[FactAdultsAttendanceSummary]    Script Date: 11/18/2016 4:04:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [Transform].[FactAdultsAttendanceSummary](
	[AdultsAttendanceSummaryID] [int] NOT NULL,
	[TenantID] [int] NOT NULL,
	[CampusID] [int] NOT NULL,
	[MinistryID] [int] NOT NULL,
	[InstanceDateID] [int] NOT NULL,
	[AttendanceCount] [int] NOT NULL,
	[ExecutionID] [varchar](50) NOT NULL,
	[ETLActionID] [int] NOT NULL,
	[InsertedDateTime] [datetime] NULL,
	[UpdatedDateTime] [datetime] NULL,
	[Hashvalue] [nvarchar](64) NOT NULL,
 CONSTRAINT [PK_TransformFactAdultsAttendanceSummary__AttendanceID_TenantID] PRIMARY KEY CLUSTERED 
(
	[AdultsAttendanceSummaryID] ASC,
	[TenantID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING ON
GO

ALTER TABLE [Transform].[FactAdultsAttendanceSummary] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO

ALTER TABLE [Transform].[FactAdultsAttendanceSummary] ADD  DEFAULT (getdate()) FOR [UpdatedDateTime]
GO

ALTER TABLE [Transform].[FactAdultsAttendanceSummary]  WITH NOCHECK ADD  CONSTRAINT [FK_FactAdultsAttendanceSummary_Tenant__TenantID] FOREIGN KEY([TenantID])
REFERENCES [dbo].[Tenant] ([TenantID])
GO

ALTER TABLE [Transform].[FactAdultsAttendanceSummary] CHECK CONSTRAINT [FK_FactAdultsAttendanceSummary_Tenant__TenantID]
GO


