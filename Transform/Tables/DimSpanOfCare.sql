CREATE TABLE [Transform].[DimSpanOfCare](
    SpanOfCareID       INT NOT NULL
  , TenantID         INT NOT NULL
  , Name             NVARCHAR(255) NOT NULL

    --ETL Specific Columns
  , ExecutionID      VARCHAR(50) NOT NULL
  , ETLActionID      INT NOT NULL
  , InsertedDateTime DATETIME DEFAULT(GETDATE())
  , UpdatedDateTime  DATETIME DEFAULT(GETDATE())
  , Hashvalue        NVARCHAR(64) NOT NULL
    
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_TransformDimSpanOfCare__SpanOfCareID_TenantID] 
	   PRIMARY KEY CLUSTERED(SpanOfCareID, TenantID)
  , CONSTRAINT [FK_TransformDimSpanOfCare_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]([TenantID])
);