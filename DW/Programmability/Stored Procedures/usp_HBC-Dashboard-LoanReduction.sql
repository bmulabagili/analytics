--drop PROCEDURE [DW].[usp_HBC-Dashboard-LoanReduction]

/*
Created By: Linda Kuhajda
Created Date: 5/12/2016
Updated:

Purpose: Get Loan Reduction data for HBC dashboard

exec [DW].[usp_HBC-Dashboard-LoanReduction] 2, 2016
*/

CREATE PROCEDURE [DW].[usp_HBC-Dashboard-LoanReduction]
	 @CurrMonth TINYINT  
	, @CurrYear INTEGER

AS

declare 
			--@CurrMonth TINYINT = 2,
		 --   @CurrYear INTEGER = 2016, 
			@LastYear INTEGER,
			@CurrYearLoanRed MONEY,
		    @LastYearLoanRed MONEY,
			@CurrMonthLoanRed MONEY

-- CurrentMonth

	SELECT -- SUM(t1.amount) as CurrentMonth
	@CurrMonthLoanRed = SUM(t1.Amount)
	--[GLCode],  t1.amount
	FROM [DW].[FactFinancialOther] t1
	LEFT JOIN [DW].[DimFinancialCategory] t2
	ON t1.[FinancialCategoryID] = t2.[FinancialCategoryID]
	JOIN DW.DimDate T3
	ON t1.DateID = t3.DateID 
	WHERE t3.[CalendarYear] =  @CurrYear --2016
	AND t3.[CalendarMonth] = @CurrMonth --MONTH(GETDATE())
	--GL accounts 24225 through 24272.  
	AND t2.[GLCode] >= 24225
	AND t2.[GLCode] <= 24272
	AND t2.TenantID = 3

-------------------------------------
	SELECT @LastYear  = @CurrYear -1

	SELECT  --SUM(t1.amount) as LoadRedAmount
	@CurrYearLoanRed = SUM(t1.amount) 
	--[GLCode],  t1.amount
	FROM [DW].[FactFinancialOther] t1
	LEFT JOIN [DW].[DimFinancialCategory] t2
	ON t1.[FinancialCategoryID] = t2.[FinancialCategoryID]
	JOIN DW.DimDate T3
	ON t1.DateID = t3.DateID 
	WHERE t3.[CalendarYear] =  @CurrYear
	AND t3.[CalendarMonth]  <=  @CurrMonth
	--GL accounts 24225 through 24272.  
	AND [GLCode] in (24225, 24230, 24233, 24235, 24272 )
	AND t2.TenantID = 3


	SELECT -- SUM(t1.amount) as LoadRedAmount
	@LastYearLoanRed = SUM(t1.amount)
	--[GLCode],  t1.amount
	FROM [DW].[FactFinancialOther] t1
	LEFT JOIN [DW].[DimFinancialCategory] t2
	ON t1.[FinancialCategoryID] = t2.[FinancialCategoryID]
	JOIN DW.DimDate T3
	ON t1.DateID = t3.DateID 
	WHERE t3.[CalendarYear] = @CurrYear -1
	--AND t3.[CalendarMonth]  <= @CurrMonth
	--GL accounts 24225 through 24272.  
	AND [GLCode] in (24225, 24230, 24233, 24235, 24272 )
	AND t2.TenantID = 3

	SELECT @CurrYearLoanRed AS CurrentYear, @LastYearLoanRed + @CurrYearLoanRed  as MortgageBalance
		, @CurrMonthLoanRed as CurrentMonth

	RETURN 0