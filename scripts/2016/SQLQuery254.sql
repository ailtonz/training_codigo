CREATE PROCEDURE dbo.ExportToXMLFile
      @TableName varchar(1000)
    , @Where varchar(2000)=''
    , @TicketNumber varchar(500)
    , @debug bit=0
as
/*
    Date:2016-12-09
    Author: ailtonzsilva
    Purpose: Exports data from table to XML file on filesystem. 
    @TableName = name of table to export. 
    @Where = optitional, to set @Where Clause. DO NOT ENTER WHERE at beggining of the string 
    @TicketNumber = To save to folder on filesystem
    @Debug = Optitional. To debug this SP.

    Examples:
    EXEC dbo.ExportToXMLFile '#tt','columnX=2','221',0
    EXEC dbo.ExportToXMLFile '[Production].[Product]','','252',1
    EXEC dbo.ExportToXMLFile '[dbo].[DatabaseLog]','ColumnZ=55','351',0
    EXEC dbo.ExportToXMLFile '[dbo].[DatabaseLog]','','7865',1
*/
begin 

    if @debug=0
        SET NOCOUNT ON

    declare @SQL nvarchar(max)
    declare @IsTempTable bit
    declare @NewTableName varchar(1000)
    declare @Xml as XML

    if (isnull(@TicketNumber,''))=''
    begin
        RAISERROR('No ticket number defined',16,1,1)
        RETURN
    END

    --check if table is tmp or variable
    if (SELECT SUBSTRING(@TableName,1,1))='#' or (SELECT SUBSTRING(@TableName,1,1))='@'
    BEGIN
        if @debug=1
            PRINT 'Source is TMP table'
        set @NewTableName='TMPTBL_'+@TableName
    END
    ELSE
    BEGIN
        if @debug=1
            PRINT 'Source is db table'
        set @NewTableName=replace(@TableName,'.','_')
    END

        --RemoveSpecialChars
        declare @KeepValues varchar(1000)
        set @KeepValues = '%[^a-z^0-9^_]%'
        WHILE PATINDEX(@KeepValues,@NewTableName)>0
        set @NewTableName = STUFF(@NewTableName, PATINDEX(@KeepValues,@NewTableName),1,'')

    if @debug=1
        PRINT 'Node name for XML Header and filename: '+@NewTableName

    if ISNULL(@Where,'')=''
    BEGIN
        set @SQL= 'SELECT * FROM '+ @TableName+' FOR XML PATH, ROOT ('''+@NewTableName+'''), ELEMENTS'
        if @debug=1
            PRINT 'NO Where condition'
    END
    ELSE
    BEGIN
        set @SQL= 'SELECT * FROM '+ @TableName+' WHERE '+@Where+ ' FOR XML PATH, ROOT ('''+@NewTableName+'''), ELEMENTS'
        if @debug=1
            PRINT 'With Where condition'
    END

    --Get XML to tbl
    if ISNULL(OBJECT_ID ('tempdb..##TXML'),0)>0
    DROP TABLE ##TXML

    CREATE TABLE ##TXML (XMLText XML)

    set @SQL =  ' insert into ##TXML select ('+@SQL+')'

    --parse query
    declare @testsql nvarchar(max)
    declare @result int
    set @testsql = N'set parseonly on; ' + @sql
    exec @result = sp_executesql @testsql

    -- If it worked, execute it
    if @result = 0
        begin
            if @debug=1
                PRINT 'Query OK: '+ @SQL
            exec sp_executesql @sql
        end
    else 
    BEGIN
        DECLARE @msg varchar(2000)
        set @msg ='Parsing Error on query: ' + @SQL
        RAISERROR (@msg,16,1,1)
        RETURN
    END

    DECLARE @Tbl TABLE (id int identity(1,1), Dir varchar(256))

    --check if dir exsists
    INSERT into @Tbl
    EXEC master.dbo.xp_subdirs 'Z:\_siscob\'


    if (SELECT Count(*) from @Tbl WHERE Dir=@TicketNumber)=0
    BEGIN
        --create new dir
        DECLARE @t varchar(500)
        set @t ='Z:\_siscob\'+@TicketNumber

        EXEC master.sys.xp_create_subdir @t
    END

    declare @bcp varchar(500)
    declare @Filename VARCHAR(255)

    set @Filename =convert(varchar(100),GETDATE(),112)+'_'+replace(convert(varchar(100),GETDATE(),114),':','')+'_'+@NewTableName+'.xml'

    set @bcp = 'bcp "SELECT XMLText from ##TXML" queryout Z:\_siscob\'+@TicketNumber+'\'+@Filename+' -w -T -S'+ @@servername

    --save file
    if @debug=0
        EXEC xp_cmdshell @bcp, NO_OUTPUT
    ELSE 
    BEGIN
        EXEC xp_cmdshell @bcp
        PRINT @bcp
    END

    DROP table ##TXML

end

go