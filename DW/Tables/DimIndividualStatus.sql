CREATE TABLE [DW].[DimIndividualStatus]
(
	 IndividualStatusID INT NOT NULL
    , TenantID INT NOT NULL
    , [Status] NVARCHAR(255)
    , [SubStatus] NVARCHAR(255)
    , CampusID INT
  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWDimIndividualStatus__IndividualStatusID_TenantID] 
	   PRIMARY KEY CLUSTERED(IndividualStatusID, TenantID)
  , CONSTRAINT [FK_DWDimIndividualStatus_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);

