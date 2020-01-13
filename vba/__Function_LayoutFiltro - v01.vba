Private Function LayoutFiltro(ctrl As Control, strCadastro As String, strPesquisa As String)
Dim rstLayout As ADODB.Recordset
Dim strSQL As String

Set rstLayout = New ADODB.Recordset

'Layout da Pesquisa
strSQL = "Select * from dbo_admCampos where codControle = " & PegarCodigoControle(strCadastro) & " and TipoControle = 'ListBox' and Descricao = '" & strPesquisa & "' and Ativo = true Order by Classificacao"

rstLayout.Open strSQL, CurrentProject.Connection


While Not rstLayout.EOF
    
    'Posicionar Listagem de pesqisa na tela
    With ctrl
        'Tipo De Origem Da Linha
        .RowSourceType = "Table/Query"
        'Esquerda
        .Left = rstLayout.Fields("Esquerda")
        'Altura
        .Height = rstLayout.Fields("Altura")
        'Topo
        .Top = rstLayout.Fields("Topo")
        'Largura
        .Width = rstLayout.Fields("Largura")
        'Tamanho da Fonte
        .FontSize = rstLayout.Fields("TamanhoDaFonte")
        'Fonte Em Negrito
        .FontBold = rstLayout.Fields("FonteEmNegrito")
        'Apar�ncia
'        .SpecialEffect = rstLayout.Fields("Aparencia")
        'Estilo da borda
        .BorderStyle = rstLayout.Fields("EstiloDaBorda")
        'Parada De Tabula��o
        .TabStop = IIf(IsNull(rstLayout.Fields("Tabulacao")), True, rstLayout.Fields("Tabulacao"))
        'Vis�vel
        .Visible = True
    End With

    rstLayout.MoveNext

Wend

rstLayout.Close

Set rstLayout = Nothing

End Function