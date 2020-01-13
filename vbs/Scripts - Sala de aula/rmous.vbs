' First, the usual Bindings
Set WshShell = Wscript.CreateObject("Wscript.Shell")
Set WshSysEnv = WshShell.Environment("Process")

Set Root=GetObject("LDAP://RootDSE")
ConfigurationRoot = Root.Get("configurationNamingContext")
Set Root  = GetObject("LDAP://" & ConfigurationRoot)

RemoveServer("Vancouver")
RemoveServer("Denver")
RemoveServer("Perth")
RemoveServer("Brisbane")
RemoveServer("Lisbon")
RemoveServer("Bonn")
RemoveServer("Lima")
RemoveServer("Santiago")
RemoveServer("Bangalore")
RemoveServer("Singapore")
RemoveServer("Casablanca")
RemoveServer("Tunis")
RemoveServer("Acapulco")
RemoveServer("Miami")
RemoveServer("Auckland")
RemoveServer("Suva")
RemoveServer("Stockholm")
RemoveServer("Moscow")
RemoveServer("Caracas")
RemoveServer("Montevideo")
RemoveServer("Manila")
RemoveServer("Tokyo")
RemoveServer("Khartoum")
RemoveServer("Nairobi")

wshShell.run "REG.EXE add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce\RemoveDNS=c:\tools\nodns.cmd", 6, true
wshShell.run "REG.EXE add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce\ClearDns=c:\moc\win2154a\labfiles\cleardns.vbs", 6, true
wshShell.run "dcpromo.exe /answer:c:\moc\win2154a\labfiles\demote.txt", 6, true


''''''''''''''''''''''''''''''''''''''
Sub RemoveServer(ServerName)
''''''''''''''''''''''''''''''''''''''
   On Error Resume Next
   

   Set objNTDS = Root.GetObject("sitesContainer", "CN=NTDS Settings,CN=" & ServerName & ",CN=Servers,CN=Default-First-Site-Name,CN=Sites")
   Set objServer = Root.GetObject("sitesContainer", "CN=" & ServerName & ",CN=Servers,CN=Default-First-Site-Name,CN=Sites")
   Set objSiteName = Root.GetObject("sitesContainer", "CN=Servers,CN=Default-First-Site-Name,CN=Sites")

   For each child in objNTDS	
      objNTDS.delete "nTDSConnection", child.name	
   Next

   objServer.Delete "nTDSDSA", "CN=NTDS Settings"
   objSiteName.Delete "server" , "CN=" & ServerName 
End Sub


