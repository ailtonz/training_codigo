Public Function ImportarDados(strOrigem As String, strDestino As String)

Dim cn As New ADODB.Connection
Dim rstOrigem As New ADODB.Recordset
Dim rstDestino As DAO.Recordset


'Pegar Parametros para Conec��o
PegarParametrosDeConeccao

'Conectar
cn.ConnectionString = "Provider=" & strDriver & ";Server=" & strServidor & ";database=" & strBaseDeDados & ";uid=" & strUsuario & ";pwd=" & strSenha
cn.CursorLocation = adUseClient
cn.ConnectionTimeout = 15
cn.Open

'Pegar dados para importa��o
strSQL = "Select * from  " & strOrigem
rstOrigem.Open strSQL, cn, adOpenKeyset, adLockOptimistic
strSQL = ""

LimparCadastro strDestino

'Abre Destino
Set rstDestino = CurrentDb.OpenRecordset("Select * from " & strDestino)

'Inicio de transferencia
BeginTrans
While Not rstOrigem.EOF
    rstDestino.AddNew
    For x = 0 To rstOrigem.Fields.Count - 1
        rstDestino.Fields(x) = rstOrigem.Fields(x)
    Next
    rstDestino.Update
    rstOrigem.MoveNext
Wend
CommitTrans
rstOrigem.Close
rstDestino.Close

cn.Close

Set rstOrigem = Nothing
Set rstDestino = Nothing
Set cn = Nothing

End Function
