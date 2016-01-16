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
  , (2, N'Data Source=hbcrmmip.harvestbible.org\mipdbase;Persist Security Info=True;Initial Catalog=CHC;packet size=4096;UserID=HBCMIPServices01;Password=S3rv!ce$;', 'MIP-CHC', -1, GETUTCDATE(), GETUTCDATE(), '')
  , (3, N'Data Source=hbcrmmip.harvestbible.org\mipdbase;Persist Security Info=True;Initial Catalog=HBC;packet size=4096;UserID=HBCMIPServices01;Password=S3rv!ce$;', 'MIP-HBC', -1, GETUTCDATE(), GETUTCDATE(), '')
  , (4, N'Data Source=hbcrmmip.harvestbible.org\mipdbase;Persist Security Info=True;Initial Catalog=HBF;packet size=4096;UserID=HBCMIPServices01;Password=S3rv!ce$;', 'MIP-HBF', -1, GETUTCDATE(), GETUTCDATE(), '')
  , (5, N'Data Source=hbcrmmip.harvestbible.org\mipdbase;Persist Security Info=True;Initial Catalog=HCA;packet size=4096;UserID=HBCMIPServices01;Password=S3rv!ce$;', 'MIP-HCA', -1, GETUTCDATE(), GETUTCDATE(), '')
  , (6, N'Data Source=hbcrmmip.harvestbible.org\mipdbase;Persist Security Info=True;Initial Catalog=HMP;packet size=4096;UserID=HBCMIPServices01;Password=S3rv!ce$;', 'MIP-HMP', -1, GETUTCDATE(), GETUTCDATE(), '')
  , (7, N'Data Source=hbcrmmip.harvestbible.org\mipdbase;Persist Security Info=True;Initial Catalog=WITW;packet size=4096;UserID=HBCMIPServices01;Password=S3rv!ce$;', 'MIP-WITW', -1, GETUTCDATE(), GETUTCDATE(), '')
	
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
INSERT INTO Tenant
( TenantID, TenantName, IsActive, ConnectionStringID, ExecutionID, InsertedDateTime, UpdatedDateTime, Hashvalue)
VALUES(3, 'HBC',1, 1, -1, GETUTCDATE(), GETUTCDATE(), '');

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
INSERT INTO DW.DimMinistry
SELECT 
      ROW_NUMBER() OVER (ORDER BY CampusID) + 1 AS MinistryID
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
FROM DW.DimCampus 
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

TRUNCATE TABLE GLExpenseGrouping
INSERT INTO GLExpenseGrouping
SELECT 4,'15126' UNION
SELECT 3,'15131' UNION
SELECT 3,'15136' UNION
SELECT 3,'15141' UNION
SELECT 5,'15146' UNION
SELECT 4,'15151' UNION
SELECT 4,'15156' UNION
SELECT 3,'15160' UNION
SELECT 3,'15171' UNION
SELECT 1,'40013' UNION
SELECT 1,'40016' UNION
SELECT 1,'40018' UNION
SELECT 1,'40019' UNION
SELECT 1,'40020' UNION
SELECT 1,'40025' UNION
SELECT 1,'40060' UNION
SELECT 1,'40085' UNION
SELECT 1,'40090' UNION
SELECT 1,'41006' UNION
SELECT 1,'41010' UNION
SELECT 1,'41010' UNION
SELECT 1,'41011' UNION
SELECT 1,'41012' UNION
SELECT 1,'41015' UNION
SELECT 1,'41016' UNION
SELECT 1,'41017' UNION
SELECT 1,'41020' UNION
SELECT 1,'41025' UNION
SELECT 1,'41027' UNION
SELECT 3,'41030' UNION
SELECT 1,'42012' UNION
SELECT 1,'42040' UNION
SELECT 1,'42055' UNION
SELECT 1,'42065' UNION
SELECT 1,'43026' UNION
SELECT 1,'43030' UNION
SELECT 5,'43035' UNION
SELECT 1,'44008' UNION
SELECT 1,'44090' UNION
SELECT 1,'45016' UNION
SELECT 1,'45018' UNION
SELECT 1,'45060' UNION
SELECT 5,'45064' UNION
SELECT 1,'46030' UNION
SELECT 1,'49011' UNION
SELECT 3,'49099' UNION
SELECT 3,'50022' UNION
SELECT 5,'50022' UNION
SELECT 3,'50060' UNION
SELECT 3,'50071' UNION
SELECT 3,'50073' UNION
SELECT 3,'50080' UNION
SELECT 3,'50110' UNION
SELECT 3,'50140' UNION
SELECT 3,'50149' UNION
SELECT 3,'50161' UNION
SELECT 5,'50170' UNION
SELECT 6,'50170' UNION
SELECT 6,'50171' UNION
SELECT 3,'50182' UNION
SELECT 3,'52010' UNION
SELECT 3,'52011' UNION
SELECT 3,'52045' UNION
SELECT 3,'52060' UNION
SELECT 3,'52075' UNION
SELECT 3,'52516' UNION
SELECT 3,'52519' UNION
SELECT 5,'52605' UNION
SELECT 5,'52606' UNION
SELECT 3,'52613' UNION
SELECT 3,'52621' UNION
SELECT 3,'52641' UNION
SELECT 3,'52665' UNION
SELECT 3,'52670' UNION
SELECT 3,'53110' UNION
SELECT 3,'53130' UNION
SELECT 3,'53132' UNION
SELECT 3,'54040' UNION
SELECT 3,'54045' UNION
SELECT 3,'54050' UNION
SELECT 3,'54065' UNION
SELECT 4,'60307' UNION
SELECT 4,'60432' UNION
SELECT 4,'61045' UNION
SELECT 4,'62050' UNION
SELECT 4,'62315' UNION
SELECT 4,'62320' UNION
SELECT 4,'62328' UNION
SELECT 4,'62385' UNION
SELECT 4,'63145' UNION
SELECT 5,'70110' UNION
SELECT 5,'70136' UNION
SELECT 5,'70165' UNION
SELECT 5,'70172' UNION
SELECT 4,'70177' UNION
SELECT 5,'70182' UNION
SELECT 5,'70198' UNION
SELECT 5,'70239' UNION
SELECT 5,'70280' UNION
SELECT 5,'70305' UNION
SELECT 5,'78050' UNION
SELECT 5,'78075' UNION
SELECT 4,'78105' UNION
SELECT 5,'78111' UNION
SELECT 5,'78125' UNION
SELECT 2,'90122' UNION
SELECT 2,'90123' UNION
SELECT 2,'90125' UNION
SELECT 2,'90128' UNION
SELECT 2,'90172' UNION
SELECT 5,'90420' UNION
SELECT 5,'90422' UNION
SELECT 5,'90425' UNION
SELECT 5,'90430' UNION
SELECT 5,'90432' UNION
SELECT 5,'90452' UNION
SELECT 5,'90485' UNION
SELECT 5,'90509' UNION
SELECT 2,'90510' UNION
SELECT 2,'90511' UNION
SELECT 2,'90512' UNION
SELECT 2,'90514' UNION
SELECT 2,'90516' UNION
SELECT 2,'90518' UNION
SELECT 2,'90610' UNION
SELECT 2,'90615' UNION
SELECT 1,'40004' UNION
SELECT 1,'40025' UNION
SELECT 1,'40060' UNION
SELECT 1,'40075' UNION
SELECT 5,'44007' UNION
SELECT 5,'44015' UNION
SELECT 5,'45010' UNION
SELECT 4,'45012' UNION
SELECT 5,'50152' UNION
SELECT 5,'70108' UNION
SELECT 5,'70119' UNION
SELECT 5,'70120' UNION
SELECT 5,'70128' UNION
SELECT 5,'70135' UNION
SELECT 5,'70160' UNION
SELECT 5,'70254' UNION
SELECT 5,'70257' UNION
SELECT 5,'70265' UNION
SELECT 5,'70290' UNION
SELECT 5,'70370' UNION
SELECT 5,'70380' UNION
SELECT 5,'70382' UNION
SELECT 5,'70491' UNION
SELECT 5,'70494' UNION
SELECT 5,'70495' UNION
SELECT 5,'70505' UNION
SELECT 5,'70540' UNION
SELECT 5,'70544' UNION
SELECT 5,'70545' UNION
SELECT 5,'70560' UNION
SELECT 5,'70600' UNION
SELECT 3,'90515' 
