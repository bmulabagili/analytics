CREATE TABLE [dbo].[ConnectionString]
(
      ConnectionStringID INT NOT NULL
    , [Source] NVARCHAR(1000) NOT NULL
    , Note NVARCHAR(1000) NULL

    --ETL Specific Columns
    , ExecutionID VARCHAR (50)   NOT NULL
    --ETLActionID Not needed at this point
    , InsertedDateTime DATETIME DEFAULT(GETDATE())
    , UpdatedDateTime DATETIME DEFAULT(GETDATE())
    , Hashvalue NVARCHAR(64) NOT NULL

	,CONSTRAINT PK_ConnectionString__ConnectionStringID 
		PRIMARY KEY (ConnectionStringID)
)
