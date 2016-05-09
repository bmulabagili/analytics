CREATE TABLE [DW].[DimRoster]
(
    RosterID         INT NOT NULL
  , TenantID         INT NOT NULL
  , RosterFolder     NVARCHAR(255)
  , Roster           NVARCHAR(255)
  , BreakoutGroup    NVARCHAR(255)
  , StartDateTime    DATETIME NOT NULL
  , EndDateTime      DATETIME NULL
  , Active           BIT NOT NULL

  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWDimRoster__RosterID_TenantID] 
	   PRIMARY KEY CLUSTERED(RosterID, TenantID)
  , CONSTRAINT [FK_DWDimRoster_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
