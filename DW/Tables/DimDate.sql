﻿CREATE TABLE [DW].[DimDate](
    [DateID]                          INT NOT NULL
  , [Actual_Date_Label]               VARCHAR(50) NULL
  , [Actual_Date]                     DATETIME NULL
  , [Calendar_Day_Of_Month]           TINYINT NULL
  , [Calendar_Day_Of_Year]            SMALLINT NULL
  , [Calendar_Last_Day_Of_Month_Flag] TINYINT NULL
  , [Calendar_Month]                  TINYINT NULL
  , [Calendar_Month_Abbreviation]     VARCHAR(12) NULL
  , [Calendar_Month_Label]            VARCHAR(50) NULL
  , [Calendar_Quarter]                TINYINT NULL
  , [Calendar_Quarter_Label]          VARCHAR(50) NULL
  , [Calendar_Week]                   TINYINT NULL
  , [Calendar_Week_End_Label]         VARCHAR(50) NULL
  , [Calendar_Week_Label]             VARCHAR(50) NULL
  , [Calendar_Week_Start_Label]       VARCHAR(50) NULL
  , [Calendar_Year]                   SMALLINT NULL
  , [Calendar_Year_Label]             VARCHAR(50) NULL
  , [Date_Description]                VARCHAR(50) NULL
  , [Day_Of_Week]                     TINYINT NULL
  , [Day_Of_Week_Abbreviation]        VARCHAR(12) NULL
  , [Day_Of_Week_Label]               VARCHAR(50) NULL
  , [Days_In_Calendar_Month]          TINYINT NULL
  , [Days_In_Calendar_Year]           SMALLINT NULL
  , [Days_In_Fiscal_Month]            SMALLINT NULL
  , [Days_In_Fiscal_Year]             SMALLINT NULL
  , [Fiscal_Day_Of_Week]              TINYINT NULL
  , [Fiscal_Day_Of_Month]             TINYINT NULL
  , [Fiscal_Day_Of_Year]              SMALLINT NULL
  , [Fiscal_Half_Year]                TINYINT NULL
  , [Fiscal_Half_Year_Label]          VARCHAR(50) NULL
  , [Fiscal_Month]                    TINYINT NULL
  , [Fiscal_Month_Abbreviation]       VARCHAR(12) NULL
  , [Fiscal_Month_Label]              VARCHAR(50) NULL
  , [Fiscal_Quarter]                  TINYINT NULL
  , [Fiscal_Quarter_Label]            VARCHAR(50) NULL
  , [Fiscal_Week]                     TINYINT NULL
  , [Fiscal_Week_End_Label]           VARCHAR(50) NULL
  , [Fiscal_Week_Label]               VARCHAR(50) NULL
  , [Fiscal_Week_Start_Label]         VARCHAR(50) NULL
  , [Fiscal_Year]                     SMALLINT NULL
  , [Fiscal_Year_Label]               VARCHAR(50) NULL
  , [Holiday_Flag]                    TINYINT NULL
  , [Weekday_Or_Weekend_Label]        VARCHAR(12) NULL
  , [Weekend_Flag]                    TINYINT NULL
    --ETL Specific Columns
  , [ExecutionID]                     VARCHAR(50) NULL
  , [InsertedDateTime]                DATETIME DEFAULT(GETUTCDATE()) NULL
  , [UpdatedDateTime]                 DATETIME DEFAULT(GETUTCDATE()) NULL
  , [Hashvalue]                       NVARCHAR(64) NULL
  , CONSTRAINT [PK_DWDimDate__DateID] PRIMARY KEY CLUSTERED([DateID] ASC)
);
GO