'This is a possible answer to lab 10
Dim iNum, iResult
On Error Resume Next
iNum = Inputbox("Enter a non-zero number")
iResult = 12/iNum
If Err.Number <> 0 Then
    Msgbox "The number must not be zero"
else
    Msgbox "12 / " & iNum & " = " & iResult
End If