CREATE TABLE [Extract].[FellowshipOne_Attribute]
(
	  textbox19				NVARCHAR(255) NULL
	, textbox1				NVARCHAR(255) NULL
	, textbox2				NVARCHAR(255) NULL
	, textbox3				NVARCHAR(255) NULL
	, textbox4				NVARCHAR(255) NULL
	, textbox7				NVARCHAR(255) NULL
	, textbox5				NVARCHAR(255) NULL
	, Individual_ID			NVARCHAR(255) NULL
	, Last_Name				NVARCHAR(255) NULL
	, First_Name			NVARCHAR(255) NULL
	, Household_ID			NVARCHAR(255) NULL
	, Household_Name		NVARCHAR(255) NULL
	, Head_Home_Phone		NVARCHAR(255) NULL
	, Spouse_Home_Phone		NVARCHAR(255) NULL
	, textbox26				NVARCHAR(255) NULL
	, Marital_Status		NVARCHAR(255) NULL
	, School_Name			NVARCHAR(255) NULL
	, Status_Group			NVARCHAR(255) NULL
	, [Status]				NVARCHAR(255) NULL
	, SubStatus				NVARCHAR(255) NULL
	, Status_Date1			NVARCHAR(255) NULL
	, DOB					NVARCHAR(255) NULL
	, Age					NVARCHAR(255) NULL
	, Gender				NVARCHAR(255) NULL
	, Home_Phone			NVARCHAR(255) NULL
	, Cell_Phone			NVARCHAR(255) NULL
	, Work_Phone			NVARCHAR(255) NULL
	, Email					NVARCHAR(255) NULL
	, Household_Email		NVARCHAR(255) NULL
	, [Address]				NVARCHAR(255) NULL
	, Address_2				NVARCHAR(255) NULL
	, Address_3				NVARCHAR(255) NULL
	, City					NVARCHAR(255) NULL
	, [State]				NVARCHAR(255) NULL
	, Zip_Code				NVARCHAR(255) NULL
	, Country				NVARCHAR(255) NULL
	, Attribute_Group		NVARCHAR(255) NULL
	, Attribute				NVARCHAR(255) NULL
	, Staff					NVARCHAR(255) NULL
	, Comment				NVARCHAR(255) NULL
	, [start_date]			NVARCHAR(255) NULL
	, end_date				NVARCHAR(255) NULL
	
	, TenantID				INT NOT NULL
	, [ExecutionID]			VARCHAR(50) NOT NULL
	, [InsertedDateTime]	DATETIME DEFAULT(GETDATE())
)
GO
CREATE CLUSTERED INDEX [CIX_ExtractFellowshipOneAttribute__ExecutionID] 
	ON [Extract].[FellowshipOne_Attribute]([ExecutionID] ASC);
GO