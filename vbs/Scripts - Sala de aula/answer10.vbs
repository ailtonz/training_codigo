'This is a possible answer to lab 9
Dim intContinue

intContinue =  MsgBox("Continue Running?", vbOKCancel + vbInformation,"Lab 9")
If intContinue = vbCancel Then
    MsgBox "The Cancel Button was pressed. Press OK to exit the program"

    'Insert a statement using the Quit method of the WScript object here
    WScript.Quit

Else
    MsgBox "The progam would run here"
End If