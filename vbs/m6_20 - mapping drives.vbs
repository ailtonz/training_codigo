'-----------------------------------------------------------------------------------
'
' Fa�a uma pesquisa no help do Windows Script Host Documentation po specialfolders
'
'-----------------------------------------------------------------------------------


'encontrar o caminho das pastas desktop e menu star do perfil do usu�rio
set oshell = createobject("wscript.shell")
pathdesktop = oshell.SpecialFolders("Desktop")
pathstart = oshell.SpecialFolders("AllUsersStartup")

'criar link para o site da intranet e coloc�-lo no desktop
set site = oshell.CreateShortcut(pathdesktop & "\Intranet.url")
site.TargetPath = "http://london"
site.Save

'descobrir onde est� instalado o windows e localizar o arquivo q. ser� o
'target do link
Set env = oshell.Environment("process")
wdir = env("windir")
patharquivo = wdir & "\system32\eula.txt"

'criar link para o arquivo alvo e coloc�-lo no menu startup no perfil de todos os usu�rios
set arq_txt = oshell.CreateShortcut(pathstart & "\Contrato.url")
arq_txt.TargetPath = patharquivo
arq_txt.Save

wscript.Echo "Foram criados 2 links em : " & vbnewline & site.FullName & vbnewline & arq_txt.FullName