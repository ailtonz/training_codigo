Dim fso, WshShell, objNet, strt

on error resume next

Set fso = CreateObject("Scripting.FileSystemObject")
fso.CopyFile "c:\tools\Auto1.lnk", "c:\Windows\Desktop\Continue Automated Setup.lnk", true
Set objNet = WScript.CreateObject("WScript.Network")
Set WshShell = WScript.CreateObject("WScript.Shell")
Set strt = fso.GetFile("c:\Windows\Start Menu\Programs\Startup\runnext.vbs")
strt.Delete

Select Case objNet.ComputerName
	Case "LONDON98" 
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\lon.bmp" ,"REG_SZ"
	Case "GLASGOW98" 
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\gla.bmp" ,"REG_SZ"
	Case "MELBOURNE98" 
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\mel.bmp" ,"REG_SZ"
	Case "VANCOUVER98" 
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\van.bmp" ,"REG_SZ"
	Case "DENVER98" 
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\den.bmp" ,"REG_SZ"
	Case "ACAPULCO98"
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\aca.bmp" ,"REG_SZ"
	Case "MIAMI98" 
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\mia.bmp" ,"REG_SZ"
	Case "LISBON98" 
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\lis.bmp" ,"REG_SZ"
	Case "BONN98"
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\bon.bmp" ,"REG_SZ"
	Case "STOCKHOLM98"
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\sto.bmp" ,"REG_SZ"
  	Case "MOSCOW98" 
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\mos.bmp" ,"REG_SZ"
	Case "BANGALORE98" 
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\ban.bmp" ,"REG_SZ"
	Case "SINGAPORE98" 
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\sin.bmp" ,"REG_SZ"
	Case "MANILA98" 
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\man.bmp" ,"REG_SZ"
	Case "TOKYO98" 
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\tok.bmp" ,"REG_SZ"
	Case "PERTH98" 
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\per.bmp" ,"REG_SZ"
	Case "BRISBANE98" 
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\bri.bmp" ,"REG_SZ"
	Case "AUCKLAND98" 
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\auc.bmp" ,"REG_SZ"
	Case "SUVA98" 
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\suv.bmp" ,"REG_SZ"
	Case "LIMA98" 
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\lim.bmp" ,"REG_SZ"
	Case "SANTIAGO98" 
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\san.bmp" ,"REG_SZ"
	Case "CARACAS98" 
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\car.bmp" ,"REG_SZ"
	Case "MONTEVIDEO98" 
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\mon.bmp" ,"REG_SZ"
	Case "CASABLANCA98" 
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\cas.bmp" ,"REG_SZ"
	Case "TUNIS98" 
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\tun.bmp" ,"REG_SZ"
	Case "KHARTOUM98" 
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\kha.bmp" ,"REG_SZ"
	Case "NAIROBI98" 
		WshShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", "c:\setup\images\nai.bmp" ,"REG_SZ"
End Select

WshShell.RegWrite "HKEY_LOCAL_MACHINE\Config\0001\Display\Settings\Resolution", "1024,768", "REG_SZ"

WshShell.RegWrite "HKEY_LOCAL_MACHINE\Config\0001\Display\Settings\BitsPerPixel", "24", "REG_SZ"
