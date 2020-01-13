Attribute VB_Name = "mdlODBC"
Option Compare Database

'//Name     :   CreateDSNConnection
'//Purpose  :   Create a DSN to link tables to SQL Server
'//Parameters
'//     stServer: Name of SQL Server that you are linking to
'//     stDatabase: Name of the SQL Server database that you are linking to
'//     stUsername: Name of the SQL Server user who can connect to SQL Server, leave blank to use a Trusted Connection
'//     stPassword: SQL Server user password
Function CreateDSNConnection(stServer As String, stDatabase As String, Optional stUsername As String, Optional stPassword As String) As Boolean
    On Error GoTo CreateDSNConnection_Err

    Dim stConnect As String
    
    If Len(stUsername) = 0 Then
        '//Use trusted authentication if stUsername is not supplied.
        stConnect = "Description=myDSN" & vbCr & "SERVER=" & stServer & vbCr & "DATABASE=" & stDatabase & vbCr & "Trusted_Connection=Yes"
    Else
        stConnect = "Description=myDSN" & vbCr & "SERVER=" & stServer & vbCr & "DATABASE=" & stDatabase & vbCr
    End If
    
    DBEngine.RegisterDatabase "myDSN", "SQL Server", True, stConnect
        
    '// Add error checking.
    CreateDSNConnection = True
    Exit Function
CreateDSNConnection_Err:
    
    CreateDSNConnection = False
    MsgBox "CreateDSNConnection encountered an unexpected error: " & Err.Description
    
End Function

'//Name     :   AttachDSNLessTable
'//Purpose  :   Create a linked table to SQL Server without using a DSN
'//Parameters
'//     stLocalTableName: Name of the table that you are creating in the current database
'//     stRemoteTableName: Name of the table that you are linking to on the SQL Server database
'//     stServer: Name of the SQL Server that you are linking to
'//     stDatabase: Name of the SQL Server database that you are linking to
'//     stUsername: Name of the SQL Server user who can connect to SQL Server, leave blank to use a Trusted Connection
'//     stPassword: SQL Server user password
Function AttachDSNLessTable(stLocalTableName As String, stRemoteTableName As String, stServer As String, stDatabase As String, Optional stUsername As String, Optional stPassword As String)
    On Error GoTo AttachDSNLessTable_Err
    Dim td As TableDef
    Dim stConnect As String
    
    For Each td In CurrentDb.TableDefs
        If td.Name = stLocalTableName Then
            CurrentDb.TableDefs.Delete stLocalTableName
        End If
    Next
      
    If Len(stUsername) = 0 Then
        '//Use trusted authentication if stUsername is not supplied.
        stConnect = "ODBC;DRIVER=SQL Server;SERVER=" & stServer & ";DATABASE=" & stDatabase & ";Trusted_Connection=Yes"
    Else
        '//WARNING: This will save the username and the password with the linked table information.
        stConnect = "ODBC;DRIVER=SQL Server;SERVER=" & stServer & ";DATABASE=" & stDatabase & ";UID=" & stUsername & ";PWD=" & stPassword
    End If
    Set td = CurrentDb.CreateTableDef(stLocalTableName, dbAttachSavePWD, stRemoteTableName, stConnect)
    CurrentDb.TableDefs.Append td
    AttachDSNLessTable = True
    Exit Function

AttachDSNLessTable_Err:
    
    AttachDSNLessTable = False
    MsgBox "AttachDSNLessTable encountered an unexpected error: " & Err.Description

End Function

'Abre a conexão ADODB para o arquivo da base de dados consolidada dos Envio de Debitos Automaticos
Public Sub OpenDB(objConnection As ADODB.Connection, strFile As String)
   If objConnection.State = adStateOpen Then objConnection.Close
    objConnection.ConnectionString = "Driver={Microsoft Excel Driver (*.xls, *.xlsx, *.xlsm, *.xlsb)};DBQ=" & strFile
    objConnection.Open
End Sub
