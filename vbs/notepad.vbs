'mudar o account de todos os servi�os que est�o configurados para startar com
'nwtraders\msft e alter�-los para a conta localsystem.
'� necess�rio dar restart no servi�o ap�s a troca.


strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colServiceList = objWMIService.ExecQuery _
    ("SELECT * FROM Win32_Service WHERE StartName = 'nwtraders\\administrator'")	'se for conta local usar \\nome
For Each objService in colServices
    errServiceChange = objService.Change _
        ( , , , , , , ".\LocalSystem" , "")
Next
