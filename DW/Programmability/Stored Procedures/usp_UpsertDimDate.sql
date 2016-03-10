CREATE PROCEDURE [DW].[usp_UpsertDimDate] @StartDate DATE,
                                          @EndDate   DATE
AS
    --based on http://www.codeproject.com/Articles/647950/Create-and-Populate-Date-Dimension-for-Data-Wareho
     --REMOVE existing rows	
	DELETE FROM DW.DimDate 
	WHERE
	   ActualDate BETWEEN @StartDate AND @EndDate;

     --Temporary Variables To Hold the Values During Processing of Each Date of Year
     DECLARE @DayOfWeekInMonth INT, @DayOfWeekInYear INT, @DayOfQuarter INT, @WeekOfMonth INT, @CurrentYear INT, @CurrentMonth INT, @CurrentQuarter INT;

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

    --Proceed only if Start Date(Current date ) is less than End date you specified above
    WHILE @CurrentDate < @EndDate
         BEGIN
 
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
             --(DateID, ActualDateLabel, ActualDate, CalendarDayOfMonth  )
            SELECT 
			   CONVERT(  CHAR(8), @CurrentDate, 112) AS DateID
                , CONVERT(  CHAR(10), @CurrentDate, 101) AS ActualDateLabel
                , @CurrentDate AS ActualDate
                , DATEPART(DAY, @CurrentDate) AS CalendarDayofmonth
                , DATEPART(DAYOFYEAR, @CurrentDate) AS CalendarDayOfYear
			 , CASE WHEN @currentDate = CONVERT(  DATETIME, CONVERT(DATE, DATEADD(DD, -(DATEPART(DD, (DATEADD(MM, 1, @CurrentDate)))), DATEADD(MM, 1, @CurrentDate))))
				THEN 1
				ELSE 0 END AS CalendarLastDayOfMonthFlag
			 , DATEPART(MONTH, @CurrentDate) AS CalendarMonth
			 , LEFT(CONVERT(VARCHAR(20), CONVERT(DATE, @CurrentDate) , 107), 3) AS CalendarMonthAbbreviation
			 , DATENAME(MONTH, @currentDate) AS CalendarMonthLabel
			 , DATEPART(QQ, @CurrentDate)  AS CalendarQuarter
			 , 'Q' + CONVERT(CHAR(1), DATEPART(QQ, @CurrentDate)) + '-'
				+ CONVERT(VARCHAR(4), DATEPART(YEAR, @CurrentDate)) AS CalendarQuarterLabel
			 , DATEPART(WEEK, @currentDate) AS CalendarWeek
			 --come back later to add CalendarWeekStartLabel
			 , NULL AS CalendarWeekStartLabel
			 --come back later to add CalendarWeekEndLabel
			 , NULL AS CalendarWeekEndLabel
			 , DATEPART(YEAR, @CurrentDate) AS CalendarYear
			 , CONVERT(VARCHAR(4), DATEPART(YEAR, @CurrentDate)) CalendarYearLabel	
			 -- not sure what to store in DateDescription
			 , NULL AS DateDescription
			 , DATEPART(WEEKDAY, @CurrentDate) AS [DayOfWeek]
			 , CASE DATEPART(WEEKDAY, @CurrentDate)
				WHEN 1 THEN 'Sun'
				WHEN 2 THEN 'Mon'
				WHEN 3 THEN 'Tue'
				WHEN 4 THEN 'Wed'
				WHEN 5 THEN 'Thu'
			 	WHEN 6 THEN 'Fri'
				WHEN 7 THEN 'Sat'
			   END AS DayOfWeekAbbreviation
			 , DATENAME(WEEKDAY, @CurrentDate) AS DayOfWeekLabel
			 --come back to Fiscal stuff later
			 , DATEPART(WEEKDAY, @CurrentDate) AS FiscalDayOfWeek            
			 , DATEPART(DAY, @CurrentDate) AS FiscalDayOfMonth           
			 , NULL AS FiscalDayOfYear            
			 , CASE WHEN DATEPART(MONTH, @CurrentDate) BETWEEN 1 AND 7 THEN DATEPART(MONTH, @CurrentDate) + 5 ELSE DATEPART(MONTH, @CurrentDate) - 7 END AS FiscalMonth  
			 , LEFT(CONVERT(VARCHAR(20), CONVERT(DATE, @CurrentDate) , 107), 3) AS FiscalMonthAbbreviation    
			 , DATENAME(MONTH, @currentDate) AS FiscalMonthLabel           
			 , NULL AS FiscalQuarter              
			 , NULL AS FiscalQuarterLabel         
			 , NULL AS FiscalWeek                 
			 , NULL AS FiscalWeekStartLabel       
			 , NULL AS FiscalWeekEndLabel         
			 , CASE WHEN DATEPART(MONTH, @CurrentDate) BETWEEN 1 AND 7 THEN DATEPART(YEAR, @CurrentDate) ELSE DATEPART(YEAR, @CurrentDate) + 1 END AS FiscalYear               
			 , CONVERT(VARCHAR(4), CASE WHEN DATEPART(MONTH, @CurrentDate) BETWEEN 1 AND 7 THEN DATEPART(YEAR, @CurrentDate) ELSE DATEPART(YEAR, @CurrentDate) + 1 END) AS FiscalYearLabel            
			 , NULL AS HolidayFlag                
			 , CASE WHEN DATEPART(WEEKDAY, @CurrentDate) IN (1,7) THEN 1 ELSE 0 END AS WeekendFlag                
			 , -1 AS ExecutionID
			 , GETUTCDATE() AS InsertedDateTime
			 , GETUTCDATE() AS UpdatedDateTime
			 , '' AS HashValue
         
             SET @CurrentDate = DATEADD(DD, 1, @CurrentDate);
         END;

    
	
     /*THANKSGIVING - Fourth THURSDAY in November*/

     UPDATE DW.DimDate
       SET
           HolidayFlag = 1 --'Thanksgiving Day'
     WHERE CalendarMonth = 11
           AND DayOfWeekLabel = 'Thursday'
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
               AND DayOfWeekLabel = 'Monday'
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
               AND DayOfWeekLabel = 'Monday'
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
           AND DayOfWeekLabel = 'Monday'
           AND CalendarYear >= 1983
            AND (DATEPART(WEEK, ActualDate) - DATEPART(WEEK, CONVERT(DATE, '11/1/' + CONVERT(VARCHAR(4), CalendarYear) )) ) + 1 = 3
		 AND ActualDate BETWEEN @StartDate AND @EndDate;

     /*President's Day - Third Monday in February*/

     UPDATE DW.DimDate
       SET
           HolidayFlag = 1 --'President''s Day'
     WHERE CalendarMonth = 2
           AND DayOfWeekLabel = 'Monday'
            AND (DATEPART(WEEK, ActualDate) - DATEPART(WEEK, CONVERT(DATE, '11/1/' + CONVERT(VARCHAR(4), CalendarYear) )) ) + 1 = 3
		 AND ActualDate BETWEEN @StartDate AND @EndDate;

     /*Mother's Day - Second Sunday of May*/

     UPDATE DW.DimDate
       SET
           HolidayFlag = 1 --'Mother''s Day'
     WHERE CalendarMonth = 5
           AND DayOfWeekLabel = 'Sunday'
            AND (DATEPART(WEEK, ActualDate) - DATEPART(WEEK, CONVERT(DATE, '11/1/' + CONVERT(VARCHAR(4), CalendarYear) )) ) + 1 = 2
		 AND ActualDate BETWEEN @StartDate AND @EndDate;

     /*Father's Day - Third Sunday of June*/

     UPDATE DW.DimDate
       SET
           HolidayFlag = 1 --'Father''s Day'
     WHERE CalendarMonth = 6
           AND DayOfWeekLabel = 'Sunday'
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