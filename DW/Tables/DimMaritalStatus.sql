CREATE TABLE [DW].DimMaritalStatus(
    MaritalStatusID    INT NOT NULL
  , TenantID           INT NOT NULL
  , Name               NVARCHAR(255) NOT NULL
    --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWDimMaritalStatus__MaritalStatusID_TenantID] 
  PRIMARY KEY CLUSTERED(MaritalStatusID, TenantID)
  , CONSTRAINT [FK_DWDimMaritalStatus_Tenant__TenantID] 
  FOREIGN KEY([TenantID]) 
  REFERENCES [dbo].[Tenant]([TenantID])
);