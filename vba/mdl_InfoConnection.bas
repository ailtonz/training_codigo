Attribute VB_Name = "mdl_InfoConnection"
Option Compare Database
Private sUser As String
Private sPwd As String
Private sConnString As String
Public objODBCConnection As New ADODB.Connection

Public Function ConfigConnection()

    Load frmAcesso
    With frmAcesso
        .Show
        sUser = .txtUser
        sPwd = .txtPwd
    End With
    sConnString = "Driver={SQL Server};Server=10.128.222.66;Database=DB_SERASA_PROV;UID=" & sUser & ";pwd=" & sPwd & ";"
    objODBCConnection.Open sConnString
    
    Call TestConnection
    
    Call ConfigLinkTable
    
    Unload frmAcesso
    
    'CurrentDb.TableDefs.Refresh
    RefreshDatabaseWindow
End Function
Public Function TestConnection()
    If objODBCConnection.State <> 1 Then
        MsgBox "Não foi possível estabelecer uma conexão com o banco. A solução será encerrada.", vbCritical, "Negociação Crystal"
        Call CloseConnection
        Application.Quit
    End If
End Function
Public Function CloseConnection()
    On Error Resume Next
    objODBCConnection.Close
    Set objODBCConnection = Nothing
    On Error GoTo 0
End Function

Public Function ConfigLinkTable()
    
    'Para versao 3.0
    'Tirar desta função o cargo de apresentar os links.
    'Colocá-los em uma tabela e criar os links depois.
    
    Dim rsTableLinks As New ADODB.Recordset
    
    rsTableLinks.Open "tblLinks", CurrentProject.Connection, adOpenDynamic
    
    'Set rsTableLinks = CurrentDb.OpenRecordset("tblLinks")
    
    'Cria os links para as tabelas e views do SQL Server
    
    'Dim bolLink As Boolean
    
    Do While Not rsTableLinks.EOF
        
        Call AttachDSNLessTable(rsTableLinks.Fields("NameLocalLink").Value, rsTableLinks.Fields("NameRemoteLink").Value, "10.128.222.66", "DB_SERASA_PROV", sUser, sPwd)
        
        rsTableLinks.MoveNext
        
    Loop

End Function
