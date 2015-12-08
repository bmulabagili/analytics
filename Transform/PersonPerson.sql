CREATE TABLE [Transform].[PersonPerson]
(
    [PersonID]            INT            NULL , -- nullable, because we want to defer to the destination to create this key
    [TenantID]            INT            NOT NULL,
    [Salutation]          NVARCHAR (20)  NULL,
    [FirstName]           NVARCHAR (255) NOT NULL,
    [MiddleName]          NVARCHAR (255) NULL,
    [GoesByName]		 NVARCHAR (255) NULL,
    [LastName]            NVARCHAR (255) NULL,
    [Suffix]              NVARCHAR (20)  NULL,
    [Gender]              CHAR (1)       NULL,
    [DateOfBirth]         DATE           NULL,
    [Age]                 SMALLINT       NULL,
    [MaritalStatusID]     INT            NULL,
    [PictureURL]          NVARCHAR (255) NULL,
    [LastInitial]         AS             (left([LastName],(1))) PERSISTED,
    [ExternalID]          INT            NULL,
    [FamilyPosition]      NVARCHAR (255) NULL,
    [HouseHoldIdentifier] INT            NULL,
    [Barcode]             NVARCHAR (75)  NULL,
    [TagComment]          NVARCHAR (500) NULL,
    [CellPhone]	      NCHAR (10)     NULL,
    [HomePhone]	      NCHAR (10)     NULL,
    [WorkPhone]	      NCHAR (10)     NULL,
    [Email]		      NVARCHAR(1000) NULL,

    --ETL Specific Columns
    --later we will add the etlcontrolid or equiv
     ETLActionID INT NOT NULL DEFAULT(0) -- by default, do Nothing!
    , InsertedDateTime DATETIME DEFAULT(GETUTCDATE())

    --Keys should get enforced at this point.
    --can't set the PK to person/tenant or externalID/Tenant since both are nullable so the transactional can set the key
    --CONSTRAINT [PK_TransformPersonPerson_ExternalID_TenantID] PRIMARY KEY CLUSTERED (ExternalID, [TenantID]),
    --skipping marital status, since it's not needed in Analytics yet
    --CONSTRAINT [FK_PersonPerson_PersonMaritalStatus__MaritalStatusID] FOREIGN KEY ([MaritalStatusID]) REFERENCES [Person].[MaritalStatus] ([MaritalStatusID]),
    CONSTRAINT [FK_TenantPersonPerson_Tenant__TenantID] FOREIGN KEY ([TenantID]) REFERENCES [dbo].[Tenant] ([TenantID])

)
GO
CREATE CLUSTERED INDEX CIX_TransformPersonPerson_ExternalID_TenantID
    ON Transform.PersonPerson(ExternalID, TenantID) -- hopefully we do get externalIDs from sources!!