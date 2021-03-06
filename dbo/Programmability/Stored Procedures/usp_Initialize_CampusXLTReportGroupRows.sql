USE [Analytics]
GO

/****** Object:  StoredProcedure [dbo].[usp_Initialize_CampusXLTReportGroupRows]    Script Date: 10/4/2016 1:56:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

exec [usp_Initialize_CampusXLTReportGroupRows]

CREATE PROCEDURE [dbo].[usp_Initialize_CampusXLTReportGroupRows]
AS

	--truncate the groups first
	TRUNCATE TABLE CampusXLTReportGroup_CampusTab;

	--then load
	INSERT INTO CampusXLTReportGroup_CampusTab
	(CampusXLTReportGroupID	, CampusHeading		, CampusDetail													, CampusDetailSortOrder, CampusCode			, CampusCodeSortOrder	, AllocateByAttendancePercentage)

	SELECT DISTINCT 1				, 'Compensation'	,'Direct (Ops)'													, 1						, 'EL'				, 2						, 0	UNION
	SELECT DISTINCT 2				, 'Compensation'	,'Direct (Ops)'													, 1						, 'RM'				, 3						, 0	UNION
	SELECT DISTINCT 62				, 'Compensation'	,'Direct (Ops)'													, 1						, 'CL'				, 5						, 0 UNION
	SELECT DISTINCT 3				, 'Compensation'	,'Indirect (IT)'												, 2						, NULL				, NULL					, 1	UNION
	SELECT DISTINCT 4				, 'Compensation'	,'Indirect (Central Svcs)'										, 3						, NULL				, NULL					, 1	UNION
	SELECT DISTINCT 5				, 'Compensation'	,'Direct (Min Staff/Admin)'										, 4						, 'EL'				, 2						, 0	UNION
	SELECT DISTINCT 6				, 'Compensation'	,'Direct (Min Staff/Admin)'										, 4						, 'RM'				, 3						, 0	UNION
	SELECT DISTINCT 7				, 'Compensation'	,'Direct (Min Staff/Admin)'										, 4						, 'NI'				, 4						, 0	UNION
	SELECT DISTINCT 8				, 'Compensation'	,'Direct (Min Staff/Admin)'										, 4						, 'CL'				, 5						, 0	UNION
	SELECT DISTINCT 9				, 'Compensation'	,'Direct (Min Staff/Admin)'										, 4						, 'CC'				, 6						, 0	UNION
	SELECT DISTINCT 10				, 'Compensation'	,'Direct (Min Staff/Admin)'										, 4						, 'AU'				, 7						, 0	UNION
	SELECT DISTINCT 11				, 'Compensation'	,'Direct (Min Staff/Admin)'										, 4						, 'DR'				, 8						, 0	UNION
	SELECT DISTINCT 12				, 'Compensation'	,'Indirect (Interns)'											, 5						, NULL				, NULL					, 1	UNION
	SELECT DISTINCT 13				, 'Compensation'	,'Indirect (Acctg, VCF net, Development)'						, 6						, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT 14				, 'Compensation'	,'Indirect (Pastoral+Exec Support))'							, 7						, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT 15				, 'Compensation'	,'Indirect (Worship, Prod, CSvcs/Comm, Online, Spec Events)'	, 8						, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT 16				, 'Compensation'	,'Indirect: BSC net'											, 9						, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT 17				, 'Compensation'	,'Health Insurance'												, 10					, 'Initiatives/BB'  , 1						, 0 UNION
	SELECT DISTINCT 18				, 'Compensation'	,'Expense Sharing'												, 11					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT DISTINCT 19				, 'Compensation'	,'HCA Pastoral Billback' 										, 12					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT DISTINCT 20				, 'Compensation'	,'HBF Pastoral Billback' 										, 13					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT DISTINCT 21				, 'Compensation'	,'WITW Pastoral Billback' 										, 14					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT DISTINCT 22				, 'Compensation'	,'Personal Accounts'											, 15					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT DISTINCT 23				, 'Compensation'	,'Cell Phones'													, 16					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT DISTINCT 24				, 'Compensation'	,'Scholarships'													, 17					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT DISTINCT 25				, 'Compensation'	,'All Staff Meetings'											, 18					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT DISTINCT 26				, 'Compensation'	,'Retreats'														, 19					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT DISTINCT 27				, 'Compensation'	,'Awards'														, 20					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT DISTINCT 28				, 'Compensation'	,'Pulpit Supply'												, 21					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT DISTINCT 29				, 'Compensation'	,'LTD/Life'														, 22					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT DISTINCT 30				, 'Compensation'	,'Workers Comp'													, 23					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT DISTINCT 31				, 'Compensation'	,'Paycor Fees'													, 24					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT DISTINCT 32				, 'Compensation'	,'Passthrough Billbacks'										, 25					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT DISTINCT 33				, 'Compensation'	,'Passthrough Billbacks Offset' 								, 26					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT DISTINCT 34				, 'Compensation'	,'Other'														, 27					, 'Initiatives/BB'	, 1						, 0 UNION

	--Administration
	--(CampusXLTReportGroupID	, CampusHeading	, CampusDetail												, CampusDetailSortOrder, CampusCode			, CampusCodeSortOrder	, AllocateByAttendancePercentage)																																																 
	SELECT DISTINCT	35				, 'Administration'	, 'General Office'												, 28					, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT	36				, 'Administration'	, 'Office Equipment'											, 29					, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT	37				, 'Administration'	, 'Technology'													, 30 					, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT	38				, 'Administration'	, 'Printing'													, 31 					, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT	39				, 'Administration'	, 'Banking, Legal, Audit, Professional Fees'					, 32 					, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT	40				, 'Administration'	, 'Payroll Processing Fees'										, 33 					, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT	41				, 'Administration'	, 'Insurance'													, 34 					, NULL				, NULL					, 1 UNION 

	--Facilities
	SELECT DISTINCT	42				, 'Facilities'		, 'Facilities & Grounds Maintenance'							, 35 					, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT	43				, 'Facilities'		, 'Utilities'													, 36 					, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT	44				, 'Facilities'		, 'Service Support'												, 37 					, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT	45				, 'Facilities'		, 'Mortgage'													, 38 					, NULL				, NULL					, 1 UNION 

	--Camp Operations
	SELECT DISTINCT  46				, 'Camp Operations' , 'Operating Expense'											, 39 					, NULL				, NULL					, 1 UNION 

	--Ministries
	--(CampusXLTReportGroupID	, CampusHeading	, CampusDetail												, CampusDetailSortOrder, CampusCode			, CampusCodeSortOrder	, AllocateByAttendancePercentage)																																																 
	SELECT DISTINCT	47				, 'Ministries'		, 'Ministry Expansion and Development'						, 40						, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT	48				, 'Ministries'		, 'Special Events'											, 41						, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT	49				, 'Ministries'		, 'Online Services'											, 42						, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT	50				, 'Ministries'		, 'Adult'													, 43						, NULL				, NULL					, 1 UNION 
	--SELECT DISTINCT	51				, 'Ministries'		, 'Single Parent'											, 44						, NULL				, NULL					, 1 UNION 
	--SELECT DISTINCT	52				, 'Ministries'		, 'Biblical Soul Care'										, 45						, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT	53				, 'Ministries'		, 'Family'													, 46						, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT	54				, 'Ministries'		, 'Student'													, 47						, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT	55				, 'Ministries'		, 'Worship'													, 48						, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT	56				, 'Ministries'		, 'Stewardship'												, 49						, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT	57				, 'Ministries'		, 'Missions & Outreach & Church Plant'						, 50						, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT	58				, 'Ministries'		, 'Congregation/FOCIS'										, 51						, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT	59				, 'Ministries'		, 'Production'												, 52						, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT	60				, 'Ministries'		, 'Creative Services, Video Prod, Media'					, 53						, NULL				, NULL					, 1 UNION 
	SELECT DISTINCT	61				, 'Ministries'		, 'Other'													, 54						, NULL				, NULL					, 1 

	
	--next truncate the Campus Tab mapping
	TRUNCATE TABLE CampusXLTReportGroup_CampusTabMap

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 62 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 = '8016'


	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 12 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8082')


	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 17 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode IN ('41010', '41011', '41012', '41015', '41016')
		AND AccountingCode9 IN( '9999','')
		AND DepartmentCode <> '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 21 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN ('8050')

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 22 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode NOT IN('LH','CH')
		AND DepartmentCode = '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
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
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 24 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode = '40020'
		AND AccountingCode9 IN ('9999') 


	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 25 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND ProjectCode = '217'
		AND AccountingCode9 = '9999'
		AND DepartmentCode <> '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
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
	SELECT DISTINCT
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
		AND ProjectCode <> '217'

	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 30 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode NOT IN ('CS','AC')
		AND GLCode IN ('52519')
		AND AccountingCode9 IN ('9999') 
		AND DepartmentCode <> '4056'


	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 33 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND DepartmentCode = '4016' 
		AND AccountingCode9 IN ('8025','8027','8028','8041','8042','8043'
				,'8044','8045','8046','8075','8081','8025','8027','8028','8041','8042','8043','8044'
				,'8045','8046','8075','8081') 


	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 34 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	LEFT JOIN [dbo].[CampusXLTReportGroup_CampusTabMap] dest
		ON DimFinancialCategory.FinancialCategoryID = dest.FinancialCategoryID 
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode IN( 'CS','AU','CC','DR')
		AND DepartmentCode <> '4036'
		AND Dest.CampusXLTReportGroupID IS NULL
	UNION
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 34 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	LEFT JOIN [dbo].[CampusXLTReportGroup_CampusTabMap] dest
		ON DimFinancialCategory.FinancialCategoryID = dest.FinancialCategoryID 
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND DepartmentCode IN ('4016', '4026', '4076', '4096', '4106')
		AND CampusCode IN ('CL','NI','RM','EL','AC','AU','CC','DR')
		AND Dest.CampusXLTReportGroupID IS NULL

	--Then load the map values
	--1. General Office
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT FinancialCategoryID, 35
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode = '5038'
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN ('52019', '52011', '52060', '49011', '52045')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	--2. Office Equipment �Expenses with the department code 5058
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT FinancialCategoryID, 36
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode = '5058'
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')

	--3. Technology
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT FinancialCategoryID, 37
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode = '5178'
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN ('52019', '52011', '52060', '49011', '52045')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	--4. Printing � Expenses with the department code 5078
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT FinancialCategoryID, 38
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode = '5078'
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')

	--5. Administration
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT FinancialCategoryID, 39
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode <> 'PER1'
		AND (
			CONVERT(INT, DepartmentCode)  < 7005 
			OR
			CONVERT(INT, DepartmentCode)  > 8992 
		)
		AND GLCode IN ('52019', '52011', '52060', '49011', '52045')
		AND DepartmentCode <> '9025'
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	--6. Payroll Processing Fees
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT FinancialCategoryID, 40
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('9025')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')

	--7. Insurance
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT FinancialCategoryID, 41
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('5098')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')

	--8.Facilities & Grounds Maintenance
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT FinancialCategoryID, 42
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('6017', '6037', '6057', '6065', '6117', '6157', '6177')
		AND CampusCode NOT IN ('LH','CH')
		AND CategoryCode <> 'PER1'
		AND GLCode NOT IN ('52019', '52011', '52060', '49011', '52045')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	--9.Utilities
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT FinancialCategoryID, 43
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('6097')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')

	--Service Support
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 44 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode = '6197'
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	--11.Mortgage
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT FinancialCategoryID, 45
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '9015', '9017')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GlCode <> '90139'
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	--12.Operating Expense (under camp operations, also called camp  operating expense on xlt management report tab) � all expenses under fund 058
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT FinancialCategoryID, 46
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CampusCode = 'LH'
		AND CategoryCode <> 'PER1'

	--Ministry Expansion and Development
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT FinancialCategoryID, 47
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('7240')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')

	--14.Special Events
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT FinancialCategoryID, 48
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '5162')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN ('52019', '52011', '52060', '49011', '52045')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	--15.Online Services � All expenses with department 5164
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT FinancialCategoryID, 49
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('5164')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')

	--16.Adult
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT FinancialCategoryID, 50
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN ( '7005', '7007', '7011', '7014', '7041', '7047', '7050', '7059'
		, '7066', '7071', '7073', '7075', '7076', '7079', '7084', '7086', '7089', '7111', '7176')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	--18.Biblical Soul Care
	--removed per alan on 20160325

	--19.Family 
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT FinancialCategoryID, 53
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '7125', '7128', '7131', '7135', '7139', '7143', '7147', '7151' )
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	--20.Student
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT FinancialCategoryID, 54
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '7165', '7166', '7170', '7171')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')


	--21.Worship
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT FinancialCategoryID, 55
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('7290')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')

	--22.Stewardship � all expenses with department code 7280
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT FinancialCategoryID, 56
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '7280')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	--Missions & Outreach & Church Plant
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT FinancialCategoryID, 57
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '7208', '7210', '7250')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	--24.Congregation/FOCIS
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT FinancialCategoryID, 58
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '7017', '7023', '7035')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	--Production 
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT FinancialCategoryID, 59
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '5160')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	--26.Creative Services, Video Prod, Media � all expenses in department codes 5158, 5159, or 6137
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT FinancialCategoryID, 60
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('5158','5159','6137')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')

	--other
	INSERT INTO [dbo].[CampusXLTReportGroup_CampusTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT DimFinancialCategory.FinancialCategoryID, 61
	FROM DW.DimFinancialCategory
	LEFT JOIN [dbo].[CampusXLTReportGroup_CampusTabMap] dest
		ON DimFinancialCategory.FinancialCategoryID = dest.FinancialCategoryID
	WHERE
		GLType IN ('EXP','REV','APO','FAO')
		AND EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260'
			, '15027','15127','15132','15142','15147','15152','15157','15172','20011')
		AND dest.CampusXLTReportGroupID IS NULL
	UNION
	SELECT DISTINCT DimFinancialCategory.FinancialCategoryID, 61
	FROM DW.DimFinancialCategory
	LEFT JOIN [dbo].[CampusXLTReportGroup_CampusTabMap] dest
		ON DimFinancialCategory.FinancialCategoryID = dest.FinancialCategoryID
	WHERE
		GLType IN ('EXP','REV','APO','FAO')
		AND EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode <> 'PER1'
		AND CampusCode = 'CH'
		AND DepartmentCode = '7250'
		AND CategoryCode = 'MIN1'
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260','20011')
		AND Dest.CampusXLTReportGroupID IS NULL

	--Now the XLT MAP
	TRUNCATE TABLE dbo.CampusXLTReportGroup_XLTTab

	INSERT INTO dbo.CampusXLTReportGroup_XLTTab
	(CampusXLTReportGroupID	, XLTHeading		, XLTDetail										, XLTDetailSortOrder, Manager	, ManagerSortOrder)
	SELECT DISTINCT 1				, 'Compensation'	, 'Pastoral Staff'								, 1					,'Scott'	, 1		UNION
	SELECT DISTINCT 2				, 'Compensation'	, 'HCA Pastoral Billback' 						, 2					,'Scott'	, 1		UNION
	SELECT DISTINCT 3				, 'Compensation'	, 'HBF Pastoral Billback' 						, 3					,'Scott'	, 1		UNION
	SELECT DISTINCT 4				, 'Compensation'	, 'WITW Pastoral Billback' 						, 4					,'Scott'	, 1		UNION
	SELECT DISTINCT 5				, 'Compensation'	, 'Executive Support' 							, 5					,'Scott'	, 1		UNION
	SELECT DISTINCT 6				, 'Compensation'	, 'Accounting' 									, 6					,'Fred'		, 2		UNION
	SELECT DISTINCT 7				, 'Compensation'	, 'Film ' 										, 7					,'Fred'		, 2		UNION
	SELECT DISTINCT 8				, 'Compensation'	, 'Development' 								, 8					,'Fred'		, 2		UNION
	SELECT DISTINCT 9				, 'Compensation'	, 'IT'											, 9					,'Dean'		, 3		UNION
	SELECT DISTINCT 10				, 'Compensation'	, 'Direct RM Ops' 								, 10				,'Dean'		, 3		UNION
	SELECT DISTINCT 11				, 'Compensation'	, 'Direct EL Ops' 								, 11				,'Dean'		, 3		UNION
	SELECT DISTINCT 12				, 'Compensation'	, 'Indirect - Central Ops' 						, 12				,'Dean'		, 3 	UNION
	SELECT DISTINCT 13				, 'Compensation'	, 'Ministry Staff-RM  Total' 					, 13				,'Jeff'		, 4 	UNION
	--SELECT DISTINCT 14				, 'Compensation'	, 'Ministry Admin-RM Total' 					, 14				,NULL 		, NULL	UNION
	SELECT DISTINCT 15				, 'Compensation'	, 'Ministry Staff-EL Total' 					, 15				,'Jeff'		, 4		UNION
	--SELECT DISTINCT 16				, 'Compensation'	, 'Ministry Admin-EL Total' 					, 16				,NULL		, NULL	UNION
	SELECT DISTINCT 17				, 'Compensation'	, 'Ministry Staff-NI Total' 					, 17				,'Jeff'		, 4		UNION
	SELECT DISTINCT 18				, 'Compensation'	, 'Ministry Staff-CL Total' 					, 18				,'Dean'		, 3		UNION
	SELECT DISTINCT 19				, 'Compensation'	, 'Ministry Staff-CL Total' 					, 18				,'Jeff'		, 4		UNION
	SELECT DISTINCT 20				, 'Compensation'	, 'Ministry Staff-CC Total' 					, 19 				,'Jeff'		, 4		UNION
	SELECT DISTINCT 21				, 'Compensation'	, 'Ministry Staff-AU Total' 					, 20				,'Jeff'		, 4		UNION
	SELECT DISTINCT 22				, 'Compensation'	, 'Ministry Staff-DR Total' 					, 21				,'Jeff'		, 4		UNION
	--SELECT DISTINCT 23				, 'Compensation'	, 'Ministry Staff Hispanic-EL' 					, 22				,NULL		, NULL	UNION
	SELECT DISTINCT 24				, 'Compensation'	, 'Misc Ministries Interns' 					, 23				,'Jeff'		, 4		UNION
	SELECT DISTINCT 25				, 'Compensation'	, 'HR' 											, 24				,'Luke'		, 5		UNION
	SELECT DISTINCT 26				, 'Compensation'	, 'Communications' 								, 25				,'Luke'		, 5		UNION
	SELECT DISTINCT 27				, 'Compensation'	, 'Production' 									, 26				,'Luke'		, 5		UNION
	SELECT DISTINCT 28				, 'Compensation'	, 'Worship' 									, 27				,'Luke'		, 5		UNION
	SELECT DISTINCT 29				, 'Compensation'	, 'BSC' 										, 28				,'XLT'		, 6		UNION
	SELECT DISTINCT 30				, 'Compensation'	, 'Health Insurance' 							, 29				,'Scott'	, 1		UNION
	SELECT DISTINCT 31				, 'Compensation'	, 'Expense Sharing'								, 30				,'XLT'		, 6		UNION
	SELECT DISTINCT 32				, 'Compensation'	, 'Personal Accounts'							, 31				,'XLT'		, 6		UNION
	SELECT DISTINCT 33				, 'Compensation'	, 'Cell Phones'									, 32				,'XLT'		, 6		UNION
	SELECT DISTINCT 34				, 'Compensation'	, 'Scholarships'								, 33				,'XLT'		, 6		UNION
	SELECT DISTINCT 35				, 'Compensation'	, 'All Staff Meetings'							, 34				,'XLT'		, 6		UNION
	SELECT DISTINCT 36				, 'Compensation'	, 'Retreats'									, 35				,'XLT'		, 6		UNION
	SELECT DISTINCT 37				, 'Compensation'	, 'Awards'										, 36				,'XLT'		, 6		UNION
	SELECT DISTINCT 38				, 'Compensation'	, 'Pulpit Supply'								, 37				,'XLT'		, 6		UNION
	SELECT DISTINCT 39				, 'Compensation'	, 'Life/LTD/Retirement'							, 38				,'XLT'		, 6		UNION
	SELECT DISTINCT 40				, 'Compensation'	, 'Workers Comp'								, 39				,'XLT'		, 6		UNION
	SELECT DISTINCT 41				, 'Compensation'	, 'Paycor Fees'									, 40				,'XLT'		, 6		UNION
	SELECT DISTINCT 42				, 'Compensation'	, 'Passthrough Billbacks'						, 41				,'XLT'		, 6		UNION
	SELECT DISTINCT 78			    , 'Compensation'	, 'Pass Thru Billbacks Offset'					, 42			    , NULL      , NULL  UNION
	SELECT DISTINCT 43				, 'Compensation'	, 'Other'										, 43				,'XLT'		, 6		UNION

																																		
	SELECT DISTINCT 	44				, 'Expense'			, 'General Office'								, 44				, 'Dean'	, 3			UNION
	SELECT DISTINCT 	45				, 'Expense'			, 'Office Equipment' 							, 45				, 'Dean'	, 3			UNION
	SELECT DISTINCT 	46				, 'Expense'			, 'Technology' 									, 46				, 'Dean'	, 3			UNION
	SELECT DISTINCT 	47				, 'Expense'			, 'Printing' 									, 47				, 'Dean'	, 3			UNION
	SELECT DISTINCT 	48				, 'Expense'			, 'Insurance' 									, 48				, 'Dean'	, 3			UNION
	SELECT DISTINCT 	49				, 'Expense'			, 'Facilities & Grounds Maintenance' 			, 49				, 'Dean'	, 3			UNION
	SELECT DISTINCT 	50				, 'Expense'			, 'Utilities' 									, 50				, 'Dean'	, 3			UNION
	SELECT DISTINCT 	51				, 'Expense'			, 'Service Support' 							, 51				, 'Dean'	, 3			UNION
	SELECT DISTINCT 	52				, 'Expense'			, 'Camp Operating Expense' 						, 52				, 'Dean'	, 3			UNION
	SELECT DISTINCT 	53				, 'Expense'			, 'Student' 									, 53				, 'Dean'	, 3			UNION
	SELECT DISTINCT 	54				, 'Expense'			, 'Banking, Legal, Audit, Professional Fees' 	, 54				, 'Fred'	, 2			UNION
	SELECT DISTINCT 	55				, 'Expense'			, 'Payroll Processing Fees' 					, 55				, 'Luke'	, 5			UNION
	SELECT DISTINCT 	56				, 'Expense'			, 'Mortgage' 									, 56				, 'XLT'		, 6			UNION
	SELECT DISTINCT 	57				, 'Expense'			, 'Ministry Expansion and Development' 			, 57				, 'XLT'		, 6			UNION
	--removed harvest studio
	--SELECT DISTINCT 	58				, 'Expense'			, 'Harvest Studio Production' 					, 58				, NULL		, NULL		UNION
	SELECT DISTINCT 	59				, 'Expense'			, 'Missions & Outreach & Church Plant'			, 59				, 'XLT'		, 6			UNION
	SELECT DISTINCT 	60				, 'Expense'			, 'Stewardship' 								, 60				, 'Fred'	, 2			UNION
	--removed BSC, campuses and single parent
	--SELECT DISTINCT 	61				, 'Expense'			, 'Biblical Soul Care' 							, 61				, NULL		, NULL		UNION
	--SELECT DISTINCT 	62				, 'Expense'			, 'Crystal Lake Campus' 						, 62				, NULL		, NULL		UNION
	--SELECT DISTINCT 	63				, 'Expense'			, 'North Shore' 								, 63				, NULL		, NULL		UNION
	--SELECT DISTINCT 	64				, 'Expense'			, 'Chicago Cathedral' 							, 64				, NULL		, NULL		UNION
	--SELECT DISTINCT 	65				, 'Expense'			, 'Niles Campus'								, 65				, NULL		, NULL		UNION
	--SELECT DISTINCT 	66				, 'Expense'			, 'Aurora' 										, 66				, NULL		, NULL		UNION
	SELECT DISTINCT 	67				, 'Expense'			, 'Adult' 										, 67				, 'Jeff'	, 4			UNION
	--SELECT DISTINCT 	68				, 'Expense'			, 'Single Parent' 								, 68				, NULL		, NULL		UNION
	SELECT DISTINCT 	69				, 'Expense'			, 'Family'  									, 69				, 'Jeff'	, 4			UNION
	SELECT DISTINCT 	70				, 'Expense'			, 'Congregation/FOCIS' 							, 70				, 'Jeff'	, 4			UNION
	SELECT DISTINCT 	71				, 'Expense'			, 'Special Events' 								, 71				, 'Luke'	, 5			UNION
	SELECT DISTINCT 	72				, 'Expense'			, 'Online Services' 							, 72				, 'Luke'	, 5			UNION
	SELECT DISTINCT 	73				, 'Expense'			, 'Worship' 									, 73				, 'Luke'	, 5			UNION
	SELECT DISTINCT 	74				, 'Expense'			, 'Production' 									, 74				, 'Luke'	, 5			UNION
	SELECT DISTINCT 	75				, 'Expense'			, 'Creative Services, Video Prod, Media' 		, 75				, 'Luke'	, 5			UNION
	SELECT DISTINCT 	76				, 'Expense'			, 'Other' 										, 76				, 'Luke'	, 5			UNION	
	--scott has no expense, but we need a place holder
	SELECT DISTINCT 77				, 'Expense'			, ''											, 77				, 'Scott'	, 1


	TRUNCATE TABLE [dbo].[CampusXLTReportGroup_XLTTabMap];

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 7 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode NOT IN('LH','CH')
		AND AccountingCode9 = '8040'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 8 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode NOT IN('LH','CH')
		AND AccountingCode9 = '8038'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 11 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode NOT IN('LH','CH')
		AND AccountingCode9 = '8009'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 24 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND AccountingCode9 IN('8082')


	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 27 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode NOT IN('LH','CH')
		AND AccountingCode9 IN('8034')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
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
	SELECT DISTINCT
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
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 30 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode IN ('41010', '41011', '41012', '41015', '41016')
		AND AccountingCode9 IN( '9999','')
		AND DepartmentCode <> '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
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
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 32 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode NOT IN('LH','CH')
		AND DepartmentCode = '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 33 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode NOT IN('LH','CH')
		AND GLCode = '44090'
		AND AccountingCode9 = '9999'
		AND DepartmentCode <> '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 34 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode = '40020'
		AND DepartmentCode <> '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 35 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND ProjectCode = '217'
		AND AccountingCode9 = '9999'
		AND DepartmentCode <> '4056'


	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 36 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode = '43026'
		AND AccountingCode9 = '9999'
		AND DepartmentCode <> '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 37 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode = '44008'
		AND AccountingCode9 = '9999'
		AND DepartmentCode <> '4056'
		AND ProjectCode <> '217'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 38 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode IN ('45016', '45018', '46022', '46026')
		AND AccountingCode9 = '9999'
		AND DepartmentCode <> '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 39 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode = 'CS'
		AND GLCode IN ('41017', '41020', '41025', '41027')
		AND AccountingCode9 = '9999'
		AND DepartmentCode <> '4056'
--Workers Comp
	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 40 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode NOT IN ('CS','AC')
		AND GLCode IN ('52519')
		AND AccountingCode9 IN ('9999') 
		AND DepartmentCode <> '4056'
	

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 41 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode IN ('60432', '53130')
		AND AccountingCode9 = '9999'
		AND DepartmentCode <> '4056'

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 42 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode IN ('40060')
		AND AccountingCode9 = '9999'
		AND DepartmentCode <> '4056'
	
	--'Pass Thru Billbacks Offset'
	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 78 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND DepartmentCode = '4016' 
		AND AccountingCode9 IN ('8025','8027','8028','8041','8042','8043'
				,'8044','8045','8046','8075','8081','8025','8027','8028','8041','8042','8043','8044'
				,'8045','8046','8075','8081') 

	--other
	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 43 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory 
	LEFT JOIN CampusXLTReportGroup_XLTTabMap dest
		ON DimFinancialCategory.FinancialCategoryID = dest.FinancialCategoryID
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND CampusCode IN('CS','AU','CC','DR')
		AND DepartmentCode <> '4036'
		--AND AccountingCode9 = '9999'
		--AND DepartmentCode NOT IN ('4056', '4036')
		AND dest.CampusXLTReportGroupID IS NULL
	UNION
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 43 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory 
	LEFT JOIN CampusXLTReportGroup_XLTTabMap dest
		ON DimFinancialCategory.FinancialCategoryID = dest.FinancialCategoryID
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode = 'PER1'
		AND DepartmentCode IN ('4016', '4026', '4076', '4096', '4106')
		AND CampusCode IN ('CL','NI','RM','EL','AC','AU','CC','DR')
		AND Dest.CampusXLTReportGroupID IS NULL

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 44 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode = '5038'
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN ('52019', '52011', '52060', '49011', '52045')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')
		
	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 45 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode = '5058'
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 46 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode = '5178' --possibly need to add in 6017
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN ('52019', '52011', '52060', '49011', '52045')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 47 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode = '5078'
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 48 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode = '5098'
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 49 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '6017', '6037', '6057', '6065', '6117', '6157', '6177')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN ('52019', '52011', '52060', '49011', '52045')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 50 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode = '6097'
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 51 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode = '6197'
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 52 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CampusCode = 'LH'
		AND CategoryCode <> 'PER1'
	
	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 53 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '7165', '7166', '7170', '7171')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	
	--'Banking, Legal, Audit, Professional Fees' 
	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 54 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode <> 'PER1'
		AND (
			CONVERT(INT, DepartmentCode)  < 7005 
			OR
			CONVERT(INT, DepartmentCode)  > 8992 
		)
		AND GLCode IN ('52019', '52011', '52060', '49011', '52045')
		AND DepartmentCode <> '9025'
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 55 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '9025')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')


	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 56 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '9015', '9017')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GlCode <> '90139'
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')
	--'Ministry Expansion and Development' 
	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 57 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND Departmentcode IN('7240')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 59 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '7208', '7210', '7250')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 60 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '7280')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 67 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN ( '7005', '7007', '7011', '7014', '7041', '7047', '7050', '7059'
		, '7066', '7071', '7073', '7075', '7076', '7079', '7084', '7086', '7089', '7111', '7176')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 69 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '7125', '7128', '7131', '7135', '7139', '7143', '7147', '7151' )
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 70 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '7017', '7023', '7035')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 71 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '5162')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN ('52019', '52011', '52060', '49011', '52045')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 72 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '5164')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 73 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '7290')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 74 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '5160')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 75 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	WHERE
		EntityCode = 'HBC'
		AND FundCode = '025'
		AND DepartmentCode IN( '5158', '5159', '6137')
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260')

	--other 
	INSERT INTO [dbo].[CampusXLTReportGroup_XLTTabMap]
	( FinancialCategoryID, CampusXLTReportGroupID )
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 76 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	LEFT JOIN [CampusXLTReportGroup_XLTTabMap] dest
		ON  DimFinancialCategory.FinancialCategoryID = dest.FinancialCategoryID
	WHERE
		GLType IN ('EXP','REV','APO','FAO')
		AND EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode <> 'PER1'
		AND CampusCode NOT IN ('LH','CH')
		AND GLCode NOT IN (
			'21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260'
			, '15027','15125','15127','15132','15142','15147','15152','15157','15172','20011')
		AND dest.CampusXLTReportGroupID IS NULL
	--and pick up some special cases of 'CH'
	UNION
	SELECT DISTINCT
		DimFinancialCategory.FinancialCategoryID, 76 AS CampusXLTReportGroupID
	FROM DW.DimFinancialCategory
	LEFT JOIN [CampusXLTReportGroup_XLTTabMap] dest
		ON  DimFinancialCategory.FinancialCategoryID = dest.FinancialCategoryID
	WHERE
		GLType IN ('EXP','REV','APO','FAO')
		AND EntityCode = 'HBC'
		AND FundCode = '025'
		AND CategoryCode <> 'PER1'
		AND CampusCode = 'CH'
		AND DepartmentCode = '7250'
		AND CategoryCode = 'MIN1'
		AND GLCode NOT IN (
			'15125','21010','21015','22025','22045','23017','30010','30058','90139','90145'
			,'90222','90227','90232','90235','90237','90247','90252','90260','20011')
		AND dest.CampusXLTReportGroupID IS NULL


RETURN 0



GO


