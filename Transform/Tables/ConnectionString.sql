CREATE TABLE [Transform].[ConnectionString]
(
    --Destination Specific Columns (pretty much mirrors the table where this data will go)
      ConnectionStringID INT NOT NULL IDENTITY(1,1) 
    , [Source] NVARCHAR(1000) NOT NULL
    , Note NVARCHAR(1000) NULL

    --ETL Specific Columns
    , ExecutionID VARCHAR (50)   NOT NULL
    , ETLActionID INT NOT NULL
    , InsertedDateTime DATETIME DEFAULT(GETDATE())
    , UpdatedDateTime DATETIME DEFAULT(GETDATE())
    , Hashvalue NVARCHAR(64) NOT NULL
    --Keys should get enforced at this point.

	,CONSTRAINT PK_TransformConnectionString__ConnectionStringID 
		PRIMARY KEY (ConnectionStringID)
    ,  CONSTRAINT FK_TransformConnectionString_ETLAction__ETLActionID
	   FOREIGN KEY (ETLActionID)
	   REFERENCES ETLAction(ETLActionID)
)
