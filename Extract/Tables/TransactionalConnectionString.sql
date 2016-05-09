CREATE TABLE [Extract].[TransactionalConnectionString](
    --Source Specific Columns
    ConnectionStringID INT
  , [Source]           NVARCHAR(1000)
  , Note               NVARCHAR(1000) 

    --ETL Specific Columns
  , ExecutionID        VARCHAR(50) NOT NULL
    --, ETLActionID INT NOT NULL -- not needed
  , InsertedDateTime   DATETIME DEFAULT(GETDATE())
--, UpdatedDateTime DATETIME DEFAULT(GETDATE()) -- not needed
--, Hashvalue VNVARCHAR(64) NOT NULL --not needed
);
GO

CREATE CLUSTERED INDEX CIX_ExtractTransactionalConnectionString__ConnectionStringID ON [Extract].[TransactionalConnectionString](ConnectionStringID);