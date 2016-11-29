USE [Analytics]
GO

/****** Object:  Table [DW].[FactAdultsAttendanceSummary]    Script Date: 11/28/2016 2:38:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [DW].[FactAdultsAttendanceSummary](
	[AdultsAttendanceSummaryID] [int] NOT NULL,
	[TenantID] [int] NOT NULL,
	[CampusID] [int] NOT NULL,
	[MinistryID] [int] NOT NULL,
	[InstanceDateID] [int] NOT NULL,
	[AttendanceCount] [int] NOT NULL,
	[ExecutionID] [varchar](50) NOT NULL,
	[InsertedDateTime] [datetime] NULL,
	[UpdatedDateTime] [datetime] NULL,
	[Hashvalue] [nvarchar](64) NOT NULL,
 CONSTRAINT [PK_DWFactAdultsAttendanceSummary__AttendanceID_TenantID] PRIMARY KEY CLUSTERED 
(
	[AdultsAttendanceSummaryID] ASC,
	[TenantID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING ON
GO

ALTER TABLE [DW].[FactAdultsAttendanceSummary] ADD  DEFAULT (getdate()) FOR [InsertedDateTime]
GO

ALTER TABLE [DW].[FactAdultsAttendanceSummary] ADD  DEFAULT (getdate()) FOR [UpdatedDateTime]
GO

ALTER TABLE [DW].[FactAdultsAttendanceSummary]  WITH NOCHECK ADD  CONSTRAINT [FK_FactAdultsAttendanceSummary_Tenant__TenantID] FOREIGN KEY([TenantID])
REFERENCES [dbo].[Tenant] ([TenantID])
GO

ALTER TABLE [DW].[FactAdultsAttendanceSummary] CHECK CONSTRAINT [FK_FactAdultsAttendanceSummary_Tenant__TenantID]
GO


