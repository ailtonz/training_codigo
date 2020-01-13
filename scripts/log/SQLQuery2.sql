SELECT * FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0','Excel 12.0;Database=F:\siscob\CARTEIRA_MKT_CONSOLIDADA.xlsx', 'SELECT * FROM [Planilha1$]')


SET @SQL = 'SELECT * FROM OPENROWSET(''Microsoft.ACE.OLEDB.12.0'',''' + @DATABASE + ''' , [Dados$])';