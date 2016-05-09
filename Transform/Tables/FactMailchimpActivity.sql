CREATE TABLE [Transform].FactMailchimpActivity
(
      MailchimpActivityID			INT NOT NULL
	, TenantID						INT NOT NULL
	, DateID						INT
	, MemberCount					INT
	, UnsubscribeCount				INT
	, CleanedCount					INT
	, MemberCountSinceSend			INT
	, UnsubscribeCountSinceSend		INT
	, CleanedCountSinceSend			INT
	, CampaignCount					INT
	, CampaignLastSentDateID		INT
	, MergeFieldCount				INT
	, AvgSubRate					INT
	, AvgUnsubRate					INT
	, TargetSubRate					INT
	, OpenRate						FLOAT
	, ClickRate						FLOAT
	, LastSubDateID					INT
	, LastUnsubDateID				INT

    --ETL Specific Columns
  , ExecutionID			VARCHAR(50) NOT NULL
  , ETLActionID			INT NOT NULL
  , InsertedDateTime	DATETIME DEFAULT(GETDATE())
  , UpdatedDateTime		DATETIME DEFAULT(GETDATE())
  , Hashvalue			NVARCHAR(64) NOT NULL
    
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_TransformMailchimpActivity__MailchimpActivityID_TenantID] 
	   PRIMARY KEY CLUSTERED(MailchimpActivityID, TenantID)
  , CONSTRAINT [FK_TransformFactMailchimpActivity_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);