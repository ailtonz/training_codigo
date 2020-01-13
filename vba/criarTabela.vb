Sub criarTabela()
'
' criarTabela Macro
'
'
    Selection.MoveUp Unit:=wdLine, Count:=5
    Selection.MoveDown Unit:=wdLine, Count:=1
    ActiveDocument.Tables.Add Range:=Selection.Range, NumRows:=4, NumColumns:= _
        4, DefaultTableBehavior:=wdWord9TableBehavior, AutoFitBehavior:= _
        wdAutoFitFixed
    With Selection.Tables(1)
        If .Style <> "Tabela com grade" Then
            .Style = "Tabela com grade"
        End If
        .ApplyStyleHeadingRows = True
        .ApplyStyleLastRow = False
        .ApplyStyleFirstColumn = True
        .ApplyStyleLastColumn = False
        .ApplyStyleRowBands = True
        .ApplyStyleColumnBands = False
    End With
    Selection.MoveUp Unit:=wdLine, Count:=5
    Selection.MoveDown Unit:=wdLine, Count:=1
    ActiveDocument.Tables.Add Range:=Selection.Range, NumRows:=5, NumColumns:= _
        4, DefaultTableBehavior:=wdWord9TableBehavior, AutoFitBehavior:= _
        wdAutoFitFixed
    With Selection.Tables(1)
        If .Style <> "Tabela com grade" Then
            .Style = "Tabela com grade"
        End If
        .ApplyStyleHeadingRows = True
        .ApplyStyleLastRow = False
        .ApplyStyleFirstColumn = True
        .ApplyStyleLastColumn = False
        .ApplyStyleRowBands = True
        .ApplyStyleColumnBands = False
    End With
End Sub