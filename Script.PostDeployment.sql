
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

--enable all defined ETLPackages as active for HBC
INSERT INTO TenantEtlProcess
SELECT 3, ETLProcessID
FROM ETLProcess;

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

--DimCampus -- hardcoded until we find an authoritative source
MERGE INTO DW.DimCampus AS Target
USING ( VALUES
      (-1, 3, ''  , 'Unknown'             , '1/1/1900', 1, -1, GETUTCDATE(), GETUTCDATE(), '')
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
