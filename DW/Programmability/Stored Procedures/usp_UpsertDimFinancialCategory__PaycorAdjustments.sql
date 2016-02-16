CREATE PROCEDURE [DW].[usp_UpsertDimFinancialCategory__PaycorAdjustments]
AS
	DECLARE @MaxFinancialCategoryID INT

	SELECT @MaxFinancialCategoryID = ISNULL(MAX(FinancialCategoryID), 1)
	FROM DW.DimFinancialCategory
	
	INSERT INTO DW.DimFinancialCategory
	SELECT 
		  ROW_NUMBER() OVER (ORDER BY Paycor_MIP_Mapping.GLOrgCode, Paycor_MIP_Mapping.CampusCode, DimCampus.Name, Paycor_MIP_Mapping.AccountingCode9, Paycor_MIP_Mapping.AccountingName9 ) + @MaxFinancialCategoryID AS FinancialCategoryID
		, 3 AS TenantID -- only works for HBC
		, Paycor_MIP_Mapping.GLOrgCode as GLCode
		, 'Paycor' AS GLName
		, 'EXP' AS GLType
		, NULL AS GLDesignationCode
		, '025' AS FundCode
		, 'General' AS FundName
		, NULL AS FundType
		, NULL AS FundDesignationCode
		, 3 AS EntityID -- HBC ONLY
		, 'HBC' AS EntityCode
		, 'Harvest Bible Chapel' AS EntityName
		, NULL AS EntityType
		, NULL AS EntityDesignationCode
		, Paycor_MIP_Mapping.CampusCode AS CampusCode
		, DimCampus.Name AS CampusName
		, NULL AS CampusType
		, NULL AS CampusDesignationCode
		, NULL AS DepartmentCode
		, NULL AS DepartmentName
		, NULL AS DepartmentType
		, NULL AS DepartmentDesignationCode
		, NULL AS StaffCode
		, NULL AS StaffName
		, NULL AS StaffType
		, NULL AS StaffDesignationCode
		, NULL AS ProjectCode
		, NULL AS ProjectName
		, NULL AS ProjectType
		, NULL AS ProjectDesignationCode
		, NULL AS RestrictionCode
		, NULL AS RestrictionName
		, NULL AS RestrictionType
		, NULL AS RestrictionDesignationCode
		, 'PER1' AS CategoryCode
		, 'Personnel' AS CategoryName
		, NULL AS CategoryType
		, NULL AS CategoryDesignationCode
		, Paycor_MIP_Mapping.AccountingCode9
		, Paycor_MIP_Mapping.AccountingName9
		, NULL as AccountingType9
		, NULL AS AccountingDesignationCode9
		, NULL AS AccountgingCode10
		, 'Paycor Adjustment' AS ExecutionID
		, GETDATE() AS InsertedDateTime
		, GETDATE() AS UpdatedDateTime
		, '' AS HashValue
	FROM Paycor_MIP_Mapping
	LEFT JOIN DW.DimCampus
		ON Paycor_MIP_Mapping.CampusCode = DimCampus.Code
		AND DimCampus.TenantID = 3
	LEFT JOIN DW.DimFinancialCategory
		ON DimFinancialCategory.TenantID = 3
	AND DimFinancialCategory.GLCode = Paycor_MIP_Mapping.GLOrgCode 
	AND DimFinancialCategory.GLName = 'Paycor'
	AND DimFinancialCategory.GLType = 'EXP'
	AND Paycor_MIP_Mapping.CampusCode = DimFinancialCategory.CampusCode
	AND Paycor_MIP_Mapping.AccountingCode9 = DimFinancialCategory.AccountingCode9
	AND Paycor_MIP_Mapping.AccountingName9 = DimFinancialCategory.AccountingName9
	WHERE
		DimFinancialCategory.FinancialCategoryID IS NULL


	RETURN 0
