' glaadmin.vbs
'
' This script adds the Administrative Privilege to the Glasgow Computer

set wshshell = wscript.CreateObject("wscript.shell")

' Add nwtraders\G IT Admins to the Power User group
wshshell.Run "net localgroup ""Administradores"" ""G IT Admins"" /ADD", 0, true