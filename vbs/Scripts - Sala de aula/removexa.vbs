dim sDirName, vRoot, vDir
sDirName = "CreditSample"
on error resume next
set vDir = nothing
set vDir = GetObject("IIS://localhost/w3svc/1/Root/" & sDirName)
on error goto 0
if not (vDir is nothing) then
    set vRoot = GetObject("IIS://localhost/w3svc/1/Root")
    vRoot.Delete "IIsWebVirtualDir", sDirName
    msgbox "Removed web directory: " & sDirName, vbOKOnly
else
    msgbox "Web directory does not exist: " & sDirName, vbOKOnly
end if
