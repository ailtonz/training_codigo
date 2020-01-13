Set WshShell = WScript.CreateObject("WScript.Shell")

bKey = WshShell.RegRead("HKCR\DAO.DBEngine.35\")
msgbox(bKey)