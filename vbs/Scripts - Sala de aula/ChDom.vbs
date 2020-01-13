Dim oRoot
Dim oDisp
Dim oCont
Dim aMenu
Dim iCount
Dim sNewMenu
Dim oFileSystem
Dim sOutFile
Dim sSystemFolder
Set oFileSystem = WScript.CreateObject("Scripting.FileSystemObject")
sSystemFolder =  oFileSystem.GetSpecialFolder(1)

Set objNet = WScript.CreateObject("WScript.Network")
bob = objNet.ComputerName


set oRoot = Getobject("LDAP://RootDSE")
set oCont = GetObject("LDAP://" & "CN=409, CN=DisplaySpecifiers," & oRoot.get("configurationNamingContext"))
Set oDisp = oCont.GetObject("displaySpecifier","cn=user-Display")

MCP_attribute= "MCP" & bob & ", " & bob & " MCP Number"

xMenuName = bob & " MCP Number"
xFileName = bob & "_hradmin"

oDisp.PutEx 3,"attributeDisplayNames" , Array(MCP_attribute)
oDisp.SetInfo

iCount = 0
If Not IsEmpty(oDisp.adminContextMenu) Then
  aMenu = oDisp.GetEx("adminContextMenu")
  For iCount = LBound(aMenu) to UBound(aMenu)
'    MsgBox "Existing Menu item: " & aMenu(iCount)
  Next
  iCount = iCount + 1
End If
sNewMenu = CStr(iCount) & "," &  xMenuName & "...," & xFileName & ".vbs"
oDisp.PutEx 3,"adminContextMenu" , Array(sNewMenu)
oDisp.SetInfo

Set objNet = WScript.CreateObject("WScript.Network")
bob = objNet.ComputerName
fred = sSystemFolder & "\" & bob & "_hradmin.vbs"

Set oFileSystem = WScript.CreateObject("Scripting.FileSystemObject")
Set sOutFile = oFileSystem.CreateTextFile(fred,True)

Message="This message box demonstrates the ability to call a program from a modified context menu. Additional code could be added to allow you to manipulate the MCP data."
sOutFile.WriteLine "MsgBox " & Chr(34) & Message & Chr(34) 
sOutFile.WriteLine "WScript.Quit"

sOutFile.Close
Set oDisp = Nothing
Set oCont = Nothing
Set oRoot = Nothing
Set oFileSystem = Nothing
WScript.Quit 
