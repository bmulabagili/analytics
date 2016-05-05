CREATE PROCEDURE [dbo].[usp_Initialize_CampusXLTReportGroupRows]
AS

	--truncate the groups first
	TRUNCATE TABLE CampusXLTReportGroup_CampusTab;

	--then load
	INSERT INTO CampusXLTReportGroup_CampusTab
	(CampusXLTReportGroupID	, CampusHeading		, CampusDetail													, CampusDetailSortOrder, CampusCode			, CampusCodeSortOrder	, AllocateByAttendancePercentage)

	SELECT 1				, 'Compensation'	,'Direct (Ops)'													, 1						, 'EL'				, 2						, 0	UNION
	SELECT 2				, 'Compensation'	,'Direct (Ops)'													, 1						, 'RM'				, 3						, 0	UNION
	SELECT 3				, 'Compensation'	,'Indirect (IT)'												, 2						, NULL				, NULL					, 1	UNION
	SELECT 4				, 'Compensation'	,'Indirect (Central Svcs)'										, 3						, NULL				, NULL					, 1	UNION
	SELECT 5				, 'Compensation'	,'Direct (Min Staff/Admin)'										, 4						, 'EL'				, 2						, 0	UNION
	SELECT 6				, 'Compensation'	,'Direct (Min Staff/Admin)'										, 4						, 'RM'				, 3						, 0	UNION
	SELECT 7				, 'Compensation'	,'Direct (Min Staff/Admin)'										, 4						, 'NI'				, 4						, 0	UNION
	SELECT 8				, 'Compensation'	,'Direct (Min Staff/Admin)'										, 4						, 'CL'				, 5						, 0	UNION
	SELECT 9				, 'Compensation'	,'Direct (Min Staff/Admin)'										, 4						, 'CC'				, 6						, 0	UNION
	SELECT 10				, 'Compensation'	,'Direct (Min Staff/Admin)'										, 4						, 'AU'				, 7						, 0	UNION
	SELECT 11				, 'Compensation'	,'Direct (Min Staff/Admin)'										, 4						, 'DR'				, 8						, 0	UNION
	SELECT 12				, 'Compensation'	,'Indirect (Interns)'											, 5						, NULL				, NULL					, 1	UNION
	SELECT 13				, 'Compensation'	,'Indirect (Acctg, VCF net, Development)'						, 6						, NULL				, NULL					, 1 UNION 
	SELECT 14				, 'Compensation'	,'Indirect (Pastoral+Exec Support))'							, 7						, NULL				, NULL					, 1 UNION 
	SELECT 15				, 'Compensation'	,'Indirect (Worship, Prod, CSvcs/Comm, Online, Spec Events)'	, 8						, NULL				, NULL					, 1 UNION 
	SELECT 16				, 'Compensation'	,'Indirect: BSC net'											, 9						, NULL				, NULL					, 1 UNION 
	SELECT 17				, 'Compensation'	,'Health Insurance'												, 10					, 'Initiatives/BB'  , 1						, 0 UNION
	SELECT 18				, 'Compensation'	,'Expense Sharing'												, 11					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 19				, 'Compensation'	,'HCA Pastoral Billback' 										, 12					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 20				, 'Compensation'	,'HBF Pastoral Billback' 										, 13					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 21				, 'Compensation'	,'WITW Pastoral Billback' 										, 14					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 22				, 'Compensation'	,'Personal Accounts'											, 15					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 23				, 'Compensation'	,'Cell Phones'													, 16					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 24				, 'Compensation'	,'Scholarships'													, 17					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 25				, 'Compensation'	,'All Staff Meetings'											, 18					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 26				, 'Compensation'	,'Retreats'														, 19					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 27				, 'Compensation'	,'Awards'														, 20					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 28				, 'Compensation'	,'Pulpit Supply'												, 21					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 29				, 'Compensation'	,'LTD/Life'														, 22					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 30				, 'Compensation'	,'Workers Comp'													, 23					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 31				, 'Compensation'	,'Paycor Fees'													, 24					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 32				, 'Compensation'	,'Passthrough Billbacks'										, 25					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 33				, 'Compensation'	,'Reoccurring Billbacks' 										, 26					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 34				, 'Compensation'	,'Other'														, 27					, 'Initiatives/BB'	, 1						, 0 UNION

	--Administration
	--(CampusXLTReportGroupID	, CampusHeading	, CampusDetail												, CampusDetailSortOrder, CampusCode			, CampusCodeSortOrder	, AllocateByAttendancePercentage)																																																 
	SELECT	35				, 'Administration'	, 'General Office'												, 28					, NULL				, NULL					, 1 UNION 
	SELECT	36				, 'Administration'	, 'Office Equipment'											, 29					, NULL				, NULL					, 1 UNION 
	SELECT	37				, 'Administration'	, 'Technology'													, 30 					, NULL				, NULL					, 1 UNION 
	SELECT	38				, 'Administration'	, 'Printing'													, 31 					, NULL				, NULL					, 1 UNION 
	SELECT	39				, 'Administration'	, 'Banking, Legal, Audit, Professional Fees'					, 32 					, NULL				, NULL					, 1 UNION 
	SELECT	40				, 'Administration'	, 'Payroll Processing Fees'										, 33 					, NULL				, NULL					, 1 UNION 
	SELECT	41				, 'Administration'	, 'Insurance'													, 34 					, NULL				, NULL					, 1 UNION 

	--Facilities
	SELECT	42				, 'Facilities'		, 'Facilities & Grounds Maintenance'							, 35 					, NULL				, NULL					, 1 UNION 
	SELECT	43				, 'Facilities'		, 'Utilities'													, 36 					, NULL				, NULL					, 1 UNION 
	SELECT	44				, 'Facilities'		, 'Service Support'												, 37 					, NULL				, NULL					, 1 UNION 
	SELECT	45				, 'Facilities'		, 'Mortgage'													, 38 					, NULL				, NULL					, 1 UNION 

	--Camp Operations
	SELECT  46				, 'Camp Operations' , 'Operating Expense'											, 39 					, NULL				, NULL					, 1 UNION 

	--Ministries
	--(CampusXLTReportGroupID	, CampusHeading	, CampusDetail												, CampusDetailSortOrder, CampusCode			, CampusCodeSortOrder	, AllocateByAttendancePercentage)																																																 
	SELECT	47				, 'Ministries'		, 'Ministry Expansion and Development'						, 40						, NULL				, NULL					, 1 UNION 
	SELECT	48				, 'Ministries'		, 'Special Events'											, 41						, NULL				, NULL					, 1 UNION 
	SELECT	49				, 'Ministries'		, 'Online Services'											, 42						, NULL				, NULL					, 1 UNION 
	SELECT	50				, 'Ministries'		, 'Adult'													, 43						, NULL				, NULL					, 1 UNION 
	SELECT	51				, 'Ministries'		, 'Single Parent'											, 44						, NULL				, NULL					, 1 UNION 
	SELECT	52				, 'Ministries'		, 'Biblical Soul Care'										, 45						, NULL				, NULL					, 1 UNION 
	SELECT	53				, 'Ministries'		, 'Family'													, 46						, NULL				, NULL					, 1 UNION 
	SELECT	54				, 'Ministries'		, 'Student'													, 47						, NULL				, NULL					, 1 UNION 
	SELECT	55				, 'Ministries'		, 'Worship'													, 48						, NULL				, NULL					, 1 UNION 
	SELECT	56				, 'Ministries'		, 'Stewardship'												, 49						, NULL				, NULL					, 1 UNION 
	SELECT	57				, 'Ministries'		, 'Missions & Outreach & Church Plant'						, 50						, NULL				, NULL					, 1 UNION 
	SELECT	58				, 'Ministries'		, 'Congregation/FOCIS'										, 51						, NULL				, NULL					, 1 UNION 
	SELECT	59				, 'Ministries'		, 'Production'												, 52						, NULL				, NULL					, 1 UNION 
	SELECT	60				, 'Ministries'		, 'Creative Services, Video Prod, Media'					, 53						, NULL				, NULL					, 1 UNION 
	SELECT	61				, 'Ministries'		, 'Other'													, 54						, NULL				, NULL					, 1 

	
	--next truncate the Campus Tab mapping
	TRUNCATE TABLE CampusXLTReportGroup_CampusTabMap

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 1 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 = '8009'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 2 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 = '8004'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 3 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 = '8032'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 4 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 = '8037'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 5 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8005', '8006', '8007', '8008')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 6 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8000', '8001', '8002', '8003')

	
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 7 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8010', '8011', '8012', '8013')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 8 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8014', '8015')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 9 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8021', '8022', '8023')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 10 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8017', '8018', '8019', '8020')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 11 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8024')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 13 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8031', '8038', '8040')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 14 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8047', '8036')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 15 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8030', '8033', '8034', '8035')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 16 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8029')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 17 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode IN ('41010', '41011', '41012', '41015', '41016')
		AND AccountingCode9 IN ('9999')
		AND DepartmentCode <> '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 18 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode IN ('90511', '90512', '90514')
		AND AccountingCode9 IN ('9999')
		AND DepartmentCode <> '4056'

	--review with alan
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 19 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8048')
	
	
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 20 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8049')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 20 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8050')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 22 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND DepartmentCode = '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 23 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode = '44090'
		AND AccountingCode9 IN ('9999') 
		AND DepartmentCode <> '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 24 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode = '40020'
		AND AccountingCode9 IN ('9999') 
		AND DepartmentCode <> '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 25 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND ProjectCode = '217'
		AND AccountingCode9 IN ('9999') 
		AND DepartmentCode <> '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 26 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode = '43026'
		AND AccountingCode9 IN ('9999') 
		AND DepartmentCode <> '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 27 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode = '44008'
		AND AccountingCode9 IN ('9999') 
		AND DepartmentCode <> '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 28 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode IN ('45016', '45018', '46022', '46026')
		AND AccountingCode9 IN ('9999') 
		AND DepartmentCode <> '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 29 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode IN ('41017', '41020', '41025', '41027')
		AND AccountingCode9 IN ('9999') 
		AND DepartmentCode <> '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 30 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode IN ('52519')
		AND AccountingCode9 IN ('9999') 
		AND DepartmentCode <> '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 31 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode IN ('60432', '53130')
		AND AccountingCode9 IN ('9999') 
		AND DepartmentCode <> '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 32 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode IN ('40060')
		AND AccountingCode9 IN ('9999') 
		AND DepartmentCode <> '4056'

	--review reocurring billback with alan

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 32 AS CampusReportGroupID
	FROM DW.DimFinancialCategory
	LEFT JOIN [dbo].[CampusXLTReportGroup_CampusTabMap] dest
		ON DimFinancialCategory.FinancialCategoryID = dest.CampusReportGroupID 
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND Dest.CampusReportGroupID IS NULL






	/*
	--old mappings
	--Then load the map values
	--1. General Office
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 1
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND Departmentcode = '5038'
		AND Fundcode = '025'
		AND CategoryCode <> 'PER1' 
		AND CampusCode NOT IN ('LH','CH') 
		AND GLCode <> '30010'


	--2. Office Equipment –Expenses with the department code 5058
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 2
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND Departmentcode = '5058'
		AND Fundcode = '025'
		AND CategoryCode <> 'PER1' 
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode <> '30010' 

	--3. Technology
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 3
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND Departmentcode = '5178'
		AND Fundcode = '025'
		AND CategoryCode <> 'PER1' 
		AND CampusCode NOT IN ('LH','CH') 
		AND GLCode <> '30010'

	--4. Printing – Expenses with the department code 5078
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 4
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND Departmentcode = '5078'
		AND Fundcode = '025'
		AND CategoryCode <> 'PER1' 
		AND CampusCode NOT IN ('LH','CH') 
		AND GLCode <> '30010'

	--5. Banking, Legal, Audit, Professional Fees
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 5
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND GLCode IN ('49099', '52011', '52060', '52045')
		AND Fundcode = '025'
		AND CategoryCode <> 'PER1' 
		AND CampusCode NOT IN ('LH','CH') 
		AND (CONVERT(INT, DepartmentCode) < 7005 OR CONVERT(INT, DepartmentCode) > 8992)
		AND GLCode <> '30010'

	--6. Payroll Processing Fees
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 6
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND GLCode IN ('49011')
		AND Fundcode = '025'
		AND CategoryCode <> 'PER1' 
		AND CampusCode NOT IN ('LH','CH') 
		AND GLCode <> '30010'

	--7. Insurance
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 7
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND Departmentcode = '5098'
		AND Fundcode = '025'
		AND CategoryCode <> 'PER1' 
		AND CampusCode NOT IN ('LH','CH') 
		AND GLCode <> '30010'

	--8.Facilities & Grounds Maintenance
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 8
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND Departmentcode IN ('6017', '6037', '6057', '6065', '6117', '6157', '6177')
		AND Fundcode = '025'
		AND CategoryCode <> 'PER1' 
		AND CampusCode NOT IN ('LH','CH') 
		AND GLCode <> '30010'

	--9.Utilities
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 9
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND Departmentcode = '6097'
		AND Fundcode = '025'
		AND CategoryCode <> 'PER1' 
		AND CampusCode NOT IN ('LH','CH') 
		AND GLCode <> '30010'

	--10.Service Support – department 6197
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 10
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND Departmentcode = '6197'
		AND Fundcode = '025'
		AND CategoryCode <> 'PER1' 
		AND CampusCode NOT IN ('LH','CH') 
		AND GLCode <> '30010'

	--11.Mortgage
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 11
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND GLCode IN ('24225', '24230', '24233', '24235', '24272','90122', '90123', '90125', '90128', '90172')
		AND Fundcode = '025'
		AND CategoryCode <> 'PER1' 
		AND CampusCode NOT IN ('LH','CH') 
		AND GLCode <> '30010'

	--12.Operating Expense (under camp operations, also called camp  operating expense on xlt management report tab) – all expenses under fund 058
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 12
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CampusCode = 'LH'
		AND GLCode <> '30010'

	--13.Ministry Expansion and Development
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 13
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND Departmentcode = '7240'
		AND Fundcode = '025'
		AND CategoryCode <> 'PER1' 
		AND CampusCode NOT IN ('LH','CH') 
		AND GLCode <> '30010'

	--14.Special Events
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 14
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND Departmentcode = '5162'
		AND Fundcode = '025'
		AND CategoryCode <> 'PER1' 
		AND CampusCode NOT IN ('LH','CH') 
		AND GLCode <> '30010'

	--15.Online Services – All expenses with department 5164
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 15
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND Departmentcode = '5164'
		AND Fundcode = '025'
		AND CategoryCode <> 'PER1' 
		AND CampusCode NOT IN ('LH','CH') 
		AND GLCode <> '30010'

	--16.Adult
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 16
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND Departmentcode IN ('7005', '7007', '7011', '7014', '7041', '7047', '7050', '7059', '7066', '7071', '7073', '7075', '7076','7079', '7084', '7086', '7089', '7111', '7176')
		AND Fundcode = '025'
		AND CategoryCode <> 'PER1' 
		AND CampusCode NOT IN ('LH','CH') 
		AND GLCode <> '30010'

	--17.Single Parent – all expenses with department code 7059
	--REMOVED PER Kelly on 20160217

	--18.Biblical Soul Care – all expenses with fund 055
	--removed per alan on 20160325


	--19.Family 
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 19
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND Departmentcode IN ('7125', '7128', '7131', '7135', '7139', '7143', '7147', '7151')
		AND Fundcode = '025'
		AND CategoryCode <> 'PER1' 
		AND CampusCode NOT IN ('LH','CH') 
		AND GLCode <> '30010'

	--20.Student
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 20
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND Departmentcode IN ('7165', '7166', '7170', '7171')
		AND Fundcode = '025'
		AND CategoryCode <> 'PER1' 
		AND CampusCode NOT IN ('LH','CH') 
		AND GLCode <> '30010'

	--21.Worship
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 21
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND Departmentcode ='7290'
		AND Fundcode = '025'
		AND CategoryCode <> 'PER1' 
		AND CampusCode NOT IN ('LH','CH') 
		AND GLCode <> '30010'

	--22.Stewardship – all expenses with department code 7280
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 22
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND Departmentcode = '7280'
		AND Fundcode = '025'
		AND CategoryCode <> 'PER1' 
		AND CampusCode NOT IN ('LH','CH') 
		AND GLCode <> '30010'

	--23.Missions & Outreach & Church Plant
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 23
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND Departmentcode IN ('7208', '7210', '7250')
		AND Fundcode = '025'
		AND CategoryCode <> 'PER1' 
		AND CampusCode NOT IN ('LH','CH') 
		AND GLCode <> '30010'

	--24.Congregation/FOCIS
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 24
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND Departmentcode IN ('7017', '7023', '7035')
		AND Fundcode = '025'
		AND CategoryCode <> 'PER1' 
		AND CampusCode NOT IN ('LH','CH') 
		AND GLCode <> '30010'

	--25.Production – all expenses with department 5160
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 25
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND Departmentcode = '5160'
		AND Fundcode = '025'
		AND CategoryCode <> 'PER1' 
		AND CampusCode NOT IN ('LH','CH') 
		AND GLCode <> '30010'

	--26.Creative Services, Video Prod, Media – all expenses in department codes 5158, 5159, or 6137
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 26
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND Departmentcode IN ('5158','5159','6137')
		AND Fundcode = '025'
		AND CategoryCode <> 'PER1' 
		AND CampusCode NOT IN ('LH','CH') 
		AND GLCode <> '30010'

	--27.Food Ministry
	INSERT INTO CampusXLTReportGroupMap
	SELECT FinancialCategoryID, 27
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND Departmentcode = '6147'
		AND Fundcode = '025'
		AND CategoryCode <> 'PER1' 
		AND CampusCode NOT IN ('LH','CH') 
		AND GLCode <> '30010'

	--28.Harvest Studio production – all expenses with fund 069
	--INSERT INTO CampusXLTReportGroupMap
	--SELECT FinancialCategoryID, 28
	--FROM DW.DimFinancialCategory
	--WHERE
	--	EntityCode = 'HBC'
	--	AND FundCode = '095'
*/

RETURN 0
