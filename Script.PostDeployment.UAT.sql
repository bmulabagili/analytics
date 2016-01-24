SET NOCOUNT ON;
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

MERGE INTO ETLProcess AS Target
USING (VALUES
      (1, 'TransactionalTenant', NULL)
    , (2, 'FellowshipOne_Attendance', NULL)
    , (3, 'FellowshipOne_FTV', NULL)
    , (4, 'FellowshipOne_AssimilationSteps', NULL)
    , (5, 'FellowshipOne_SmallGroupStatus', NULL)
	, (6, 'MIP_RevenueAndExpense', NULL)	
	, (7, 'MIP_Budget', NULL)
)
AS Source (ETLProcessID, Name, [Description])
    ON Target.ETLProcessID = Source.ETLProcessID 
WHEN NOT MATCHED BY Target THEN
    INSERT (ETLProcessID, Name, [Description])
    VALUES (ETLProcessID, Name, [Description])
WHEN MATCHED AND Target.Name != Source.Name THEN
UPDATE SET
      Target.Name = Source.Name
    , Target.[Description] = Source.[Description]
;

MERGE INTO ETLAction AS Target
USING (VALUES
      (0, 'Do Nothing', 'An optional flag. Generally you wont load 0s to your transform table.')
    , (1, 'Insert', NULL)
    , (2, 'Update', NULL)
    , (3, 'Delete', NULL)
)
AS Source (ETLActionID, Name, [Description])
    ON Target.ETLActionID = Source.ETLActionID 
WHEN NOT MATCHED BY Target THEN
    INSERT (ETLActionID, Name, [Description])
    VALUES (ETLActionID, Name, [Description])
WHEN MATCHED AND Target.Name != Source.Name THEN
UPDATE SET
      Target.Name = Source.Name
    , Target.[Description] = Source.[Description] 
;
--base connectionstrings
MERGE INTO dbo.ConnectionString AS Target
USING (VALUES
    (0, N'FlatFileSource', N'FlatFileSource', -1, GETUTCDATE(), GETUTCDATE(), '')
  ,	(1, N'Data Source=devharvestbible.database.windows.net;Persist Security Info=True;Initial Catalog=HarvestBible;packet size=4096', 'Harvest bible connection string.', -1, GETUTCDATE(), GETUTCDATE(), '')
        --Data Source=hbcrmmip.harvestbible.org\mipdbase;User ID=52projectsMIP;Password=Proj3ct$;Initial Catalog=CHC;Provider=SQLNCLI11.1;Auto Translate=False;
  , (2, N'Data Source=192.168.240.219;User ID=52projects01;Password=Proj3ct$;Initial Catalog=CHC;Provider=SQLNCLI11.1;Auto Translate=False;', 'MIP-CHC', -1, GETUTCDATE(), GETUTCDATE(), '')
  , (3, N'Data Source=192.168.240.219;User ID=52projects01;Password=Proj3ct$;Initial Catalog=HBC;Provider=SQLNCLI11.1;Auto Translate=False;', 'MIP-HBC', -1, GETUTCDATE(), GETUTCDATE(), '')
  , (4, N'Data Source=192.168.240.219;User ID=52projects01;Password=Proj3ct$;Initial Catalog=HBF;Provider=SQLNCLI11.1;Auto Translate=False;', 'MIP-HBF', -1, GETUTCDATE(), GETUTCDATE(), '')
  , (5, N'Data Source=192.168.240.219;User ID=52projects01;Password=Proj3ct$;Initial Catalog=HCA;Provider=SQLNCLI11.1;Auto Translate=False;', 'MIP-HCA', -1, GETUTCDATE(), GETUTCDATE(), '')
  , (6, N'Data Source=192.168.240.219;User ID=52projects01;Password=Proj3ct$;Initial Catalog=HMP;Provider=SQLNCLI11.1;Auto Translate=False;', 'MIP-HMP', -1, GETUTCDATE(), GETUTCDATE(), '')
  , (7, N'Data Source=192.168.240.219;User ID=52projects01;Password=Proj3ct$;Initial Catalog=WITW;Provider=SQLNCLI11.1;Auto Translate=False;', 'MIP-WITW', -1, GETUTCDATE(), GETUTCDATE(), '')
	
)
AS Source (ConnectionStringID, [Source], Note, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
ON Target.ConnectionStringID = Source.ConnectionStringID
WHEN MATCHED THEN 
UPDATE SET 
      Target.[Source]          = Source.[Source]
    , Target.Note              = Source.Note
    , Target.ExecutionID	      = Source.ExecutionID
    , Target.InsertedDateTime  = Source.InsertedDateTime
    , Target.UpdatedDateTime   = Source.UpdatedDateTime
    , Target.HashValue		 = Source.HashValue
WHEN NOT MATCHED BY TARGET THEN
INSERT (ConnectionStringID, [Source], Note, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
VALUES (ConnectionStringID, [Source], Note, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
;

--define HBC Tenant
MERGE INTO Tenant AS Target
 USING (VALUES
	(3, 'HBC',1, 1, -1, GETUTCDATE(), GETUTCDATE(), '')
) AS Source ( TenantID, TenantName, IsActive, ConnectionStringID, ExecutionID, InsertedDateTime, UpdatedDateTime, Hashvalue)
ON Target.TenantID = Source.TenantID
WHEN MATCHED THEN 
UPDATE SET 
      Target.TenantName          = Source.TenantName
    , Target.IsActive              = Source.IsActive
	, Target.ConnectionStringID              = Source.ConnectionStringID
    , Target.ExecutionID	      = Source.ExecutionID
    , Target.InsertedDateTime  = Source.InsertedDateTime
    , Target.UpdatedDateTime   = Source.UpdatedDateTime
    , Target.HashValue		 = Source.HashValue
WHEN NOT MATCHED BY TARGET THEN
INSERT  ( TenantID, TenantName, IsActive, ConnectionStringID, ExecutionID, InsertedDateTime, UpdatedDateTime, Hashvalue)
VALUES  ( TenantID, TenantName, IsActive, ConnectionStringID, ExecutionID, InsertedDateTime, UpdatedDateTime, Hashvalue)
;

--enable all defined ETLPackages as active for HBC
--MIP imports for HBC
--short term: delete the table and rebuild
DELETE FROM TenantETLProcess;
INSERT INTO TenantETLProcess
VALUES 
    (3, 1, 1)
  , (3, 2, 0)
  , (3, 3, 0)
  , (3, 4, 0)
  , (3, 5, 0)
  , (3, 6, 2)
  , (3, 6, 3)
  , (3, 6, 4)
  , (3, 6, 5)
  , (3, 6, 6)
  , (3, 6, 7)
  , (3, 7, 2)
  , (3, 7, 3)
  , (3, 7, 4)
  , (3, 7, 5)
  , (3, 7, 6)
  , (3, 7, 7);

--base tenants (including HBC
MERGE INTO Tenant AS Target
USING (VALUES
	  (0, 'Global'				, 1, 1, -1, GETUTCDATE(), GETUTCDATE(), '')
	, (1, '52projects Church'	, 1, 1, -1, GETUTCDATE(), GETUTCDATE(), '')
	, (2, 'Integration Church'	, 1, 1, -1, GETUTCDATE(), GETUTCDATE(), '')
	, (3, 'Harvest Bible Chapel'  , 1, 1, -1, GETUTCDATE(), GETUTCDATE(), '')
)
AS Source (TenantID, TenantName, IsActive, ConnectionStringID, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
	ON Target.TenantID = Source.TenantID
WHEN MATCHED THEN
UPDATE SET 
	  target.TenantName = Source.TenantName
	, target.IsActive = Source.IsActive
	, target.ConnectionStringID = Source.ConnectionStringID
	, Target.ExecutionID	   = Source.ExecutionID
	 , Target.InsertedDateTime  = Source.InsertedDateTime
	 , Target.UpdatedDateTime   = Source.UpdatedDateTime
	 , Target.HashValue		   = Source.HashValue
WHEN NOT MATCHED BY TARGET THEN
INSERT (TenantID, TenantName, IsActive, ConnectionStringID, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
VALUES (TenantID, TenantName, IsActive, ConnectionStringID, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
;

--DimActivity depends on DimCampus And DimMinistry, so it's after DimMinistry

--DimAttendanceType
MERGE INTO DW.DimAttendanceType AS Target
USING ( VALUES
      ( -1, 3, 'Unknown'    , ''                   , ''                                  , -1, GETUTCDATE(), GETUTCDATE(), '')
   
) AS Source
(AttendanceTypeID, TenantID, Category, Job, VolStaffSchedule, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
    ON Target.AttendanceTypeID = Source.AttendanceTypeID
    AND Target.TenantID = Source.TenantID
WHEN NOT MATCHED BY Target THEN
    INSERT (AttendanceTypeID, TenantID, Category, Job, VolStaffSchedule, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
    VALUES (AttendanceTypeID, TenantID, Category, Job, VolStaffSchedule, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
WHEN MATCHED THEN
UPDATE SET
        Target.Category         = Source.Category
	 , Target.Job              = Source.Job 
	 , Target.VolStaffSchedule = Source.VolStaffSchedule
	 , Target.ExecutionID	   = Source.ExecutionID
	 , Target.InsertedDateTime  = Source.InsertedDateTime
	 , Target.UpdatedDateTime   = Source.UpdatedDateTime
	 , Target.HashValue		   = Source.HashValue
;

--DimCampus -- hardcoded until we find an authoritative source
MERGE INTO DW.DimCampus AS Target
USING ( VALUES
      (-1, 3, '--', 'Unknown'             , '1/1/1900', 1, -1, GETUTCDATE(), GETUTCDATE(), '')
    , (1 , 3, 'AU', 'Aurora'		       , '1/1/1900', 1, -1, GETUTCDATE(), GETUTCDATE(), '')
    , (2 , 3, 'CC', 'Chicago Cathedral'   , '1/1/1900', 1, -1, GETUTCDATE(), GETUTCDATE(), '')
    , (3 , 3, 'CL', 'Crystal Lake'        , '1/1/1900', 1, -1, GETUTCDATE(), GETUTCDATE(), '')
    , (4 , 3, 'EL', 'Elgin'               , '1/1/1900', 1, -1, GETUTCDATE(), GETUTCDATE(), '')
    , (5 , 3, 'NI', 'Niles'               , '1/1/1900', 1, -1, GETUTCDATE(), GETUTCDATE(), '')
    , (6 , 3, 'NS', 'Deerfield Rd'        , '1/1/1900', 1, -1, GETUTCDATE(), GETUTCDATE(), '')
    , (7 , 3, 'RM', 'Rolling Meadows'     , '1/1/1900', 1, -1, GETUTCDATE(), GETUTCDATE(), '')
    , (8 , 3, 'SP', 'Elgin Campus Spanish', '1/1/1900', 1, -1, GETUTCDATE(), GETUTCDATE(), '')
    , (9 , 3, 'WW', 'Online Church'       , '1/1/1900', 1, -1, GETUTCDATE(), GETUTCDATE(), '')

) AS Source
(CampusID, TenantID, Code, Name, StartDateTime, Active, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
    ON  Target.CampusID = Source.CampusID
    AND Target.TenantID = Source.TenantID
WHEN NOT MATCHED BY Target THEN
    INSERT (CampusID, TenantID, Code, Name, StartDateTime, Active, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
    VALUES (CampusID, TenantID, Code, Name, StartDateTime, Active, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
WHEN MATCHED AND Target.Name != Source.Name OR Target.Code != Source.Code THEN
UPDATE SET
        Target.Code              = Source.Code
	 , Target.Name			   = Source.Name
	 , Target.StartDateTime	   = Source.StartDateTime
	 , Target.Active		   = Source.Active
	 , Target.ExecutionID	   = Source.ExecutionID
	 , Target.InsertedDateTime  = Source.InsertedDateTime
	 , Target.UpdatedDateTime   = Source.UpdatedDateTime
	 , Target.HashValue		   = Source.HashValue
;

--DimDate Load at least the next five years and the previous five years
DECLARE @FiveYearsAgo DATE, @FiveYearsFromNow DATE
SET @FiveYearsAgo = '1/1/' + CONVERT(VARCHAR(4), YEAR(GETUTCDATE()) - 5)
SET @FiveYearsFromNow = '12/31/' + CONVERT(VARCHAR(4), YEAR(GETUTCDATE()) + 5)

EXEC DW.usp_UpsertDimDate @FiveYearsAgo, @FiveYearsFromNow

--DimIndividualStatus

MERGE INTO DW.DimIndividualStatus AS Target
USING ( VALUES
    (-1, 3, 'Unknown','Unknown', -1, -1, GETUTCDATE(), GETUTCDATE(), '')
)AS Source
(IndividualStatusID, TenantID, [Status], SubStatus, CampusID, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
   ON Target.IndividualStatusID = Source.IndividualStatusID
    AND Target.TenantID = Source.TenantID
WHEN NOT MATCHED BY Target THEN
    INSERT (IndividualStatusID, TenantID, [Status], SubStatus, CampusID, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
    VALUES (IndividualStatusID, TenantID, [Status], SubStatus, CampusID, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
WHEN MATCHED THEN
UPDATE SET
        Target.[Status]            = Source.[Status]
      , Target.SubStatus            = Source.SubStatus
	 , Target.CampusID            = Source.CampusID	   
   	 , Target.ExecutionID	   = Source.ExecutionID
	 , Target.InsertedDateTime  = Source.InsertedDateTime
	 , Target.UpdatedDateTime   = Source.UpdatedDateTime
	 , Target.HashValue		   = Source.HashValue
;
--DimLifeEventType
MERGE INTO DW.DimLifeEventType AS Target
USING ( VALUES
        (-1, 3, 'Unknown'                      , -1, GETUTCDATE(), GETUTCDATE(), '')
	 , (1 , 3, 'FTV'                          , -1, GETUTCDATE(), GETUTCDATE(), '')
	 , (2 , 3, 'Step 1: Meet'                 , -1, GETUTCDATE(), GETUTCDATE(), '')
      , (3 , 3, 'Step 2: Connect'              , -1, GETUTCDATE(), GETUTCDATE(), '')
      , (4 , 3, 'Baptized'                     , -1, GETUTCDATE(), GETUTCDATE(), '')  	
	 , (5 , 3, 'Membership Confirmation Sent' , -1, GETUTCDATE(), GETUTCDATE(), '')  	
) AS Source
(LifeEventTypeID, TenantID, Name, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
    ON Target.LifeEventTypeID = Source.LifeEventTypeID
    AND Target.TenantID = Source.TenantID
WHEN NOT MATCHED BY Target THEN
    INSERT (LifeEventTypeID, TenantID, Name, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
    VALUES (LifeEventTypeID, TenantID, Name, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
WHEN MATCHED THEN
UPDATE SET
        Target.Name            = Source.Name
   	 , Target.ExecutionID	   = Source.ExecutionID
	 , Target.InsertedDateTime  = Source.InsertedDateTime
	 , Target.UpdatedDateTime   = Source.UpdatedDateTime
	 , Target.HashValue		   = Source.HashValue
;



--DimMaritalStatus
MERGE INTO DW.DimMaritalStatus AS Target
USING ( VALUES
      (-1, 3, 'Unknown'  , -1, GETUTCDATE(), GETUTCDATE(), '')
    , ( 1, 3, 'Child/Yth', -1, GETUTCDATE(), GETUTCDATE(), '')
    , ( 2, 3, 'Divorced'	, -1, GETUTCDATE(), GETUTCDATE(), '')
    , ( 3, 3, 'Married'	, -1, GETUTCDATE(), GETUTCDATE(), '')
    , ( 4, 3, 'Separated', -1, GETUTCDATE(), GETUTCDATE(), '')
    , ( 5, 3, 'Single'	, -1, GETUTCDATE(), GETUTCDATE(), '')
    , ( 6, 3, 'Widow'	, -1, GETUTCDATE(), GETUTCDATE(), '')
    , ( 7, 3, 'Widower'	, -1, GETUTCDATE(), GETUTCDATE(), '')
) AS Source
(MaritalStatusID, TenantID, Name, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
    ON Target.MaritalStatusID = Source.MaritalStatusID
    AND Target.TenantID = Source.TenantID
WHEN NOT MATCHED BY Target THEN
    INSERT (MaritalStatusID, TenantID, Name, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
    VALUES (MaritalStatusID, TenantID, Name, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
WHEN MATCHED THEN
UPDATE SET
        Target.Name            = Source.Name
   	 , Target.ExecutionID	   = Source.ExecutionID
	 , Target.InsertedDateTime  = Source.InsertedDateTime
	 , Target.UpdatedDateTime   = Source.UpdatedDateTime
	 , Target.HashValue		   = Source.HashValue
;

--DimMinistry
MERGE INTO DW.DimMinistry AS Target
USING ( VALUES
    (-1, 3, 'Undefined', -1, '1/1/1900', NULL, 1, -1, GETUTCDATE(), GETUTCDATE(), '')
) AS Source
    (MinistryID, TenantID, Name, CampusID, StartDateTime, EndDateTime, Active, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
 ON Target.MinistryID = Source.MinistryID
    AND Target.TenantID = Source.TenantID
WHEN NOT MATCHED BY Target THEN
    INSERT (MinistryID, TenantID, Name, CampusID, StartDateTime, EndDateTime, Active, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
    VALUES (MinistryID, TenantID, Name, CampusID, StartDateTime, EndDateTime, Active, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
WHEN MATCHED THEN
UPDATE SET
      Target.Name       = Source.Name
    , Target.CampusID   = Source.CampusID
    , Target.ExecutionID	   = Source.ExecutionID
    , Target.InsertedDateTime  = Source.InsertedDateTime
    , Target.UpdatedDateTime   = Source.UpdatedDateTime
    , Target.HashValue		   = Source.HashValue
;
--handle the 'CS - Worship  & Production' for each campus insert
MERGE INTO DW.DimMinistry AS Target
USING (
	SELECT 
		  ROW_NUMBER() OVER (ORDER BY src.CampusID) + 1 AS MinistryID
		, 3 AS TenantID
		, 'CS - Worship  & Production' AS Name
		, CampusID
		, '1/1/1900' AS StartDateTime
		, NULL AS EndDateTime
		, 1  AS Active
		, -1 AS ExecutionID
		, GETUTCDATE() AS InsertedDateTime
		, GETUTCDATE() AS UpdatedDateTime
		, '' AS HashValue
	FROM DW.DimCampus src) AS Source
	ON source.MinistryID = Target.MinistryID
	AND source.TenantID = Target.TenantID
WHEN NOT MATCHED BY Target THEN
    INSERT (MinistryID, TenantID, Name, CampusID, StartDateTime, EndDateTime, Active, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
    VALUES (MinistryID, TenantID, Name, CampusID, StartDateTime, EndDateTime, Active, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
WHEN MATCHED THEN
UPDATE SET
      Target.Name       = Source.Name
    , Target.CampusID   = Source.CampusID
    , Target.ExecutionID	   = Source.ExecutionID
    , Target.InsertedDateTime  = Source.InsertedDateTime
    , Target.UpdatedDateTime   = Source.UpdatedDateTime
    , Target.HashValue		   = Source.HashValue
;



--DimActivity
MERGE INTO DW.DimActivity AS Target
USING ( VALUES
    (-1, 3, 'Undefined', -1, -1, '1/1/1900', NULL, 1, -1, GETUTCDATE(), GETUTCDATE(), '')
) AS Source
(ActivityID, TenantID, Name, MinistryID, CampusID, StartDateTime, EndDateTime, Active, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
 ON Target.ActivityID = Source.ActivityID
    AND Target.TenantID = Source.TenantID
WHEN NOT MATCHED BY Target THEN
    INSERT (ActivityID, TenantID, Name, MinistryID, CampusID, StartDateTime, EndDateTime, Active, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
    VALUES (ActivityID, TenantID, Name, MinistryID, CampusID, StartDateTime, EndDateTime, Active, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
WHEN MATCHED THEN
UPDATE SET
      Target.Name       = Source.Name
    , Target.MinistryID = Source.MinistryID
    , Target.CampusID   = Source.CampusID
    , Target.ExecutionID	   = Source.ExecutionID
    , Target.InsertedDateTime  = Source.InsertedDateTime
    , Target.UpdatedDateTime   = Source.UpdatedDateTime
    , Target.HashValue		   = Source.HashValue
;

--DimRoster
MERGE INTO DW.DimRoster AS Target
USING ( VALUES
    (-1, 3, 'Undefined', 'Undefined', 'Undefined', '1/1/1900', NULL, 1, -1, GETUTCDATE(), GETUTCDATE(), '')
) AS Source
(RosterID, TenantID, RosterFolder, Roster, BreakoutGroup, StartDateTime, EndDateTime, Active, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
 ON Target.RosterID = Source.RosterID
    AND Target.TenantID = Source.TenantID
WHEN NOT MATCHED BY Target THEN
    INSERT (RosterID, TenantID, RosterFolder, Roster, BreakoutGroup, StartDateTime, EndDateTime, Active, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
    VALUES (RosterID, TenantID, RosterFolder, Roster, BreakoutGroup, StartDateTime, EndDateTime, Active, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
WHEN MATCHED THEN
UPDATE SET
      Target.RosterFolder       = Source.RosterFolder
    , Target.Roster = Source.Roster
    , Target.BreakoutGroup   = Source.BreakoutGroup
    , Target.ExecutionID	   = Source.ExecutionID
    , Target.InsertedDateTime  = Source.InsertedDateTime
    , Target.UpdatedDateTime   = Source.UpdatedDateTime
    , Target.HashValue		   = Source.HashValue
;

--DimEntity
MERGE INTO DW.DimEntity AS Target
USING ( VALUES
    (-1, 3, ''    , 'Undefined'                ,  -1, GETUTCDATE(), GETUTCDATE(), '')
  , (1 , 3, 'HBF' , 'Harvest Bible Fellowship' ,  -1, GETUTCDATE(), GETUTCDATE(), '')
  , (2 , 3, 'HCA' , 'Harvest Christian Academy',  -1, GETUTCDATE(), GETUTCDATE(), '')
  , (3 , 3, 'HBC' , 'Harvest Bible Chapel'     ,  -1, GETUTCDATE(), GETUTCDATE(), '')
  , (4 , 3, 'WITW', 'Walk in the Word'         ,  -1, GETUTCDATE(), GETUTCDATE(), '')
) AS Source
(EntityID, TenantID, Code, Name, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
 ON Target.EntityID = Source.EntityID
    AND Target.TenantID = Source.TenantID
WHEN NOT MATCHED BY Target THEN
    INSERT (EntityID, TenantID, Code, Name, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
    VALUES (EntityID, TenantID, Code, Name, ExecutionID, InsertedDateTime, UpdatedDateTime, HashValue)
WHEN MATCHED THEN
UPDATE SET
      Target.Name = Source.Name
    , Target.Code = Source.Code
    , Target.ExecutionID	   = Source.ExecutionID
    , Target.InsertedDateTime  = Source.InsertedDateTime
    , Target.UpdatedDateTime   = Source.UpdatedDateTime
    , Target.HashValue		   = Source.HashValue
;
TRUNCATE TABLE GLReportGrouping
INSERT INTO GLReportGrouping
SELECT 4,'15126', 'Expense' UNION
SELECT 3,'15131', 'Expense' UNION
SELECT 3,'15136', 'Expense' UNION
SELECT 3,'15141', 'Expense' UNION
SELECT 5,'15146', 'Expense' UNION
SELECT 4,'15151', 'Expense' UNION
SELECT 4,'15156', 'Expense' UNION
SELECT 3,'15160', 'Expense' UNION
SELECT 3,'15171', 'Expense' UNION
SELECT 1,'40013', 'Expense' UNION
SELECT 1,'40016', 'Expense' UNION
SELECT 1,'40018', 'Expense' UNION
SELECT 1,'40019', 'Expense' UNION
SELECT 1,'40020', 'Expense' UNION
SELECT 1,'40025', 'Expense' UNION
SELECT 1,'40060', 'Expense' UNION
SELECT 1,'40085', 'Expense' UNION
SELECT 1,'40090', 'Expense' UNION
SELECT 1,'41006', 'Expense' UNION
SELECT 1,'41010', 'Expense' UNION
SELECT 1,'41010', 'Expense' UNION
SELECT 1,'41011', 'Expense' UNION
SELECT 1,'41012', 'Expense' UNION
SELECT 1,'41015', 'Expense' UNION
SELECT 1,'41016', 'Expense' UNION
SELECT 1,'41017', 'Expense' UNION
SELECT 1,'41020', 'Expense' UNION
SELECT 1,'41025', 'Expense' UNION
SELECT 1,'41027', 'Expense' UNION
SELECT 3,'41030', 'Expense' UNION
SELECT 1,'42012', 'Expense' UNION
SELECT 1,'42040', 'Expense' UNION
SELECT 1,'42055', 'Expense' UNION
SELECT 1,'42065', 'Expense' UNION
SELECT 1,'43026', 'Expense' UNION
SELECT 1,'43030', 'Expense' UNION
SELECT 5,'43035', 'Expense' UNION
SELECT 1,'44008', 'Expense' UNION
SELECT 1,'44090', 'Expense' UNION
SELECT 1,'45016', 'Expense' UNION
SELECT 1,'45018', 'Expense' UNION
SELECT 1,'45060', 'Expense' UNION
SELECT 5,'45064', 'Expense' UNION
SELECT 1,'46030', 'Expense' UNION
SELECT 1,'49011', 'Expense' UNION
SELECT 3,'49099', 'Expense' UNION
SELECT 3,'50022', 'Expense' UNION
SELECT 3,'50060', 'Expense' UNION
SELECT 3,'50071', 'Expense' UNION
SELECT 3,'50073', 'Expense' UNION
SELECT 3,'50080', 'Expense' UNION
SELECT 3,'50110', 'Expense' UNION
SELECT 3,'50140', 'Expense' UNION
SELECT 3,'50149', 'Expense' UNION
SELECT 3,'50161', 'Expense' UNION
SELECT 5,'50170', 'Expense' UNION
SELECT 6,'50171', 'Expense' UNION
SELECT 3,'50182', 'Expense' UNION
SELECT 3,'52010', 'Expense' UNION
SELECT 3,'52011', 'Expense' UNION
SELECT 3,'52045', 'Expense' UNION
SELECT 3,'52060', 'Expense' UNION
SELECT 3,'52075', 'Expense' UNION
SELECT 3,'52516', 'Expense' UNION
SELECT 3,'52519', 'Expense' UNION
SELECT 5,'52605', 'Expense' UNION
SELECT 5,'52606', 'Expense' UNION
SELECT 3,'52613', 'Expense' UNION
SELECT 3,'52621', 'Expense' UNION
SELECT 3,'52641', 'Expense' UNION
SELECT 3,'52665', 'Expense' UNION
SELECT 3,'52670', 'Expense' UNION
SELECT 3,'53110', 'Expense' UNION
SELECT 3,'53130', 'Expense' UNION
SELECT 3,'53132', 'Expense' UNION
SELECT 3,'54040', 'Expense' UNION
SELECT 3,'54045', 'Expense' UNION
SELECT 3,'54050', 'Expense' UNION
SELECT 3,'54065', 'Expense' UNION
SELECT 4,'60307', 'Expense' UNION
SELECT 4,'60432', 'Expense' UNION
SELECT 4,'61045', 'Expense' UNION
SELECT 4,'62050', 'Expense' UNION
SELECT 4,'62315', 'Expense' UNION
SELECT 4,'62320', 'Expense' UNION
SELECT 4,'62328', 'Expense' UNION
SELECT 4,'62385', 'Expense' UNION
SELECT 4,'63145', 'Expense' UNION
SELECT 5,'70110', 'Expense' UNION
SELECT 5,'70136', 'Expense' UNION
SELECT 5,'70165', 'Expense' UNION
SELECT 5,'70172', 'Expense' UNION
SELECT 4,'70177', 'Expense' UNION
SELECT 5,'70182', 'Expense' UNION
SELECT 5,'70198', 'Expense' UNION
SELECT 5,'70239', 'Expense' UNION
SELECT 5,'70280', 'Expense' UNION
SELECT 5,'70305', 'Expense' UNION
SELECT 5,'78050', 'Expense' UNION
SELECT 5,'78075', 'Expense' UNION
SELECT 4,'78105', 'Expense' UNION
SELECT 5,'78111', 'Expense' UNION
SELECT 5,'78125', 'Expense' UNION
SELECT 2,'90122', 'Expense' UNION
SELECT 2,'90123', 'Expense' UNION
SELECT 2,'90125', 'Expense' UNION
SELECT 2,'90128', 'Expense' UNION
SELECT 2,'90172', 'Expense' UNION
SELECT 5,'90420', 'Expense' UNION
SELECT 5,'90422', 'Expense' UNION
SELECT 5,'90425', 'Expense' UNION
SELECT 5,'90430', 'Expense' UNION
SELECT 5,'90432', 'Expense' UNION
SELECT 5,'90452', 'Expense' UNION
SELECT 5,'90485', 'Expense' UNION
SELECT 5,'90509', 'Expense' UNION
SELECT 2,'90510', 'Expense' UNION
SELECT 2,'90511', 'Expense' UNION
SELECT 2,'90512', 'Expense' UNION
SELECT 2,'90514', 'Expense' UNION
SELECT 2,'90516', 'Expense' UNION
SELECT 2,'90518', 'Expense' UNION
SELECT 2,'90610', 'Expense' UNION
SELECT 2,'90615', 'Expense' UNION
SELECT 1,'40004', 'Expense' UNION
SELECT 1,'40025', 'Expense' UNION
SELECT 1,'40060', 'Expense' UNION
SELECT 1,'40075', 'Expense' UNION
SELECT 5,'44007', 'Expense' UNION
SELECT 5,'44015', 'Expense' UNION
SELECT 5,'45010', 'Expense' UNION
SELECT 4,'45012', 'Expense' UNION
SELECT 5,'50152', 'Expense' UNION
SELECT 5,'70108', 'Expense' UNION
SELECT 5,'70119', 'Expense' UNION
SELECT 5,'70120', 'Expense' UNION
SELECT 5,'70128', 'Expense' UNION
SELECT 5,'70135', 'Expense' UNION
SELECT 5,'70160', 'Expense' UNION
SELECT 5,'70254', 'Expense' UNION
SELECT 5,'70257', 'Expense' UNION
SELECT 5,'70265', 'Expense' UNION
SELECT 5,'70290', 'Expense' UNION
SELECT 5,'70370', 'Expense' UNION
SELECT 5,'70380', 'Expense' UNION
SELECT 5,'70382', 'Expense' UNION
SELECT 5,'70491', 'Expense' UNION
SELECT 5,'70494', 'Expense' UNION
SELECT 5,'70495', 'Expense' UNION
SELECT 5,'70505', 'Expense' UNION
SELECT 5,'70540', 'Expense' UNION
SELECT 5,'70544', 'Expense' UNION
SELECT 5,'70545', 'Expense' UNION
SELECT 5,'70560', 'Expense' UNION
SELECT 5,'70600', 'Expense' UNION
SELECT 3,'90515', 'Expense' UNION
--Revenues
SELECT 3, '30005', 'Revenue' UNION
SELECT 3, '30007', 'Revenue' UNION
SELECT 3, '30008', 'Revenue' UNION
SELECT 1, '30010', 'Revenue' UNION
SELECT 1, '30012', 'Revenue' UNION
SELECT 3, '30015', 'Revenue' UNION
SELECT 1, '30016', 'Revenue' UNION
SELECT 3, '30018', 'Revenue' UNION
SELECT 2, '30022', 'Revenue' UNION
SELECT 1, '30024', 'Revenue' UNION
SELECT 1, '30026', 'Revenue' UNION
SELECT 1, '30030', 'Revenue' UNION
SELECT 2, '30031', 'Revenue' UNION
SELECT 3, '30034', 'Revenue' UNION
SELECT 3, '30035', 'Revenue' UNION
SELECT 3, '30038', 'Revenue' UNION
SELECT 3, '30039', 'Revenue' UNION
SELECT 3, '30040', 'Revenue' UNION
SELECT 3, '30041', 'Revenue' UNION
SELECT 3, '30042', 'Revenue' UNION
SELECT 3, '30043', 'Revenue' UNION
SELECT 3, '30046', 'Revenue' UNION
SELECT 3, '30058', 'Revenue' UNION
SELECT 3, '30060', 'Revenue' UNION
SELECT 3, '30065', 'Revenue' UNION
SELECT 2, '30067', 'Revenue' UNION
SELECT 3, '30075', 'Revenue' UNION
SELECT 3, '30085', 'Revenue' UNION
SELECT 3, '30090', 'Revenue' UNION
SELECT 3, '30091', 'Revenue' UNION
SELECT 3, '30093', 'Revenue' UNION
SELECT 3, '30094', 'Revenue' UNION
SELECT 3, '30095', 'Revenue' UNION
SELECT 3, '30096', 'Revenue' UNION
SELECT 3, '30097', 'Revenue' UNION
SELECT 3, '30098', 'Revenue' UNION
SELECT 3, '30100', 'Revenue' UNION
SELECT 3, '30101', 'Revenue' UNION
SELECT 3, '30102', 'Revenue' UNION
SELECT 3, '30104', 'Revenue' UNION
SELECT 3, '30106', 'Revenue' UNION
SELECT 3, '30108', 'Revenue' UNION
SELECT 3, '30110', 'Revenue' UNION
SELECT 3, '30112', 'Revenue' UNION
SELECT 3, '30114', 'Revenue' UNION
SELECT 3, '30116', 'Revenue' UNION
SELECT 3, '30117', 'Revenue' UNION
SELECT 3, '30118', 'Revenue' UNION
SELECT 3, '30120', 'Revenue' UNION
SELECT 1, '30150', 'Revenue' UNION
SELECT 3, '30190', 'Revenue' UNION
SELECT 3, '30195', 'Revenue' UNION
SELECT 3, '30196', 'Revenue' UNION
SELECT 3, '30197', 'Revenue' UNION
SELECT 3, '30199', 'Revenue' UNION
SELECT 3, '30200', 'Revenue' UNION
SELECT 3, '30202', 'Revenue' UNION
SELECT 3, '31025', 'Revenue' UNION
SELECT 3, '31030', 'Revenue' UNION
SELECT 3, '31035', 'Revenue' UNION
SELECT 3, '32008', 'Revenue' UNION
SELECT 3, '32010', 'Revenue' UNION
SELECT 3, '32012', 'Revenue' UNION
SELECT 3, '32018', 'Revenue' UNION
SELECT 3, '32090', 'Revenue' UNION
SELECT 3, '35001', 'Revenue' UNION
SELECT 3, '35003', 'Revenue' UNION
SELECT 3, '35004', 'Revenue' UNION
SELECT 3, '35005', 'Revenue' UNION
SELECT 3, '35010', 'Revenue' UNION
SELECT 3, '35015', 'Revenue' UNION
SELECT 3, '35020', 'Revenue' UNION
SELECT 3, '35024', 'Revenue' UNION
SELECT 3, '35025', 'Revenue' UNION
SELECT 3, '35026', 'Revenue' UNION
SELECT 3, '35050', 'Revenue' UNION
SELECT 3, '35050', 'Revenue' UNION
SELECT 3, '35060', 'Revenue' UNION
SELECT 3, '35115', 'Revenue' UNION
SELECT 3, '35126', 'Revenue' UNION
SELECT 3, '35135', 'Revenue' UNION
SELECT 3, '35141', 'Revenue' UNION
SELECT 3, '35142', 'Revenue' UNION
SELECT 3, '35143', 'Revenue' UNION
SELECT 3, '35145', 'Revenue' UNION
SELECT 3, '35158', 'Revenue' UNION
SELECT 3, '37005', 'Revenue' UNION
SELECT 3, '37006', 'Revenue' UNION
SELECT 3, '37010', 'Revenue' UNION
SELECT 3, '37012', 'Revenue' UNION
SELECT 3, '37020', 'Revenue' UNION
SELECT 3, '37020', 'Revenue' UNION
SELECT 3, '37020', 'Revenue' UNION
SELECT 3, '37021', 'Revenue' UNION
SELECT 3, '37022', 'Revenue' UNION
SELECT 3, '37022', 'Revenue' UNION
SELECT 3, '37023', 'Revenue' UNION
SELECT 3, '37024', 'Revenue' UNION
SELECT 3, '37025', 'Revenue' UNION
SELECT 3, '37025', 'Revenue' UNION
SELECT 3, '37030', 'Revenue' UNION
SELECT 3, '37030', 'Revenue' UNION
SELECT 3, '37432', 'Revenue' UNION
SELECT 3, '39999', 'Revenue' 
