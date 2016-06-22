CREATE PROCEDURE [DW].[usp_UpsertDimDate] @StartDate DATE,
                                          @EndDate   DATE
AS
	SET NOCOUNT ON;
    --based on http://www.codeproject.com/Articles/647950/Create-and-Populate-Date-Dimension-for-Data-Wareho
	
	--Set first day of week to sunday, or none of the following works!
	SET DATEFIRST 7; -- Sunday is the first day of the week.

	--Calendar Year: 1/1/yyyy - 12/31/yyyy 
		--calendar weeks sunday to Saturday
	--Fiscal   Year: 7/1/yyyy - 6/30/yyyy
	--Ministry Year: 8/1/yyyy - 7/31/yyyy
		--HBC minsitry weeks (Monday - Sunday) are reported together in Summary for KPI Reports
		--When a week is split over 2 calendar months, the Sunday date determines which month the KPI report data gets calculated into.
		--UNLESS that would cause days to move into the next calendar year (from july - august)
		--weekly data is defined starting Monday 12:00 AM through Sunday 11:59 PM
	--School   Year: 6/1/yyyy - 5/31/yyyy

     --REMOVE existing rows	
	DELETE FROM DW.DimDate 
	WHERE
	   ActualDate BETWEEN @StartDate AND @EndDate;

     --Temporary Variables To Hold the Values During Processing of Each Date of Year
     DECLARE @DayOfWeekInMonth INT, @DayOfWeekInYear INT, @DayOfQuarter INT, @WeekOfMonth INT, @CurrentYear INT, @CurrentMonth INT
		, @CurrentQuarter INT, @MinistryMonth INT, @MinistryMonthAbbreviation NVARCHAR(255), @MinistryMonthLabel NVARCHAR(255);

     /*Table Data type to store the day of week count for the month and year*/
     DECLARE @DayOfWeek TABLE(
	     DayOWeek          INT
	   , MonthCount   INT
	   , QuarterCount INT
	   , YearCount    INT
     );

     INSERT INTO @DayOfWeek
     VALUES(1, 0, 0, 0);
     INSERT INTO @DayOfWeek
     VALUES(2, 0, 0, 0);
     INSERT INTO @DayOfWeek
     VALUES(3, 0, 0, 0);
     INSERT INTO @DayOfWeek
     VALUES(4, 0, 0, 0);
     INSERT INTO @DayOfWeek
     VALUES(5, 0, 0, 0);
     INSERT INTO @DayOfWeek
     VALUES(6, 0, 0, 0);
     INSERT INTO @DayOfWeek
     VALUES(7, 0, 0, 0);

    --Extract and assign various parts of Values from Current Date to Variable

    DECLARE @CurrentDate AS DATE= @StartDate;
    SET @CurrentMonth = DATEPART(MM, @CurrentDate);
    SET @CurrentYear = DATEPART(YY, @CurrentDate);
    SET @CurrentQuarter = DATEPART(QQ, @CurrentDate);

	DECLARE @CalendarWeekStartLabel NVARCHAR(255), @CalendarWeekEndLabel NVARCHAR(255);
	DECLARE @MinistryDayOfWeek INT, @MinistryWeekStartLabel NVARCHAR(255), @MinistryWeekEndLabel NVARCHAR(255)
		, @MinistryWeek INT;

    --Proceed only if Start Date(Current date ) is less than End date you specified above
    WHILE @CurrentDate < @EndDate
         BEGIN
			--handle the Calendar week labels
			IF DATEPART(WEEKDAY, @CurrentDate) = 1 
			BEGIN 
				SET @CalendarWeekStartLabel = CONVERT(  CHAR(10), @CurrentDate, 101)
				SET @CalendarWeekEndLabel = CONVERT(  CHAR(10), DATEADD(DAY, 6, @CurrentDate), 101)
			END
			
			--Reset the Ministry week to 1 on 8/1/yyyy
			IF MONTH(@CurrentDate) = 8 AND DATEPART(DAY, @CurrentDate) = 1
				SET @MinistryWeek = 1
					
			--Handle Ministry week labels
			SET @MinistryDayOfWeek = CASE WHEN DATEPART(WEEKDAY, @CurrentDate) BETWEEN 2 AND 7 THEN DATEPART(WEEKDAY, @CurrentDate) - 1 ELSE 7 END;
			IF @MinistryDayOfWeek = 1 
			BEGIN
				SET @MinistryWeekStartLabel = CONVERT(  CHAR(10), @CurrentDate, 101)
				SET @MinistryWeekEndLabel = CONVERT(  CHAR(10), DATEADD(DAY, 6, @CurrentDate), 101)
				--Increment the @MinistryWeek too, Don't start at ministry week 2 if the first day of the ministry year is also a Monday
				IF MONTH(@CurrentDate) = 8 AND DATEPART(DAY, @CurrentDate) <> 1
					SET @MinistryWeek = @MinistryWeek + 1
			END

			--default Ministry Month Handler:
			SET @MinistryMonth = CASE WHEN DATEPART(MM, @CurrentDate) BETWEEN 1 AND 7 THEN DATEPART(MM, @CurrentDate) + 5 ELSE DATEPART(MM, @CurrentDate) - 7 END
			--default handling for Ministry Month Abbreviation and label
			SET @MinistryMonthAbbreviation = LEFT(CONVERT(VARCHAR(20), CONVERT(DATE, @CurrentDate) , 107), 3)
			SET @MinistryMonthLabel = DATENAME(MONTH, @currentDate) 

			--Special Handling for Ministry Month, Abbreviation and Label
			IF DATENAME(WEEKDAY, @CurrentDate) = 'Monday'    AND (DATEPART(MM, DATEADD(DAY, 6, @CurrentDate)) > DATEPART(MM, @CurrentDate) OR DATEPART(MM, DATEADD(DAY, 6, @CurrentDate)) = 1) AND DATEPART(MM, DATEADD(DAY, 6, @CurrentDate)) <> 8
			BEGIN
				SET @MinistryMonth = CASE WHEN DATEPART(MM, DATEADD(DAY, 6, @CurrentDate)) BETWEEN 1 AND 7 THEN DATEPART(MM, DATEADD(DAY, 6, @CurrentDate)) + 5 ELSE DATEPART(MM, DATEADD(DAY, 6, @CurrentDate)) - 7 END
				SET @MinistryMonthAbbreviation = LEFT(CONVERT(VARCHAR(20), DATEADD(DAY, 6, @CurrentDate) , 107), 3)
				SET @MinistryMonthLabel = DATENAME(MONTH, DATEADD(DAY, 6, @CurrentDate)) 
			END

			IF DATENAME(WEEKDAY, @CurrentDate) = 'Tuesday'   AND (DATEPART(MM, DATEADD(DAY, 5, @CurrentDate)) > DATEPART(MM, @CurrentDate) OR DATEPART(MM, DATEADD(DAY, 5, @CurrentDate)) = 1) AND DATEPART(MM, DATEADD(DAY, 6, @CurrentDate)) <> 8
			BEGIN
				SET @MinistryMonth = CASE WHEN DATEPART(MM, DATEADD(DAY, 5, @CurrentDate)) BETWEEN 1 AND 7 THEN DATEPART(MM, DATEADD(DAY, 5, @CurrentDate)) + 5 ELSE DATEPART(MM, DATEADD(DAY, 5, @CurrentDate)) - 7 END
				SET @MinistryMonthAbbreviation = LEFT(CONVERT(VARCHAR(20), DATEADD(DAY, 5, @CurrentDate) , 107), 3)
				SET @MinistryMonthLabel = DATENAME(MONTH, DATEADD(DAY, 5, @CurrentDate)) 
			END

			IF DATENAME(WEEKDAY, @CurrentDate) = 'Wednesday' AND (DATEPART(MM, DATEADD(DAY, 4, @CurrentDate)) > DATEPART(MM, @CurrentDate) OR DATEPART(MM, DATEADD(DAY, 4, @CurrentDate)) = 1) AND DATEPART(MM, DATEADD(DAY, 6, @CurrentDate)) <> 8
			BEGIN
				SET @MinistryMonth = CASE WHEN DATEPART(MM, DATEADD(DAY, 4, @CurrentDate)) BETWEEN 1 AND 7 THEN DATEPART(MM, DATEADD(DAY, 4, @CurrentDate)) + 5 ELSE DATEPART(MM, DATEADD(DAY, 4, @CurrentDate)) - 7 END
				SET @MinistryMonthAbbreviation = LEFT(CONVERT(VARCHAR(20), DATEADD(DAY, 4, @CurrentDate) , 107), 3)
				SET @MinistryMonthLabel = DATENAME(MONTH, DATEADD(DAY, 4, @CurrentDate)) 
			END

			IF DATENAME(WEEKDAY, @CurrentDate) = 'Thursday'  AND (DATEPART(MM, DATEADD(DAY, 3, @CurrentDate)) > DATEPART(MM, @CurrentDate) OR DATEPART(MM, DATEADD(DAY, 3, @CurrentDate)) = 1) AND DATEPART(MM, DATEADD(DAY, 6, @CurrentDate)) <> 8
			BEGIN
				SET @MinistryMonth = CASE WHEN DATEPART(MM, DATEADD(DAY, 3, @CurrentDate)) BETWEEN 1 AND 7 THEN DATEPART(MM, DATEADD(DAY, 3, @CurrentDate)) + 5 ELSE DATEPART(MM, DATEADD(DAY, 3, @CurrentDate)) - 7 END
				SET @MinistryMonthAbbreviation = LEFT(CONVERT(VARCHAR(20), DATEADD(DAY, 3, @CurrentDate) , 107), 3)
				SET @MinistryMonthLabel = DATENAME(MONTH, DATEADD(DAY, 3, @CurrentDate)) 
			END

			IF DATENAME(WEEKDAY, @CurrentDate) = 'Friday'    AND (DATEPART(MM, DATEADD(DAY, 2, @CurrentDate)) > DATEPART(MM, @CurrentDate) OR DATEPART(MM, DATEADD(DAY, 2, @CurrentDate)) = 1) AND DATEPART(MM, DATEADD(DAY, 6, @CurrentDate)) <> 8
			BEGIN
				SET @MinistryMonth = CASE WHEN DATEPART(MM, DATEADD(DAY, 2, @CurrentDate)) BETWEEN 1 AND 7 THEN DATEPART(MM, DATEADD(DAY, 2, @CurrentDate)) + 5 ELSE DATEPART(MM, DATEADD(DAY, 2, @CurrentDate)) - 7 END
				SET @MinistryMonthAbbreviation = LEFT(CONVERT(VARCHAR(20), DATEADD(DAY, 2, @CurrentDate) , 107), 3)
				SET @MinistryMonthLabel = DATENAME(MONTH, DATEADD(DAY, 2, @CurrentDate)) 
			END

			IF DATENAME(WEEKDAY, @CurrentDate) = 'Saturday'  AND (DATEPART(MM, DATEADD(DAY, 1, @CurrentDate)) > DATEPART(MM, @CurrentDate) OR DATEPART(MM, DATEADD(DAY, 1, @CurrentDate)) = 1) AND DATEPART(MM, DATEADD(DAY, 6, @CurrentDate)) <> 8
			BEGIN
				SET @MinistryMonth = CASE WHEN DATEPART(MM, DATEADD(DAY, 1, @CurrentDate)) BETWEEN 1 AND 7 THEN DATEPART(MM, DATEADD(DAY, 1, @CurrentDate)) + 5 ELSE DATEPART(MM, DATEADD(DAY, 1, @CurrentDate)) - 7 END
				SET @MinistryMonthAbbreviation = LEFT(CONVERT(VARCHAR(20), DATEADD(DAY, 1, @CurrentDate) , 107), 3)
				SET @MinistryMonthLabel = DATENAME(MONTH, DATEADD(DAY, 1, @CurrentDate)) 
			END

             --Begin day of week logic

		  /*Check for Change in Month of the Current date if Month changed then 
		    Change variable value*/

             IF @CurrentMonth != DATEPART(MM, @CurrentDate)
                 BEGIN
                     UPDATE @DayOfWeek
                       SET
                           MonthCount = 0;
                     SET @CurrentMonth = DATEPART(MM, @CurrentDate);
                 END;

		  /* Check for Change in Quarter of the Current date if Quarter changed then change 
		   Variable value*/

             IF @CurrentQuarter != DATEPART(QQ, @CurrentDate)
                 BEGIN
                     UPDATE @DayOfWeek
                       SET
                           QuarterCount = 0;
                     SET @CurrentQuarter = DATEPART(QQ, @CurrentDate);
                 END;
       
		  /* Check for Change in Year of the Current date if Year changed then change 
		   Variable value*/


             IF @CurrentYear != DATEPART(YY, @CurrentDate)
                 BEGIN
                     UPDATE @DayOfWeek
                       SET
                           YearCount = 0;
                     SET @CurrentYear = DATEPART(YY, @CurrentDate);
                 END;
	
             -- Set values in table data type created above from variables 

             UPDATE @DayOfWeek
               SET
                   MonthCount = MonthCount + 1,
                   QuarterCount = QuarterCount + 1,
                   YearCount = YearCount + 1
             WHERE DayOWeek = DATEPART(DW, @CurrentDate);
             SELECT @DayOfWeekInMonth = MonthCount
                  , @DayOfQuarter = QuarterCount
                  , @DayOfWeekInYear = YearCount
             FROM @DayOfWeek
             WHERE DayOWeek = DATEPART(DW, @CurrentDate);
	
             /*End day of week logic*/

             /* Populate Your Dimension Table with values*/

             INSERT INTO DW.DimDate
             (DateID, ActualDateLabel, ActualDate
			 --Calendar Dates
			 , CalendarWeek, CalendarWeekStartLabel, CalendarWeekEndLabel, CalendarDayOfWeek, CalendarDayOfWeekLabel
			 , CalendarDayOfWeekAbbreviation, CalendarMonth, CalendarMonthAbbreviation, CalendarMonthLabel
			 , CalendarDayOfMonth, CalendarLastDayOfMonthFlag, CalendarQuarter, CalendarQuarterLabel, CalendarYear
			 , CalendarYearLabel, CalendarDayOfYear
			 
			 --special calendar dates
			 , DateDescription, HolidayFlag, WeekendFlag
			 --Fiscal dates
			 , FiscalWeek, FiscalWeekStartLabel, FiscalWeekEndLabel, FiscalDayOfWeek, FiscalDayOfWeekLabel		
			 , FiscalDayOfWeekAbbreviation, FiscalMonth, FiscalMonthAbbreviation, FiscalMonthLabel
			 , FiscalDayOfMonth, FiscalLastDayOfMonthFlag, FiscalQuarter, FiscalQuarterLabel, FiscalYear					
			 , FiscalYearLabel, FiscalDayOfYear			
			 --MinistryDates
			 , MinistryWeek, MinistryWeekStartLabel, MinistryWeekEndLabel, MinistryDayOfWeek, MinistryDayOfWeekLabel		
			 , MinistryDayOfWeekAbbreviation, MinistryMonth, MinistryMonthAbbreviation, MinistryMonthLabel
			 , MinistryDayOfMonth, MinistryLastDayOfMonthFlag, MinistryQuarter, MinistryQuarterLabel, MinistryYear					
			 , MinistryYearLabel, MinistryDayOfYear		
			 --School Dates
			 , SchoolWeek, SchoolWeekStartLabel, SchoolWeekEndLabel, SchoolDayOfWeek, SchoolDayOfWeekLabel		
			 , SchoolDayOfWeekAbbreviation, SchoolMonth, SchoolMonthAbbreviation, SchoolMonthLabel
			 , SchoolDayOfMonth, SchoolLastDayOfMonthFlag, SchoolQuarter, SchoolQuarterLabel, SchoolYear					
			 , SchoolYearLabel, SchoolDayOfYear		
			 --etl columns
			 , ExecutionID, InsertedDateTime, UpdatedDateTime, Hashvalue  )
            SELECT 
				  CONVERT(  CHAR(8), @CurrentDate, 112) AS DateID
                , CONVERT(  CHAR(10), @CurrentDate, 101) AS ActualDateLabel
                , @CurrentDate AS ActualDate
                --Calendar Dates
				, DATEPART(WEEK, @currentDate) AS CalendarWeek
				, @CalendarWeekStartLabel AS CalendarWeekStartLabel
				, @CalendarWeekEndLabel AS CalendarWeekEndLabel
				, DATEPART(WEEKDAY, @CurrentDate) AS CalendarDayOfWeek
				, DATENAME(WEEKDAY, @CurrentDate) AS CalendarDayOfWeekLabel
				, CASE DATEPART(WEEKDAY, @CurrentDate)
					WHEN 1 THEN 'Sun'
					WHEN 2 THEN 'Mon'
					WHEN 3 THEN 'Tue'
					WHEN 4 THEN 'Wed'
					WHEN 5 THEN 'Thu'
			 		WHEN 6 THEN 'Fri'
					WHEN 7 THEN 'Sat'
				  END AS CalendarDayOfWeekAbbreviation
				, @CurrentMonth AS CalendarMonth
				, LEFT(CONVERT(VARCHAR(20), CONVERT(DATE, @CurrentDate) , 107), 3) AS CalendarMonthAbbreviation
				, DATENAME(MONTH, @currentDate) AS CalendarMonthLabel
				, DATEPART(DAY, @CurrentDate) AS CalendarDayofmonth
				, CASE WHEN @currentDate = CONVERT(  DATETIME, CONVERT(DATE, DATEADD(DD, -(DATEPART(DD, (DATEADD(MM, 1, @CurrentDate)))), DATEADD(MM, 1, @CurrentDate))))
				  THEN 1
				  ELSE 0 END AS CalendarLastDayOfMonthFlag
				, DATEPART(QQ, @CurrentDate)  AS CalendarQuarter
				, 'Q' + CONVERT(CHAR(1), DATEPART(QQ, @CurrentDate)) + '-'
					+ CONVERT(VARCHAR(4), DATEPART(YEAR, @CurrentDate)) AS CalendarQuarterLabel
				, DATEPART(YEAR, @CurrentDate) AS CalendarYear	
				, CONVERT(VARCHAR(4), DATEPART(YEAR, @CurrentDate)) CalendarYearLabel	
				, DATEPART(DAYOFYEAR, @CurrentDate) AS CalendarDayOfYear
			 
				-- not sure what to store in DateDescription
				, NULL AS DateDescription
				, NULL AS HolidayFlag                
				, CASE WHEN DATEPART(WEEKDAY, @CurrentDate) IN (1,7) THEN 1 ELSE 0 END AS WeekendFlag 
			 
			 --Fiscal dates
			 , NULL AS FiscalWeek     
			 , NULL AS FiscalWeekStartLabel       
			 , NULL AS FiscalWeekEndLabel         
			 , DATEPART(WEEKDAY, @CurrentDate) AS FiscalDayOfWeek  
			 , DATENAME(WEEKDAY, @CurrentDate) AS FiscalDayOfWeekLabel
			 , CASE DATEPART(WEEKDAY, @CurrentDate)
				WHEN 1 THEN 'Sun'
				WHEN 2 THEN 'Mon'
				WHEN 3 THEN 'Tue'
				WHEN 4 THEN 'Wed'
				WHEN 5 THEN 'Thu'
			 	WHEN 6 THEN 'Fri'
				WHEN 7 THEN 'Sat'
			   END AS FiscalDayOfWeekAbbreviation      
			 , CASE WHEN @CurrentMonth BETWEEN 1 AND 6 THEN @CurrentMonth + 6 ELSE @CurrentMonth - 6 END AS FiscalMonth  
			 , LEFT(CONVERT(VARCHAR(20), CONVERT(DATE, @CurrentDate) , 107), 3) AS FiscalMonthAbbreviation    
			 , DATENAME(MONTH, @currentDate) AS FiscalMonthLabel           
			 , DATEPART(DAY, @CurrentDate) AS FiscalDayOfMonth           
			 , CASE WHEN @currentDate = CONVERT(  DATETIME, CONVERT(DATE, DATEADD(DD, -(DATEPART(DD, (DATEADD(MM, 1, @CurrentDate)))), DATEADD(MM, 1, @CurrentDate))))
				THEN 1
				ELSE 0 END AS FiscalLastDayOfMonthFlag
			 , NULL AS FiscalQuarter  
			 , NULL AS FiscalQuarterLabel         
			 , CASE WHEN @CurrentMonth BETWEEN 1 AND 6 THEN DATEPART(YEAR, @CurrentDate) ELSE DATEPART(YEAR, @CurrentDate) + 1 END AS FiscalYear   
			 , CONVERT(VARCHAR(4), CASE WHEN @CurrentMonth BETWEEN 1 AND 6 THEN DATEPART(YEAR, @CurrentDate) ELSE DATEPART(YEAR, @CurrentDate) + 1 END) AS FiscalYearLabel   
			 , NULL AS FiscalDayOfYear            
			             
			-- Ministry Dates
			---fix ministry week in an update
			 , @MinistryWeek AS MinistryWeek  
			 , @MinistryWeekStartLabel AS MinistryWeekStartLabel       
			 , @MinistryWeekEndLabel AS MinistryWeekEndLabel         
			 --shift all day of week - 1 (from first day of week sunday, to first day of week is monday)
			 , CASE WHEN DATEPART(WEEKDAY, @CurrentDate) BETWEEN 2 AND 7 THEN DATEPART(WEEKDAY, @CurrentDate) - 1 ELSE 7 END AS MinistryDayOfWeek
			 , DATENAME(WEEKDAY, @CurrentDate) AS MinistryDayOfWeekLabel
			 , CASE DATEPART(WEEKDAY, @CurrentDate)
				WHEN 1 THEN 'Sun'
				WHEN 2 THEN 'Mon'
				WHEN 3 THEN 'Tue'
				WHEN 4 THEN 'Wed'
				WHEN 5 THEN 'Thu'
			 	WHEN 6 THEN 'Fri'
				WHEN 7 THEN 'Sat'
			   END AS MinistryDayOfWeekAbbreviation      
			 , @MinistryMonth AS MinistryMonth  
			 , @MinistryMonthAbbreviation AS MinistryMonthAbbreviation    
			 , @MinistryMonthLabel AS MinistryMonthLabel
			 --The ministry Day of month won't always be right, correct it later         
			 , NULL AS MinistryDayOfMonth           
			 , CASE WHEN @currentDate = CONVERT(  DATETIME, CONVERT(DATE, DATEADD(DD, -(DATEPART(DD, (DATEADD(MM, 1, @CurrentDate)))), DATEADD(MM, 1, @CurrentDate))))
				THEN 1
				ELSE 0 END AS MinistryLastDayOfMonthFlag
			 , NULL AS MinistryQuarter  
			 , NULL AS MinistryQuarterLabel         
			 , CASE WHEN @CurrentMonth BETWEEN 1 AND 7 THEN DATEPART(YEAR, @CurrentDate) ELSE DATEPART(YEAR, @CurrentDate) + 1 END AS MinistryYear   
			 , CONVERT(VARCHAR(4), CASE WHEN @CurrentMonth BETWEEN 1 AND 7 THEN DATEPART(YEAR, @CurrentDate) ELSE DATEPART(YEAR, @CurrentDate) + 1 END) AS MinistryYearLabel   
			 --the ministrydayofyear will be corrected via update
			 , NULL AS MinistryDayOfYear     

			--School Dates
			 , NULL AS SchoolWeek     
			 , NULL AS SchoolWeekStartLabel       
			 , NULL AS SchoolWeekEndLabel         
			 , DATEPART(WEEKDAY, @CurrentDate) AS SchoolDayOfWeek  
			 , DATENAME(WEEKDAY, @CurrentDate) AS SchoolDayOfWeekLabel
			 , CASE DATEPART(WEEKDAY, @CurrentDate)
				WHEN 1 THEN 'Sun'
				WHEN 2 THEN 'Mon'
				WHEN 3 THEN 'Tue'
				WHEN 4 THEN 'Wed'
				WHEN 5 THEN 'Thu'
			 	WHEN 6 THEN 'Fri'
				WHEN 7 THEN 'Sat'
			   END AS SchoolDayOfWeekAbbreviation      
			 , CASE WHEN @CurrentMonth BETWEEN 1 AND 5 THEN @CurrentMonth + 7 ELSE @CurrentMonth - 5 END AS SchoolMonth  
			 , LEFT(CONVERT(VARCHAR(20), CONVERT(DATE, @CurrentDate) , 107), 3) AS SchoolMonthAbbreviation    
			 , DATENAME(MONTH, @currentDate) AS SchoolMonthLabel           
			 , DATEPART(DAY, @CurrentDate) AS SchoolDayOfMonth           
			 , CASE WHEN @currentDate = CONVERT(  DATETIME, CONVERT(DATE, DATEADD(DD, -(DATEPART(DD, (DATEADD(MM, 1, @CurrentDate)))), DATEADD(MM, 1, @CurrentDate))))
				THEN 1
				ELSE 0 END AS SchoolLastDayOfMonthFlag
			 , NULL AS SchoolQuarter  
			 , NULL AS SchoolQuarterLabel         
			 , CASE WHEN @CurrentMonth BETWEEN 1 AND 5 THEN DATEPART(YEAR, @CurrentDate) ELSE DATEPART(YEAR, DATEADD(YEAR, 1, @currentdate)) END AS SchoolYear   
			 , CASE WHEN @CurrentMonth BETWEEN 1 AND 5 THEN 
					CONVERT(VARCHAR(4), DATEPART(YEAR, DATEADD(YEAR, -1, @CurrentDate))) + '/' + RIGHT(CONVERT(VARCHAR(4), DATEPART(YEAR, @CurrentDate)), 2)
			   ELSE 
					CONVERT(VARCHAR(4), DATEPART(YEAR, @CurrentDate)) + '/' + RIGHT(CONVERT(VARCHAR(4), DATEPART(YEAR, DATEADD(YEAR, 1, @CurrentDate))), 2)
			   END AS SchoolYearLabel   
			 , NULL AS SchoolDayOfYear 
			                
			 , -1 AS ExecutionID
			 , GETDATE() AS InsertedDateTime
			 , GETDATE() AS UpdatedDateTime
			 , '' AS Hashvalue
         
             SET @CurrentDate = DATEADD(DD, 1, @CurrentDate);
         END;
	--Correct MinistryDayOfMonth
    ;WITH MinistryDaysInMonth AS (
		SELECT DateID, MinistryMonth, MinistryYear
		, ROW_NUMBER() OVER(PARTITION BY MinistryMonth, MinistryYear ORDER BY DateID ) AS MinistryDayOfMonth
		FROM DW.DimDate
	)
	UPDATE DimDate SET DimDate.MinistryDayOfMonth = MinistryDaysInMonth.MinistryDayOfMonth
	FROM DW.DimDate
	INNER JOIN MinistryDaysInMonth
		ON DimDate.DateID = MinistryDaysInMonth.DateID;

	--Correct MinsitryWeek
	--abandon this version, try to do it in the loop
	--;WITH MinistryWeek AS (
	--	SELECT
	--	  DateID, CalendarWeek, CalendarMonth
	--	, MinistryYear
	--	, MinistryMonth
	--	, MinistryDayOfWeek
	--	, DENSE_RANK() OVER (PARTITION BY MinistryYear, MinistryDayOfWeek ORDER BY MinistryMonth, MinistryDayOfMonth) AS MinistryWeek
	--FROM DW.DimDate
	--)
	--UPDATE DimDate SET DimDate.MinistryWeek = MinistryWeek.MinistryWeek
	--FROM DW.DimDate
	--INNER JOIN MinistryWeek
	--	ON DimDate.DateID = MinistryWeek.DateID
	--;	

	--Correct MinistryDayOfYear
	;WITH MinistryDayOfYear AS (
		SELECT
		  DateID, CalendarWeek, CalendarMonth
		, MinistryYear
		, MinistryMonth
		, MinistryDayOfWeek
		, DENSE_RANK() OVER (PARTITION BY MinistryYear ORDER BY DateID) AS MinistryDayOfYear
	FROM DW.DimDate
	)
	UPDATE DimDate SET DimDate.MinistryDayOfYear = MinistryDayOfYear.MinistryDayOfYear
	FROM DW.DimDate
	INNER JOIN MinistryDayOfYear
		ON DimDate.DateID = MinistryDayOfYear.DateID
	;	
			 
	
     /*THANKSGIVING - Fourth THURSDAY in November*/

     UPDATE DW.DimDate
       SET
           HolidayFlag = 1 --'Thanksgiving Day'
     WHERE CalendarMonth = 11
           AND CalendarDayOfWeekLabel = 'Thursday'
           --need to calculate this AND DayOfWeekInMonth = 4;
		 AND (DATEPART(WEEK, ActualDate) - DATEPART(WEEK, CONVERT(DATE, '11/1/' + CONVERT(VARCHAR(4), CalendarYear) )) ) + 1 = 4
		 AND ActualDate BETWEEN @StartDate AND @EndDate;

     /*CHRISTMAS*/

     UPDATE DW.DimDate
       SET
           HolidayFlag = 1 --'Christmas Day'
     WHERE CalendarMonth = 12
           AND CalendarDayOfMonth = 25
		 AND ActualDate BETWEEN @StartDate AND @EndDate;

     /*4th of July*/

     UPDATE DW.DimDate
       SET
           HolidayFlag = 1 --'Independance Day'
     WHERE CalendarMonth = 7
           AND CalendarDayOfMonth = 4
		 AND ActualDate BETWEEN @StartDate AND @EndDate;

     /*New Years Day*/

     UPDATE DW.DimDate
       SET
           HolidayFlag = 1 --'New Year''s Day'
     WHERE CalendarMonth = 1
           AND CalendarDayOfMonth = 1
		 AND ActualDate BETWEEN @StartDate AND @EndDate;

     /*Memorial Day - Last Monday in May*/

     UPDATE DW.DimDate
       SET
           HolidayFlag = 1 --'Memorial Day'
     FROM DW.DimDate
     WHERE DateID IN
     (
         SELECT MAX(DateID)
         FROM DW.DimDate
         WHERE CalendarMonthLabel = 'May'
               AND CalendarDayOfWeekLabel = 'Monday'
			AND ActualDate BETWEEN @StartDate AND @EndDate
         GROUP BY CalendarYear
                , CalendarMonth
     )AND ActualDate BETWEEN @StartDate AND @EndDate;

     /*Labor Day - First Monday in September*/

     UPDATE DW.DimDate
       SET
           HolidayFlag = 1 --'Labor Day'
     FROM DW.DimDate
     WHERE DateID IN
     (
         SELECT MIN(DateID)
         FROM DW.DimDate
         WHERE CalendarMonthLabel = 'September'
               AND CalendarDayOfWeekLabel = 'Monday'
			AND ActualDate BETWEEN @StartDate AND @EndDate
         GROUP BY CalendarYear
                , CalendarMonth
     )AND ActualDate BETWEEN @StartDate AND @EndDate;

     /*Valentine's Day*/

     UPDATE DW.DimDate
       SET
           HolidayFlag = 1 --'Valentine''s Day'
     WHERE CalendarMonth = 2
           AND CalendarDayOfMonth = 14
		 AND ActualDate BETWEEN @StartDate AND @EndDate;

     /*Saint Patrick's Day*/

     UPDATE DW.DimDate
       SET
           HolidayFlag = 1 --'Saint Patrick''s Day'
     WHERE CalendarMonth = 3
           AND CalendarDayOfMonth = 17
		 AND ActualDate BETWEEN @StartDate AND @EndDate;

     /*Martin Luthor King Day - Third Monday in January starting in 1983*/

     UPDATE DW.DimDate
       SET
           HolidayFlag = 1 --'Martin Luthor King Jr Day'
     WHERE CalendarMonth = 1
           AND CalendarDayOfWeekLabel = 'Monday'
           AND CalendarYear >= 1983
            AND (DATEPART(WEEK, ActualDate) - DATEPART(WEEK, CONVERT(DATE, '11/1/' + CONVERT(VARCHAR(4), CalendarYear) )) ) + 1 = 3
		 AND ActualDate BETWEEN @StartDate AND @EndDate;

     /*President's Day - Third Monday in February*/

     UPDATE DW.DimDate
       SET
           HolidayFlag = 1 --'President''s Day'
     WHERE CalendarMonth = 2
           AND CalendarDayOfWeekLabel = 'Monday'
            AND (DATEPART(WEEK, ActualDate) - DATEPART(WEEK, CONVERT(DATE, '11/1/' + CONVERT(VARCHAR(4), CalendarYear) )) ) + 1 = 3
		 AND ActualDate BETWEEN @StartDate AND @EndDate;

     /*Mother's Day - Second Sunday of May*/

     UPDATE DW.DimDate
       SET
           HolidayFlag = 1 --'Mother''s Day'
     WHERE CalendarMonth = 5
           AND CalendarDayOfWeekLabel = 'Sunday'
            AND (DATEPART(WEEK, ActualDate) - DATEPART(WEEK, CONVERT(DATE, '11/1/' + CONVERT(VARCHAR(4), CalendarYear) )) ) + 1 = 2
		 AND ActualDate BETWEEN @StartDate AND @EndDate;

     /*Father's Day - Third Sunday of June*/

     UPDATE DW.DimDate
       SET
           HolidayFlag = 1 --'Father''s Day'
     WHERE CalendarMonth = 6
           AND CalendarDayOfWeekLabel = 'Sunday'
            AND (DATEPART(WEEK, ActualDate) - DATEPART(WEEK, CONVERT(DATE, '11/1/' + CONVERT(VARCHAR(4), CalendarYear) )) ) + 1 = 3
		 AND ActualDate BETWEEN @StartDate AND @EndDate;

     /*Halloween 10/31*/

     UPDATE DW.DimDate
       SET
           HolidayFlag = 1 --'Halloween'
     WHERE CalendarMonth = 10
           AND CalendarDayOfMonth = 31
		 AND ActualDate BETWEEN @StartDate AND @EndDate;
     
     RETURN 0;
GO