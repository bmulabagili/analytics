CREATE TABLE [DW].FactPaycor
(
    PaycorID			INT NOT NULL
  , TenantID			INT NOT NULL
  , DateID				INT NOT NULL
  , GLOrgCode			NVARCHAR(255)
  , Amount			    MONEY NOT NULL
  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETUTCDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETUTCDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWFactPaycor__PaycorID_TenantID] 
	   PRIMARY KEY CLUSTERED(PaycorID, TenantID)
  , CONSTRAINT [FK_DWFactPaycor_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
