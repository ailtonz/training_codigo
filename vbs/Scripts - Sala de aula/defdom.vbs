function connGetOpenConnection() ' as ADODB.Connection
	dim strConnectionString
	strConnectionString = g_ConnectionString ' this should be changed
	set connGetOpenConnection = Server.CreateObject ("ADODB.Connection")
	connGetOpenConnection.ConnectionString = strConnectionString
	connGetOpenConnection.CursorLocation = 3 ' adUseClient
	connGetOpenConnection.Open	
end function

function rsExecuteSprocReturnRS (strCommandText) ' as ADODB.Recordset
	set rsExecuteSprocReturnRS = connGetOpenConnection().Execute (strCommandText)
end function
