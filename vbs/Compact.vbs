set wshshell = wscript.createobject("wscript.shell")
set fso = createobject("scripting.filesystemobject")
error = 1
while error = 1
	Set IPConfigSet = GetObject("winmgmts:").ExecQuery ("select IPAddress,SettingID from Win32_NetworkAdapterConfiguration where IPEnabled=TRUE")
	for each j in IpConfigSet
		if Not IsNull(j.ipaddress) then
			x = j.ipaddress(i)
			if x <> "" then
				exit for
			end if
		end if
	next
	on error resume next
	y=j.settingid(i)
	on error goto 0
	if y = "" then
		if fso.FileExists("C:\Documents and Settings\All Users\Start Menu\Programs\Startup\mocsetup.cmd") then
			set MyFile = fso.GetFile("C:\Documents and Settings\All Users\Start Menu\Programs\Startup\mocsetup.cmd")
			MyFile.Delete
		end if
		set strt = fso.getfolder("c:\documents and settings\all users\start menu\programs\startup")
		fn = "runnext.vbs"
		set nxt = fso.getfile("c:\setup\instruct\lon_gui.vbs")
		set fl = fso.createtextfile(strt & "\" & fn, true)
		fl.writeline("set wshshell = wscript.createobject" & chr(40) & chr(34) & "wscript.shell" & chr(34) & chr(41))
		fl.writeline("wshshell.run " & chr(34) & nxt & chr(34))
		fl.Close
		msgbox "You have a network interface card (NIC) that has drivers that are not included in Windows XP. Please install the drivers now, and then click OK to continue with automated setup."
	else
		Error = 0
	end if
	
wend