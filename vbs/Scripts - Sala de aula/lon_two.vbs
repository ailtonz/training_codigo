option explicit
on error resume next

dim message, title, done, shell, fso
message = "Office 2000 Premium is installing, Please Wait"
title = "Course 1572c Setup"
done = 0

set shell = wscript.createobject("wscript.shell")
set fso = createobject("scripting.filesystemobject")

shell.run "d:\office\setup.exe /wait /settings c:\tools\lon_off.ini", 1, false

do while done = 0
shell.popup message,60,title,64
	if fso.fileexists("C:\Documents and Settings\All Users\Start Menu\Programs\microsoft word.lnk") then
		done = 1
		shell.Popup message,90,title,64
		exit do
	end if
loop
