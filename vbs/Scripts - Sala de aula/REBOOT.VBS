Function ReadConfig(strName)
	Set fso = CreateObject("Scripting.FileSystemObject")
	configfile = "C:\software.cfg"
	'configfile = "D:\ngasII\software.cfg" ' for debugging purpouses
	
	if fso.FileExists (configfile) then	' is there a config file?
		Set f = fso.OpenTextFile(configfile)
		
		' check each line of the config file until strName is found
		do while not f.AtEndOfStream
			s = f.ReadLine
			s = split(s,"=")
			if strcomp(s(0),strName) = 0 then exit do 
			s(1) = ""
		loop
		f.Close 
		
		' was the path found?
		if strcomp(s(1), "") <> 0 then
			path = s(1)
			'format path
			If right(path, 1) = "\" Then
				path = left(path, len(path)-1)
			End IF
			ReadConfig = path
			' is path valid?
			'set regex = new regexp
			'regex.pattern = "(\\{2}[A-Za-z].*\\[A-Za-z].*|[A-Za-z]:(\\[A-Za-z].*)*)"
			'set matches = regex.execute(path)
			'if matches.count <> 0 and matches(0) = path then ReadConfig = path
	
		end if
	end if
	if ReadConfig = "" then ReadConfig = False
End Function