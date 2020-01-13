Attribute VB_Name = "Module1"
'MTBIA
'Written by: Gleb Gudzenko

Sub Check()
Dim Primary, Secondary As Range
Dim tmpValue
Dim numRows, outerCount, innerCount, Y As Integer
Dim colPrint, countPrint As Integer
Dim ColA, ColB

'Comparison locations
ColA = 1
ColB = 2
'Print Locations
colPrint = 4 'static
rowPrint = 2
'Loop counts starting locations
outerCount = 1
innerCount = 1

'Number of used rows in sheet
numRows = Cells.Find(What:="*", After:=[A1], SearchOrder:=xlByRows, SearchDirection:=xlPrevious).Row

Set Primary = Range(Cells(2, ColA), Cells(numRows, ColA))
Set Secondary = Range(Cells(2, ColB), Cells(numRows, ColB))

For outerCount = 2 To numRows
Primary.Cells(outerCount, 1).Select
tmpValue = Selection.Value
innerCount = 1

'The Column which is being compared to has a value of 1, add 1 to this to get the true excel column number
'The defualt column in this script is actually 2 (1+1).
'Change this to compare to whatever column you want to compare your values to
    Do
    If tmpValue Like Secondary.Cells(innerCount, 1).Value Then
        Secondary.Cells(innerCount, 1).Select
        ActiveCell.Copy (Cells(rowPrint, colPrint))
        ActiveCell.Font.Color = RGB(0, 255, 0)
        rowPrint = rowPrint + 1
    End If

    innerCount = innerCount + 1
    
    If IsEmpty(Secondary.Cells(innerCount, 1).Value) = True Then
        Exit Do
    End If
    
    Loop
Next outerCount

End Sub


