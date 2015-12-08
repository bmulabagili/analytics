﻿/*
Deployment script for Analytics

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Analytics"
:setvar DefaultFilePrefix "Analytics"
:setvar DefaultDataPath "e:\SQL\MSSQL12.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "e:\SQL\MSSQL12.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creating [Common]...';


GO
CREATE SCHEMA [Common]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [Extract]...';


GO
CREATE SCHEMA [Extract]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [Transform]...';


GO
CREATE SCHEMA [Transform]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [Common].[DimDate]...';


GO
CREATE TABLE [Common].[DimDate] (
    [DateID]                          INT          NOT NULL,
    [Actual_Date_Label]               VARCHAR (50) NOT NULL,
    [Actual_Date]                     DATETIME     NOT NULL,
    [Calendar_Day_Of_Month]           TINYINT      NOT NULL,
    [Calendar_Day_Of_Year]            SMALLINT     NOT NULL,
    [Calendar_Half_Year]              TINYINT      NOT NULL,
    [Calendar_Half_Year_Label]        VARCHAR (50) NOT NULL,
    [Calendar_Last_Day_Of_Month_Flag] TINYINT      NOT NULL,
    [Calendar_Month]                  TINYINT      NOT NULL,
    [Calendar_Month_Abbreviation]     VARCHAR (12) NOT NULL,
    [Calendar_Month_Label]            VARCHAR (50) NOT NULL,
    [Calendar_Trimester]              TINYINT      NOT NULL,
    [Calendar_Trimester_Label]        VARCHAR (50) NOT NULL,
    [Calendar_Quarter]                TINYINT      NOT NULL,
    [Calendar_Quarter_Label]          VARCHAR (50) NOT NULL,
    [Calendar_Week]                   TINYINT      NOT NULL,
    [Calendar_Week_End_Label]         VARCHAR (50) NOT NULL,
    [Calendar_Week_Label]             VARCHAR (50) NOT NULL,
    [Calendar_Week_Start_Label]       VARCHAR (50) NOT NULL,
    [Calendar_Year]                   SMALLINT     NOT NULL,
    [Calendar_Year_Label]             VARCHAR (50) NOT NULL,
    [Date_Description]                VARCHAR (50) NOT NULL,
    [Day_Of_Week]                     TINYINT      NOT NULL,
    [Day_Of_Week_Abbreviation]        VARCHAR (12) NOT NULL,
    [Day_Of_Week_Label]               VARCHAR (50) NOT NULL,
    [Days_In_Calendar_Month]          TINYINT      NOT NULL,
    [Days_In_Calendar_Year]           SMALLINT     NOT NULL,
    [Holiday_Flag]                    TINYINT      NOT NULL,
    [Weekday_Or_Weekend_Label]        VARCHAR (12) NOT NULL,
    [Weekend_Flag]                    TINYINT      NOT NULL,
    CONSTRAINT [PK_CommonDimDate__DateID] PRIMARY KEY CLUSTERED ([DateID] ASC)
);


GO
PRINT N'Creating [Extract].[FocusTenant]...';


GO
CREATE TABLE [Extract].[FocusTenant] (
    [TenantID]           INT            NULL,
    [TenantName]         NVARCHAR (255) NULL,
    [ConnectionStringID] INT            NULL,
    [isActive]           INT            NULL,
    [ExecutionID]        VARCHAR (50)   NOT NULL,
    [InsertedDateTime]   DATETIME       NULL
);


GO
PRINT N'Creating [Extract].[FocusTenant].[CIX_ExtractFocusTenant__TenantID]...';


GO
CREATE NONCLUSTERED INDEX [CIX_ExtractFocusTenant__TenantID]
    ON [Extract].[FocusTenant]([TenantID] ASC);


GO
PRINT N'Creating [Extract].[FocusConnectionString]...';


GO
CREATE TABLE [Extract].[FocusConnectionString] (
    [ConnectionStringID] INT             NULL,
    [Source]             NVARCHAR (1000) NULL,
    [Note]               NVARCHAR (1000) NULL,
    [ExecutionID]        VARCHAR (50)    NOT NULL,
    [InsertedDateTime]   DATETIME        NULL
);


GO
PRINT N'Creating [Extract].[FocusConnectionString].[CIX_ExtractFocusConnectionString__ConnectionStringID]...';


GO
CREATE CLUSTERED INDEX [CIX_ExtractFocusConnectionString__ConnectionStringID]
    ON [Extract].[FocusConnectionString]([ConnectionStringID] ASC);


GO
PRINT N'Creating [Extract].[f1_SubFund]...';


GO
CREATE TABLE [Extract].[f1_SubFund] (
    [SubFundID]          INT            NOT NULL,
    [TenantID]           INT            NULL,
    [ParentFundID]       INT            NULL,
    [ParentFundName]     NVARCHAR (255) NULL,
    [SubFundName]        NVARCHAR (255) NULL,
    [GeneralLedger]      NVARCHAR (255) NULL,
    [SubFundCode]        NVARCHAR (255) NULL,
    [IsWebEnabled]       NVARCHAR (255) NULL,
    [IsActive]           BIT            NULL,
    [CreatedDateTime]    DATETIME       NULL,
    [LastUpdateDateTime] DATETIME       NULL,
    [ExecutionID]        VARCHAR (50)   NOT NULL,
    [InsertedDateTime]   DATETIME       NULL
);


GO
PRINT N'Creating [Extract].[f1_SubFund].[CIX_Extractf1SubFund__SubFundID_TenantID]...';


GO
CREATE CLUSTERED INDEX [CIX_Extractf1SubFund__SubFundID_TenantID]
    ON [Extract].[f1_SubFund]([SubFundID] ASC, [TenantID] ASC);


GO
PRINT N'Creating [Extract].[f1_PledgeDrive]...';


GO
CREATE TABLE [Extract].[f1_PledgeDrive] (
    [PledgeDriveID]       INT            NULL,
    [TenantID]            INT            NULL,
    [Name]                NVARCHAR (255) NULL,
    [StartDateTime]       DATETIME       NULL,
    [EndDateTime]         DATETIME       NULL,
    [Goal]                FLOAT (53)     NULL,
    [FundID]              INT            NULL,
    [FundName]            NVARCHAR (255) NULL,
    [SubFundID]           INT            NULL,
    [SubFundName]         NVARCHAR (255) NULL,
    [Iswebactive]         BIT            NULL,
    [CreateDateTime]      DATETIME       NULL,
    [LastUpdatedDateTime] DATETIME       NULL,
    [ExecutionID]         VARCHAR (50)   NOT NULL,
    [InsertedDateTime]    DATETIME       NULL
);


GO
PRINT N'Creating [Extract].[f1_PledgeDrive].[CIX_Extractf1PledgeDrive__PledgeDriveID_TenantID]...';


GO
CREATE CLUSTERED INDEX [CIX_Extractf1PledgeDrive__PledgeDriveID_TenantID]
    ON [Extract].[f1_PledgeDrive]([PledgeDriveID] ASC, [TenantID] ASC);


GO
PRINT N'Creating [Extract].[f1_PersonStatus]...';


GO
CREATE TABLE [Extract].[f1_PersonStatus] (
    [PersonStatusID]   INT          NOT NULL,
    [TenantID]         INT          NULL,
    [Name]             NVARCHAR (1) NULL,
    [ExecutionID]      VARCHAR (50) NOT NULL,
    [InsertedDateTime] DATETIME     NULL
);


GO
PRINT N'Creating [Extract].[f1_PersonStatus].[CIX_Extractf1PersonStatus__PersonStatusID_TenantID]...';


GO
CREATE CLUSTERED INDEX [CIX_Extractf1PersonStatus__PersonStatusID_TenantID]
    ON [Extract].[f1_PersonStatus]([PersonStatusID] ASC, [TenantID] ASC);


GO
PRINT N'Creating [Extract].[f1_Fund]...';


GO
CREATE TABLE [Extract].[f1_Fund] (
    [FundID]             INT            NOT NULL,
    [TenantID]           INT            NULL,
    [Name]               NVARCHAR (255) NULL,
    [FundTypeID]         INT            NULL,
    [FundTypeName]       NVARCHAR (255) NULL,
    [FundCode]           NVARCHAR (255) NULL,
    [IsWebEnabled]       BIT            NULL,
    [AccountReferenceID] NVARCHAR (255) NULL,
    [IsActive]           BIT            NULL,
    [CreatedDateTime]    DATETIME       NULL,
    [LastUpdateDateTime] DATETIME       NULL,
    [ExecutionID]        VARCHAR (50)   NOT NULL,
    [InsertedDateTime]   DATETIME       NULL
);


GO
PRINT N'Creating [Extract].[f1_Fund].[CIX_Extractf1Fund__FundID_TenantID]...';


GO
CREATE CLUSTERED INDEX [CIX_Extractf1Fund__FundID_TenantID]
    ON [Extract].[f1_Fund]([FundID] ASC, [TenantID] ASC);


GO
PRINT N'Creating [Extract].[f1_ContributionType]...';


GO
CREATE TABLE [Extract].[f1_ContributionType] (
    [ContributionTypeID] INT            NOT NULL,
    [TenantID]           INT            NOT NULL,
    [Name]               NVARCHAR (255) NOT NULL,
    [ExecutionID]        VARCHAR (50)   NOT NULL,
    [InsertedDateTime]   DATETIME       NULL
);


GO
PRINT N'Creating [Extract].[f1_ContributionType].[CIX_Extractf1ContributionType__ContributionTypeID_TenantID]...';


GO
CREATE CLUSTERED INDEX [CIX_Extractf1ContributionType__ContributionTypeID_TenantID]
    ON [Extract].[f1_ContributionType]([ContributionTypeID] ASC, [TenantID] ASC);


GO
PRINT N'Creating [Extract].[f1_ContributionSubType]...';


GO
CREATE TABLE [Extract].[f1_ContributionSubType] (
    [ContributionSubTypeID] INT            NOT NULL,
    [TenantID]              INT            NOT NULL,
    [Name]                  NVARCHAR (255) NOT NULL,
    [ContributionTypeID]    INT            NULL,
    [ExecutionID]           VARCHAR (50)   NOT NULL,
    [InsertedDateTime]      DATETIME       NULL
);


GO
PRINT N'Creating [Extract].[f1_ContributionSubType].[CIX_Extractf1ContributionSubType__ContributionSubTypeID_TenantID]...';


GO
CREATE CLUSTERED INDEX [CIX_Extractf1ContributionSubType__ContributionSubTypeID_TenantID]
    ON [Extract].[f1_ContributionSubType]([ContributionSubTypeID] ASC, [TenantID] ASC);


GO
PRINT N'Creating [Transform].[Tenant]...';


GO
CREATE TABLE [Transform].[Tenant] (
    [TenantID]           INT            NOT NULL,
    [TenantName]         NVARCHAR (255) NOT NULL,
    [IsActive]           INT            NOT NULL,
    [ConnectionStringID] INT            NULL,
    [ExecutionID]        VARCHAR (50)   NOT NULL,
    [ETLActionID]        INT            NOT NULL,
    [InsertedDateTime]   DATETIME       NULL,
    [UpdatedDateTime]    DATETIME       NULL,
    [Hashvalue]          NVARCHAR (64)  NOT NULL,
    CONSTRAINT [PK_TransformTenant__TenantID] PRIMARY KEY CLUSTERED ([TenantID] ASC)
);


GO
PRINT N'Creating [Transform].[PersonPerson]...';


GO
CREATE TABLE [Transform].[PersonPerson] (
    [PersonID]            INT             NULL,
    [TenantID]            INT             NOT NULL,
    [Salutation]          NVARCHAR (20)   NULL,
    [FirstName]           NVARCHAR (255)  NOT NULL,
    [MiddleName]          NVARCHAR (255)  NULL,
    [GoesByName]          NVARCHAR (255)  NULL,
    [LastName]            NVARCHAR (255)  NULL,
    [Suffix]              NVARCHAR (20)   NULL,
    [Gender]              CHAR (1)        NULL,
    [DateOfBirth]         DATE            NULL,
    [Age]                 SMALLINT        NULL,
    [MaritalStatusID]     INT             NULL,
    [PictureURL]          NVARCHAR (255)  NULL,
    [LastInitial]         AS              (LEFT([LastName], (1))) PERSISTED,
    [ExternalID]          INT             NULL,
    [FamilyPosition]      NVARCHAR (255)  NULL,
    [HouseHoldIdentifier] INT             NULL,
    [Barcode]             NVARCHAR (75)   NULL,
    [TagComment]          NVARCHAR (500)  NULL,
    [CellPhone]           NCHAR (10)      NULL,
    [HomePhone]           NCHAR (10)      NULL,
    [WorkPhone]           NCHAR (10)      NULL,
    [Email]               NVARCHAR (1000) NULL,
    [ETLActionID]         INT             NOT NULL,
    [InsertedDateTime]    DATETIME        NULL
);


GO
PRINT N'Creating [Transform].[PersonPerson].[CIX_TransformPersonPerson_ExternalID_TenantID]...';


GO
CREATE CLUSTERED INDEX [CIX_TransformPersonPerson_ExternalID_TenantID]
    ON [Transform].[PersonPerson]([ExternalID] ASC, [TenantID] ASC);


GO
PRINT N'Creating [Transform].[ConnectionString]...';


GO
CREATE TABLE [Transform].[ConnectionString] (
    [ConnectionStringID] INT             IDENTITY (1, 1) NOT NULL,
    [Source]             NVARCHAR (1000) NOT NULL,
    [Note]               NVARCHAR (1000) NULL,
    [ExecutionID]        VARCHAR (50)    NOT NULL,
    [ETLActionID]        INT             NOT NULL,
    [InsertedDateTime]   DATETIME        NULL,
    [UpdatedDateTime]    DATETIME        NULL,
    [Hashvalue]          NVARCHAR (64)   NOT NULL,
    CONSTRAINT [PK_TransformConnectionString__ConnectionStringID] PRIMARY KEY CLUSTERED ([ConnectionStringID] ASC)
);


GO
PRINT N'Creating [dbo].[ConnectionString]...';


GO
CREATE TABLE [dbo].[ConnectionString] (
    [ConnectionStringID] INT             NOT NULL,
    [Source]             NVARCHAR (1000) NOT NULL,
    [Note]               NVARCHAR (1000) NULL,
    [ExecutionID]        VARCHAR (50)    NOT NULL,
    [InsertedDateTime]   DATETIME        NULL,
    [UpdatedDateTime]    DATETIME        NULL,
    [Hashvalue]          NVARCHAR (64)   NOT NULL,
    CONSTRAINT [PK_ConnectionString__ConnectionStringID] PRIMARY KEY CLUSTERED ([ConnectionStringID] ASC)
);


GO
PRINT N'Creating [dbo].[ETLAction]...';


GO
CREATE TABLE [dbo].[ETLAction] (
    [ETLActionID] INT             NOT NULL,
    [Name]        NVARCHAR (255)  NOT NULL,
    [Description] NVARCHAR (1000) NULL,
    CONSTRAINT [PK_ETLAction__ETLActionID] PRIMARY KEY CLUSTERED ([ETLActionID] ASC)
);


GO
PRINT N'Creating [dbo].[ETLProcess]...';


GO
CREATE TABLE [dbo].[ETLProcess] (
    [ETLProcessID] INT             NOT NULL,
    [Name]         NVARCHAR (255)  NOT NULL,
    [Description]  NVARCHAR (1000) NULL,
    CONSTRAINT [PK_ETLProcess__ETLProcessID] PRIMARY KEY CLUSTERED ([ETLProcessID] ASC)
);


GO
PRINT N'Creating [dbo].[Tenant]...';


GO
CREATE TABLE [dbo].[Tenant] (
    [TenantID]           INT            NOT NULL,
    [TenantName]         NVARCHAR (255) NOT NULL,
    [IsActive]           INT            NOT NULL,
    [ConnectionStringID] INT            NULL,
    [ExecutionID]        VARCHAR (50)   NOT NULL,
    [InsertedDateTime]   DATETIME       NULL,
    [UpdatedDateTime]    DATETIME       NULL,
    [Hashvalue]          NVARCHAR (64)  NOT NULL,
    CONSTRAINT [PK_Tenant__TenantID] PRIMARY KEY CLUSTERED ([TenantID] ASC)
);


GO
PRINT N'Creating [dbo].[TenantETLProcess]...';


GO
CREATE TABLE [dbo].[TenantETLProcess] (
    [TenantID]     INT NOT NULL,
    [ETLProcessID] INT NOT NULL,
    CONSTRAINT [PK_TenantETLPRocess__TenantID_ETLProcessID] PRIMARY KEY CLUSTERED ([TenantID] ASC, [ETLProcessID] ASC)
);


GO
PRINT N'Creating [Common].[DF_DimDate_Calendar_Trimester]...';


GO
ALTER TABLE [Common].[DimDate]
    ADD CONSTRAINT [DF_DimDate_Calendar_Trimester] DEFAULT ((0)) FOR [Calendar_Trimester];


GO
PRINT N'Creating [Common].[DF_DimDate_Calendar_Trimester_Label]...';


GO
ALTER TABLE [Common].[DimDate]
    ADD CONSTRAINT [DF_DimDate_Calendar_Trimester_Label] DEFAULT (' ') FOR [Calendar_Trimester_Label];


GO
PRINT N'Creating unnamed constraint on [Extract].[FocusTenant]...';


GO
ALTER TABLE [Extract].[FocusTenant]
    ADD DEFAULT (GETUTCDATE()) FOR [InsertedDateTime];


GO
PRINT N'Creating unnamed constraint on [Extract].[FocusConnectionString]...';


GO
ALTER TABLE [Extract].[FocusConnectionString]
    ADD DEFAULT (GETUTCDATE()) FOR [InsertedDateTime];


GO
PRINT N'Creating unnamed constraint on [Extract].[f1_SubFund]...';


GO
ALTER TABLE [Extract].[f1_SubFund]
    ADD DEFAULT (GETUTCDATE()) FOR [InsertedDateTime];


GO
PRINT N'Creating unnamed constraint on [Extract].[f1_PledgeDrive]...';


GO
ALTER TABLE [Extract].[f1_PledgeDrive]
    ADD DEFAULT (GETUTCDATE()) FOR [InsertedDateTime];


GO
PRINT N'Creating unnamed constraint on [Extract].[f1_PersonStatus]...';


GO
ALTER TABLE [Extract].[f1_PersonStatus]
    ADD DEFAULT (GETUTCDATE()) FOR [InsertedDateTime];


GO
PRINT N'Creating unnamed constraint on [Extract].[f1_Fund]...';


GO
ALTER TABLE [Extract].[f1_Fund]
    ADD DEFAULT (GETUTCDATE()) FOR [InsertedDateTime];


GO
PRINT N'Creating unnamed constraint on [Extract].[f1_ContributionType]...';


GO
ALTER TABLE [Extract].[f1_ContributionType]
    ADD DEFAULT (GETUTCDATE()) FOR [InsertedDateTime];


GO
PRINT N'Creating unnamed constraint on [Extract].[f1_ContributionSubType]...';


GO
ALTER TABLE [Extract].[f1_ContributionSubType]
    ADD DEFAULT (GETUTCDATE()) FOR [InsertedDateTime];


GO
PRINT N'Creating unnamed constraint on [Transform].[Tenant]...';


GO
ALTER TABLE [Transform].[Tenant]
    ADD DEFAULT ((0)) FOR [IsActive];


GO
PRINT N'Creating unnamed constraint on [Transform].[Tenant]...';


GO
ALTER TABLE [Transform].[Tenant]
    ADD DEFAULT (GETUTCDATE()) FOR [InsertedDateTime];


GO
PRINT N'Creating unnamed constraint on [Transform].[Tenant]...';


GO
ALTER TABLE [Transform].[Tenant]
    ADD DEFAULT (GETUTCDATE()) FOR [UpdatedDateTime];


GO
PRINT N'Creating unnamed constraint on [Transform].[PersonPerson]...';


GO
ALTER TABLE [Transform].[PersonPerson]
    ADD DEFAULT (0) FOR [ETLActionID];


GO
PRINT N'Creating unnamed constraint on [Transform].[PersonPerson]...';


GO
ALTER TABLE [Transform].[PersonPerson]
    ADD DEFAULT (GETUTCDATE()) FOR [InsertedDateTime];


GO
PRINT N'Creating unnamed constraint on [Transform].[ConnectionString]...';


GO
ALTER TABLE [Transform].[ConnectionString]
    ADD DEFAULT (GETUTCDATE()) FOR [InsertedDateTime];


GO
PRINT N'Creating unnamed constraint on [Transform].[ConnectionString]...';


GO
ALTER TABLE [Transform].[ConnectionString]
    ADD DEFAULT (GETUTCDATE()) FOR [UpdatedDateTime];


GO
PRINT N'Creating unnamed constraint on [dbo].[ConnectionString]...';


GO
ALTER TABLE [dbo].[ConnectionString]
    ADD DEFAULT (GETUTCDATE()) FOR [InsertedDateTime];


GO
PRINT N'Creating unnamed constraint on [dbo].[ConnectionString]...';


GO
ALTER TABLE [dbo].[ConnectionString]
    ADD DEFAULT (GETUTCDATE()) FOR [UpdatedDateTime];


GO
PRINT N'Creating unnamed constraint on [dbo].[Tenant]...';


GO
ALTER TABLE [dbo].[Tenant]
    ADD DEFAULT ((0)) FOR [IsActive];


GO
PRINT N'Creating unnamed constraint on [dbo].[Tenant]...';


GO
ALTER TABLE [dbo].[Tenant]
    ADD DEFAULT (GETUTCDATE()) FOR [InsertedDateTime];


GO
PRINT N'Creating unnamed constraint on [dbo].[Tenant]...';


GO
ALTER TABLE [dbo].[Tenant]
    ADD DEFAULT (GETUTCDATE()) FOR [UpdatedDateTime];


GO
PRINT N'Creating [Transform].[FK_TransformTenant_ConnectionString__ConnectionStringID]...';


GO
ALTER TABLE [Transform].[Tenant]
    ADD CONSTRAINT [FK_TransformTenant_ConnectionString__ConnectionStringID] FOREIGN KEY ([ConnectionStringID]) REFERENCES [dbo].[ConnectionString] ([ConnectionStringID]);


GO
PRINT N'Creating [Transform].[FK_TransformTenant_ETLAction__ETLActionID]...';


GO
ALTER TABLE [Transform].[Tenant]
    ADD CONSTRAINT [FK_TransformTenant_ETLAction__ETLActionID] FOREIGN KEY ([ETLActionID]) REFERENCES [dbo].[ETLAction] ([ETLActionID]);


GO
PRINT N'Creating [Transform].[FK_TenantPersonPerson_Tenant__TenantID]...';


GO
ALTER TABLE [Transform].[PersonPerson]
    ADD CONSTRAINT [FK_TenantPersonPerson_Tenant__TenantID] FOREIGN KEY ([TenantID]) REFERENCES [dbo].[Tenant] ([TenantID]);


GO
PRINT N'Creating [Transform].[FK_TransformConnectionString_ETLAction__ETLActionID]...';


GO
ALTER TABLE [Transform].[ConnectionString]
    ADD CONSTRAINT [FK_TransformConnectionString_ETLAction__ETLActionID] FOREIGN KEY ([ETLActionID]) REFERENCES [dbo].[ETLAction] ([ETLActionID]);


GO
PRINT N'Creating [dbo].[FK_Tenant_ConnectionString__ConnectionStringID]...';


GO
ALTER TABLE [dbo].[Tenant]
    ADD CONSTRAINT [FK_Tenant_ConnectionString__ConnectionStringID] FOREIGN KEY ([ConnectionStringID]) REFERENCES [dbo].[ConnectionString] ([ConnectionStringID]);


GO
PRINT N'Creating [dbo].[FK_TenantETLProcess_Tenant__TenantID]...';


GO
ALTER TABLE [dbo].[TenantETLProcess]
    ADD CONSTRAINT [FK_TenantETLProcess_Tenant__TenantID] FOREIGN KEY ([TenantID]) REFERENCES [dbo].[Tenant] ([TenantID]);


GO
PRINT N'Creating [dbo].[FK_TenantETLProcess_ETLProcess__ETLProcessID]...';


GO
ALTER TABLE [dbo].[TenantETLProcess]
    ADD CONSTRAINT [FK_TenantETLProcess_ETLProcess__ETLProcessID] FOREIGN KEY ([ETLProcessID]) REFERENCES [dbo].[ETLProcess] ([ETLProcessID]);


GO
PRINT N'Creating [dbo].[SplitCSV]...';


GO
CREATE FUNCTION [dbo].[SplitCSV]
(
	@param1 int,
	@param2 int
)
RETURNS INT
AS
BEGIN
	RETURN @param1 + @param2
END
GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO
