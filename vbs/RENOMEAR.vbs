'==========================================
' Consultar/Editar/Apagar Chaves do Register
'=========================================
set oshell = createobject("wscript.shell")

' Gravar chave:
oshell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ProxyServer", "10.0.0.1:80" ,"REG_SZ"
oshell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ProxyEnable", "1" ,"REG_DWORD"

' Ler e mostrar: 
variavel = oshell.RegRead("HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ProxyServer")
oshell.popup "Novo proxy: " & variavel,5,"Registry Alterado", 0+48

' Deletar Chave:
oshell.RegDelete ("HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ProxyEnable")



'Chaves de Proxy
'"HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ProxyServer", "10.0.0.1:80" ,"REG_SZ"
'"HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ProxyEnable", "1" ,"REG_DWORD"

