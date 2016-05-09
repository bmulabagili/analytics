CREATE TABLE [Transform].[Tenant](
    --Destination Specific Columns (pretty much mirrors the table where this data will go)
    TenantID           INT NOT NULL -- not an identity column in DW
  , TenantName         NVARCHAR(255) NOT NULL
  , IsActive           INT DEFAULT((0))
                           NOT NULL -- need to import this when I get back
  , ConnectionStringID INT NULL 
    --the extra columns from the tranactional aren't currently needed
    --ETL Specific Columns
  , ExecutionID        VARCHAR(50) NOT NULL
  , ETLActionID        INT NOT NULL
  , InsertedDateTime   DATETIME DEFAULT(GETDATE())
  , UpdatedDateTime    DATETIME DEFAULT(GETDATE())
  , Hashvalue          NVARCHAR(64) NOT NULL
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_TransformTenant__TenantID] PRIMARY KEY CLUSTERED([TenantID] ASC)
  , CONSTRAINT FK_TransformTenant_ConnectionString__ConnectionStringID FOREIGN KEY(ConnectionStringID) REFERENCES ConnectionString(
                                                                                                                  ConnectionStringID)
  , CONSTRAINT FK_TransformTenant_ETLAction__ETLActionID FOREIGN KEY(ETLActionID) REFERENCES ETLAction(
                                                                                             ETLActionID)
);