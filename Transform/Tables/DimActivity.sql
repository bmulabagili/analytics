﻿CREATE TABLE [Transform].[DimActivity](
    ActivityID       INT NOT NULL
  , TenantID         INT NOT NULL
  , Name             NVARCHAR(255) NOT NULL
  , MinistryID       INT NOT NULL
  , CampusID         INT NOT NULL 

    --ETL Specific Columns
  , ExecutionID      VARCHAR(50) NOT NULL
  , ETLActionID      INT NOT NULL
  , InsertedDateTime DATETIME DEFAULT(GETUTCDATE())
  , UpdatedDateTime  DATETIME DEFAULT(GETUTCDATE())
  , Hashvalue        NVARCHAR(64) NOT NULL
    
    --Keys should get enforced at this point.

  , CONSTRAINT [PK_TransformDimActivity__ActivityID_TenantID] 
    PRIMARY KEY CLUSTERED(ActivityID, TenantID)
  , CONSTRAINT [FK_TransformDimActivity_Tenant__TenantID] 
    FOREIGN KEY([TenantID]) 
    REFERENCES [dbo].[Tenant]([TenantID])
);
GO