CREATE FUNCTION [dbo].[fnSplit](
    @strInputList VARCHAR(8000),  -- List of delimited items
    @strDelimiter VARCHAR(8000) = ',' -- delimiter that separates items
)
RETURNS @List TABLE (Item VARCHAR(8000))
  
 BEGIN
  DECLARE @strItem VARCHAR(8000)
    
   WHILE CHARINDEX(@strDelimiter,@strInputList,0) <> 0
   BEGIN
     SELECT
      @strItem=RTRIM(LTRIM(SUBSTRING(@strInputList,1,CHARINDEX(@strDelimiter,@strInputList,0)-1))),
      @strInputList=RTRIM(LTRIM(SUBSTRING(@strInputList,CHARINDEX(@strDelimiter,@strInputList,0)+LEN(@strDelimiter),LEN(@strInputList))))
     
     IF LEN(@strItem) > 0
      INSERT INTO @List SELECT @strItem
   END
  
   IF LEN(@strInputList) > 0
    INSERT INTO @List SELECT @strInputList -- Put the last item in
   RETURN
 END