' Creates a set of groups on the local computer and adds members to them.

Set WshNetwork = wscript.CreateObject("Wscript.Network")
strComputer = WshNetwork.ComputerName

Set colAccounts = GetObject("WinNT://" & strComputer & "")

Call CrtGroup("AWSalesDirector", objGroup)
Call AddMember(objGroup, "EuropeDirector")
Call AddMember(objGroup, "PacificDirector")
Call AddMember(objGroup, "NADirector")

Call CrtGroup("AWSalesAnalyst", objGroup)
Call AddMember(objGroup, "SalesAnalyst")

Function CrtGroup(sGID, oGrp)
   Set oGrp = colAccounts.Create("group", sGID)
   oGrp.SetInfo
End Function

Function AddMember(oGrp, sUID)
   Set oUsr = GetObject("WinNT://" & strComputer & "/" & sUID & ",user")
   oGrp.Add(oUsr.ADsPath)
End Function