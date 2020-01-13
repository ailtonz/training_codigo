USE [DB_SISCOB]
GO
/****** Object:  StoredProcedure [FILE_CAR].[PRC_000_UPLOAD_CAR_MOVEL]    Script Date: 12/5/2016 7:25:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [FILE_CAR].[PRC_000_UPLOAD_CAR_MOVEL]   
--WITH EXECUTE AS 'USR_ADMIN'  
  
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
-- ########################################  
-- LISTAR ARQUIVOS E DESCOMPACTAR ARQUIVOS  
-- ########################################  
  
DECLARE   
    @name   VARCHAR(50)  
  , @PERIODO  VARCHAR(10)  
  , @RETVAL  INT  
  , @tmp   VARCHAR(100)    
  , @FILE_NAME VARCHAR(100)  
    
  
DECLARE @FILE_PATH VARCHAR(100) SET @FILE_PATH = 'D:\siscob\Relatorios\FILE_CAR\'  
DECLARE @FILE_MOVE VARCHAR(100) SET @FILE_MOVE = '\\10.128.222.63\siscob\Relatorios\FILE_CAR\_BKP\CAR\'  
DECLARE @STRSPACE VARCHAR(10)  SET @STRSPACE = '          '  
DECLARE @CMD  NVARCHAR(2000)   
  
 DECLARE @files TABLE (ID int IDENTITY, FileName varchar(100)); INSERT INTO @files EXECUTE xp_cmdshell @CMD   
 DECLARE db_cursor CURSOR FOR SELECT [FileName] FROM @files WHERE [FileName] is not null and [FileName] <> 'file not found'  
   
  
 DECLARE @DIA  VARCHAR(2);  
 DECLARE @MES  VARCHAR(2);  
 DECLARE @nameText VARCHAR(50);  
 DECLARE @RET_FILE INT;  
  
 DECLARE @FILE_CAR VARCHAR(100) SET @FILE_CAR  = 'CAR_MOVEL*.txt'  
 DECLARE @CMD_FILES NVARCHAR(2000) SET @CMD_FILES  = 'dir ' + @FILE_PATH + @FILE_CAR + ' /A-D /B /ON'  
 DECLARE @fileCAR TABLE (ID int IDENTITY, FileName varchar(100)); INSERT INTO @fileCAR EXECUTE xp_cmdshell @CMD_FILES  
 DECLARE db_file CURSOR FOR SELECT [FileName] FROM @fileCAR WHERE [FileName] is not null and [FileName] <> 'file not found'  
   
  
  
  
-- ########################################  
-- LISTAR ARQUIVOS E DESCOMPACTAR ARQUIVOS  
-- ########################################  
 SET @FILE_NAME = 'CAR_MOVEL*.*'  
 SET @CMD = 'dir ' + @FILE_PATH + @FILE_NAME + ' /A-D /B /ON'  
   
 --DECLARE @files TABLE (ID int IDENTITY, FileName varchar(100)); INSERT INTO @files EXECUTE xp_cmdshell @CMD   
 --DECLARE db_cursor CURSOR FOR SELECT [FileName] FROM @files WHERE [FileName] is not null and [FileName] <> 'file not found'  
 OPEN db_cursor FETCH NEXT FROM db_cursor INTO @name     
  
 WHILE @@FETCH_STATUS = 0     
 BEGIN     
  SET @tmp  = db_siscob.dbo.GetFileNameWithoutExtension(@FILE_PATH+@name);   
  SET @PERIODO = right(left(@tmp,LEN(@tmp)-4),8);   
  SET DATEFORMAT ymd;   
  -- VALIDAR NOME DO ARQUIVO  
  SET @RETVAL  = ISDATE(LEFT(@PERIODO,4)+'-'+substring(@PERIODO,len(@PERIODO)-3,2)+'-'+right(@PERIODO,2));   
  IF @RETVAL   = 1   
  BEGIN   
   -- UNZIP   
   SET @CMD = @FILE_PATH + '7z.bat ' + @name   
   exec xp_cmdshell @CMD    
   -- MOVE FILE  
   SET @CMD = 'EXEC xp_cmdshell  ''move /y '  + @FILE_PATH + @name +  ' ' + @FILE_MOVE +''''  
   EXEC sp_executesql @CMD;     
  END  
     
  FETCH NEXT FROM db_cursor INTO @name     
 END  
  
-- ########################################  
--- ################### UPLOAD FILE CAR  
-- ########################################  
  
 --DECLARE @DIA  VARCHAR(2);  
 --DECLARE @MES  VARCHAR(2);  
 --DECLARE @nameText VARCHAR(50);  
 --DECLARE @RET_FILE INT;  
   
 --DECLARE @FILE_CAR VARCHAR(100) SET @FILE_CAR  = 'CAR_MOVEL*.txt'  
 --DECLARE @CMD_FILES NVARCHAR(2000) SET @CMD_FILES  = 'dir ' + @FILE_PATH + @FILE_CAR + ' /A-D /B /ON'  
 --DECLARE @fileCAR TABLE (ID int IDENTITY, FileName varchar(100)); INSERT INTO @fileCAR EXECUTE xp_cmdshell @CMD_FILES  
 --DECLARE db_file CURSOR FOR SELECT [FileName] FROM @fileCAR WHERE [FileName] is not null and [FileName] <> 'file not found'  
  
 OPEN db_file FETCH NEXT FROM db_file INTO @nameText  
  
 WHILE @@FETCH_STATUS = 0     
 BEGIN     
    
  SET @tmp  = db_siscob.dbo.GetFileNameWithoutExtension(@FILE_PATH+@nameText);  
  SET @PERIODO = right(left(@tmp,LEN(@tmp)-4),8);  
  SET @DIA  = right(@PERIODO,2);   
  SET @MES  = substring(@PERIODO,len(@PERIODO)-3,2);   
  
  
  ---- ADICIONAR NOVO PERIODO  
  --IF @DIA=26  
  -- BEGIN   
  --  -- LIMPAR PERIODOS  
  --  UPDATE [DB_SISCOB].[AUXILIAR].[TB_PERIODO] SET [STATUS]=0 WHERE [STATUS]=1  
  
  --  -- NOVO PERIODO (C/ MUDANÇA DE MÊS)  
  --  INSERT INTO [DB_SISCOB].[AUXILIAR].[TB_PERIODO]  
  --       ([PERIODO],[STATUS])   
  --       VALUES   
  --       (db_siscob.dbo.fn_Mes(CONVERT(INT, @MES)+1)+'/'+LEFT(@PERIODO,4),1)  
  -- END  
  --ELSE  
  -- BEGIN  
  --  -- NOVO PERIODO (S/ MUDANÇA DE MÊS)  
  --  INSERT INTO [DB_SISCOB].[AUXILIAR].[TB_PERIODO]  
  --       ([PERIODO],[STATUS])   
  --       VALUES   
  --       (db_siscob.dbo.fn_Mes(@MES)+'/'+LEFT(@PERIODO,4),1)  
     
  -- END  
     
    
  -- VERIFICA A EXISTENCIA DA SUBIDA DO "FILE_CAR"   
  SET @RET_FILE = (SELECT S.[ID] FROM [DB_SISCOB].[AUXILIAR].[TB_STATUS_CAR] S WHERE S.[FILE_CAR] LIKE '%'+@nameText+'%')  
    
  -- SE NÃO EXISTIR CADASTRA  
  IF @RET_FILE IS NULL   
  BEGIN  
     
   EXEC FILE_CAR.PRC_110_CARREGAR_CAR_MOVEL @nameText
   EXEC FILE_CAR.PRC_002_A_REGRA_ENREQUECIMENTO_MOVEL
   EXEC FILE_CAR.PRC_002_B_ATRIBUI_FORNECEDOR
   
   -- CADASTRA O LOG DA SUBIDA DO ARQUIVO "FILE_CAR"  
	INSERT INTO [DB_SISCOB].[ADM].[TB_APP_CONTROLE]
				([TIPO],[DESCRICAO],[DESCRICAO_02],[DTSUBIDA])
		 VALUES 
				('LOG_CAR',@FILE_PATH + @nameText,SUBSTRING(@FILE_PATH + @nameText,CHARINDEX('.',@FILE_PATH + @nameText)-2,2),CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE(),106),103))			

  END  
    
  FETCH NEXT FROM db_file INTO @nameText     
 END     
   
  
 CLOSE db_cursor     
 DEALLOCATE db_cursor  
  
 CLOSE db_file     
 DEALLOCATE db_file         
  
END  
  
  