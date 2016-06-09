CREATE TABLE [Transform].[WorkflowMilestoneQueue]
(
	  WorkflowMilestoneQueueID INT NOT NULL
	, TenantID INT NOT NULL
	, WorkflowMilestoneTypeID INT NOT NULL
	, PersonIdentifier INT NOT NULL
	, MinistryName NVARCHAR(255) NULL
	, ActivityName NVARCHAR(255) NULL
	, RosterName NVARCHAR(255) NULL
	, AttendanceCount INT NULL
	, AttributeGroupName NVARCHAR(255) NULL
	, AttributeName NVARCHAR(255) NULL
	, ContactFormName NVARCHAR(255) NULL
	, ContactItemName NVARCHAR(255) NULL
	--ETL Specific Columns
	, ExecutionID        VARCHAR(50) NOT NULL
	, ETLActionID        INT NOT NULL
	, InsertedDateTime   DATETIME DEFAULT(GETDATE())
	, UpdatedDateTime    DATETIME DEFAULT(GETDATE())
	, Hashvalue          NVARCHAR(64) NOT NULL
    
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_TransformWorkflowMilestoneQueue__WorkflowMilestoneQueueID_TenantID] 
	   PRIMARY KEY CLUSTERED(WorkflowMilestoneQueueID, TenantID)
  , CONSTRAINT [FK_TransformWorkflowMilestoneQueue_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);