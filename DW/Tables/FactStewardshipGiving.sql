CREATE TABLE [DW].FactStewardshipGiving
(
    StewardshipGivingID INT NOT NULL 
  , TenantID INT NOT NULL
  , CampusID INT NOT NULL
  , CalendarMonth INT NOT NULL
  , CalendarYear INT NOT NULL
  , StewardshipGivingAmount INT NOT NULL
  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETUTCDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETUTCDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWFactStewardshipGiving__StewardshipGivingID_TenantID] 
	   PRIMARY KEY CLUSTERED(StewardshipGivingID, TenantID)
  , CONSTRAINT [FK_DWFactStewardshipGiving_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
