'mudar o account de todos os serviços que estão configurados para startar com
'nwtraders\msft e alterá-los para a conta localsystem.
'é necessário dar restart no serviço após a troca.


strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colServiceList = objWMIService.ExecQuery _
    ("SELECT * FROM Win32_Service WHERE StartName = 'nwtraders\\administrator'")	'se for conta local usar \\nome
For Each objService in colServices
    errServiceChange = objService.Change _
        ( , , , , , , ".\LocalSystem" , "")
Next
