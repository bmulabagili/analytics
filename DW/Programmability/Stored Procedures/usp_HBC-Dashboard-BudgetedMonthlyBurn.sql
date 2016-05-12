

--drop PROCEDURE [DW].[usp_HBC-Dashboard-BudgetedMonthlyBurn]

/*
Created By: Linda Kuhajda
Created Date: 5/12/2016
Updated:

Purpose: Calculate monthly burn based on a weekly amount applied for the number
of Sundays in the month

exec [DW].[usp_HBC-Dashboard-BudgetedMonthlyBurn] '1-1-2016', '12-31-2016', 460000
*/

CREATE PROCEDURE [DW].[usp_HBC-Dashboard-BudgetedMonthlyBurn]
	 @BeginningDate DATETIME  
	, @EndingDate DATETIME
	, @WeeklyBudgetAmount money
AS

--DECLARE @NumSun TINYINT,
--@WeeklyBudgetAmount money = 460000,
-- @BeginningDate DATETIME, @EndingDate DATETIME

--SELECT @BeginningDate = '1-1-2016', @EndingDate = '12-31-2016'

;WITH dates (date)
AS
(
SELECT @BeginningDate
UNION all
SELECT dateadd(d,1,date)
FROM dates
WHERE date < @EndingDate
)

--select * from dates
--select date from dates where datename(dw, date) = 'sunday'

SELECT  month(date) as BudgetMonth
, count(1) as NumSundaysInMonth
,  count(1) * @WeeklyBudgetAmount as WeeklyBudgetAmount
--, (select sum(count(1) * @WeeklyBudgetAmount) from dates d2 where month(d2.date) <= month(d1.date)) 'CumulativeSum'
into #t1
from dates d1 where datename(dw, date) = 'sunday'

group by month(date)

option (maxrecursion 1000)

--select * from #t1

select BudgetMonth, NumSundaysInMonth, WeeklyBudgetAmount
	, (select sum(d2.WeeklyBudgetAmount) from #t1 d2  where d2.BudgetMonth <= d1.BudgetMonth)  'CumulativeSum'

from #t1 d1

drop table #t1


RETURN 0