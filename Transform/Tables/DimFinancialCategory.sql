CREATE TABLE [Transform].DimFinancialCategory(
    FinancialCategoryID			INT NOT NULL
  , TenantID					INT NOT NULL
  --sCodeIDf_0
  , GLCode						NVARCHAR(20) NOT NULL
  , GLName						NVARCHAR(100) NULL
  , GLType						NVARCHAR(3) NULL
  , GLDesignationCode			NVARCHAR(3) NULL
  --sCodeIDf_1
  , FundCode					NVARCHAR(20) NOT NULL
  , FundName					NVARCHAR(100) NULL
  , FundType					NVARCHAR(3) NULL
  , FundDesignationCode			NVARCHAR(3) NULL
  --sCodeIDf_2 -- ALSO in DimEntity
  , EntityID					INT
  , EntityCode					NVARCHAR(20) NOT NULL
  , EntityName					NVARCHAR(100) NULL
  , EntityType					NVARCHAR(3) NULL
  , EntityDesignationCode		NVARCHAR(3) NULL
  --sCodeIDf_3 -- for HBC this is campus
  , CampusCode					NVARCHAR(20)  NULL
  , CampusName					NVARCHAR(100) NULL
  , CampusType					NVARCHAR(3) NULL
  , CampusDesignationCode		NVARCHAR(3) NULL
  --sCodeIDf_4 -- for HBC this is department
  , DepartmentCode              NVARCHAR(20) NULL
  , DepartmentName				NVARCHAR(100) NULL
  , DepartmentType				NVARCHAR(3) NULL
  , DepartmentDesignationCode	NVARCHAR(3) NULL
  --sCodeIDf_5 -- Per Kelly ALtieri this is StaffCode
  , StaffCode                   NVARCHAR(20) NULL
  , StaffName		     		NVARCHAR(100) NULL
  , StaffType   			  	NVARCHAR(3) NULL
  , StaffDesignationCode    	NVARCHAR(3) NULL
  --sCodeIDf_6 -- Project Numbers
  , ProjectCode					NVARCHAR(20) NULL
  , ProjectName					NVARCHAR(100) NULL
  , ProjectType					NVARCHAR(3) NULL
  , ProjectDesignationCode      NVARCHAR(3) NULL
  --sCodeIDf_7 -- Per Kelly Altieri: RestrictionCode
  , RestrictionCode             NVARCHAR(20) NULL
  , RestrictionName				NVARCHAR(100) NULL
  , RestrictionType				NVARCHAR(3) NULL
  , RestrictionDesignationCode 	NVARCHAR(3) NULL
  --sCodeIDf_8 -- Per Kelly Altieri: CategoryCode
  , CategoryCode                NVARCHAR(20) NULL
  , CategoryName				NVARCHAR(100) NULL
  , CategoryType				NVARCHAR(3) NULL
  , CategoryDesignationCode 	NVARCHAR(3) NULL
  --sCodeIDf_9 -- currently unknown
  , AccountingCode9             NVARCHAR(20) NULL
  , AccountingName9				NVARCHAR(100) NULL
  , AccountingType9				NVARCHAR(3) NULL
  , AccountingDesignationCode9	NVARCHAR(3) NULL
  --ScodeIDF_10
  , AccountingCode10            NVARCHAR(20) NULL

    --ETL Specific Columns
  , ExecutionID      VARCHAR(50) NOT NULL
  , ETLActionID      INT NOT NULL
  , InsertedDateTime DATETIME DEFAULT(GETUTCDATE())
  , UpdatedDateTime  DATETIME DEFAULT(GETUTCDATE())
  , Hashvalue        NVARCHAR(64) NOT NULL
    
    --Keys should get enforced at this point.

  , CONSTRAINT [pk_TransformDimFinancialCategory__FinancialCategoryID_TenantID] 
	   PRIMARY KEY CLUSTERED(FinancialCategoryID, TenantID)
  , CONSTRAINT [FK_TransformDimFinancialCategory_Tenant__TenantID] 
	   FOREIGN KEY([TenantID]) 
	   REFERENCES [dbo].[Tenant]([TenantID])
);