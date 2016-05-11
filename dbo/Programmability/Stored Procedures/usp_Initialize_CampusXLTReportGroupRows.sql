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
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 1 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 = '8009'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 2 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 = '8004'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 3 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 = '8032'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 4 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 = '8037'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 5 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8005', '8006', '8007', '8008')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 6 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8000', '8001', '8002', '8003')

	
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 7 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8010', '8011', '8012', '8013')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 8 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8014', '8015')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 9 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8021', '8022', '8023')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 10 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8017', '8018', '8019', '8020')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 11 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8024')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 13 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8031', '8038', '8040')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 14 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8047', '8036')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 15 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8030', '8033', '8034', '8035')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 16 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8029')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 17 AS CampusXLTReportGroupID
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
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 18 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode IN ('90511', '90512', '90514')
		AND AccountingCode9 IN ('9999')
		AND DepartmentCode <> '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 19 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8048')
	
	
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 20 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8049')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 20 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8050')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 22 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND DepartmentCode = '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 23 AS CampusXLTReportGroupID
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
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 24 AS CampusXLTReportGroupID
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
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 25 AS CampusXLTReportGroupID
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
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 26 AS CampusXLTReportGroupID
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
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 27 AS CampusXLTReportGroupID
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
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 28 AS CampusXLTReportGroupID
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
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 29 AS CampusXLTReportGroupID
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
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 30 AS CampusXLTReportGroupID
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
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 31 AS CampusXLTReportGroupID
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
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 32 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode IN ('40060')
		AND AccountingCode9 IN ('9999') 
		AND DepartmentCode <> '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 33 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode IN ('40060')
		AND AccountingCode9 IN ('9999') 
		AND DepartmentCode <> '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 32 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	LEFT JOIN [dbo].[CampusXLTReportGroup_CampusTabMap] dest
		ON DimFinancialCategory.FinancialCategoryID = dest.CampusXLTReportGroupID 
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND Dest.CampusXLTReportGroupID IS NULL



	--Then load the map values
	--1. General Office
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT FinancialCategoryID, 35
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode = '5038'

	--2. Office Equipment –Expenses with the department code 5058
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT FinancialCategoryID, 36
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode = '5058'
		
	--3. Technology
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT FinancialCategoryID, 37
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode = '5178'

	--4. Printing – Expenses with the department code 5078
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT FinancialCategoryID, 38
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode = '5078'

	--5. Banking, Legal, Audit, Professional Fees
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT FinancialCategoryID, 39
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('5018','5138','9020')

	--6. Payroll Processing Fees
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT FinancialCategoryID, 40
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('9025')

	--7. Insurance
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT FinancialCategoryID, 41
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('5098')

	--8.Facilities & Grounds Maintenance
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT FinancialCategoryID, 42
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('6017', '6037', '6057', '6065', '6117', '6157', '6177')

	--9.Utilities
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT FinancialCategoryID, 43
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('6097')

	--10.Service Support
	--no longer mapped

	--11.Mortgage
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT FinancialCategoryID, 45
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('9015','9017')

	--12.Operating Expense (under camp operations, also called camp  operating expense on xlt management report tab) – all expenses under fund 058
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT FinancialCategoryID, 46
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CampusCode = 'LH'

	--13.Ministry Expansion and Development
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT FinancialCategoryID, 47
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('7240')

	--14.Special Events
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT FinancialCategoryID, 48
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('5162')

	--15.Online Services – All expenses with department 5164
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT FinancialCategoryID, 49
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('5164')

	--16.Adult
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT FinancialCategoryID, 50
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('7005', '7007', '7011', '7014', '7041', '7047', '7050', '7059', '7066', '7071', '7073', '7075', '7076', '7079', '7084', '7086', '7089', '7111', '7176')

	--18.Biblical Soul Care
	--removed per alan on 20160325

	--19.Family 
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT FinancialCategoryID, 53
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('7125', '7128', '7131', '7135', '7139', '7143', '7147', '7151')

	--20.Student
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT FinancialCategoryID, 54
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('7165', '7166', '7170', '7171')

	--21.Worship
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT FinancialCategoryID, 55
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('7290')

	--22.Stewardship – all expenses with department code 7280
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT FinancialCategoryID, 56
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('4276')

	--23.Missions & Outreach & Church Plant
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT FinancialCategoryID, 57
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('7208','7210','7250')

	--24.Congregation/FOCIS
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT FinancialCategoryID, 58
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('7017','7023','7035')

	--25.Production – all expenses with department 5160
	--no longer mapped

	--26.Creative Services, Video Prod, Media – all expenses in department codes 5158, 5159, or 6137
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT FinancialCategoryID, 60
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('5158','5159','6137')

	--other
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DimFinancialCategory.FinancialCategoryID, 61
	FROM DW.DimFinancialCategory
	LEFT JOIN [dbo].[CampusXLTReportGroup_CampusTabMap] dest
		ON DimFinancialCategory.FinancialCategoryID = dest.FinancialCategoryID
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Dest.CampusXLTReportGroupID IS NULL


	--Now the XLT MAP
	TRUNCATE TABLE dbo.CampusXLTReportGroup_XLTTab

	INSERT INTO dbo.CampusXLTReportGroup_XLTTab
	(CampusXLTReportGroupID	, XLTHeading		, XLTDetail										, XLTDetailSortOrder, Manager	, ManagerSortOrder)
	SELECT 1				, 'Compensation'	, 'Pastoral Staff'								, 1					,'Scott'	, 1		UNION
	SELECT 2				, 'Compensation'	, 'HCA Pastoral Billback' 						, 2					,'Scott'	, 2		UNION
	SELECT 3				, 'Compensation'	, 'HBF Pastoral Billback' 						, 3					,'Scott'	, 3		UNION
	SELECT 4				, 'Compensation'	, 'WITW Pastoral Billback' 						, 4					,'Scott'	, 4		UNION
	SELECT 5				, 'Compensation'	, 'Executive Support' 							, 5					,'Scott'	, 5		UNION
	SELECT 6				, 'Compensation'	, 'Accounting' 									, 6					,'Fred'		, 6		UNION
	SELECT 7				, 'Compensation'	, 'Film (self funding)' 						, 7					,'Fred'		, 7		UNION
	SELECT 8				, 'Compensation'	, 'Development (self funding)' 					, 8					,'Fred'		, 8		UNION
	SELECT 9				, 'Compensation'	, 'IT'											, 9					,'Dean'		, 9		UNION
	SELECT 10				, 'Compensation'	, 'Direct RM Ops' 								, 10				,'Dean'		, 10	UNION
	SELECT 11				, 'Compensation'	, 'Direct EL Ops' 								, 11				,'Dean'		, 11	UNION
	SELECT 12				, 'Compensation'	, 'Indirect - Central Ops' 						, 12				,'Dean'		, 12	UNION
	SELECT 13				, 'Compensation'	, 'Ministry Staff-RM  Total' 					, 13				,'Jeff'		, 13	UNION
	SELECT 14				, 'Compensation'	, 'Ministry Admin-RM Total' 					, 14				,NULL 		, 14	UNION
	SELECT 15				, 'Compensation'	, 'Ministry Staff-EL Total' 					, 15				,'Jeff'		, 15	UNION
	SELECT 16				, 'Compensation'	, 'Ministry Admin-EL Total' 					, 16				,NULL		, 16	UNION
	SELECT 17				, 'Compensation'	, 'Ministry Staff-NI Total' 					, 17				,'Jeff'		, 17	UNION
	SELECT 18				, 'Compensation'	, 'Ministry Staff-CL Total' 					, 18				,'Dean'		, 18	UNION
	SELECT 19				, 'Compensation'	, 'Ministry Staff-CL Total' 					, 18				,'Jeff'		, 19	UNION
	SELECT 20				, 'Compensation'	, 'Ministry Staff-CC Total' 					, 19 				,'Jeff'		, 20	UNION
	SELECT 21				, 'Compensation'	, 'Ministry Staff-AU Total' 					, 20				,'Jeff'		, 21	UNION
	SELECT 22				, 'Compensation'	, 'Ministry Staff-DR Total' 					, 21				,'Jeff'		, 22	UNION
	SELECT 23				, 'Compensation'	, 'Ministry Staff Hispanic-EL' 					, 22				,NULL		, 23	UNION
	SELECT 24				, 'Compensation'	, 'Misc Ministries Interns' 					, 23				,NULL		, 24	UNION
	SELECT 25				, 'Compensation'	, 'HR' 											, 24				,'Luke'		, 25	UNION
	SELECT 26				, 'Compensation'	, 'Communications' 								, 25				,'Luke'		, 26	UNION
	SELECT 27				, 'Compensation'	, 'Production' 									, 26				,'Luke'		, 27	UNION
	SELECT 28				, 'Compensation'	, 'Worship' 									, 27				,'Luke'		, 28	UNION
	SELECT 29				, 'Compensation'	, 'BSC (self funding)' 							, 28				,'XLT'		, 29	UNION
	SELECT 30				, 'Compensation'	, 'Health Insurance' 							, 29				,'XLT'		, 30	UNION
	SELECT 31				, 'Compensation'	, 'Expense Sharing'								, 30				,'XLT'		, 31	UNION
	SELECT 32				, 'Compensation'	, 'Personal Accounts'							, 31				,'XLT'		, 32	UNION
	SELECT 33				, 'Compensation'	, 'Cell Phones'									, 32				,'XLT'		, 33	UNION
	SELECT 34				, 'Compensation'	, 'Scholarships'								, 33				,'XLT'		, 34	UNION
	SELECT 35				, 'Compensation'	, 'All Staff Meetings'							, 34				,'XLT'		, 35	UNION
	SELECT 36				, 'Compensation'	, 'Retreats'									, 35				,'XLT'		, 36	UNION
	SELECT 37				, 'Compensation'	, 'Awards'										, 36				,'XLT'		, 37	UNION
	SELECT 38				, 'Compensation'	, 'Pulpit Supply'								, 37				,'XLT'		, 38	UNION
	SELECT 39				, 'Compensation'	, 'LTD/Life'									, 38				,'XLT'		, 39	UNION
	SELECT 40				, 'Compensation'	, 'Workers Comp'								, 39				,'XLT'		, 40	UNION
	SELECT 41				, 'Compensation'	, 'Paycor Fees'									, 40				,'XLT'		, 41	UNION
	SELECT 42				, 'Compensation'	, 'Passthrough Billbacks'						, 41				,'XLT'		, 42	UNION
	SELECT 43				, 'Compensation'	, 'Other'										, 42				,'XLT'		, 43	UNION
																																		
	SELECT 	44				, 'Expense'			, 'General Office'								, 43				, 'Dean'	, 44		UNION
	SELECT 	45				, 'Expense'			, 'Office Equipment' 							, 44				, 'Dean'	, 45		UNION
	SELECT 	46				, 'Expense'			, 'Technology' 									, 45				, 'Dean'	, 46		UNION
	SELECT 	47				, 'Expense'			, 'Printing' 									, 46				, 'Dean'	, 47		UNION
	SELECT 	48				, 'Expense'			, 'Insurance' 									, 47				, 'Dean'	, 48		UNION
	SELECT 	49				, 'Expense'			, 'Facilities & Grounds Maintenance' 			, 48				, 'Dean'	, 49		UNION
	SELECT 	50				, 'Expense'			, 'Utilities' 									, 49				, 'Dean'	, 50		UNION
	SELECT 	51				, 'Expense'			, 'Service Support' 							, 50				, 'Dean'	, 51		UNION
	SELECT 	52				, 'Expense'			, 'Camp Operating Expense' 						, 51				, 'Dean'	, 52		UNION
	SELECT 	53				, 'Expense'			, 'Student' 									, 52				, 'Dean'	, 53		UNION
	SELECT 	54				, 'Expense'			, 'Banking, Legal, Audit, Professional Fees' 	, 53				, 'Fred'	, 54		UNION
	SELECT 	55				, 'Expense'			, 'Payroll Processing Fees' 					, 54				, 'Luke'	, 55		UNION
	SELECT 	56				, 'Expense'			, 'Mortgage' 									, 55				, 'XLT'		, 56		UNION
	SELECT 	57				, 'Expense'			, 'Ministry Expansion and Development' 			, 56				, 'XLT'		, 57		UNION
	SELECT 	58				, 'Expense'			, 'Harvest Studio Production' 					, 57				, NULL		, 58		UNION
	SELECT 	59				, 'Expense'			, 'Missions & Outreach & Church Plant'			, 58				, 'XLT'		, 59		UNION
	SELECT 	60				, 'Expense'			, 'Stewardship' 								, 59				, 'Fred'	, 60		UNION
	SELECT 	61				, 'Expense'			, 'Biblical Soul Care' 							, 60				, NULL		, 61		UNION
	SELECT 	62				, 'Expense'			, 'Crystal Lake Campus' 						, 61				, NULL		, 62		UNION
	SELECT 	63				, 'Expense'			, 'North Shore' 								, 62				, NULL		, 63		UNION
	SELECT 	64				, 'Expense'			, 'Chicago Cathedral' 							, 63				, NULL		, 64		UNION
	SELECT 	65				, 'Expense'			, 'Niles Campus'								, 64				, NULL		, 65		UNION
	SELECT 	66				, 'Expense'			, 'Aurora' 										, 65				, NULL		, 66		UNION
	SELECT 	67				, 'Expense'			, 'Adult' 										, 66				, 'Jeff'	, 67		UNION
	SELECT 	68				, 'Expense'			, 'Single Parent' 								, 67				, NULL		, 68		UNION
	SELECT 	69				, 'Expense'			, 'Family'  									, 68				, 'Jeff'	, 69		UNION
	SELECT 	70				, 'Expense'			, 'Congregation/FOCIS' 							, 69				, 'Jeff'	, 70		UNION
	SELECT 	71				, 'Expense'			, 'Special Events' 								, 70				, 'Luke'	, 71		UNION
	SELECT 	72				, 'Expense'			, 'Online Services' 							, 71				, 'Luke'	, 72		UNION
	SELECT 	73				, 'Expense'			, 'Worship' 									, 72				, 'Luke'	, 73		UNION
	SELECT 	74				, 'Expense'			, 'Production' 									, 73				, 'Luke'	, 74		UNION
	SELECT 	75				, 'Expense'			, 'Creative Services, Video Prod, Media' 		, 74				, 'Luke'	, 75		UNION
	SELECT 	76				, 'Expense'			, 'Other' 										, 75				, 'Luke'	, 76


	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 1 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 = '8047'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 2 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 = '8048'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 3 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 = '8049'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 4 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 = '8050'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 5 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 = '8036'


	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 6 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 = '8031'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 7 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 = '8040'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 8 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 = '8038'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 9 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 = '8032'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 10 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 = '8004'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 11 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 = '8009'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 12 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 = '8037'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 13 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN( '8000','8001','8002','8003')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 15 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN( '8005','8006','8007','8008')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 17 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN( '8010','8011','8012','8013')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 18 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN( '8016')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 19 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN( '8014','8015')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 20 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN( '8021','8022','8023')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 21 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN( '8017','8018','8019','8020')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 22 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN( '8024')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 25 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN( '8030')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 26 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN( '8033')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 27 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN( '8034')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 28 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN( '8035')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 29 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN( '8029')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 30 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode IN ('41010', '41011', '41012', '41015', '41016')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 31 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN( '9999')
		AND GLCode IN ('90511', '90512', '90514')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 32 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND DepartmentCode = '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 33 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode = '44090'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 34 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode = '44020'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 35 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND ProjectCode = '217'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 36 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode = '43026'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 37 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode = '44008'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 38 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode IN ('45016', '45018', '46022', '46026')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 39 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode IN ('41017', '41020', '41025', '41027')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 40 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode IN ('52519')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 41 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode IN ('60432', '53130')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 42 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode IN ('40060')
		AND AccountingCode9 = '9999'

	--other
	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 42 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory 
	LEFT JOIN CampusXLTReportGroup_XLTTabMap dest
		ON DimFinancialCategory.FinancialCategoryID = dest.FinancialCategoryID
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND dest.CampusXLTReportGroupID IS NULL

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 44 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode = '5038'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 45 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode = '5058'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 46 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode = '5178'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 47 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode = '5078'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 48 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode = '5098'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 49 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '6017', '6037', '6057', '6065', '6117', '6157', '6177')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 50 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode = '6097'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 51 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode = '6197'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 52 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CampusCode = 'LH'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 53 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '7165', '7166', '7170', '7171')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 54 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '5018', '5138', '9020')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 55 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '9025')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 56 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '9015', '9017')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 59 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '7208', '7210', '7250')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 60 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '7280')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 67 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '7005', '7007', '7011', '7014', '7041', '7047', '7050', '7059', '7066', '7071', '7073', '7075', '7076', '7079', '7084', '7086', '7089', '7111', '7176')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 69 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '7125', '7128', '7131', '7135', '7139', '7143', '7147', '7151' )

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 70 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '7017', '7023', '7035')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 71 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '5162')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 72 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '5164')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 73 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '7290')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 74 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '5160')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 75 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '5158', '5159', '6137')


	--other ?? why not the remainder as in the other tab?
	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT
		DimFinancialCategory.FinancialCategoryID, 76 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '6147')

RETURN 0
