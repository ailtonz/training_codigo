Dim wshShell, btn
Set wshShell = WScript.CreateObject("WScript.Shell")

' Call the Popup method with a 7 second timeout.
btn = WshShell.Popup("Do you feel alright?", 7, "Question:", &H4 + &H20)

Select Case btn
    ' Yes button pressed.
    case 6
        WScript.Echo "Glad to hear you feel alright."
    ' No button pressed.
    case 7
        WScript.Echo "Hope you're feeling better soon."
    ' Timed out.
    case -1
        WScript.Echo "Is there anybody out there?"
End Select