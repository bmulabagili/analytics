CREATE TABLE [DW].[DimCampus] (
    [CampusID]         INT            NOT NULL,
    [TenantID]         INT            NOT NULL,
    [Code]             NVARCHAR (255) NOT NULL,
    [Name]             NVARCHAR (255) NOT NULL,
    [StartDateTime]    DATETIME       NOT NULL,
    [EndDateTime]      DATETIME       NULL,
    [Active]           BIT            NOT NULL,
    [ExecutionID]      VARCHAR (50)   NOT NULL,
    [InsertedDateTime] DATETIME       DEFAULT (getutcdate()) NULL,
    [UpdatedDateTime]  DATETIME       DEFAULT (getutcdate()) NULL,
    [Hashvalue]        NVARCHAR (64)  NOT NULL,
    CONSTRAINT [pk_DWDimCampus__CampusID] PRIMARY KEY CLUSTERED ([CampusID] ASC),
    CONSTRAINT [FK_DWDimCampus_Tenant__TenantID] FOREIGN KEY ([TenantID]) REFERENCES [dbo].[Tenant] ([TenantID])
);
GO

