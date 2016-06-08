CREATE TABLE [Extract].[FellowshipOne_ContactItem]
(
	
	  Textbox27				NVARCHAR(255) NULL    
	, textbox5				NVARCHAR(255) NULL
	, textbox12				NVARCHAR(255) NULL
	, Household_ID			NVARCHAR(255) NULL
	, Individual_ID			NVARCHAR(255) NULL
	, textbox22				NVARCHAR(255) NULL
	, Textbox28				NVARCHAR(255) NULL
	, Address_2				NVARCHAR(255) NULL
	, Address_3				NVARCHAR(255) NULL
	, City					NVARCHAR(255) NULL
	, State_Province		NVARCHAR(255) NULL
	, Postal_Code			NVARCHAR(255) NULL
	, Home_Phone			NVARCHAR(255) NULL
	, Cell_Phone			NVARCHAR(255) NULL
	, Email					NVARCHAR(255) NULL
	, textbox24				NVARCHAR(255) NULL
	, textbox6				NVARCHAR(255) NULL
	, Contact_Disposition	NVARCHAR(255) NULL
	, textbox20				NVARCHAR(255) NULL
	, textbox7				NVARCHAR(255) NULL
	, textbox18				NVARCHAR(255) NULL
	, textbox8				NVARCHAR(255) NULL
	, Activity				NVARCHAR(255) NULL
	, [Date]				NVARCHAR(255) NULL
	, textbox10				NVARCHAR(255) NULL
	, textbox14				NVARCHAR(255) NULL
	, textbox16				NVARCHAR(255) NULL
	, Additional_Note		NVARCHAR(255) NULL

	, TenantID            INT NOT NULL
	, [ExecutionID]       VARCHAR(50) NOT NULL
	, [InsertedDateTime]  DATETIME DEFAULT(GETDATE())
)
GO
CREATE CLUSTERED INDEX [CIX_ExtractFellowshipOneContactItem__ExecutionID] 
	ON [Extract].[FellowshipOne_ContactItem]([ExecutionID] ASC);
GO