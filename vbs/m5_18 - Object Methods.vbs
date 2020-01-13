on error resume next

'----------------------------------------------------------------------------
'			!!!!!! N�o altere os comandos abaixo !!!!!!
'----------------------------------------------------------------------------

Set fso_user = CreateObject("Scripting.FileSystemObject")
   if fso_user.FolderExists("c:\user") = 0 then
    fso_user.CreateFolder("c:\user")
    wscript.Sleep 2000
   end if


'---------------------------------------------------------------------------------------
'Para dar erro no script altere o valor da vari�vel path para uma pasta que n�o exista
'---------------------------------------------------------------------------------------
'----------------------------------------------------------------------------
'LAB EXTRA: Se a pasta j� existir pergunte ao usu�rio se deseja exclu�-la,
' caso sim apague-a.
'----------------------------------------------------------------------------

dim nic,path,nome,p
   set nic = wscript.CreateObject("wscript.network")
   nome= nic.UserName
   path="c:\user\"
	p = ReportFolderStatus(path&nome)
	call validar(p)
	call erros


'=============================================================
Function ReportFolderStatus(fldr)
   Dim fso
   Set fso = CreateObject("Scripting.FileSystemObject")
   If (fso.FolderExists(fldr)) Then
      ReportFolderStatus = 1
   Else
      ReportFolderStatus = 0
   End If
End Function

'=============================================================
'verificar se a vari�vel � 0 (pasta n�o existe) ou 1 (pasta j� existe).
sub validar(pasta)
if pasta = 0 then
	criar = msgbox("A pasta para o usu�rio " & nome & " n�o existe deseja cri�-la?",vbquestion+vbyesno)
		if criar = vbyes then
			call criar_pasta
		else
		wscript.Echo "Cria��o de pasta abortada."
		end if
else
	wscript.Echo "A pasta " & nome & " j� existe!"
end if
end sub

'=============================================================

sub criar_pasta()
Set fso = CreateObject("Scripting.FileSystemObject")
fso.CreateFolder(path&nome)
wscript.Echo "Pasta criada em : " & path&nome
end sub

'=============================================================

sub erros()
if err.Number <> 0 then
	wscript.Echo "Ocorreu o erro " & err.Number & vbcrlf & "Que significa: " & err.Description
end if
end sub
