'==========================================
' Executar Programas
'==========================================
set objshell = createobject("wscript.shell")

'objshell.Run"notepad.exe c:\boot.ini"   'nome do programa + arquivo + tipo de tamanho

'==========================================
'Enviar comandos de Teclado
'==========================================
'with objshell
'	.sendkeys "^{esc}"
'	.sendkeys "{up}"	
'	.sendkeys "~"
'end with         = enviar shut down