'==========================================
'Conectar com Desktop do Usuario Logado
'==========================================
'set objshell = createobject("wscript.shell")

'objdesktop = objshell.SpecialFolders("Desktop")
'wscript.Echo objdesktop

'============================================
'Criar atalhos
'============================================
'set objLink = objshell.CreateShortcut(objdesktop & "\calc.lnk")
'objLink.TargetPath = "calc.exe"
'objLink.Save

'==========================================
' Vari�veis de Ambiente
'==========================================
set objshell = createobject("wscript.shell")
set objenv = objshell.Environment("process")
objwindir = objenv("logonserver")

'for each p in objenv               'para trazer todas as op��es do environmente
'txt = txt & p & vbnewline
'next
'wscript.Echo txt

wscript.Echo objwindir 
