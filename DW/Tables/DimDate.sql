CREATE TABLE DW.DimDate
(DateID								INT NOT NULL,
 ActualDateLabel					VARCHAR(50) NULL,
 ActualDate							DATE NULL,
 DateDescription					VARCHAR(50) NULL,
 --Calendar dates
 CalendarWeek						TINYINT NULL,
 CalendarWeekStartLabel				VARCHAR(50) NULL,
 CalendarWeekEndLabel				VARCHAR(50) NULL,
 CalendarDayOfWeek					TINYINT NULL,
 CalendarDayOfWeekLabel				VARCHAR(50) NULL,
 CalendarDayOfWeekAbbreviation		VARCHAR(12) NULL,
 
 CalendarMonth						TINYINT NULL,
 CalendarMonthAbbreviation			VARCHAR(12) NULL,
 CalendarMonthLabel					VARCHAR(50) NULL,
 CalendarDayOfMonth					TINYINT NULL,
 CalendarLastDayOfMonthFlag			TINYINT NULL,
  
 CalendarQuarter					TINYINT NULL,
 CalendarQuarterLabel				VARCHAR(50) NULL,
 
 CalendarYear						SMALLINT NULL,
 CalendarYearLabel					VARCHAR(50) NULL,
 CalendarDayOfYear					SMALLINT NULL,
  
 HolidayFlag						TINYINT NULL,
 WeekendFlag						TINYINT NULL  ,

 --fiscal dates
 FiscalWeek							TINYINT NULL,
 FiscalWeekStartLabel				VARCHAR(50) NULL,
 FiscalWeekEndLabel					VARCHAR(50) NULL,
 FiscalDayOfWeek					TINYINT NULL,
 FiscalDayOfWeekLabel				VARCHAR(50) NULL,
 FiscalDayOfWeekAbbreviation		VARCHAR(12) NULL,
 
 FiscalMonth						TINYINT NULL,
 FiscalMonthAbbreviation			VARCHAR(12) NULL,
 FiscalMonthLabel					VARCHAR(50) NULL,
 FiscalDayOfMonth					TINYINT NULL,
 FiscalLastDayOfMonthFlag			TINYINT NULL,

 FiscalQuarter						TINYINT NULL,
 FiscalQuarterLabel					VARCHAR(50) NULL,

 FiscalYear							SMALLINT NULL,
 FiscalYearLabel					VARCHAR(50) NULL,
 FiscalDayOfYear					SMALLINT NULL,
  
 --ministry dates
 MinistryWeek						TINYINT NULL,
 MinistryWeekStartLabel				VARCHAR(50) NULL,
 MinistryWeekEndLabel				VARCHAR(50) NULL,
 MinistryDayOfWeek					TINYINT NULL,
 MinistryDayOfWeekLabel				VARCHAR(50) NULL,
 MinistryDayOfWeekAbbreviation		VARCHAR(12) NULL,
 
 MinistryMonth						TINYINT NULL,
 MinistryMonthAbbreviation			VARCHAR(12) NULL,
 MinistryMonthLabel					VARCHAR(50) NULL,
 MinistryDayOfMonth					TINYINT NULL,
 MinistryLastDayOfMonthFlag			TINYINT NULL,

 MinistryQuarter					TINYINT NULL,
 MinistryQuarterLabel				VARCHAR(50) NULL,

 MinistryYear						SMALLINT NULL,
 MinistryYearLabel					VARCHAR(50) NULL,
 MinistryDayOfYear					SMALLINT NULL,

 --school dates
 SchoolWeek							TINYINT NULL,
 SchoolWeekStartLabel				VARCHAR(50) NULL,
 SchoolWeekEndLabel					VARCHAR(50) NULL,
 SchoolDayOfWeek					TINYINT NULL,
 SchoolDayOfWeekLabel				VARCHAR(50) NULL,
 SchoolDayOfWeekAbbreviation		VARCHAR(12) NULL,
 
 SchoolMonth						TINYINT NULL,
 SchoolMonthAbbreviation			VARCHAR(12) NULL,
 SchoolMonthLabel					VARCHAR(50) NULL,
 SchoolDayOfMonth					TINYINT NULL,
 SchoolLastDayOfMonthFlag			TINYINT NULL,

 SchoolQuarter						TINYINT NULL,
 SchoolQuarterLabel					VARCHAR(50) NULL,

 SchoolYear							SMALLINT NULL,
 SchoolYearLabel					VARCHAR(50) NULL,
 SchoolDayOfYear					SMALLINT NULL,

 --ETL Specific Columns
 ExecutionID                VARCHAR(50) NULL,
 InsertedDateTime           DATETIME DEFAULT(GETUTCDATE()) NULL,
 UpdatedDateTime            DATETIME DEFAULT(GETUTCDATE()) NULL,
 Hashvalue                  NVARCHAR(64) NULL,
 CONSTRAINT PK_DWDimDate__DateID PRIMARY KEY CLUSTERED(DateID ASC)
);
GO