'conectar com obj usu�rio
'OBS: Para efetivar as altera��es � necess�rio executar o m�todo setinfo dop objeto
'pq as altera��es s� ficam no cache local.

Set objUser = GetObject("LDAP://cn=admin25,OU=wst,dc=nwtraders,dc=msft")
	wscript.Echo "E-mail atual: " & objuser.mail
	objuser.put "mail", "ciclano@ig.com.br"
	objuser.put "description", "lab de sala de aula3."
	objUser.SetInfo
	wscript.Echo "Novo e-mail: " & objuser.mail
	