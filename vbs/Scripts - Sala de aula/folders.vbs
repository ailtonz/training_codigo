ExpPath = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\"
dim WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
	
	'Show Hidden Files
	wshshell.RegWrite ExpPath & "Hidden", 1 ,"REG_DWORD"
	
	'Show Protected Operating System Files
	wshshell.RegWrite ExpPath & "ShowSuperHidden", 1 ,"REG_DWORD"
	
	'Do Not Hide File Extentions for Known File Types
	wshshell.RegWrite ExpPath & "HideFileExt", 0 ,"REG_DWORD"
	
Set WshShell = Nothing