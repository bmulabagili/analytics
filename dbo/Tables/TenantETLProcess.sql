CREATE TABLE [dbo].[TenantETLProcess]
(
	 TenantID INT NOT NULL 
    , ETLProcessID INT NOT NULL

	
    , CONSTRAINT PK_TenantETLPRocess__TenantID_ETLProcessID
	   PRIMARY KEY(TenantID, ETLProcessID)
    , CONSTRAINT FK_TenantETLProcess_Tenant__TenantID
	   FOREIGN KEY(TenantID)
	   REFERENCES Tenant(TenantID) 
    , CONSTRAINT FK_TenantETLProcess_ETLProcess__ETLProcessID
	   FOREIGN KEY(ETLProcessID)
	   REFERENCES ETLProcess(ETLProcessID)
)
