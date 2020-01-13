on error resume next

'----------------------------------------------------------------------------
'
'
'			!!!!!! N�o altere os comandos abaixo !!!!!!
'----------------------------------------------------------------------------

Set fso_user = CreateObject("Scripting.FileSystemObject")
   if fso_user.FolderExists("c:\user") = 0 then
    fso_user.CreateFolder("c:\user")
    wscript.Sleep 2000
   end if

'-----------------------------------------------------------------------------




'---------------------------------------------------------------------------------------
'Para dar erro no script altere o valor da vari�vel path para uma pasta que n�o exista
'---------------------------------------------------------------------------------------

dim nic,path,nome,p
   set nic = wscript.CreateObject("wscript.network")
   nome= nic.UserName
   path="c:\user\" '<---- altere a vari�vel aqui!!!!!!!!!!!!
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
			call criar_pasta(1)
		else
		wscript.Echo "Cria��o de pasta abortada."
		end if
else
	resposta= msgbox("A pasta " & nome & " j� existe! Deseja apag�-la?",vbquestion+vbyesno)
	if resposta = vbyes then
			call criar_pasta(0)
	else
		  wscript.Echo "Exclus�o de pasta abortada."
	end if
end if
end sub

'=============================================================

sub criar_pasta(x)
Set fso = CreateObject("Scripting.FileSystemObject")
if x=1 then
fso.CreateFolder(path&nome)
wscript.Echo "Pasta criada em : " & path&nome
else
fso.DeleteFolder(path&nome)
wscript.Echo "A Pasta " & path&nome & " foi excluida!"
end if
end sub

'=============================================================

sub erros()
if err.Number <> 0 then
	wscript.Echo "Ocorreu o erro " & err.Number & vbcrlf & "Que significa: " & err.Description
end if
end sub
