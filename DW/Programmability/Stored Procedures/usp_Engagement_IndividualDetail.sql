CREATE PROCEDURE [DW].[usp_Engagement_IndividualDetail]
	  @IndividualIdentifier INT
	, @StartDate DATE
	, @EndDate DATE
AS

--individual Involvement
SELECT FactEngagement.* 
FROM dw.FactEngagement
INNER JOIN DW.DimDate
	ON FactEngagement.DateID = DimDate.DateID
WHERE 
	IndividualIdentifier = @IndividualIdentifier
	--optionally date ranges:
	AND DimDate.ActualDate BETWEEN @StartDate AND @EndDate
	
--family involvement:
Select FactEngagement.*
FROM dw.FactEngagement
INNER JOIN DW.DimDate
	ON FactEngagement.DateID = DimDate.DateID
WHERE 
	HouseholdIdentifier IN (SELECT DISTINCT HouseholdIdentifier FROM DW.Factengagement WHERE IndividualIdentifier = @IndividualIdentifier)
	AND IndividualIdentifier <> @IndividualIdentifier
	AND DimDate.ActualDate BETWEEN @StartDate AND @EndDate