CREATE TABLE [DW].[DimRoster]
(
	 RosterID         INT NOT NULL
  , TenantID         INT NOT NULL
  , RosterFolder     NVARCHAR(255)
  , Roster           NVARCHAR(255)
  , BreakoutGroup    NVARCHAR(255)

  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETUTCDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETUTCDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWDimRoster__RosterID_TenantID] 
	   PRIMARY KEY CLUSTERED(RosterID, TenantID)
  , CONSTRAINT [FK_DWDimRoster_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
