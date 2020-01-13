Function VerificaCPF(Cpf As String) As Boolean

Dim i As Integer, a As Integer, b As Integer, dv1 As Integer, dv2 As Integer

For i = 1 To 9
a = a + Mid(Cpf, i, 1) * (11 - i)
b = b + Mid(Cpf, i, 1) * (12 - i)
Next i

dv1 = IIf((11 - (a Mod 11)) >= 10, 0, (11 - (a Mod 11)))
b = b + (dv1 * 2)
dv2 = IIf((11 - (b Mod 11)) >= 10, 0, (11 - (b Mod 11)))
VerificaCPF = (Mid(Cpf, 10, 2) = dv1 & dv2)
    If VerificaCPF Then
        VerificaCPF = True
    Else
        VerificaCPF = False
    End If
End Function