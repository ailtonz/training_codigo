'========================================================================================
'           CRIAR PASTA
'
'=======================================================================================
SET FSO = CREATEOBJECT("SCRIPTING.FILESYSTEMOBJECT")
'IF FSO.FolderExists("C:\relatorio\vendas") = TRUE THEN 
'	WSCRIPT.Echo " A Pasta já existe...."
'	
'else
'
'	set pasta = fso.CreateFolder("C:\relatorio")
'	set pasta2 = fso.CreateFolder("C:\relatorio\vendas")
'	wscript.Echo "A pasta foi criada."
'end if

'============================================================================
'Copiar e mover pasta
'
'========================================================================

'fso.CopyFolder "c:\relatorio\vendas" , "c:\"
'wscript.Echo "Pasta Copiada"
							
'fso.MoveFolder "C:\relatorio\vendas" , "c:\"
'wscript.Echo "Pasta Movida"

'=============================================================================
'          Apagar pasta 
'===========================================================================
'
'fso.DeleteFolder "c:\vendas"


'===================================
'
'COLEÇÃO DE PASTAS 
'====================================

set colpastas = fso.GetFolder("c:\winnt")
for each pasta in colpastas.SubFolders
	txt = txt & pasta.Name & " - " & pasta.size & vbnewline
next
wscript.Echo txt