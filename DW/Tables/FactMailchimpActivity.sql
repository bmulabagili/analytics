CREATE TABLE [DW].[FactMailchimpActivity]
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
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWFactMailchimpActivity__MailchimpActivityID_TenantID] 
	   PRIMARY KEY CLUSTERED(MailchimpActivityID, TenantID)
  , CONSTRAINT [FK_DWFactMailchimpActivity_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
