Dim iDays, iHours(), iTotal, iAverage, iLoop
Do 
	iDays = InputBox("How many days did you work last week?")
Loop While Not IsNumeric(iDays)
ReDim iHours(iDays-1)
For iLoop = 0 to iDays - 1
	iHours(iLoop) = CSng(InputBox("Enter hours for day " & iLoop + 1))
	iTotal = iTotal + iHours(iLoop)
Next
iAverage = iTotal/iDays
Msgbox "Total hours worked: " & iTotal
Msgbox "Average daily shift: " & iAverage