Private Function OcultarControles()
Dim obj As Variant

Me.cmdMovimentos.SetFocus

For Each obj In Me.Controls
    If obj.Visible Then
        If TypeOf obj Is TextBox Then
            obj.Visible = False
        ElseIf TypeOf obj Is ComboBox Then
            obj.Visible = False
        ElseIf TypeOf obj Is ListBox Then
            obj.Visible = False
        ElseIf TypeOf obj Is Label Then
            If obj.Name = "lblOpcoes" Then
                obj.Visible = True
            Else
                obj.Visible = False
            End If
        End If
    End If
Next

End Function
