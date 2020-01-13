Option Compare Database

Public Function ConstruirCampos()
Dim rstCampos As DAO.Recordset

Dim ctl As Control
Dim strForm As String
Dim strSQL As String

Dim Esquerda As Integer
Dim Topo As Integer
Dim Largura As Integer
Dim Altura As Integer

Esquerda = 10
Topo = 10
Largura = 1
Altura = 1

strForm = "MenuPrincipal"

DoCmd.OpenForm strForm, acDesign

strSQL = "Select Distinct TipoControle,Descricao from admCampos where TipoControle <> 'ListBox' Order by TipoControle"

Set rstCampos = CurrentDb.OpenRecordset(strSQL)

While Not rstCampos.EOF

    Select Case rstCampos.Fields("TipoControle")

        Case "Label"

            Set ctl = CreateControl(strForm, acLabel, , "", , Esquerda, Topo, Largura, Altura)
            With ctl
                'Nome do Controle
                .Name = "lbl" & rstCampos.Fields("Descricao")
                'Visivel
                .Visible = False
            End With

        Case Is = "TextBox"

            Set ctl = CreateControl(strForm, acTextBox, , "", , Esquerda, Topo, Largura, Altura)
            With ctl
                'Nome do Controle
                .Name = "txt" & rstCampos.Fields("Descricao")
                'Visivel
                .Visible = False
                'Parada De Tabula��o
                .TabStop = False
                'Bloqueado
                .Locked = True
            End With

        Case Is = "ComboBox"

            Set ctl = CreateControl(strForm, acComboBox, , "", , Esquerda, Topo, Largura, Altura)
            With ctl
                'Nome do Controle
                .Name = "cbo" & rstCampos.Fields("Descricao")
                'Visivel
                .Visible = False
                'Parada De Tabula��o
                .TabStop = False
                'Bloqueado
                .Locked = True
                
            End With
        
        Case Is = "CommandButton"

            Set ctl = CreateControl(strForm, acCommandButton, , "", , Esquerda, Topo, Largura, Altura)
            With ctl
                'Nome do Controle
                .Name = "cmd" & rstCampos.Fields("Descricao")
                'Legenda
                .Caption = rstCampos.Fields("Descricao")
                'Visivel
                .Visible = False
                'Parada De Tabula��o
                .TabStop = False
            End With

    End Select

    rstCampos.MoveNext

Wend

rstCampos.Close

Set rstCampos = Nothing

DoCmd.Restore
DoCmd.Close acForm, strForm, acSaveYes
DoCmd.OpenForm strForm

End Function

Public Function AjusteDoMenuPrincipal()
Dim cn As New ADODB.Connection
Dim rsObjeto As New ADODB.Recordset
Dim strSQL As String
Dim strFormulario As String
Dim frm As Form

PegarParametrosDeConeccao

cn.ConnectionString = "Provider=" & strDriver & ";Server=" & strServidor & ";database=" & strBaseDeDados & ";uid=" & strUsuario & ";pwd=" & strSenha
cn.CursorLocation = adUseClient
cn.ConnectionTimeout = 15
cn.Open

''Nome do Formul�rio que ser� alterado
strFormulario = "MenuPrincipal"

strSQL = "Select * from x1ConstrutorObjeto where Cadastro = '" & strFormulario & "'"
rsObjeto.Open strSQL, cn, adOpenKeyset, adLockOptimistic
strSQL = ""

Set frm = Forms("MenuPrincipal")

With frm

    'Visualizar Teclas
    .KeyPreview = True
    'Altura
    .Section(0).Height = rsObjeto.Fields("Altura")
    'Largura
    .Width = rsObjeto.Fields("Largura")
    'Titulo do formul�rio
    .Caption = rsObjeto.Fields("Titulo")
    'Estilo da Borda
'    .BorderStyle = 1
    'Linhas divis�rias
    .DividingLines = False
    'Centralizar
'    .AutoCenter = True
    'Auto Ajuste
'    .AutoResize = True
    'Bot�es de navega��o
    .NavigationButtons = False
    'Seletor de registos
    .RecordSelectors = False
    'Janela Restrita
    .Modal = True
    'Barras De Rolagem
    .ScrollBars = 0
    'Caixa De Controle
'    .ControlBox = False
    'Bot�es de Maximizar e Minimizar
'    .MinMaxButtons = 0
    'Permitir ser feitas altera��es de design
'    .AllowDesignChanges = True
    
End With


rsObjeto.Close
cn.Close

Set rsObjeto = Nothing
Set cn = Nothing

DoCmd.Restore
DoCmd.Close acForm, strFormulario, acSaveYes
DoCmd.OpenForm strFormulario

End Function
