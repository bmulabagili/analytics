﻿SET NOCOUNT ON;
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
	, (8, 'TransactionalManualDataEntry',NULL)
	, (9, 'Paycor',NULL)
	, (10, 'InfiniteCampus_Enrollment', NULL)
	, (11, 'GoogleAnalytics',NULL)
	, (12, 'Mailchimp_Stats', NULL)
	, (13, 'MPX_Activity', NULL)
	, (14, 'FellowshipOne_ContactItem', NULL)
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
IF @@SERVERNAME = 'UATANALYTICS' 
BEGIN
	MERGE INTO dbo.ConnectionString AS Target
	USING (VALUES
		 (0, N'FlatFileSource', N'FlatFileSource', -1, GETDATE(), GETDATE(), '')
	  ,	(1, N'Data Source=devharvestbible.database.windows.net;User ID=HB1User;Password=u53r4hb1!;Initial Catalog=HarvestBible;Provider=SQLNCLI11.1;Auto Translate=False;', 'Harvest bible connection string.', -1, GETDATE(), GETDATE(), '')
	  , (2, N'Data Source=192.168.240.219;User ID=52projects01;Password=Proj3ct$;Initial Catalog=CHC;Provider=SQLNCLI11.1;Auto Translate=False;', 'MIP-CHC', -1, GETDATE(), GETDATE(), '')
	  , (3, N'Data Source=192.168.240.219;User ID=52projects01;Password=Proj3ct$;Initial Catalog=HBC;Provider=SQLNCLI11.1;Auto Translate=False;', 'MIP-HBC', -1, GETDATE(), GETDATE(), '')
	  , (4, N'Data Source=192.168.240.219;User ID=52projects01;Password=Proj3ct$;Initial Catalog=HBF;Provider=SQLNCLI11.1;Auto Translate=False;', 'MIP-HBF', -1, GETDATE(), GETDATE(), '')
	  , (5, N'Data Source=192.168.240.219;User ID=52projects01;Password=Proj3ct$;Initial Catalog=HCA;Provider=SQLNCLI11.1;Auto Translate=False;', 'MIP-HCA', -1, GETDATE(), GETDATE(), '')
	  , (6, N'Data Source=192.168.240.219;User ID=52projects01;Password=Proj3ct$;Initial Catalog=HMP;Provider=SQLNCLI11.1;Auto Translate=False;', 'MIP-HMP', -1, GETDATE(), GETDATE(), '')
	  , (7, N'Data Source=192.168.240.219;User ID=52projects01;Password=Proj3ct$;Initial Catalog=WITW;Provider=SQLNCLI11.1;Auto Translate=False;', 'MIP-WITW', -1, GETDATE(), GETDATE(), '')
	  --for some reason the infinite campus data was named harvest on 219
	  , (8 , N'Data Source=192.168.240.219;User ID=52projects01;Password=Proj3ct$;Initial Catalog=harvest;Provider=SQLNCLI11.1;Auto Translate=False;', 'InfiniteCampus', -1, GETDATE(), GETDATE(), '')
	  , (9 , N'Data Source=192.168.240.219;User ID=52projects01;Password=Proj3ct$;Initial Catalog=MPXWIWU;Provider=SQLNCLI11.1;Auto Translate=False;', 'MPX', -1, GETDATE(), GETDATE(), '')
	  , (10, N'Data Source=192.168.240.219;User ID=52projects01;Password=Proj3ct$;Initial Catalog=MPXWIWC;Provider=SQLNCLI11.1;Auto Translate=False;', 'MPX', -1, GETDATE(), GETDATE(), '')
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
END
ELSE
BEGIN
	MERGE INTO dbo.ConnectionString AS Target
	USING (VALUES
		(0, N'FlatFileSource', N'FlatFileSource', -1, GETDATE(), GETDATE(), '')
	  ,	(1, N'Data Source=devharvestbible.database.windows.net;Persist Security Info=True;Initial Catalog=HarvestBible;packet size=4096', 'Harvest bible connection string.', -1, GETDATE(), GETDATE(), '')
			--Data Source=hbcrmmip.harvestbible.org\mipdbase;User ID=52projectsMIP;Password=Proj3ct$;Initial Catalog=CHC;Provider=SQLNCLI11.1;Auto Translate=False;
	  , (2, N'Data Source=hbcrmmip.harvestbible.org\mipdbase;User ID=HBCMIPServices01;Password=S3rv!ce$;Initial Catalog=CHC;Provider=SQLNCLI11.1;Auto Translate=False;', 'MIP-CHC', -1, GETDATE(), GETDATE(), '')
	  , (3, N'Data Source=hbcrmmip.harvestbible.org\mipdbase;User ID=HBCMIPServices01;Password=S3rv!ce$;Initial Catalog=HBC;Provider=SQLNCLI11.1;Auto Translate=False;', 'MIP-HBC', -1, GETDATE(), GETDATE(), '')
	  , (4, N'Data Source=hbcrmmip.harvestbible.org\mipdbase;User ID=HBCMIPServices01;Password=S3rv!ce$;Initial Catalog=HBF;Provider=SQLNCLI11.1;Auto Translate=False;', 'MIP-HBF', -1, GETDATE(), GETDATE(), '')
	  , (5, N'Data Source=hbcrmmip.harvestbible.org\mipdbase;User ID=HBCMIPServices01;Password=S3rv!ce$;Initial Catalog=HCA;Provider=SQLNCLI11.1;Auto Translate=False;', 'MIP-HCA', -1, GETDATE(), GETDATE(), '')
	  , (6, N'Data Source=hbcrmmip.harvestbible.org\mipdbase;User ID=HBCMIPServices01;Password=S3rv!ce$;Initial Catalog=HMP;Provider=SQLNCLI11.1;Auto Translate=False;', 'MIP-HMP', -1, GETDATE(), GETDATE(), '')
	  , (7, N'Data Source=hbcrmmip.harvestbible.org\mipdbase;User ID=HBCMIPServices01;Password=S3rv!ce$;Initial Catalog=WITW;Provider=SQLNCLI11.1;Auto Translate=False;', 'MIP-WITW', -1, GETDATE(), GETDATE(), '')
	  , (8, N'Data Source=localhost;User ID=sa;Password=C4lr1ss14n;Initial Catalog=IC;Provider=SQLNCLI11.1;Auto Translate=False;', 'InfiniteCampus', -1, GETDATE(), GETDATE(), '')
	  , (9, N'Data Source=localhost;User ID=sa;Password=C4lr1ss14n;Initial Catalog=MPXWIWU;Provider=SQLNCLI11.1;Auto Translate=False;', 'MPX-US', -1, GETDATE(), GETDATE(), '')
	  , (10, N'Data Source=localhost;User ID=sa;Password=C4lr1ss14n;Initial Catalog=MPXWIWC;Provider=SQLNCLI11.1;Auto Translate=False;', 'MPX-Canada', -1, GETDATE(), GETDATE(), '')
	  , (11, N'Data Source=localhost;User ID=sa;Password=C4lr1ss14n;Initial Catalog=AsterixAdmin;Provider=SQLNCLI11.1;Auto Translate=False;', 'AsterixAdmin', -1, GETDATE(), GETDATE(), '')
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
END
--define HBC Tenant
MERGE INTO Tenant AS Target
 USING (VALUES
	(3, 'HBC',1, 1, -1, GETDATE(), GETDATE(), '')
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
  , (3, 7, 7)
  , (3, 8, 1)
  , (3, 9, 0)
  , (3, 10, 8)
  , (3, 11, 0)
  , (3, 12, 0)
  , (3, 13, 9)
  , (3, 13, 10)
  , (3, 14, 0);

--base tenants (including HBC
MERGE INTO Tenant AS Target
USING (VALUES
	  (0, 'Global'				, 1, 1, -1, GETDATE(), GETDATE(), '')
	, (1, '52projects Church'	, 1, 1, -1, GETDATE(), GETDATE(), '')
	, (2, 'Integration Church'	, 1, 1, -1, GETDATE(), GETDATE(), '')
	, (3, 'Harvest Bible Chapel'  , 1, 1, -1, GETDATE(), GETDATE(), '')
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
      ( -1, 3, 'Unknown'    , ''                   , ''                                  , -1, GETDATE(), GETDATE(), '')
   
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
      (-1, 3, '--', 'Unknown'             , '1/1/1900', 1, -1, GETDATE(), GETDATE(), '')
    , (1 , 3, 'AU', 'Aurora'		       , '1/1/1900', 1, -1, GETDATE(), GETDATE(), '')
    , (2 , 3, 'CC', 'Chicago Cathedral'   , '1/1/1900', 1, -1, GETDATE(), GETDATE(), '')
    , (3 , 3, 'CL', 'Crystal Lake'        , '1/1/1900', 1, -1, GETDATE(), GETDATE(), '')
    , (4 , 3, 'EL', 'Elgin'               , '1/1/1900', 1, -1, GETDATE(), GETDATE(), '')
    , (5 , 3, 'NI', 'Niles'               , '1/1/1900', 1, -1, GETDATE(), GETDATE(), '')
    , (6 , 3, 'DR', 'Deerfield Rd'        , '1/1/1900', 1, -1, GETDATE(), GETDATE(), '')
    , (7 , 3, 'RM', 'Rolling Meadows'     , '1/1/1900', 1, -1, GETDATE(), GETDATE(), '')
    , (8 , 3, 'SP', 'Elgin Campus Spanish', '1/1/1900', 1, -1, GETDATE(), GETDATE(), '')
    , (9 , 3, 'WW', 'Online Church'       , '1/1/1900', 1, -1, GETDATE(), GETDATE(), '')

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
SET @FiveYearsAgo = '1/1/' + CONVERT(VARCHAR(4), YEAR(GETDATE()) - 5)
SET @FiveYearsFromNow = '12/31/' + CONVERT(VARCHAR(4), YEAR(GETDATE()) + 5)

EXEC DW.usp_UpsertDimDate @FiveYearsAgo, @FiveYearsFromNow

--DimIndividualStatus

MERGE INTO DW.DimIndividualStatus AS Target
USING ( VALUES
    (-1, 3, 'Unknown','Unknown', -1, -1, GETDATE(), GETDATE(), '')
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
        (-1, 3, 'Unknown'                      , -1, GETDATE(), GETDATE(), '')
	 , (1 , 3, 'FTV'                          , -1, GETDATE(), GETDATE(), '')
	 , (2 , 3, 'Step 1: Meet'                 , -1, GETDATE(), GETDATE(), '')
      , (3 , 3, 'Step 2: Connect'              , -1, GETDATE(), GETDATE(), '')
      , (4 , 3, 'Baptized'                     , -1, GETDATE(), GETDATE(), '')  	
	 , (5 , 3, 'Membership Confirmation Sent' , -1, GETDATE(), GETDATE(), '')  	
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
      (-1, 3, 'Unknown'  , -1, GETDATE(), GETDATE(), '')
    , ( 1, 3, 'Child/Yth', -1, GETDATE(), GETDATE(), '')
    , ( 2, 3, 'Divorced'	, -1, GETDATE(), GETDATE(), '')
    , ( 3, 3, 'Married'	, -1, GETDATE(), GETDATE(), '')
    , ( 4, 3, 'Separated', -1, GETDATE(), GETDATE(), '')
    , ( 5, 3, 'Single'	, -1, GETDATE(), GETDATE(), '')
    , ( 6, 3, 'Widow'	, -1, GETDATE(), GETDATE(), '')
    , ( 7, 3, 'Widower'	, -1, GETDATE(), GETDATE(), '')
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
    (-1, 3, 'Undefined', -1, '1/1/1900', NULL, 1, -1, GETDATE(), GETDATE(), '')
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
		, 'CS - Worship & Production' AS Name
		, CampusID
		, '1/1/1900' AS StartDateTime
		, NULL AS EndDateTime
		, 1  AS Active
		, -1 AS ExecutionID
		, GETDATE() AS InsertedDateTime
		, GETDATE() AS UpdatedDateTime
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
    (-1, 3, 'Undefined', -1, -1, '1/1/1900', NULL, 1, -1, GETDATE(), GETDATE(), '')
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
    (-1, 3, 'Undefined', 'Undefined', 'Undefined', '1/1/1900', NULL, 1, -1, GETDATE(), GETDATE(), '')
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
    (-1, 3, ''    , 'Undefined'                ,  -1, GETDATE(), GETDATE(), '')
  , (1 , 3, 'HBF' , 'Harvest Bible Fellowship' ,  -1, GETDATE(), GETDATE(), '')
  , (2 , 3, 'HCA' , 'Harvest Christian Academy',  -1, GETDATE(), GETDATE(), '')
  , (3 , 3, 'HBC' , 'Harvest Bible Chapel'     ,  -1, GETDATE(), GETDATE(), '')
  , (4 , 3, 'WITW', 'Walk in the Word'         ,  -1, GETDATE(), GETDATE(), '')
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
--entity financial mapping
TRUNCATE TABLE GLReportGrouping

DECLARE @EntityCode NVARCHAR(4)

DECLARE @Entities TABLE (EntityCode NVARCHAR(4) )
INSERT INTO @Entities
SELECT 'HBC' UNION
SELECT 'HCA' UNION
SELECT 'HBF' UNION
SELECT 'WITW'

WHILE EXISTS (Select 1 FROM @Entities)
BEGIN
	SELECT TOP 1 @EntityCode = EntityCode FROM @Entities

	INSERT INTO GLReportGrouping
	SELECT 4, '15126', 'Expense', @EntityCode UNION
	SELECT 3, '15131', 'Expense', @EntityCode UNION
	SELECT 3, '15136', 'Expense', @EntityCode UNION
	SELECT 3, '15141', 'Expense', @EntityCode UNION
	SELECT 5, '15146', 'Expense', @EntityCode UNION
	SELECT 4, '15151', 'Expense', @EntityCode UNION
	SELECT 4, '15156', 'Expense', @EntityCode UNION
	SELECT 3, '15160', 'Expense', @EntityCode UNION
	SELECT 3, '15171', 'Expense', @EntityCode UNION
	SELECT 1, '40013', 'Expense', @EntityCode UNION
	SELECT 1, '40016', 'Expense', @EntityCode UNION
	SELECT 1, '40018', 'Expense', @EntityCode UNION
	SELECT 1, '40019', 'Expense', @EntityCode UNION
	SELECT 1, '40020', 'Expense', @EntityCode UNION
	SELECT 1, '40025', 'Expense', @EntityCode UNION
	SELECT 1, '40060', 'Expense', @EntityCode UNION
	SELECT 1, '40085', 'Expense', @EntityCode UNION
	SELECT 1, '40090', 'Expense', @EntityCode UNION
	SELECT 1, '41006', 'Expense', @EntityCode UNION
	SELECT 1, '41010', 'Expense', @EntityCode UNION
	SELECT 1, '41010', 'Expense', @EntityCode UNION
	SELECT 1, '41011', 'Expense', @EntityCode UNION
	SELECT 1, '41012', 'Expense', @EntityCode UNION
	SELECT 1, '41015', 'Expense', @EntityCode UNION
	SELECT 1, '41016', 'Expense', @EntityCode UNION
	SELECT 1, '41017', 'Expense', @EntityCode UNION
	SELECT 1, '41020', 'Expense', @EntityCode UNION
	SELECT 1, '41025', 'Expense', @EntityCode UNION
	SELECT 1, '41027', 'Expense', @EntityCode UNION
	SELECT 3, '41030', 'Expense', @EntityCode UNION
	SELECT 1, '42012', 'Expense', @EntityCode UNION
	SELECT 1, '42040', 'Expense', @EntityCode UNION
	SELECT 1, '42055', 'Expense', @EntityCode UNION
	SELECT 1, '42065', 'Expense', @EntityCode UNION
	SELECT 1, '43026', 'Expense', @EntityCode UNION
	SELECT 1, '43030', 'Expense', @EntityCode UNION
	SELECT 5, '43035', 'Expense', @EntityCode UNION
	SELECT 1, '44008', 'Expense', @EntityCode UNION
	SELECT 1, '44090', 'Expense', @EntityCode UNION
	SELECT 1, '45016', 'Expense', @EntityCode UNION
	SELECT 1, '45018', 'Expense', @EntityCode UNION
	SELECT 1, '45060', 'Expense', @EntityCode UNION
	SELECT 5, '45064', 'Expense', @EntityCode UNION
	SELECT 1, '46030', 'Expense', @EntityCode UNION
	SELECT 1, '49011', 'Expense', @EntityCode UNION
	SELECT 3, '49099', 'Expense', @EntityCode UNION
	SELECT 3, '50022', 'Expense', @EntityCode UNION
	SELECT 3, '50060', 'Expense', @EntityCode UNION
	SELECT 3, '50071', 'Expense', @EntityCode UNION
	SELECT 3, '50073', 'Expense', @EntityCode UNION
	SELECT 3, '50080', 'Expense', @EntityCode UNION
	SELECT 3, '50110', 'Expense', @EntityCode UNION
	SELECT 3, '50140', 'Expense', @EntityCode UNION
	SELECT 3, '50149', 'Expense', @EntityCode UNION
	SELECT 3, '50161', 'Expense', @EntityCode UNION
	SELECT 6, '50170', 'Expense', @EntityCode UNION
	SELECT 6, '50171', 'Expense', @EntityCode UNION
	SELECT 3, '50182', 'Expense', @EntityCode UNION
	SELECT 3, '52010', 'Expense', @EntityCode UNION
	SELECT 3, '52011', 'Expense', @EntityCode UNION
	SELECT 3, '52045', 'Expense', @EntityCode UNION
	SELECT 3, '52060', 'Expense', @EntityCode UNION
	SELECT 3, '52075', 'Expense', @EntityCode UNION
	SELECT 3, '52516', 'Expense', @EntityCode UNION
	SELECT 3, '52519', 'Expense', @EntityCode UNION
	SELECT 5, '52605', 'Expense', @EntityCode UNION
	SELECT 5, '52606', 'Expense', @EntityCode UNION
	SELECT 3, '52613', 'Expense', @EntityCode UNION
	SELECT 3, '52621', 'Expense', @EntityCode UNION
	SELECT 3, '52641', 'Expense', @EntityCode UNION
	SELECT 3, '52665', 'Expense', @EntityCode UNION
	SELECT 3, '52670', 'Expense', @EntityCode UNION
	SELECT 3, '53110', 'Expense', @EntityCode UNION
	SELECT 3, '53130', 'Expense', @EntityCode UNION
	SELECT 3, '53132', 'Expense', @EntityCode UNION
	SELECT 3, '54040', 'Expense', @EntityCode UNION
	SELECT 3, '54045', 'Expense', @EntityCode UNION
	SELECT 3, '54050', 'Expense', @EntityCode UNION
	SELECT 3, '54065', 'Expense', @EntityCode UNION
	SELECT 6, '54069', 'Expense', @EntityCode UNION
	SELECT 6, '54070', 'Expense', @EntityCode UNION
	SELECT 4, '60307', 'Expense', @EntityCode UNION
	SELECT 4, '60432', 'Expense', @EntityCode UNION
	SELECT 4, '61045', 'Expense', @EntityCode UNION
	SELECT 4, '62050', 'Expense', @EntityCode UNION
	SELECT 4, '62315', 'Expense', @EntityCode UNION
	SELECT 4, '62320', 'Expense', @EntityCode UNION
	SELECT 4, '62328', 'Expense', @EntityCode UNION
	SELECT 4, '62385', 'Expense', @EntityCode UNION
	SELECT 4, '63145', 'Expense', @EntityCode UNION
	SELECT 5, '70110', 'Expense', @EntityCode UNION
	SELECT 5, '70136', 'Expense', @EntityCode UNION
	SELECT 5, '70165', 'Expense', @EntityCode UNION
	SELECT 5, '70172', 'Expense', @EntityCode UNION
	SELECT 4, '70177', 'Expense', @EntityCode UNION
	SELECT 5, '70182', 'Expense', @EntityCode UNION
	SELECT 5, '70198', 'Expense', @EntityCode UNION
	SELECT 5, '70239', 'Expense', @EntityCode UNION
	SELECT 5, '70280', 'Expense', @EntityCode UNION
	SELECT 5, '70305', 'Expense', @EntityCode UNION
	SELECT 5, '78050', 'Expense', @EntityCode UNION
	SELECT 5, '78075', 'Expense', @EntityCode UNION
	SELECT 4, '78105', 'Expense', @EntityCode UNION
	SELECT 5, '78111', 'Expense', @EntityCode UNION
	SELECT 5, '78125', 'Expense', @EntityCode UNION
	SELECT 5, '90420', 'Expense', @EntityCode UNION
	SELECT 5, '90422', 'Expense', @EntityCode UNION
	SELECT 5, '90425', 'Expense', @EntityCode UNION
	SELECT 5, '90430', 'Expense', @EntityCode UNION
	SELECT 5, '90432', 'Expense', @EntityCode UNION
	SELECT 5, '90452', 'Expense', @EntityCode UNION
	SELECT 5, '90485', 'Expense', @EntityCode UNION
	SELECT 5, '90509', 'Expense', @EntityCode UNION
	SELECT 2, '90510', 'Expense', @EntityCode UNION
	SELECT 2, '90511', 'Expense', @EntityCode UNION
	SELECT 2, '90512', 'Expense', @EntityCode UNION
	SELECT 2, '90514', 'Expense', @EntityCode UNION
	SELECT 2, '90516', 'Expense', @EntityCode UNION
	SELECT 2, '90518', 'Expense', @EntityCode UNION
	SELECT 2, '90610', 'Expense', @EntityCode UNION
	SELECT 2, '90615', 'Expense', @EntityCode UNION
	SELECT 1, '40004', 'Expense', @EntityCode UNION
	SELECT 1, '40025', 'Expense', @EntityCode UNION
	SELECT 1, '40060', 'Expense', @EntityCode UNION
	SELECT 1, '40075', 'Expense', @EntityCode UNION
	SELECT 5, '44007', 'Expense', @EntityCode UNION
	SELECT 5, '44015', 'Expense', @EntityCode UNION
	SELECT 5, '45010', 'Expense', @EntityCode UNION
	SELECT 4, '45012', 'Expense', @EntityCode UNION
	SELECT 5, '50152', 'Expense', @EntityCode UNION
	SELECT 5, '70108', 'Expense', @EntityCode UNION
	SELECT 5, '70119', 'Expense', @EntityCode UNION
	SELECT 5, '70120', 'Expense', @EntityCode UNION
	SELECT 5, '70128', 'Expense', @EntityCode UNION
	SELECT 5, '70135', 'Expense', @EntityCode UNION
	SELECT 5, '70160', 'Expense', @EntityCode UNION
	SELECT 5, '70254', 'Expense', @EntityCode UNION
	SELECT 5, '70257', 'Expense', @EntityCode UNION
	SELECT 5, '70265', 'Expense', @EntityCode UNION
	SELECT 5, '70290', 'Expense', @EntityCode UNION
	SELECT 5, '70370', 'Expense', @EntityCode UNION
	SELECT 5, '70380', 'Expense', @EntityCode UNION
	SELECT 5, '70382', 'Expense', @EntityCode UNION
	SELECT 5, '70491', 'Expense', @EntityCode UNION
	SELECT 5, '70494', 'Expense', @EntityCode UNION
	SELECT 5, '70495', 'Expense', @EntityCode UNION
	SELECT 5, '70505', 'Expense', @EntityCode UNION
	SELECT 5, '70540', 'Expense', @EntityCode UNION
	SELECT 5, '70544', 'Expense', @EntityCode UNION
	SELECT 5, '70545', 'Expense', @EntityCode UNION
	SELECT 5, '70560', 'Expense', @EntityCode UNION
	SELECT 5, '70600', 'Expense', @EntityCode UNION
	SELECT 3, '90515', 'Expense', @EntityCode UNION
	--adding "Depreciation and Amortization"
	SELECT 7, '90139', 'Expense', @EntityCode UNION
	SELECT 7, '90145', 'Expense', @EntityCode UNION
	SELECT 7, '90222', 'Expense', @EntityCode UNION
	SELECT 7, '90227', 'Expense', @EntityCode UNION
	SELECT 7, '90232', 'Expense', @EntityCode UNION
	SELECT 7, '90235', 'Expense', @EntityCode UNION
	SELECT 7, '90237', 'Expense', @EntityCode UNION
	SELECT 7, '90242', 'Expense', @EntityCode UNION
	SELECT 7, '90247', 'Expense', @EntityCode UNION
	SELECT 7, '80248', 'Expense', @EntityCode UNION
	SELECT 7, '90252', 'Expense', @EntityCode UNION
	SELECT 7, '90257', 'Expense', @EntityCode UNION
	SELECT 7, '90270', 'Expense', @EntityCode UNION

	--Revenues
	SELECT 3, '30005', 'Revenue', @EntityCode UNION
	SELECT 3, '30007', 'Revenue', @EntityCode UNION
	SELECT 3, '30008', 'Revenue', @EntityCode UNION
	SELECT 1, '30012', 'Revenue', @EntityCode UNION
	SELECT 3, '30015', 'Revenue', @EntityCode UNION
	SELECT 1, '30016', 'Revenue', @EntityCode UNION
	SELECT 3, '30018', 'Revenue', @EntityCode UNION
	SELECT 1, '30024', 'Revenue', @EntityCode UNION
	SELECT 1, '30026', 'Revenue', @EntityCode UNION
	SELECT 1, '30030', 'Revenue', @EntityCode UNION
	SELECT 2, '30031', 'Revenue', @EntityCode UNION
	SELECT 3, '30034', 'Revenue', @EntityCode UNION
	SELECT 3, '30035', 'Revenue', @EntityCode UNION
	SELECT 3, '30038', 'Revenue', @EntityCode UNION
	SELECT 3, '30039', 'Revenue', @EntityCode UNION
	SELECT 3, '30040', 'Revenue', @EntityCode UNION
	SELECT 3, '30041', 'Revenue', @EntityCode UNION
	SELECT 2, '30042', 'Revenue', @EntityCode UNION
	SELECT 3, '30043', 'Revenue', @EntityCode UNION
	SELECT 2, '30046', 'Revenue', @EntityCode UNION
	SELECT 2, '30058', 'Revenue', @EntityCode UNION
	SELECT 3, '30060', 'Revenue', @EntityCode UNION
	SELECT 1, '30065', 'Revenue', @EntityCode UNION
	SELECT 2, '30067', 'Revenue', @EntityCode UNION
	SELECT 3, '30075', 'Revenue', @EntityCode UNION
	SELECT 1, '30085', 'Revenue', @EntityCode UNION
	SELECT 3, '30090', 'Revenue', @EntityCode UNION
	SELECT 3, '30091', 'Revenue', @EntityCode UNION
	SELECT 3, '30093', 'Revenue', @EntityCode UNION
	SELECT 3, '30094', 'Revenue', @EntityCode UNION
	SELECT 3, '30095', 'Revenue', @EntityCode UNION
	SELECT 3, '30096', 'Revenue', @EntityCode UNION
	SELECT 3, '30097', 'Revenue', @EntityCode UNION
	SELECT 3, '30098', 'Revenue', @EntityCode UNION
	SELECT 3, '30100', 'Revenue', @EntityCode UNION
	SELECT 3, '30101', 'Revenue', @EntityCode UNION
	SELECT 3, '30102', 'Revenue', @EntityCode UNION
	SELECT 3, '30104', 'Revenue', @EntityCode UNION
	SELECT 2, '30105', 'Revenue', @EntityCode UNION
	SELECT 3, '30106', 'Revenue', @EntityCode UNION
	SELECT 3, '30108', 'Revenue', @EntityCode UNION
	SELECT 3, '30110', 'Revenue', @EntityCode UNION
	SELECT 3, '30112', 'Revenue', @EntityCode UNION
	SELECT 3, '30114', 'Revenue', @EntityCode UNION
	SELECT 3, '30116', 'Revenue', @EntityCode UNION
	SELECT 3, '30117', 'Revenue', @EntityCode UNION
	SELECT 3, '30118', 'Revenue', @EntityCode UNION
	SELECT 3, '30120', 'Revenue', @EntityCode UNION
	SELECT 1, '30150', 'Revenue', @EntityCode UNION
	SELECT 3, '30190', 'Revenue', @EntityCode UNION
	SELECT 3, '30195', 'Revenue', @EntityCode UNION
	SELECT 3, '30196', 'Revenue', @EntityCode UNION
	SELECT 3, '30197', 'Revenue', @EntityCode UNION
	SELECT 3, '30199', 'Revenue', @EntityCode UNION
	SELECT 3, '30200', 'Revenue', @EntityCode UNION
	SELECT 3, '30202', 'Revenue', @EntityCode UNION
	SELECT 3, '31025', 'Revenue', @EntityCode UNION
	SELECT 3, '31030', 'Revenue', @EntityCode UNION
	SELECT 3, '31035', 'Revenue', @EntityCode UNION
	SELECT 3, '32008', 'Revenue', @EntityCode UNION
	SELECT 3, '32010', 'Revenue', @EntityCode UNION
	SELECT 3, '32012', 'Revenue', @EntityCode UNION
	SELECT 3, '32018', 'Revenue', @EntityCode UNION
	SELECT 3, '32090', 'Revenue', @EntityCode UNION
	SELECT 3, '35001', 'Revenue', @EntityCode UNION
	SELECT 3, '35003', 'Revenue', @EntityCode UNION
	SELECT 3, '35004', 'Revenue', @EntityCode UNION
	SELECT 3, '35005', 'Revenue', @EntityCode UNION
	SELECT 3, '35010', 'Revenue', @EntityCode UNION
	SELECT 3, '35015', 'Revenue', @EntityCode UNION
	SELECT 3, '35020', 'Revenue', @EntityCode UNION
	SELECT 3, '35024', 'Revenue', @EntityCode UNION
	SELECT 3, '35025', 'Revenue', @EntityCode UNION
	SELECT 3, '35026', 'Revenue', @EntityCode UNION
	SELECT 3, '35050', 'Revenue', @EntityCode UNION
	SELECT 3, '35050', 'Revenue', @EntityCode UNION
	SELECT 3, '35060', 'Revenue', @EntityCode UNION
	SELECT 3, '35115', 'Revenue', @EntityCode UNION
	SELECT 3, '35126', 'Revenue', @EntityCode UNION
	SELECT 3, '35135', 'Revenue', @EntityCode UNION
	SELECT 3, '35141', 'Revenue', @EntityCode UNION
	SELECT 3, '35142', 'Revenue', @EntityCode UNION
	SELECT 3, '35143', 'Revenue', @EntityCode UNION
	SELECT 3, '35145', 'Revenue', @EntityCode UNION
	SELECT 3, '35158', 'Revenue', @EntityCode UNION
	SELECT 3, '37005', 'Revenue', @EntityCode UNION
	SELECT 3, '37006', 'Revenue', @EntityCode UNION
	SELECT 3, '37010', 'Revenue', @EntityCode UNION
	SELECT 3, '37012', 'Revenue', @EntityCode UNION
	SELECT 3, '37020', 'Revenue', @EntityCode UNION
	SELECT 3, '37020', 'Revenue', @EntityCode UNION
	SELECT 3, '37020', 'Revenue', @EntityCode UNION
	SELECT 3, '37021', 'Revenue', @EntityCode UNION
	SELECT 3, '37022', 'Revenue', @EntityCode UNION
	SELECT 3, '37022', 'Revenue', @EntityCode UNION
	SELECT 3, '37023', 'Revenue', @EntityCode UNION
	SELECT 3, '37024', 'Revenue', @EntityCode UNION
	SELECT 3, '37025', 'Revenue', @EntityCode UNION
	SELECT 3, '37025', 'Revenue', @EntityCode UNION
	SELECT 3, '37030', 'Revenue', @EntityCode UNION
	SELECT 3, '37030', 'Revenue', @EntityCode UNION
	SELECT 3, '37432', 'Revenue', @EntityCode UNION
	SELECT 3, '39999', 'Revenue', @EntityCode

	DELETE FROM @entities WHERE EntityCode = @EntityCode
END
	--hca exception for 30010
	INSERT INTO GLReportGrouping
	SELECT 1, '30010', 'Revenue', 'HBC'  UNION
	SELECT 1, '30010', 'Revenue', 'HBF'  UNION
	SELECT 1, '30010', 'Revenue', 'WITW' UNION
	SELECT 3, '30010', 'Revenue', 'HCA'  UNION

	SELECT 1, '30022', 'Revenue', 'HBC' UNION
	SELECT 1, '30022', 'Revenue', 'HBF' UNION
	SELECT 1, '30022', 'Revenue', 'WITW' UNION
	SELECT 3, '30022', 'Revenue', 'HCA' 

SELECT 
	GroupID
	, CASE WHEN Category = 'Revenue' THEN
		CASE GroupID	
			WHEN 1 THEN 'Unrestricted Donations'			
			WHEN 2 THEN 'Restricted Donations'
			WHEN 3 THEN 'Other Sales (VCB, VCF, WITW, Curriculum)' END 
	  ELSE 
		CASE GroupID
			WHEN 1 THEN 'Compensation'			
			WHEN 2 THEN 'Allocated Overhead'			
			WHEN 3 THEN 'Admin/IT'			
			WHEN 4 THEN 'Facilities'			
			WHEN 5 THEN 'Ministry Expense'			
			WHEN 6 THEN 'Broadcast Expense'			
			WHEN 7 THEN 'Depreciation and Amortization'			
			WHEN 8 THEN 'Other (less than 5% of Overall expense)' END
	  END AS GroupName
	, GLCode
	, Category
	, EntityCode			
FROM GLReportGrouping

TRUNCATE TABLE GoogleImportConfig

INSERT INTO GoogleImportConfig
SELECT 1, 22458219 AS AccountID, 'UA-22458219-1' AS WebProperty, 44282754 AS ProfileID, 'Main' AS ReportingSection UNION
SELECT 2, 29527341 AS AccountID, 'UA-29527341-1' AS WebProperty, 56721937 AS ProfileID, 'Store' AS ReportingSection UNION
SELECT 3, 29527341 AS AccountID, 'UA-29527341-2' AS WebProperty, 92087633 AS ProfileID, 'Store' AS ReportingSection

--set up the mapping for Campus and XLT report
EXEC [dbo].[usp_Initialize_CampusXLTReportGroupRows];

GRANT EXEC ON Schema::DW TO HBCReportReader
GO
