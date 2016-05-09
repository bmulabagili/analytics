CREATE TABLE [Extract].[Transactional_HeadCount]
(
    MinistryName	    NVARCHAR(255) NOT NULL
  , ActivityName	    NVARCHAR(255) NOT NULL
  , RosterName		    NVARCHAR(255) NOT NULL
  , RecordedValue	    INT NOT NULL
  , InstanceDateTime    DATETIME NOT NULL

  , TenantID            INT NOT NULL
  , [ExecutionID]       VARCHAR(50) NOT NULL
  , [InsertedDateTime]  DATETIME DEFAULT(GETDATE())
                                 NULL
);
GO
CREATE CLUSTERED INDEX [CIX_ExtractTransactionalHeadCount_ExecutionID] ON [Extract].[Transactional_HeadCount]([ExecutionID] ASC);
GO