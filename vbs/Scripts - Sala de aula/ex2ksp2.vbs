Set oSHApp = CreateObject("Shell.Application")
sSrc = "\\london\exchange\*.*"
sDest = "d:\exchange"
oSHApp.Namespace(sDest).CopyHere sSrc, &H10&
Set oSHApp = nothing
WScript.Quit
