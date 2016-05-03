﻿CREATE PROCEDURE [dbo].[usp_Initialize_CampusXLTReportGroupRows]
AS

	--truncate the groups first
	TRUNCATE TABLE CampusXLTReportGroup_CampusTab;

	--then load
	INSERT INTO CampusXLTReportGroup_CampusTab
	(CampusXLTReportGroupID	, CampusHeading		, CampusDetail													, CampusDetailSortOrder, CampusCode			, CampusCodeSortOrder	, AllocateByAttendancePercentage)

	SELECT 1				, 'Compensation'	,'Direct (Ops)'													, 1						, 'EL'				, 2						, 0	UNION
	SELECT 1				, 'Compensation'	,'Direct (Ops)'													, 1						, 'RM'				, 3						, 0	UNION
	SELECT 2				, 'Compensation'	,'Indirect (IT)'												, 2						, NULL				, NULL					, 1	UNION
	SELECT 3				, 'Compensation'	,'Indirect (Central Svcs)'										, 3						, NULL				, NULL					, 1	UNION
	SELECT 4				, 'Compensation'	,'Direct (Min Staff/Admin)'										, 4						, 'EL'				, 2						, 0	UNION
	SELECT 4				, 'Compensation'	,'Direct (Min Staff/Admin)'										, 4						, 'RM'				, 3						, 0	UNION
	SELECT 4				, 'Compensation'	,'Direct (Min Staff/Admin)'										, 4						, 'NI'				, 4						, 0	UNION
	SELECT 4				, 'Compensation'	,'Direct (Min Staff/Admin)'										, 4						, 'CL'				, 5						, 0	UNION
	SELECT 4				, 'Compensation'	,'Direct (Min Staff/Admin)'										, 4						, 'CC'				, 6						, 0	UNION
	SELECT 4				, 'Compensation'	,'Direct (Min Staff/Admin)'										, 4						, 'AU'				, 7						, 0	UNION
	SELECT 4				, 'Compensation'	,'Direct (Min Staff/Admin)'										, 4						, 'DR'				, 8						, 0	UNION
	SELECT 5				, 'Compensation'	,'Indirect (Interns)'											, 5						, NULL				, NULL					, 1	UNION
	SELECT 6				, 'Compensation'	,'Indirect (Acctg, VCF net, Development)'						, 6						, NULL				, NULL					, 1 UNION 
	SELECT 7				, 'Compensation'	,'Indirect (Pastoral+Exec Support))'							, 7						, NULL				, NULL					, 1 UNION 
	SELECT 8				, 'Compensation'	,'Indirect (Worship, Prod, CSvcs/Comm, Online, Spec Events)'	, 8						, NULL				, NULL					, 1 UNION 
	SELECT 9				, 'Compensation'	,'Indirect: BSC net'											, 9						, NULL				, NULL					, 1 UNION 
	SELECT 10				, 'Compensation'	,'Health Insurance'												, 10					, 'Initiatives/BB'  , 1						, 0 UNION
	SELECT 11				, 'Compensation'	,'Expense Sharing'												, 11					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 12				, 'Compensation'	,'HCA Pastoral Billback' 										, 12					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 13				, 'Compensation'	,'HBF Pastoral Billback' 										, 13					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 14				, 'Compensation'	,'WITW Pastoral Billback' 										, 14					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 15				, 'Compensation'	,'Personal Accounts'											, 15					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 16				, 'Compensation'	,'Cell Phones'													, 16					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 17				, 'Compensation'	,'Scholarships'													, 17					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 18				, 'Compensation'	,'All Staff Meetings'											, 18					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 19				, 'Compensation'	,'Retreats'														, 19					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 20				, 'Compensation'	,'Awards'														, 20					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 21				, 'Compensation'	,'Pulpit Supply'												, 21					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 22				, 'Compensation'	,'LTD/Life'														, 22					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 23				, 'Compensation'	,'Workers Comp'													, 23					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 24				, 'Compensation'	,'Paycor Fees'													, 24					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 25				, 'Compensation'	,' Passthrough Billbacks'										, 25					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 26				, 'Compensation'	,' Reoccurring Billbacks' 										, 26					, 'Initiatives/BB'	, 1						, 0 UNION
	SELECT 27				, 'Compensation'	,'Other'														, 27					, 'Initiatives/BB'	, 1						, 0 UNION

	--Administration
	--(CampusXLTReportGroupID	, CampusHeading	, CampusDetail												, CampusDetailSortOrder, CampusCode			, CampusCodeSortOrder	, AllocateByAttendancePercentage)																																																 
	SELECT	28				, 'Administration'	, 'General Office'												, 28					, NULL				, NULL					, 1 UNION 
	SELECT	29				, 'Administration'	, 'Office Equipment'											, 29					, NULL				, NULL					, 1 UNION 
	SELECT	30				, 'Administration'	, 'Technology'													, 30 					, NULL				, NULL					, 1 UNION 
	SELECT	31				, 'Administration'	, 'Printing'													, 31 					, NULL				, NULL					, 1 UNION 
	SELECT	32				, 'Administration'	, 'Banking, Legal, Audit, Professional Fees'					, 32 					, NULL				, NULL					, 1 UNION 
	SELECT	33				, 'Administration'	, 'Payroll Processing Fees'										, 33 					, NULL				, NULL					, 1 UNION 
	SELECT	34				, 'Administration'	, 'Insurance'													, 34 					, NULL				, NULL					, 1 UNION 

	--Facilities
	SELECT	35				, 'Facilities'		, 'Facilities & Grounds Maintenance'							, 35 					, NULL				, NULL					, 1 UNION 
	SELECT	36				, 'Facilities'		, 'Utilities'													, 36 					, NULL				, NULL					, 1 UNION 
	SELECT	37				, 'Facilities'		, 'Service Support'												, 37 					, NULL				, NULL					, 1 UNION 
	SELECT	38				, 'Facilities'		, 'Mortgage'													, 38 					, NULL				, NULL					, 1 UNION 

	--Camp Operations
	SELECT 39				, 'Camp Operations' , 'Operating Expense'											, 39 					, NULL				, NULL					, 1 UNION 

	--Ministries
	--(CampusXLTReportGroupID	, CampusHeading	, CampusDetail												, CampusDetailSortOrder, CampusCode			, CampusCodeSortOrder	, AllocateByAttendancePercentage)																																																 
	SELECT					, 'Ministries'		, 'Ministry Expansion and Development'						, 40						, NULL				, NULL					, 1 UNION 
	SELECT					, 'Ministries'		, 'Special Events'											, 41						, NULL				, NULL					, 1 UNION 
	SELECT					, 'Ministries'		, 'Online Services'											, 42						, NULL				, NULL					, 1 UNION 
	SELECT					, 'Ministries'		, 'Adult'													, 43						, NULL				, NULL					, 1 UNION 
	SELECT					, 'Ministries'		, 'Single Parent'											, 44						, NULL				, NULL					, 1 UNION 
	SELECT					, 'Ministries'		, 'Biblical Soul Care'										, 45						, NULL				, NULL					, 1 UNION 
	SELECT					, 'Ministries'		, 'Family'													, 46						, NULL				, NULL					, 1 UNION 
	SELECT					, 'Ministries'		, 'Student'													, 47						, NULL				, NULL					, 1 UNION 
	SELECT					, 'Ministries'		, 'Worship'													, 48						, NULL				, NULL					, 1 UNION 
	SELECT					, 'Ministries'		, 'Stewardship'												, 49						, NULL				, NULL					, 1 UNION 
	SELECT					, 'Ministries'		, 'Missions & Outreach & Church Plant'						, 50						, NULL				, NULL					, 1 UNION 
	SELECT					, 'Ministries'		, 'Congregation/FOCIS'										, 51						, NULL				, NULL					, 1 UNION 
	SELECT					, 'Ministries'		, 'Production'												, 52						, NULL				, NULL					, 1 UNION 
	SELECT					, 'Ministries'		, 'Creative Services, Video Prod, Media'					, 53						, NULL				, NULL					, 1 UNION 
	SELECT					, 'Ministries'		, 'Other'													, 54						, NULL				, NULL					, 1 

	
	--next truncate the mapping
	TRUNCATE TABLE CampusXLTReportGroupMap

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


RETURN 0