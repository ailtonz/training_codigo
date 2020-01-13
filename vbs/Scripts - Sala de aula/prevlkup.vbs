

' preverse.vbs
'
' This script creates a primary reverse lookup zone on London

Option Explicit

Dim WshShell
Dim IpConfigSet, IPConfig, IPAddr, Classroom, CmdStr
Dim i

Set WshShell = WScript.CreateObject("WScript.Shell")

Set IPConfigSet = GetObject("winmgmts:").ExecQuery _
		("select IPAddress from Win32_NetworkAdapterConfiguration where IPEnabled=TRUE")

For Each IPConfig in IPConfigSet
   If Not IsNull(IPConfig.IPAddress) then 
      For i = LBound(IPConfig.IPAddress) to UBound(IPConfig.IPAddress)
	 If Left(IPConfig.IPAddress(i), 7) = "192.168" And _
            Right(IPConfig.IPAddress(i), 3) = "200" Then
            IPAddr = IPConfig.IPAddress(i)
	 End If
      Next
   End If
Next

Classroom = Mid(IPAddr, 9, 1)

' Add reverse lookup zone
CmdStr = "c:\tools\dnscmd london /zoneadd " & Classroom & ".168.192.in-addr.arpa /Primary /file " & _
          Classroom & ".168.192.in-addr.arpa.dns"
WshShell.Run CmdStr, 0, True

Call AddRecord("Vancouver",  "101", Classroom)
Call AddRecord("Denver",     "102", Classroom)
Call AddRecord("Perth",      "103", Classroom)
Call AddRecord("Brisbane",   "104", Classroom)
Call AddRecord("Lisbon",     "105", Classroom)
Call AddRecord("Bonn",       "106", Classroom)
Call AddRecord("Lima",       "107", Classroom)
Call AddRecord("Santiago",   "108", Classroom)
Call AddRecord("Bangalore",  "109", Classroom)
Call AddRecord("Singapore",  "110", Classroom)
Call AddRecord("Casablanca", "111", Classroom)
Call AddRecord("Tunis",      "112", Classroom)
Call AddRecord("Acapulco",   "113", Classroom)
Call AddRecord("Miami",      "114", Classroom)
Call AddRecord("Auckland",   "115", Classroom)
Call AddRecord("Suva",       "116", Classroom)
Call AddRecord("Stockholm",  "117", Classroom)
Call AddRecord("Moscow",     "118", Classroom)
Call AddRecord("Caracas",    "119", Classroom)
Call AddRecord("Montevideo", "120", Classroom)
Call AddRecord("Manila",     "121", Classroom)
Call AddRecord("Tokyo",      "122", Classroom)
Call AddRecord("Khartoum",   "123", Classroom)
Call AddRecord("Nairobi",    "124", Classroom)

WScript.Quit 0


' Add a New Resource Record
'
Sub AddRecord(Machine, EndAddr, CRNum)
   ' Build command to add Name Server.
   CmdStr = "c:\tools\dnscmd london /RecordAdd " & CRNum & ".168.192.in-addr.arpa @ " & _
            "NS " & Machine  & ".nwtraders.msft."
   WshShell.Run CmdStr, 0, True

   ' Build command to add Name Server's and IP address.
   CmdStr = "c:\tools\dnscmd london /RecordAdd " & CRNum & ".168.192.in-addr.arpa " & _
            Machine  & ".nwtraders.msft. " & _
            "A 192.168" & "." & CRNum & "." & EndAddr
   WshShell.Run CmdStr, 0, True
End Sub