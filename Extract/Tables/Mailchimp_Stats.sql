CREATE TABLE [Extract].[MailChimp_Stats]
(
	  member_count					INT
	, unsubscribe_count				INT
	, cleaned_count					INT
	, member_count_since_send		INT
	, unsubscribe_count_since_send	INT
	, cleaned_count_since_send		INT
	, campaign_count				INT
	, campaign_last_sent			NVARCHAR(255)
	, merge_field_count				INT
	, avg_sub_rate					INT
	, avg_unsub_rate				INT
	, target_sub_rate				INT
	, open_rate						FLOAT
	, click_rate					FLOAT
	, last_sub_date					NVARCHAR(255)
	, last_unsub_date				NVARCHAR(255)

	, TenantID          INT NOT NULL
	--ETL Specific Columns
	, ExecutionID       VARCHAR(50) NOT NULL
	--, ETLActionID INT NOT NULL -- not needed
	, InsertedDateTime  DATETIME DEFAULT(GETDATE())
	--, UpdatedDateTime DATETIME DEFAULT(GETDATE()) -- not needed
	--, Hashvalue VNVARCHAR(64) NOT NULL --not needed
);
GO
CREATE CLUSTERED INDEX CIX_ExtractMailChimp_Stats__ExecutionID_TenantID ON [Extract].MailChimp_Stats(ExecutionID, TenantID);