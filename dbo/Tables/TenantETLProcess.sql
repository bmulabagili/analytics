CREATE TABLE [dbo].[TenantETLProcess]
(
	 TenantID INT NOT NULL 
    , ETLProcessID INT NOT NULL
	, ConnectionStringID INT NOT NULL -- can be 0 for flat file
	
    , CONSTRAINT PK_TenantETLPRocess__TenantID_ETLProcessID_ConnectionStringID
	   PRIMARY KEY(TenantID, ETLProcessID, ConnectionStringID)
    , CONSTRAINT FK_TenantETLProcess_Tenant__TenantID
	   FOREIGN KEY(TenantID)
	   REFERENCES Tenant(TenantID) 
    , CONSTRAINT FK_TenantETLProcess_ETLProcess__ETLProcessID
	   FOREIGN KEY(ETLProcessID)
	   REFERENCES ETLProcess(ETLProcessID)
	, CONSTRAINT FK_TenantETLProcess_ConnectionString__ConnectionStringID
		FOREIGN KEY(ConnectionStringID)
		REFERENCES ConnectionString(ConnectionStringID)
)
