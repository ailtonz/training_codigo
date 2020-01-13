Call MainProc

Sub MainProc()
Dim iResult, iAnswer
iResult = CalcAvg()
Select Case iResult
Case 1
	Msgbox "Cannot divide by zero"
	iAnswer = Msgbox("Do you want to try again?",vbYesNo)
	If iAnswer = vbYes then
		Call MainProc
	Else
		WScript.Quit
	End IF
Case 2
	Msgbox "Only numeric data is allowed"
	iAnswer = Msgbox("Do you want to try again?",vbYesNo)
	If iAnswer = vbYes then
		Call MainProc
	Else
		WScript.Quit
	End IF
Case 3
	Msgbox "An unexpected error occurred"
	iAnswer = Msgbox("Do you want to try again?",vbYesNo)
	If iAnswer = vbYes then
		Call MainProc
	Else
		WScript.Quit
	End IF
End Select
End Sub

Function CalcAvg()
On Error Resume Next
Dim intNumberOfTests, intTotalPoints, nAverage 
' collect test information
intTotalPoints = InputBox("Enter the Total points scored.")
intNumberOfTests = InputBox("Enter the number of exams.")
' calculate average
nAverage = CInt(intTotalPoints)/CInt(intNumberOfTests)
Select Case Err.Number
Case 0 'No error occurred
	Msgbox "Average score = " & nAverage
	CalcAvg = 0
Case 11 'Division by zero
	CalcAvg = 1
Case 13 ' Type mis-match
	CalcAvg = 2
Case Else
	CalcAvg = 3
End Select

End Function