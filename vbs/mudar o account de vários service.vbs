'mudar o account do servi�o Alerter (que � sensitivo a caps) para conta nwtraders\administrator.
'� necess�rio dar restart no servi�o ap�s a troca.

strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colServices = objWMIService.ExecQuery _
    ("Select * from Win32_Service")
For each objService in colServices
    If objService.Name = "Alerter" Then
        errServiceChange = objService.Change _
        ( , , , , , , "nwtraders\administrator" , "password")  
wscript.echo objService.Name & " teve account logon reconfigurado." 
    End If
Next

