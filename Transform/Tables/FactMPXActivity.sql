CREATE TABLE [Transform].FactMPXActivity
(
        MPXActivityID					INT
	, TenantID						INT
	--GRAIN/Dims:	
	, CalendarMonth					INT
	, CalendarYear					INT
	, Country						NVARCHAR(255)
	, SourceGroup					NVARCHAR(255)
	, PartnerType					NVARCHAR(255)
	--skipping motivationcodes for now, no need in reporting
	--, MotivationCode				NVARCHAR(255)
	--, MediaCode						NVARCHAR(255)
	--Measures
	, EntityCount					INT
	, ActiveCount					INT
	, NewCount						INT
	, ConversionCount				INT
	, ReactivationCount				INT
	, TransactionCount				INT
	, TransactionValue				DECIMAL(9,2)


    --ETL Specific Columns
  , ExecutionID			VARCHAR(50) NOT NULL
  , ETLActionID			INT NOT NULL
  , InsertedDateTime	DATETIME DEFAULT(GETDATE())
  , UpdatedDateTime		DATETIME DEFAULT(GETDATE())
  , Hashvalue			NVARCHAR(64) NOT NULL
    
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_TransformMPXActivity__MPXActivityID_TenantID] 
	   PRIMARY KEY CLUSTERED(MPXActivityID, TenantID)
  , CONSTRAINT [FK_TransformFactMPXActivity_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);