CREATE TABLE [DW].DimFinancialCategory
(
    FinancialCategoryID       INT NOT NULL
  , TenantID       INT NOT NULL
  --sCodeIDf_0
  , GLCode						NVARCHAR(6) NOT NULL
  , GLName						NVARCHAR(100) NULL
  , GLType						NVARCHAR(3) NULL
  , GLDesignationCode			NVARCHAR(3) NULL
  --sCodeIDf_1
  , FundCode					NVARCHAR(6) NOT NULL
  , FundName					NVARCHAR(100) NULL
  , FundType					NVARCHAR(3) NULL
  , FundDesignationCode			NVARCHAR(3) NULL
  --sCodeIDf_2 -- now in DimEntity
  --sCodeIDf_3 -- for HBC this is campus
  , CampusCode					NVARCHAR(6) NOT NULL
  , CampusName					NVARCHAR(100) NULL
  , CampusType					NVARCHAR(3) NULL
  , CampusDesignationCode		NVARCHAR(3) NULL
  --sCodeIDf_4 -- for HBC this is department
  , DepartmentCode              NVARCHAR(6) NOT NULL
  , DepartmentName				NVARCHAR(100) NULL
  , DepartmentType				NVARCHAR(3) NULL
  , DepartmentDesignationCode	NVARCHAR(3) NULL
  --sCodeIDf_5 -- currently unknown
  , AccountingCode5             NVARCHAR(6) NOT NULL
  , AccountingName5				NVARCHAR(100) NULL
  , AccountingType5				NVARCHAR(3) NULL
  , AccountingDesignationCode5	NVARCHAR(3) NULL
  --sCodeIDf_6 -- Project Numbers
  , ProjectCode					NVARCHAR(6) NOT NULL
  , ProjectName					NVARCHAR(100) NULL
  , ProjectType					NVARCHAR(3) NULL
  , ProjectDesignationCode      NVARCHAR(3) NULL
  --sCodeIDf_7 -- currently unknown
  , AccountingCode7             NVARCHAR(6) NOT NULL
  , AccountingName7				NVARCHAR(100) NULL
  , AccountingType7				NVARCHAR(3) NULL
  , AccountingDesignationCode7	NVARCHAR(3) NULL
  --sCodeIDf_8 -- currently unknown
  , AccountingCode8             NVARCHAR(6) NOT NULL
  , AccountingName8				NVARCHAR(100) NULL
  , AccountingType8				NVARCHAR(3) NULL
  , AccountingDesignationCode8	NVARCHAR(3) NULL
  --sCodeIDf_9 -- currently unknown
  , AccountingCode9             NVARCHAR(6) NOT NULL
  , AccountingName9				NVARCHAR(100) NULL
  , AccountingType9				NVARCHAR(3) NULL
  , AccountingDesignationCode9	NVARCHAR(3) NULL
  --ScodeIDF_10
  , AccountingCode10             NVARCHAR(6) NOT NULL
  
  --ETL Specific Columns
  , [ExecutionID]      VARCHAR(50) NOT NULL
  , [InsertedDateTime] DATETIME DEFAULT(GETUTCDATE()) NULL
  , [UpdatedDateTime]  DATETIME DEFAULT(GETUTCDATE()) NULL
  , [Hashvalue]        NVARCHAR(64) NOT NULL
  , CONSTRAINT [pk_DWDimFinancialCategory__FinancialCategoryID_TenantID] 
	   PRIMARY KEY CLUSTERED(FinancialCategoryID, TenantID)
  , CONSTRAINT [FK_DWDimFinancialCategory_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]( [TenantID])
);
