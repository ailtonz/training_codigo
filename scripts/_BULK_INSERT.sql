--TRUNCATE TABLE [DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA_IMPORT]
--TRUNCATE TABLE [DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT]


--TRUNCATE TABLE [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA]
--TRUNCATE TABLE [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL]

--BULK INSERT [DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA_IMPORT]
--FROM 'Z:\_siscob\_TRANSITO\TB_CAR_FIXA_IMPORT.TXT'
--WITH
--(
--    FIRSTROW = 1,
--    FIELDTERMINATOR = ';',  --CSV field delimiter
--    ROWTERMINATOR = '\n',   --Use to shift the control to next row
--    TABLOCK
--)

--BULK INSERT [DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT]
--FROM 'Z:\_siscob\_TRANSITO\TB_CAR_MOVEL_IMPORT.TXT'
--WITH
--(
--    FIRSTROW = 1,
--    FIELDTERMINATOR = ';',  --CSV field delimiter
--    ROWTERMINATOR = '\n',   --Use to shift the control to next row
--    TABLOCK
--)

--BULK INSERT [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA]
--FROM 'Z:\_siscob\_TRANSITO\TB_TRATAMENTO_FIXA.TXT'
--WITH
--(
--    FIRSTROW = 1,
--    FIELDTERMINATOR = ';',  --CSV field delimiter
--    ROWTERMINATOR = '\n',   --Use to shift the control to next row
--    TABLOCK
--)

--BULK INSERT [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL]
--FROM 'Z:\_siscob\_TRANSITO\TB_TRATAMENTO_MOVEL.TXT'
--WITH
--(
--    FIRSTROW = 1,
--    FIELDTERMINATOR = ';',  --CSV field delimiter
--    ROWTERMINATOR = '\n',   --Use to shift the control to next row
--    TABLOCK
--)