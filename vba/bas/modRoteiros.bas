Attribute VB_Name = "modRoteiros"
Option Compare Database
Option Explicit

Public Function ReagendamentoColoca(codLigacao As Long)
Dim rstLigacao As DAO.Recordset
Dim rstLigacoes As DAO.Recordset
Dim rstColoca As DAO.Recordset
Dim SALDO As Long

Set rstLigacoes = CurrentDb.OpenRecordset("Select * from Ligacoes ")
Set rstLigacao = CurrentDb.OpenRecordset("Select * from Ligacoes where codLigacao = " & codLigacao)
Set rstColoca = CurrentDb.OpenRecordset("Select * from qryRoteirosColoca where codLigacao = " & codLigacao)

If Not rstLigacao.EOF Then
    
    SALDO = rstLigacao.Fields("C") - rstColoca.Fields("QTD")
    
    If SALDO = 0 Then
        
        ''' ATUALIZA LIGA플O
        rstLigacao.Edit
        rstLigacao.Fields("C") = rstColoca.Fields("QTD")
        rstLigacao.Fields("DT_C") = Format(Now() + 1, "DD/MM/YYYY")
        rstLigacao.Update
        
    Else
    
        ''' AJUSTAR LIGA플O
        rstLigacao.Edit
        rstLigacao.Fields("C") = SALDO
        rstLigacao.Update
        
        ''' NOVA LIGA플O
        rstLigacoes.AddNew
        rstLigacoes.Fields("codCadastro") = rstLigacao.Fields("codCadastro")
        rstLigacoes.Fields("codObra") = rstLigacao.Fields("codObra")
        rstLigacoes.Fields("OBS") = rstLigacao.Fields("OBS")
        rstLigacoes.Fields("USUARIOS") = rstLigacao.Fields("USUARIOS")
        rstLigacoes.Fields("CLIENTE") = rstLigacao.Fields("CLIENTE")
        rstLigacoes.Fields("OBRA") = rstLigacao.Fields("OBRA")
        rstLigacoes.Fields("BAIRRO") = rstLigacao.Fields("BAIRRO")
        rstLigacoes.Fields("CONTATO") = rstLigacao.Fields("CONTATO")
        rstLigacoes.Fields("CTR") = rstLigacao.Fields("CTR")
        rstLigacoes.Fields("DATA") = Format(Now() + 1, "DD/MM/YYYY")
        rstLigacoes.Fields("PROPAGANDA") = "REAGENDAMENTO"
        
        rstLigacoes.Fields("C") = rstColoca.Fields("QTD")
        rstLigacoes.Fields("DT_C") = Format(Now() + 1, "DD/MM/YYYY")
        rstLigacoes.Fields("C_PRIORIDADE") = rstLigacao.Fields("C_PRIORIDADE")
        rstLigacoes.Update
        
    End If
    
End If



rstLigacoes.Close
Set rstLigacoes = Nothing

rstLigacao.Close
Set rstLigacao = Nothing

rstColoca.Close
Set rstColoca = Nothing

End Function

Public Function ReagendamentoTroca(codLigacao As Long)
Dim rstLigacao As DAO.Recordset
Dim rstLigacoes As DAO.Recordset
Dim rstTroca As DAO.Recordset
Dim SALDO As Long

Set rstLigacoes = CurrentDb.OpenRecordset("Select * from Ligacoes ")
Set rstLigacao = CurrentDb.OpenRecordset("Select * from Ligacoes where codLigacao = " & codLigacao)
Set rstTroca = CurrentDb.OpenRecordset("Select * from qryRoteirosTroca where codLigacao = " & codLigacao)

If Not rstLigacao.EOF Then
    
    SALDO = rstLigacao.Fields("T") - rstTroca.Fields("QTD")
    
    If SALDO = 0 Then
        
        ''' ATUALIZA LIGA플O
        rstLigacao.Edit
        rstLigacao.Fields("T") = rstTroca.Fields("QTD")
        rstLigacao.Fields("DT_T") = Format(Now() + 1, "DD/MM/YYYY")
        rstLigacao.Update
        
    Else
    
        ''' AJUSTAR LIGA플O
        rstLigacao.Edit
        rstLigacao.Fields("T") = SALDO
        rstLigacao.Update
        
        ''' NOVA LIGA플O
        rstLigacoes.AddNew
        rstLigacoes.Fields("codCadastro") = rstLigacao.Fields("codCadastro")
        rstLigacoes.Fields("codObra") = rstLigacao.Fields("codObra")
        rstLigacoes.Fields("OBS") = rstLigacao.Fields("OBS")
        rstLigacoes.Fields("USUARIOS") = rstLigacao.Fields("USUARIOS")
        rstLigacoes.Fields("CLIENTE") = rstLigacao.Fields("CLIENTE")
        rstLigacoes.Fields("OBRA") = rstLigacao.Fields("OBRA")
        rstLigacoes.Fields("BAIRRO") = rstLigacao.Fields("BAIRRO")
        rstLigacoes.Fields("CONTATO") = rstLigacao.Fields("CONTATO")
        rstLigacoes.Fields("CTR") = rstLigacao.Fields("CTR")
        rstLigacoes.Fields("DATA") = Format(Now() + 1, "DD/MM/YYYY")
        rstLigacoes.Fields("PROPAGANDA") = "REAGENDAMENTO"
        
        rstLigacoes.Fields("T") = rstTroca.Fields("QTD")
        rstLigacoes.Fields("DT_T") = Format(Now() + 1, "DD/MM/YYYY")
        rstLigacoes.Fields("T_PRIORIDADE") = rstLigacao.Fields("T_PRIORIDADE")
        rstLigacoes.Update
        
    End If
    
End If



rstLigacoes.Close
Set rstLigacoes = Nothing

rstLigacao.Close
Set rstLigacao = Nothing

rstTroca.Close
Set rstTroca = Nothing

End Function


Public Function ReagendamentoRetira(codLigacao As Long)
Dim rstLigacao As DAO.Recordset
Dim rstLigacoes As DAO.Recordset
Dim rstRetira As DAO.Recordset
Dim SALDO As Long

Set rstLigacoes = CurrentDb.OpenRecordset("Select * from Ligacoes ")
Set rstLigacao = CurrentDb.OpenRecordset("Select * from Ligacoes where codLigacao = " & codLigacao)
Set rstRetira = CurrentDb.OpenRecordset("Select * from qryRoteirosRetira where codLigacao = " & codLigacao)

If Not rstLigacao.EOF Then
    
    SALDO = rstLigacao.Fields("R") - rstRetira.Fields("QTD")
    
    If SALDO = 0 Then
        
        ''' ATUALIZA LIGA플O
        rstLigacao.Edit
        rstLigacao.Fields("R") = rstRetira.Fields("QTD")
        rstLigacao.Fields("DT_R") = Format(Now() + 1, "DD/MM/YYYY")
        rstLigacao.Update
        
    Else
    
        ''' AJUSTAR LIGA플O
        rstLigacao.Edit
        rstLigacao.Fields("R") = SALDO
        rstLigacao.Update
        
        ''' NOVA LIGA플O
        rstLigacoes.AddNew
        rstLigacoes.Fields("codCadastro") = rstLigacao.Fields("codCadastro")
        rstLigacoes.Fields("codObra") = rstLigacao.Fields("codObra")
        rstLigacoes.Fields("OBS") = rstLigacao.Fields("OBS")
        rstLigacoes.Fields("USUARIOS") = rstLigacao.Fields("USUARIOS")
        rstLigacoes.Fields("CLIENTE") = rstLigacao.Fields("CLIENTE")
        rstLigacoes.Fields("OBRA") = rstLigacao.Fields("OBRA")
        rstLigacoes.Fields("BAIRRO") = rstLigacao.Fields("BAIRRO")
        rstLigacoes.Fields("CONTATO") = rstLigacao.Fields("CONTATO")
        rstLigacoes.Fields("CTR") = rstLigacao.Fields("CTR")
        rstLigacoes.Fields("DATA") = Format(Now() + 1, "DD/MM/YYYY")
        rstLigacoes.Fields("PROPAGANDA") = "REAGENDAMENTO"
        
        rstLigacoes.Fields("R") = rstRetira.Fields("QTD")
        rstLigacoes.Fields("DT_R") = Format(Now() + 1, "DD/MM/YYYY")
        rstLigacoes.Fields("R_PRIORIDADE") = rstLigacao.Fields("R_PRIORIDADE")
        rstLigacoes.Update
        
    End If
    
End If



rstLigacoes.Close
Set rstLigacoes = Nothing

rstLigacao.Close
Set rstLigacao = Nothing

rstRetira.Close
Set rstRetira = Nothing

End Function


