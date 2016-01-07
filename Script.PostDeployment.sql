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
	(1, N'Data Source=devharvestbible.database.windows.net;Persist Security Info=True;Initial Catalog=HarvestBible;packet size=4096', 'Harvest bible connection string.', -1, GETUTCDATE(), GETUTCDATE(), '')
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
INSERT INTO TenantEtlProcess
SELECT 3, src.ETLProcessID
FROM ETLProcess src
LEFT JOIN TenantEtlProcess dest
    ON dest.TenantID = 3
    AND src.ETLProcessID = dest.ETLProcessID
WHERE
    dest.ETLProcessID IS NULL;



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

