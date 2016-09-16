USE [master]
CREATE LOGIN [HBCReportReader] WITH PASSWORD = 'R3p0rts*'
GO
USE Analytics
GO
CREATE USER [HBCReportReader]
GO
GRANT CONNECT TO [HBCReportReader]
