using System;
using System.Collections.Generic;
using System.Xml;
using System.Text.RegularExpressions;
using Excel = Microsoft.Office.Interop.Excel;


//teste de uso.
namespace exportarAcordo
{

    public class report_segmento
    {
        public String PROCV { get; set; }
        public String ID { get; set; }
        public String NOME_ANALISTA { get; set; }
        public String FEEDBACK { get; set; }
        public String AREA_OFENSORA { get; set; }
        public String TIPO_PAGTO { get; set; }
        public String DT_PAGTO { get; set; }
        public String VALOR_PAGTO { get; set; }
        public String DT_AJUSTE { get; set; }
        public String VALOR_AJUSTADO { get; set; }
        public String RESUMO_EXECUTIVO_PROBLEMA { get; set; }
        public String RESUMO_EXECUTIVO_ACAO { get; set; }
        public String DT_FOLLOW_UP { get; set; }
        public String DT_CONTATO { get; set; }
        public String RESPONSAVEL { get; set; }
        public String FAIXA_FORNECEDOR { get; set; }
        public String FAIXA_FECHO { get; set; }
        public String FAIXA_ARRECADA_INICIAL { get; set; }
        public String FAIXA_ARRECADA_ATUAL { get; set; }
        public String RAIZ_GRUPO { get; set; }
        public String GRUPO { get; set; }
        public String RAIZ { get; set; }
        public String CNPJ { get; set; }
        public String NOME { get; set; }
        public String NOME_CLIENTE { get; set; }
        public String TIPO { get; set; }
        public String EMPRESA { get; set; }
        public String CONTA { get; set; }
        public String TEL { get; set; }
        public String NRC { get; set; }
        public String CLASSERV { get; set; }
        public String TITULO { get; set; }
        public String FILIAL { get; set; }
        public String LJ_CLI { get; set; }
        public String COD_CLI { get; set; }
        public String DOCUMENTO_SAP { get; set; }
        public String DOC_FAT { get; set; }
        public String N_DOC_DE_PARA_ATLYS { get; set; }
        public String NOTA_FISCAL { get; set; }
        public String VENC_ATUAL { get; set; }
        public String VENC_ORIGINAL { get; set; }
        public String DT_PROCESS { get; set; }
        public String ANOMES { get; set; }
        public String DIA_VENCIMENTO_LOTE { get; set; }
        public String NUMERO_LOTE { get; set; }
        public String VALOR_LOTE { get; set; }
        public String SALDO_CAR_26 { get; set; }
        public String SALDO_CAR_05 { get; set; }
        public String SALDO_CAR_30 { get; set; }
        public String SALDO_CAR_14 { get; set; }
        public String SALDO_CAR_21 { get; set; }
        public String SALDO_CAR_25 { get; set; }
        public String SALDO_TOTAL { get; set; }
        public String VALOR_PAGAMENTO { get; set; }
        public String VALOR_AJUSTE { get; set; }
        public String DT_ATRIB { get; set; }
        public String SALDO_ATUAL { get; set; }
        public String CICLO { get; set; }
        public String UF { get; set; }
        public String STATUS { get; set; }
        public String CLASSE { get; set; }
        public String SEGMENTO_GERENCIA { get; set; }
        public String GN { get; set; }
        public String GV { get; set; }
        public String DIRETOR { get; set; }
        public String ANALISTA_TLF_VIVO { get; set; }
        public String INTRAGOV { get; set; }
        public String INTERCOMPANY { get; set; }
        public String PENDENTE_ID_ANALISE_CONTA { get; set; }
        public String PENDENTE_DATA_ANALISE_CONTA { get; set; }
        public String CONCLUIDO_ID_ANALISE_CONTA { get; set; }
        public String CONCLUIDO_DATA_ANALISE_CONTA { get; set; }
        public String REABERTO_ID_ANALISE_CONTA { get; set; }
        public String REABERTO_DATA_ANALISE_CONTA { get; set; }
        public String AREA_ATUACAO { get; set; }
        public String TASK_FORCE { get; set; }
        public String SEG_DESCR { get; set; }
        public String PARCELAMENTO { get; set; }
        public String CONTA_BONUS { get; set; }
        public String FORNECEDOR { get; set; }
        public String REGRA_PDD { get; set; }
        public String PROVISAO { get; set; }
        public String SITUACAO_SERVICO { get; set; }
        public String SALDO_FX_ENT_26 { get; set; }
        public String SALDO_PDD_26 { get; set; }
        public String SALDO_FX_ENT_30 { get; set; }
        public String SALDO_PDD_30 { get; set; }
        public String SALDO_FX_ENT_05 { get; set; }
        public String SALDO_PDD_05 { get; set; }
        public String SALDO_FX_ENT_14 { get; set; }
        public String SALDO_PDD_14 { get; set; }
        public String SALDO_FX_ENT_21 { get; set; }
        public String SALDO_PDD_21 { get; set; }
        public String SALDO_FX_ENT_25 { get; set; }
        public String SALDO_PDD_25 { get; set; }
        public String RECEBIVEL { get; set; }

        public report_segmento(
        String procv,
        String id,
        String nome_analista,
        String feedback,
        String area_ofensora,
        String tipo_pagto,
        String dt_pagto,
        String valor_pagto,
        String dt_ajuste,
        String valor_ajustado,
        String resumo_executivo_problema,
        String resumo_executivo_acao,
        String dt_follow_up,
        String dt_contato,
        String responsavel,
        String faixa_fornecedor,
        String faixa_fecho,
        String faixa_arrecada_inicial,
        String faixa_arrecada_atual,
        String raiz_grupo,
        String grupo,
        String raiz,
        String cnpj,
        String nome,
        String nome_cliente,
        String tipo,
        String empresa,
        String conta,
        String tel,
        String nrc,
        String classerv,
        String titulo,
        String filial,
        String lj_cli,
        String cod_cli,
        String documento_sap,
        String doc_fat,
        String n_doc_de_para_atlys,
        String nota_fiscal,
        String venc_atual,
        String venc_original,
        String dt_process,
        String anomes,
        String dia_vencimento_lote,
        String numero_lote,
        String valor_lote,
        String saldo_car_26,
        String saldo_car_05,
        String saldo_car_30,
        String saldo_car_14,
        String saldo_car_21,
        String saldo_car_25,
        String saldo_total,
        String valor_pagamento,
        String valor_ajuste,
        String dt_atrib,
        String saldo_atual,
        String ciclo,
        String uf,
        String status,
        String classe,
        String segmento_gerencia,
        String gn,
        String gv,
        String diretor,
        String analista_tlf_vivo,
        String intragov,
        String intercompany,
        String pendente_id_analise_conta,
        String pendente_data_analise_conta,
        String concluido_id_analise_conta,
        String concluido_data_analise_conta,
        String reaberto_id_analise_conta,
        String reaberto_data_analise_conta,
        String area_atuacao,
        String task_force,
        String seg_descr,
        String parcelamento,
        String conta_bonus,
        String fornecedor,
        String regra_pdd,
        String provisao,
        String situacao_servico,
        String saldo_fx_ent_26,
        String saldo_pdd_26,
        String saldo_fx_ent_30,
        String saldo_pdd_30,
        String saldo_fx_ent_05,
        String saldo_pdd_05,
        String saldo_fx_ent_14,
        String saldo_pdd_14,
        String saldo_fx_ent_21,
        String saldo_pdd_21,
        String saldo_fx_ent_25,
        String saldo_pdd_25,
        String recebivel
        )
        {
            this.PROCV = procv;
            this.ID = id;
            this.NOME_ANALISTA = nome_analista;
            this.FEEDBACK = feedback;
            this.AREA_OFENSORA = area_ofensora;
            this.TIPO_PAGTO = tipo_pagto;
            this.DT_PAGTO = dt_pagto;
            this.VALOR_PAGTO = valor_pagto;
            this.DT_AJUSTE = dt_ajuste;
            this.VALOR_AJUSTADO = valor_ajustado;
            this.RESUMO_EXECUTIVO_PROBLEMA = resumo_executivo_problema;
            this.RESUMO_EXECUTIVO_ACAO = resumo_executivo_acao;
            this.DT_FOLLOW_UP = dt_follow_up;
            this.DT_CONTATO = dt_contato;
            this.RESPONSAVEL = responsavel;
            this.FAIXA_FORNECEDOR = faixa_fornecedor;
            this.FAIXA_FECHO = faixa_fecho;
            this.FAIXA_ARRECADA_INICIAL = faixa_arrecada_inicial;
            this.FAIXA_ARRECADA_ATUAL = faixa_arrecada_atual;
            this.RAIZ_GRUPO = raiz_grupo;
            this.GRUPO = grupo;
            this.RAIZ = raiz;
            this.CNPJ = cnpj;
            this.NOME = nome;
            this.NOME_CLIENTE = nome_cliente;
            this.TIPO = tipo;
            this.EMPRESA = empresa;
            this.CONTA = conta;
            this.TEL = tel;
            this.NRC = nrc;
            this.CLASSERV = classerv;
            this.TITULO = titulo;
            this.FILIAL = filial;
            this.LJ_CLI = lj_cli;
            this.COD_CLI = cod_cli;
            this.DOCUMENTO_SAP = documento_sap;
            this.DOC_FAT = doc_fat;
            this.N_DOC_DE_PARA_ATLYS = n_doc_de_para_atlys;
            this.NOTA_FISCAL = nota_fiscal;
            this.VENC_ATUAL = venc_atual;
            this.VENC_ORIGINAL = venc_original;
            this.DT_PROCESS = dt_process;
            this.ANOMES = anomes;
            this.DIA_VENCIMENTO_LOTE = dia_vencimento_lote;
            this.NUMERO_LOTE = numero_lote;
            this.VALOR_LOTE = valor_lote;
            this.SALDO_CAR_26 = saldo_car_26;
            this.SALDO_CAR_05 = saldo_car_05;
            this.SALDO_CAR_30 = saldo_car_30;
            this.SALDO_CAR_14 = saldo_car_14;
            this.SALDO_CAR_21 = saldo_car_21;
            this.SALDO_CAR_25 = saldo_car_25;
            this.SALDO_TOTAL = saldo_total;
            this.VALOR_PAGAMENTO = valor_pagamento;
            this.VALOR_AJUSTE = valor_ajuste;
            this.DT_ATRIB = dt_atrib;
            this.SALDO_ATUAL = saldo_atual;
            this.CICLO = ciclo;
            this.UF = uf;
            this.STATUS = status;
            this.CLASSE = classe;
            this.SEGMENTO_GERENCIA = segmento_gerencia;
            this.GN = gn;
            this.GV = gv;
            this.DIRETOR = diretor;
            this.ANALISTA_TLF_VIVO = analista_tlf_vivo;
            this.INTRAGOV = intragov;
            this.INTERCOMPANY = intercompany;
            this.PENDENTE_ID_ANALISE_CONTA = pendente_id_analise_conta;
            this.PENDENTE_DATA_ANALISE_CONTA = pendente_data_analise_conta;
            this.CONCLUIDO_ID_ANALISE_CONTA = concluido_id_analise_conta;
            this.CONCLUIDO_DATA_ANALISE_CONTA = concluido_data_analise_conta;
            this.REABERTO_ID_ANALISE_CONTA = reaberto_id_analise_conta;
            this.REABERTO_DATA_ANALISE_CONTA = reaberto_data_analise_conta;
            this.AREA_ATUACAO = area_atuacao;
            this.TASK_FORCE = task_force;
            this.SEG_DESCR = seg_descr;
            this.PARCELAMENTO = parcelamento;
            this.CONTA_BONUS = conta_bonus;
            this.FORNECEDOR = fornecedor;
            this.REGRA_PDD = regra_pdd;
            this.PROVISAO = provisao;
            this.SITUACAO_SERVICO = situacao_servico;
            this.SALDO_FX_ENT_26 = saldo_fx_ent_26;
            this.SALDO_PDD_26 = saldo_pdd_26;
            this.SALDO_FX_ENT_30 = saldo_fx_ent_30;
            this.SALDO_PDD_30 = saldo_pdd_30;
            this.SALDO_FX_ENT_05 = saldo_fx_ent_05;
            this.SALDO_PDD_05 = saldo_pdd_05;
            this.SALDO_FX_ENT_14 = saldo_fx_ent_14;
            this.SALDO_PDD_14 = saldo_pdd_14;
            this.SALDO_FX_ENT_21 = saldo_fx_ent_21;
            this.SALDO_PDD_21 = saldo_pdd_21;
            this.SALDO_FX_ENT_25 = saldo_fx_ent_25;
            this.SALDO_PDD_25 = saldo_pdd_25;
            this.RECEBIVEL = recebivel;
        }
    }

    public class Segmento
    {
        public String PROCV { get; set; }
        public String ID { get; set; }
        public String NOME_ANALISTA { get; set; }
        //public String NOME_ANALISTA_TMP { get; set; }
        //public String NOME_LIDER { get; set; }
        public String FEEDBACK { get; set; }
        public String AREA_OFENSORA { get; set; }
        public String TIPO_PAGTO { get; set; }
        public String DT_PAGTO { get; set; }
        public String VALOR_PAGTO { get; set; }
        public String DT_AJUSTE { get; set; }
        public String VALOR_AJUSTADO { get; set; }
        public String RESUMO_EXECUTIVO_PROBLEMA { get; set; }
        public String RESUMO_EXECUTIVO_ACAO { get; set; }
        public String HISTORICO_DETALHADO { get; set; }
        public String DT_FOLLOW_UP { get; set; }
        public String DT_CONTATO { get; set; }
        public String RESPONSAVEL { get; set; }
        public String FAIXA_FORNECEDOR { get; set; }
        public String FAIXA_FECHO { get; set; }
        public String FAIXA_ARRECADA_INICIAL { get; set; }
        public String FAIXA_ARRECADA_ATUAL { get; set; }
        public String RAIZ_GRUPO { get; set; }
        public String GRUPO { get; set; }
        public String RAIZ { get; set; }
        public String CNPJ { get; set; }
        public String NOME { get; set; }
        public String NOME_CLIENTE { get; set; }
        public String TIPO { get; set; }
        public String EMPRESA { get; set; }
        public String CONTA { get; set; }
        public String TEL { get; set; }
        public String LOCAL { get; set; }
        public String TERMINAL { get; set; }
        public String DV { get; set; }
        public String NRC { get; set; }
        public String CLASSERV { get; set; }
        public String TITULO { get; set; }
        public String FILIAL { get; set; }
        public String LJ_CLI { get; set; }
        public String COD_CLI { get; set; }
        public String DOCUMENTO_SAP { get; set; }
        public String DOC_FAT { get; set; }
        public String N_DOC_DE_PARA_ATLYS { get; set; }
        public String NOTA_FISCAL { get; set; }
        public String VENC_ATUAL { get; set; }
        public String VENC_ORIGINAL { get; set; }
        public String DT_PROCESS { get; set; }
        public String ANOMES { get; set; }
        public String DIA_VENCIMENTO_LOTE { get; set; }
        public String NUMERO_LOTE { get; set; }
        public String VALOR_LOTE { get; set; }
        public String SALDO_CAR_26 { get; set; }
        public String SALDO_CAR_05 { get; set; }
        public String SALDO_CAR_30 { get; set; }
        public String SALDO_CAR_14 { get; set; }
        public String SALDO_CAR_21 { get; set; }
        public String SALDO_CAR_25 { get; set; }
        public String SALDO_TOTAL { get; set; }
        public String SOMA_FXE_PDD_26 { get; set; }
        public String SOMA_FXE_PDD_30 { get; set; }
        public String SOMA_FXE_PDD_05 { get; set; }
        public String SOMA_FXE_PDD_14 { get; set; }
        public String SOMA_FXE_PDD_21 { get; set; }
        public String SOMA_FXE_PDD_25 { get; set; }
        public String VALOR_PAGAMENTO { get; set; }
        public String VALOR_AJUSTE { get; set; }
        public String DT_ATRIB { get; set; }
        public String DTCORTE { get; set; }
        public String SALDO_ATUAL { get; set; }
        public String CICLO { get; set; }
        public String UF { get; set; }
        public String STATUS { get; set; }
        public String CLASSE { get; set; }
        public String SEGMENTO_GERENCIA { get; set; }
        public String GN { get; set; }
        public String GV { get; set; }
        public String DIRETOR { get; set; }
        public String ANALISTA_TLF_VIVO { get; set; }
        public String INTRAGOV { get; set; }
        public String INTERCOMPANY { get; set; }
        public String FEEDBACK_00 { get; set; }
        public String FEEDBACK_01 { get; set; }
        public String FEEDBACK_02 { get; set; }
        public String FEEDBACK_03 { get; set; }
        public String FEEDBACK_04 { get; set; }
        public String FEEDBACK_05 { get; set; }
        public String PENDENTE_ID_ANALISE_CONTA { get; set; }
        public String PENDENTE_DATA_ANALISE_CONTA { get; set; }
        public String CONCLUIDO_ID_ANALISE_CONTA { get; set; }
        public String CONCLUIDO_DATA_ANALISE_CONTA { get; set; }
        public String REABERTO_ID_ANALISE_CONTA { get; set; }
        public String REABERTO_DATA_ANALISE_CONTA { get; set; }
        public String QTD_REG_AGRUPADO { get; set; }
        public String DT_ULT_ALTERACAO { get; set; }
        public String USUARIO_ATUALIZACAO { get; set; }
        public String AREA_ATUACAO { get; set; }
        public String TASK_FORCE { get; set; }
        public String SEG_DESCR { get; set; }
        public String PARCELAMENTO { get; set; }
        public String CONTA_BONUS { get; set; }
        public String FORNECEDOR { get; set; }
        public String ESCALATION { get; set; }
        public String REGRA_PDD { get; set; }
        public String FAIXA_CORTE { get; set; }
        public String PROVISAO { get; set; }
        public String SITUACAO_SERVICO { get; set; }
        public String ENDERECO { get; set; }
        public String SALDO_FX_ENT_26 { get; set; }
        public String SALDO_PDD_26 { get; set; }
        public String SALDO_FX_ENT_30 { get; set; }
        public String SALDO_PDD_30 { get; set; }
        public String SALDO_FX_ENT_05 { get; set; }
        public String SALDO_PDD_05 { get; set; }
        public String SALDO_FX_ENT_14 { get; set; }
        public String SALDO_PDD_14 { get; set; }
        public String SALDO_FX_ENT_21 { get; set; }
        public String SALDO_PDD_21 { get; set; }
        public String SALDO_FX_ENT_25 { get; set; }
        public String SALDO_PDD_25 { get; set; }
        public String RECEBIVEL { get; set; }

        public Segmento
        (
        String procv
        , String id
        , String nome_analista
        //, String nome_analista_tmp
        //, String nome_lider
        , String feedback
        , String area_ofensora
        , String tipo_pagto
        , String dt_pagto
        , String valor_pagto
        , String dt_ajuste
        , String valor_ajustado
        , String resumo_executivo_problema
        , String resumo_executivo_acao
        , String historico_detalhado
        , String dt_follow_up
        , String dt_contato
        , String responsavel
        , String faixa_fornecedor
        , String faixa_fecho
        , String faixa_arrecada_inicial
        , String faixa_arrecada_atual
        , String raiz_grupo
        , String grupo
        , String raiz
        , String cnpj
        , String nome
        , String nome_cliente
        , String tipo
        , String empresa
        , String conta
        , String tel
        , String local
        , String terminal
        , String dv
        , String nrc
        , String classerv
        , String titulo
        , String filial
        , String lj_cli
        , String cod_cli
        , String documento_sap
        , String doc_fat
        , String n_doc_de_para_atlys
        , String nota_fiscal
        , String venc_atual
        , String venc_original
        , String dt_process
        , String anomes
        , String dia_vencimento_lote
        , String numero_lote
        , String valor_lote
        , String saldo_car_26
        , String saldo_car_05
        , String saldo_car_30
        , String saldo_car_14
        , String saldo_car_21
        , String saldo_car_25
        , String saldo_total
        , String soma_fxe_pdd_26
        , String soma_fxe_pdd_30
        , String soma_fxe_pdd_05
        , String soma_fxe_pdd_14
        , String soma_fxe_pdd_21
        , String soma_fxe_pdd_25
        , String valor_pagamento
        , String valor_ajuste
        , String dt_atrib
        , String dtcorte
        , String saldo_atual
        , String ciclo
        , String uf
        , String status
        , String classe
        , String segmento_gerencia
        , String gn
        , String gv
        , String diretor
        , String analista_tlf_vivo
        , String intragov
        , String intercompany
        , String feedback_00
        , String feedback_01
        , String feedback_02
        , String feedback_03
        , String feedback_04
        , String feedback_05
        , String pendente_id_analise_conta
        , String pendente_data_analise_conta
        , String concluido_id_analise_conta
        , String concluido_data_analise_conta
        , String reaberto_id_analise_conta
        , String reaberto_data_analise_conta
        , String qtd_reg_agrupado
        , String dt_ult_alteracao
        , String usuario_atualizacao
        , String area_atuacao
        , String task_force
        , String seg_descr
        , String parcelamento
        , String conta_bonus
        , String fornecedor
        , String escalation
        , String regra_pdd
        , String faixa_corte
        , String provisao
        , String situacao_servico
        , String endereco
        , String saldo_fx_ent_26
        , String saldo_pdd_26
        , String saldo_fx_ent_30
        , String saldo_pdd_30
        , String saldo_fx_ent_05
        , String saldo_pdd_05
        , String saldo_fx_ent_14
        , String saldo_pdd_14
        , String saldo_fx_ent_21
        , String saldo_pdd_21
        , String saldo_fx_ent_25
        , String saldo_pdd_25
        , String recebivel
        )
        {
            this.PROCV = procv;
            this.ID = id;
            this.NOME_ANALISTA = nome_analista;
            //this.NOME_ANALISTA_TMP = nome_analista_tmp;
            //this.NOME_LIDER = nome_lider;
            this.FEEDBACK = feedback;
            this.AREA_OFENSORA = area_ofensora;
            this.TIPO_PAGTO = tipo_pagto;
            this.DT_PAGTO = dt_pagto;
            this.VALOR_PAGTO = valor_pagto;
            this.DT_AJUSTE = dt_ajuste;
            this.VALOR_AJUSTADO = valor_ajustado;
            this.RESUMO_EXECUTIVO_PROBLEMA = resumo_executivo_problema;
            this.RESUMO_EXECUTIVO_ACAO = resumo_executivo_acao;
            this.HISTORICO_DETALHADO = historico_detalhado;
            this.DT_FOLLOW_UP = dt_follow_up;
            this.DT_CONTATO = dt_contato;
            this.RESPONSAVEL = responsavel;
            this.FAIXA_FORNECEDOR = faixa_fornecedor;
            this.FAIXA_FECHO = faixa_fecho;
            this.FAIXA_ARRECADA_INICIAL = faixa_arrecada_inicial;
            this.FAIXA_ARRECADA_ATUAL = faixa_arrecada_atual;
            this.RAIZ_GRUPO = raiz_grupo;
            this.GRUPO = grupo;
            this.RAIZ = raiz;
            this.CNPJ = cnpj;
            this.NOME = nome;
            this.NOME_CLIENTE = nome_cliente;
            this.TIPO = tipo;
            this.EMPRESA = empresa;
            this.CONTA = conta;
            this.TEL = tel;
            this.LOCAL = local;
            this.TERMINAL = terminal;
            this.DV = dv;
            this.NRC = nrc;
            this.CLASSERV = classerv;
            this.TITULO = titulo;
            this.FILIAL = filial;
            this.LJ_CLI = lj_cli;
            this.COD_CLI = cod_cli;
            this.DOCUMENTO_SAP = documento_sap;
            this.DOC_FAT = doc_fat;
            this.N_DOC_DE_PARA_ATLYS = n_doc_de_para_atlys;
            this.NOTA_FISCAL = nota_fiscal;
            this.VENC_ATUAL = venc_atual;
            this.VENC_ORIGINAL = venc_original;
            this.DT_PROCESS = dt_process;
            this.ANOMES = anomes;
            this.DIA_VENCIMENTO_LOTE = dia_vencimento_lote;
            this.NUMERO_LOTE = numero_lote;
            this.VALOR_LOTE = valor_lote;
            this.SALDO_CAR_26 = saldo_car_26;
            this.SALDO_CAR_05 = saldo_car_05;
            this.SALDO_CAR_30 = saldo_car_30;
            this.SALDO_CAR_14 = saldo_car_14;
            this.SALDO_CAR_21 = saldo_car_21;
            this.SALDO_CAR_25 = saldo_car_25;
            this.SALDO_TOTAL = saldo_total;
            this.SOMA_FXE_PDD_26 = soma_fxe_pdd_26;
            this.SOMA_FXE_PDD_30 = soma_fxe_pdd_30;
            this.SOMA_FXE_PDD_05 = soma_fxe_pdd_05;
            this.SOMA_FXE_PDD_14 = soma_fxe_pdd_14;
            this.SOMA_FXE_PDD_21 = soma_fxe_pdd_21;
            this.SOMA_FXE_PDD_25 = soma_fxe_pdd_25;
            this.VALOR_PAGAMENTO = valor_pagamento;
            this.VALOR_AJUSTE = valor_ajuste;
            this.DT_ATRIB = dt_atrib;
            this.DTCORTE = dtcorte;
            this.SALDO_ATUAL = saldo_atual;
            this.CICLO = ciclo;
            this.UF = uf;
            this.STATUS = status;
            this.CLASSE = classe;
            this.SEGMENTO_GERENCIA = segmento_gerencia;
            this.GN = gn;
            this.GV = gv;
            this.DIRETOR = diretor;
            this.ANALISTA_TLF_VIVO = analista_tlf_vivo;
            this.INTRAGOV = intragov;
            this.INTERCOMPANY = intercompany;
            this.FEEDBACK_00 = feedback_00;
            this.FEEDBACK_01 = feedback_01;
            this.FEEDBACK_02 = feedback_02;
            this.FEEDBACK_03 = feedback_03;
            this.FEEDBACK_04 = feedback_04;
            this.FEEDBACK_05 = feedback_05;
            this.PENDENTE_ID_ANALISE_CONTA = pendente_id_analise_conta;
            this.PENDENTE_DATA_ANALISE_CONTA = pendente_data_analise_conta;
            this.CONCLUIDO_ID_ANALISE_CONTA = concluido_id_analise_conta;
            this.CONCLUIDO_DATA_ANALISE_CONTA = concluido_data_analise_conta;
            this.REABERTO_ID_ANALISE_CONTA = reaberto_id_analise_conta;
            this.REABERTO_DATA_ANALISE_CONTA = reaberto_data_analise_conta;
            this.QTD_REG_AGRUPADO = qtd_reg_agrupado;
            this.DT_ULT_ALTERACAO = dt_ult_alteracao;
            this.USUARIO_ATUALIZACAO = usuario_atualizacao;
            this.AREA_ATUACAO = area_atuacao;
            this.TASK_FORCE = task_force;
            this.SEG_DESCR = seg_descr;
            this.PARCELAMENTO = parcelamento;
            this.CONTA_BONUS = conta_bonus;
            this.FORNECEDOR = fornecedor;
            this.ESCALATION = escalation;
            this.REGRA_PDD = regra_pdd;
            this.FAIXA_CORTE = faixa_corte;
            this.PROVISAO = provisao;
            this.SITUACAO_SERVICO = situacao_servico;
            this.ENDERECO = endereco;
            this.SALDO_FX_ENT_26 = saldo_fx_ent_26;
            this.SALDO_PDD_26 = saldo_pdd_26;
            this.SALDO_FX_ENT_30 = saldo_fx_ent_30;
            this.SALDO_PDD_30 = saldo_pdd_30;
            this.SALDO_FX_ENT_05 = saldo_fx_ent_05;
            this.SALDO_PDD_05 = saldo_pdd_05;
            this.SALDO_FX_ENT_14 = saldo_fx_ent_14;
            this.SALDO_PDD_14 = saldo_pdd_14;
            this.SALDO_FX_ENT_21 = saldo_fx_ent_21;
            this.SALDO_PDD_21 = saldo_pdd_21;
            this.SALDO_FX_ENT_25 = saldo_fx_ent_25;
            this.SALDO_PDD_25 = saldo_pdd_25;
            this.RECEBIVEL = recebivel;
        }


    }

    class Acordos
    {

        // propriedades
        private String _procv;
        private String _id;
        private String _nome_analista;
        private String _nome_analista_tmp;
        private String _feedback;
        private String _area_ofensora;
        private String _tipo_pagto;
        private String _dt_pagto;
        private String _valor_pagto;
        private String _dt_ajuste;
        private String _valor_ajustado;
        private String _resumo_executivo_acao;
        private String _resumo_executivo_problema;
        private String _historico_detalhado;
        private String _dt_follow_up;
        private String _dt_encerramento;
        private String _dt_contato;
        private String _responsavel;
        private String _faixa_fornecedor;
        private String _faixa_fecho;
        private String _faixa_arrecada_inicial;
        private String _faixa_arrecada_atual;
        private String _raiz_grupo;
        private String _grupo;
        private String _raiz;
        private String _cnpj;
        private String _nome;
        private String _nome_cliente;
        private String _tipo;
        private String _empresa;
        private String _conta;
        private String _tel;
        private String _local;
        private String _terminal;
        private String _dv;
        private String _nrc;
        private String _classerv;
        private String _titulo;
        private String _filial;
        private String _lj_cli;
        private String _cod_cli;
        private String _documento_sap;
        private String _doc_fat;
        private String _n_doc_de_para_atlys;
        private String _nota_fiscal;
        private String _venc_atual;
        private String _venc_original;
        private String _dt_process;
        private String _anomes;
        private String _dia_vencimento_lote;
        private String _numero_lote;
        private String _valor_lote;
        private String _saldo_car_26;
        private String _saldo_car_30;
        private String _saldo_car_05;
        private String _saldo_car_14;
        private String _saldo_car_21;
        private String _saldo_car_25;
        private String _saldo_total;
        private String _soma_fxe_pdd_26;
        private String _soma_fxe_pdd_30;
        private String _soma_fxe_pdd_05;
        private String _soma_fxe_pdd_14;
        private String _soma_fxe_pdd_21;
        private String _soma_fxe_pdd_25;
        private String _valor_pagamento;
        private String _valor_ajuste;
        private String _saldo_atual;
        private String _ciclo;
        private String _uf;
        private String _status;
        private String _classe;
        private String _segmento_gerencia;
        private String _gn;
        private String _gv;
        private String _diretor;
        private String _analista_tlf_vivo;
        private String _intragov;
        private String _intercompany;
        private String _feedback_00;
        private String _feedback_01;
        private String _feedback_02;
        private String _feedback_03;
        private String _feedback_04;
        private String _feedback_05;
        private String _pendente_id_analise_conta;
        private String _pendente_data_analise_conta;
        private String _concluido_id_analise_conta;
        private String _concluido_data_analise_conta;
        private String _reaberto_id_analise_conta;
        private String _reaberto_data_analise_conta;
        private String _qtd_reg_agrupado;
        private String _dt_ult_alteracao;
        private String _usuario_atualizacao;
        private String _id_analista;
        private String _id_analista_tmp;
        private String _area_atuacao;
        private String _task_force;
        private String _seg_descr;
        private String _parcelamento;
        private String _escalation;
        private String _conta_bonus;
        private String _obs;
        private String _id_portal_demanda;
        private String _Faixa_Corte;
        private String _Regra_PDD;
        private String _SITUACAO_SERVICO;


        // métodos // contrutor
        public Acordos(
                String procv
                , String id
                , String nome_analista
                , String nome_analista_tmp
                , String feedback
                , String area_ofensora
                , String tipo_pagto
                , String dt_pagto
                , String valor_pagto
                , String dt_ajuste
                , String valor_ajustado
                , String resumo_executivo_acao
                , String resumo_executivo_problema
                , String historico_detalhado
                , String dt_follow_up
                , String dt_encerramento
                , String dt_contato
                , String responsavel
                , String faixa_fornecedor
                , String faixa_fecho
                , String faixa_arrecada_inicial
                , String faixa_arrecada_atual
                , String raiz_grupo
                , String grupo
                , String raiz
                , String cnpj
                , String nome
                , String nome_cliente
                , String tipo
                , String empresa
                , String conta
                , String tel
                , String local
                , String terminal
                , String dv
                , String nrc
                , String classerv
                , String titulo
                , String filial
                , String lj_cli
                , String cod_cli
                , String documento_sap
                , String doc_fat
                , String n_doc_de_para_atlys
                , String nota_fiscal
                , String venc_atual
                , String venc_original
                , String dt_process
                , String anomes
                , String dia_vencimento_lote
                , String numero_lote
                , String valor_lote
                , String saldo_car_26
                , String saldo_car_30
                , String saldo_car_05
                , String saldo_car_14
                , String saldo_car_21
                , String saldo_car_25
                , String saldo_total
                , String soma_fxe_pdd_26
                , String soma_fxe_pdd_30
                , String soma_fxe_pdd_05
                , String soma_fxe_pdd_14
                , String soma_fxe_pdd_21
                , String soma_fxe_pdd_25
                , String valor_pagamento
                , String valor_ajuste
                , String saldo_atual
                , String ciclo
                , String uf
                , String status
                , String classe
                , String segmento_gerencia
                , String gn
                , String gv
                , String diretor
                , String analista_tlf_vivo
                , String intragov
                , String intercompany
                , String feedback_00
                , String feedback_01
                , String feedback_02
                , String feedback_03
                , String feedback_04
                , String feedback_05
                , String pendente_id_analise_conta
                , String pendente_data_analise_conta
                , String concluido_id_analise_conta
                , String concluido_data_analise_conta
                , String reaberto_id_analise_conta
                , String reaberto_data_analise_conta
                , String qtd_reg_agrupado
                , String dt_ult_alteracao
                , String usuario_atualizacao
                , String id_analista
                , String id_analista_tmp
                , String area_atuacao
                , String task_force
                , String seg_descr
                , String parcelamento
                , String escalation
                , String conta_bonus
                , String obs
                , String id_portal_demanda
                , String faixa_corte
                , String regra_pdd
                , String situacao_servico


            )
        {
            this._procv = procv;
            this._id = id;
            this._nome_analista = nome_analista;
            this._nome_analista_tmp = nome_analista_tmp;
            this._feedback = feedback;
            this._area_ofensora = area_ofensora;
            this._tipo_pagto = tipo_pagto;
            this._dt_pagto = dt_pagto;
            this._valor_pagto = valor_pagto;
            this._dt_ajuste = dt_ajuste;
            this._valor_ajustado = valor_ajustado;
            this._resumo_executivo_acao = resumo_executivo_acao;
            this._resumo_executivo_problema = resumo_executivo_problema;
            this._historico_detalhado = historico_detalhado;
            this._dt_follow_up = dt_follow_up;
            this._dt_encerramento = dt_encerramento;
            this._dt_contato = dt_contato;
            this._responsavel = responsavel;
            this._faixa_fornecedor = faixa_fornecedor;
            this._faixa_fecho = faixa_fecho;
            this._faixa_arrecada_inicial = faixa_arrecada_inicial;
            this._faixa_arrecada_atual = faixa_arrecada_atual;
            this._raiz_grupo = raiz_grupo;
            this._grupo = grupo;
            this._raiz = raiz;
            this._cnpj = cnpj;
            this._nome = nome;
            this._nome_cliente = nome_cliente;
            this._tipo = tipo;
            this._empresa = empresa;
            this._conta = conta;
            this._tel = tel;
            this._local = local;
            this._terminal = terminal;
            this._dv = dv;
            this._nrc = nrc;
            this._classerv = classerv;
            this._titulo = titulo;
            this._filial = filial;
            this._lj_cli = lj_cli;
            this._cod_cli = cod_cli;
            this._documento_sap = documento_sap;
            this._doc_fat = doc_fat;
            this._n_doc_de_para_atlys = n_doc_de_para_atlys;
            this._nota_fiscal = nota_fiscal;
            this._venc_atual = venc_atual;
            this._venc_original = venc_original;
            this._dt_process = dt_process;
            this._anomes = anomes;
            this._dia_vencimento_lote = dia_vencimento_lote;
            this._numero_lote = numero_lote;
            this._valor_lote = valor_lote;
            this._saldo_car_26 = saldo_car_26;
            this._saldo_car_30 = saldo_car_30;
            this._saldo_car_05 = saldo_car_05;
            this._saldo_car_14 = saldo_car_14;
            this._saldo_car_21 = saldo_car_21;
            this._saldo_car_25 = saldo_car_25;
            this._saldo_total = saldo_total;
            this._soma_fxe_pdd_26 = soma_fxe_pdd_26;
            this._soma_fxe_pdd_30 = soma_fxe_pdd_30;
            this._soma_fxe_pdd_05 = soma_fxe_pdd_05;
            this._soma_fxe_pdd_14 = soma_fxe_pdd_14;
            this._soma_fxe_pdd_21 = soma_fxe_pdd_21;
            this._soma_fxe_pdd_25 = soma_fxe_pdd_25;
            this._valor_pagamento = valor_pagamento;
            this._valor_ajuste = valor_ajuste;
            this._saldo_atual = saldo_atual;
            this._ciclo = ciclo;
            this._uf = uf;
            this._status = status;
            this._classe = classe;
            this._segmento_gerencia = segmento_gerencia;
            this._gn = gn;
            this._gv = gv;
            this._diretor = diretor;
            this._analista_tlf_vivo = analista_tlf_vivo;
            this._intragov = intragov;
            this._intercompany = intercompany;
            this._feedback_00 = feedback_00;
            this._feedback_01 = feedback_01;
            this._feedback_02 = feedback_02;
            this._feedback_03 = feedback_03;
            this._feedback_04 = feedback_04;
            this._feedback_05 = feedback_05;
            this._pendente_id_analise_conta = pendente_id_analise_conta;
            this._pendente_data_analise_conta = pendente_data_analise_conta;
            this._concluido_id_analise_conta = concluido_id_analise_conta;
            this._concluido_data_analise_conta = concluido_data_analise_conta;
            this._reaberto_id_analise_conta = reaberto_id_analise_conta;
            this._reaberto_data_analise_conta = reaberto_data_analise_conta;
            this._qtd_reg_agrupado = qtd_reg_agrupado;
            this._dt_ult_alteracao = dt_ult_alteracao;
            this._usuario_atualizacao = usuario_atualizacao;
            this._id_analista = id_analista;
            this._id_analista_tmp = id_analista_tmp;
            this._area_atuacao = area_atuacao;
            this._task_force = task_force;
            this._seg_descr = seg_descr;
            this._parcelamento = parcelamento;
            this._escalation = escalation;
            this._conta_bonus = conta_bonus;
            this._obs = obs;
            this._id_portal_demanda = id_portal_demanda;
            this._Faixa_Corte = faixa_corte;
            this._Regra_PDD = regra_pdd;
            this._SITUACAO_SERVICO = situacao_servico;


        }

        // métodos 
        public String procv { get { return _procv; } }
        public String id { get { return _id; } }
        public String nome_analista { get { return _nome_analista; } }
        public String nome_analista_tmp { get { return _nome_analista_tmp; } }
        public String feedback { get { return _feedback; } }
        public String area_ofensora { get { return _area_ofensora; } }
        public String tipo_pagto { get { return _tipo_pagto; } }
        public String dt_pagto { get { return _dt_pagto; } }
        public String valor_pagto { get { return _valor_pagto; } }
        public String dt_ajuste { get { return _dt_ajuste; } }
        public String valor_ajustado { get { return _valor_ajustado; } }
        public String resumo_executivo_acao { get { return _resumo_executivo_acao; } }
        public String resumo_executivo_problema { get { return _resumo_executivo_problema; } }
        public String historico_detalhado { get { return _historico_detalhado; } }
        public String dt_follow_up { get { return _dt_follow_up; } }
        public String dt_encerramento { get { return _dt_encerramento; } }
        public String dt_contato { get { return _dt_contato; } }
        public String responsavel { get { return _responsavel; } }
        public String faixa_fornecedor { get { return _faixa_fornecedor; } }
        public String faixa_fecho { get { return _faixa_fecho; } }
        public String faixa_arrecada_inicial { get { return _faixa_arrecada_inicial; } }
        public String faixa_arrecada_atual { get { return _faixa_arrecada_atual; } }
        public String raiz_grupo { get { return _raiz_grupo; } }
        public String grupo { get { return _grupo; } }
        public String raiz { get { return _raiz; } }
        public String cnpj { get { return _cnpj; } }
        public String nome { get { return _nome; } }
        public String nome_cliente { get { return _nome_cliente; } }
        public String tipo { get { return _tipo; } }
        public String empresa { get { return _empresa; } }
        public String conta { get { return _conta; } }
        public String tel { get { return _tel; } }
        public String local { get { return _local; } }
        public String terminal { get { return _terminal; } }
        public String dv { get { return _dv; } }
        public String nrc { get { return _nrc; } }
        public String classerv { get { return _classerv; } }
        public String titulo { get { return _titulo; } }
        public String filial { get { return _filial; } }
        public String lj_cli { get { return _lj_cli; } }
        public String cod_cli { get { return _cod_cli; } }
        public String documento_sap { get { return _documento_sap; } }
        public String doc_fat { get { return _doc_fat; } }
        public String n_doc_de_para_atlys { get { return _n_doc_de_para_atlys; } }
        public String nota_fiscal { get { return _nota_fiscal; } }
        public String venc_atual { get { return _venc_atual; } }
        public String venc_original { get { return _venc_original; } }
        public String dt_process { get { return _dt_process; } }
        public String anomes { get { return _anomes; } }
        public String dia_vencimento_lote { get { return _dia_vencimento_lote; } }
        public String numero_lote { get { return _numero_lote; } }
        public String valor_lote { get { return _valor_lote; } }
        public String saldo_car_26 { get { return _saldo_car_26; } }
        public String saldo_car_30 { get { return _saldo_car_30; } }
        public String saldo_car_05 { get { return _saldo_car_05; } }
        public String saldo_car_14 { get { return _saldo_car_14; } }
        public String saldo_car_21 { get { return _saldo_car_21; } }
        public String saldo_car_25 { get { return _saldo_car_25; } }
        public String saldo_total { get { return _saldo_total; } }
        public String soma_fxe_pdd_26 { get { return _soma_fxe_pdd_26; } }
        public String soma_fxe_pdd_30 { get { return _soma_fxe_pdd_30; } }
        public String soma_fxe_pdd_05 { get { return _soma_fxe_pdd_05; } }
        public String soma_fxe_pdd_14 { get { return _soma_fxe_pdd_14; } }
        public String soma_fxe_pdd_21 { get { return _soma_fxe_pdd_21; } }
        public String soma_fxe_pdd_25 { get { return _soma_fxe_pdd_25; } }
        public String valor_pagamento { get { return _valor_pagamento; } }
        public String valor_ajuste { get { return _valor_ajuste; } }
        public String saldo_atual { get { return _saldo_atual; } }
        public String ciclo { get { return _ciclo; } }
        public String uf { get { return _uf; } }
        public String status { get { return _status; } }
        public String classe { get { return _classe; } }
        public String segmento_gerencia { get { return _feedback; } }
        public String gn { get { return _gn; } }
        public String gv { get { return _gv; } }
        public String diretor { get { return _diretor; } }
        public String analista_tlf_vivo { get { return _analista_tlf_vivo; } }
        public String intragov { get { return _intragov; } }
        public String intercompany { get { return _intercompany; } }
        public String feedback_00 { get { return _feedback_00; } }
        public String feedback_01 { get { return _feedback; } }
        public String feedback_02 { get { return _feedback_02; } }
        public String feedback_03 { get { return _feedback_03; } }
        public String feedback_04 { get { return _feedback_04; } }
        public String feedback_05 { get { return _feedback_05; } }
        public String pendente_id_analise_conta { get { return _pendente_id_analise_conta; } }
        public String pendente_data_analise_conta { get { return _pendente_data_analise_conta; } }
        public String concluido_id_analise_conta { get { return _concluido_id_analise_conta; } }
        public String concluido_data_analise_conta { get { return _concluido_data_analise_conta; } }
        public String reaberto_id_analise_conta { get { return _reaberto_id_analise_conta; } }
        public String reaberto_data_analise_conta { get { return _reaberto_data_analise_conta; } }
        public String qtd_reg_agrupado { get { return _qtd_reg_agrupado; } }
        public String dt_ult_alteracao { get { return _dt_ult_alteracao; } }
        public String usuario_atualizacao { get { return _usuario_atualizacao; } }
        public String id_analista { get { return _id_analista; } }
        public String id_analista_tmp { get { return _id_analista_tmp; } }
        public String area_atuacao { get { return _feedback; } }
        public String task_force { get { return _task_force; } }
        public String seg_descr { get { return _seg_descr; } }
        public String parcelamento { get { return _parcelamento; } }
        public String escalation { get { return _escalation; } }
        public String conta_bonus { get { return _feedback; } }
        public String obs { get { return _obs; } }
        public String id_portal_demanda { get { return _id_portal_demanda; } }
        public String faixa_Corte { get { return _Faixa_Corte; } }
        public String regra_pdd { get { return _Regra_PDD; } }
        public String situacao_servico { get { return _SITUACAO_SERVICO; } }
    }

    class Program
    {


        Excel.Application oApp;
        Excel.Worksheet oSheet;
        Excel.Workbook oBook;

        static int Main(string[] args) //string[] args
        {

            //String texto = "c:\\tmp\\fileName.xml"; Console.WriteLine(texto.Substring(0, texto.Length - 3) + "7z");

            #region CRIAR_ARQUIVO
            // variaveis
            //string sSQL = "SELECT * FROM [DB_SISCOB].[transito].[tmp_VW_RELATORIO_WEB_MIS_VPE_FIXA_SIM]";
            //string sSQL = "SELECT [PROCV],[ID],[NOME_ANALISTA],[NOME_ANALISTA_TMP],[NOME_LIDER],[FEEDBACK],[AREA_OFENSORA],[TIPO_PAGTO],[DT_PAGTO],[VALOR_PAGTO],[DT_AJUSTE],[VALOR_AJUSTADO],[RESUMO_EXECUTIVO_PROBLEMA],[RESUMO_EXECUTIVO_ACAO],[DT_FOLLOW_UP],[DT_CONTATO],[RESPONSAVEL],[FAIXA_FORNECEDOR],[FAIXA_FECHO],[FAIXA_ARRECADA_INICIAL],[FAIXA_ARRECADA_ATUAL],[RAIZ_GRUPO],[GRUPO],[RAIZ],[CNPJ],[NOME],[NOME_CLIENTE],[TIPO],[EMPRESA],[CONTA],[TEL],[LOCAL],[TERMINAL],[DV],[NRC],[CLASSERV],[TITULO],[FILIAL],[LJ_CLI],[COD_CLI],[DOCUMENTO_SAP],[DOC_FAT],[N_DOC_DE_PARA_ATLYS],[NOTA_FISCAL],[VENC_ATUAL],[VENC_ORIGINAL],[DT_PROCESS],[ANOMES],[DIA_VENCIMENTO_LOTE],[NUMERO_LOTE],[VALOR_LOTE],[SALDO_CAR_26],[SALDO_CAR_05],[SALDO_CAR_30],[SALDO_CAR_14],[SALDO_CAR_21],[SALDO_CAR_25],[SALDO_TOTAL],[SOMA_FXE_PDD_26],[SOMA_FXE_PDD_30],[SOMA_FXE_PDD_05],[SOMA_FXE_PDD_14],[SOMA_FXE_PDD_21],[SOMA_FXE_PDD_25],[VALOR_PAGAMENTO],[VALOR_AJUSTE],[dt_atrib],[DTCORTE],[SALDO_ATUAL],[CICLO],[UF],[STATUS],[CLASSE],[SEGMENTO_GERENCIA],[GN],[GV],[DIRETOR],[ANALISTA_TLF_VIVO],[INTRAGOV],[INTERCOMPANY],[FEEDBACK_00],[FEEDBACK_01],[FEEDBACK_02],[FEEDBACK_03],[FEEDBACK_04],[FEEDBACK_05],[PENDENTE_ID_ANALISE_CONTA],[PENDENTE_DATA_ANALISE_CONTA],[CONCLUIDO_ID_ANALISE_CONTA],[CONCLUIDO_DATA_ANALISE_CONTA],[REABERTO_ID_ANALISE_CONTA],[REABERTO_DATA_ANALISE_CONTA],[QTD_REG_AGRUPADO],[DT_ULT_ALTERACAO],[USUARIO_ATUALIZACAO],[AREA_ATUACAO],[TASK_FORCE],[SEG_DESCR],[PARCELAMENTO],[CONTA_BONUS],[FORNECEDOR],[ESCALATION],[REGRA_PDD],[FAIXA_CORTE],[PROVISAO],[SITUACAO_SERVICO],[ENDERECO],[SALDO_FX_ENT_26],[SALDO_PDD_26],[SALDO_FX_ENT_30],[SALDO_PDD_30],[SALDO_FX_ENT_05],[SALDO_PDD_05],[SALDO_FX_ENT_14],[SALDO_PDD_14],[SALDO_FX_ENT_21],[SALDO_PDD_21],[SALDO_FX_ENT_25],[SALDO_PDD_25],[RECEBIVEL] FROM [DB_SISCOB].[TRANSITO].[tmp_VW_RELATORIO_WEB_MIS_VPE_FIXA_SIM]";
            //string sSQL = "SELECT top 1 [QUERY_RESUMO] FROM [APP_WEB].[TBL_ARQUIVOS_TRANSITO_ACORDOS] where id = 603 ORDER BY ID DESC";
            //bco.arquivoCriarXml(sPath + "\\4040432544.xml");
            //bco.arquivoCompactar(@"C:\tmp\OneDrive\_wkspace\App\7-ZipPortable\App\7-Zip\7zG.exe", sPath + "\\4040432544.xml", sPath + "\\4040432544.7z");
            //bco.Fechar();

            List<string> lstRegistro;
            long contador = 0;
            long acumulador = 0;

            string sPath = System.IO.Directory.GetCurrentDirectory();
            string sSQL = "SELECT top 100 * FROM [APP_EXCEL].[VW_CONSUMO_CONSOLIDADO_ACORDO_COM_FILTROS] WHERE RAIZ_GRUPO = '4040432544'  and ID_TIPO IN (1,2,4,5,9)";
            Banco bco = new Banco();
            bco.Selecao(sSQL);

            // carregar cabecalho
            List<string> lstCabecalho = new List<string>(); for (int i = 0; i < bco.Rdr.FieldCount; i++) { lstCabecalho.Add(bco.Rdr.GetName(i).ToString()); }
            Console.WriteLine(@" >>> LISTAR CABECALHOS - OK");

            // criar arquivo
            using (XmlWriter writer = XmlWriter.Create(sPath + "\\4040432544.xml"))
            {
                writer.WriteStartDocument(); writer.WriteStartElement("Registros"); // inicio do documento
                while (bco.Rdr.Read()) // listar registros
                {
                    contador++; acumulador++; lstRegistro = new List<string>(); // variaveis
                    writer.WriteStartElement("Registro"); // inicio do elemento

                    for (int i = 0; i < bco.Rdr.FieldCount; i++)
                    {
                        writer.WriteElementString(lstCabecalho[i].ToString(), CleanInvalidXmlChars(bco.Rdr[i].ToString()));
                    } // escrita do registro

                    writer.WriteEndElement(); // terminio do elemento
                    if (contador > 10000) { Console.WriteLine(acumulador + @" >>> registro criados - OK"); contador = 0; } // mostrar evolução do processo 
                }
                writer.WriteEndElement(); writer.WriteEndDocument();
            }
            Console.WriteLine(@" >>> CRIAR ARQUIVO - OK");

            #endregion




            #region Compactacao

            //string sourceName = @"C:\Users\a.dasilva\Desktop\_FOCO\tmp\SEGMENTO_VPE.mdb";
            //string targetName = @"C:\Users\a.dasilva\Desktop\_FOCO\tmp\170410_1429_SEGMENTO_VPE.7z";
            //ProcessStartInfo p = new ProcessStartInfo();
            //p.FileName = @"C:\tmp\OneDrive\_wkspace\App\7-ZipPortable\App\7-Zip\7zG.exe";
            //p.Arguments = "a \"" + targetName + "\" \"" + sourceName + "\" -mx=9";
            //p.WindowStyle = ProcessWindowStyle.Hidden;
            //Process x = Process.Start(p);
            //x.WaitForExit();

            #endregion


            #region ACORDOS

            //Banco bco = new Banco();
            //bco.carregarSolicitacao(args[0]);
            //Program carregarDados = new Program();
            //carregarDados.CarregarAcordos(lstCn, bco.Solicitacao);
            //carregarDados.CarregarAcordos(lstCn, sSQL);

            #endregion


            #region SEGMENTOS

            //List<report_segmento> lstCn = new List<report_segmento>();
            //string sSQL = "SELECT * FROM [DB_SISCOB].[APP_EXCEL].[VW_RELATORIO_WEB_MIS_SEGMENTO_VPE] ";
            //string tmpPath = sPath + "\\SEGMENTO_MODELO.xlsx";
            //carregarDados.CarregarSegmentos(lstCn, sSQL);
            //carregarDados.carregarXML(lstCn, tmpPath);
            //carregarDados.carregarXlsm(lstCn, tmpPath);

            #endregion







            Console.WriteLine(@" >>> FECHAR BANCO - OK");
            Console.ReadKey();

            return 1;

        }



        private void carregarXlsm(List<report_segmento> lstCn, string fileName)
        {


            long R = 1;

            oApp = new Excel.Application();
            oBook = oApp.Workbooks.Add();
            oSheet = oBook.Worksheets[1];
            oSheet.Name = "Dados";


            foreach (report_segmento cn in lstCn)
            {
                oSheet.Cells[R, 1] = CleanInvalidXmlChars(cn.PROCV);
                oSheet.Cells[R, 2] = CleanInvalidXmlChars(cn.ID);
                oSheet.Cells[R, 3] = CleanInvalidXmlChars(cn.NOME_ANALISTA);
                oSheet.Cells[R, 4] = CleanInvalidXmlChars(cn.FEEDBACK);
                oSheet.Cells[R, 5] = CleanInvalidXmlChars(cn.AREA_OFENSORA);
                oSheet.Cells[R, 6] = CleanInvalidXmlChars(cn.TIPO_PAGTO);
                oSheet.Cells[R, 7] = CleanInvalidXmlChars(cn.DT_PAGTO);
                oSheet.Cells[R, 8] = CleanInvalidXmlChars(cn.VALOR_PAGTO);
                oSheet.Cells[R, 9] = CleanInvalidXmlChars(cn.DT_AJUSTE);
                oSheet.Cells[R, 10] = CleanInvalidXmlChars(cn.VALOR_AJUSTADO);
                oSheet.Cells[R, 11] = CleanInvalidXmlChars(cn.RESUMO_EXECUTIVO_PROBLEMA);
                oSheet.Cells[R, 12] = CleanInvalidXmlChars(cn.RESUMO_EXECUTIVO_ACAO);
                oSheet.Cells[R, 13] = CleanInvalidXmlChars(cn.DT_FOLLOW_UP);
                oSheet.Cells[R, 14] = CleanInvalidXmlChars(cn.DT_CONTATO);
                oSheet.Cells[R, 15] = CleanInvalidXmlChars(cn.RESPONSAVEL);
                oSheet.Cells[R, 16] = CleanInvalidXmlChars(cn.FAIXA_FORNECEDOR);
                oSheet.Cells[R, 17] = CleanInvalidXmlChars(cn.FAIXA_FECHO);
                oSheet.Cells[R, 18] = CleanInvalidXmlChars(cn.FAIXA_ARRECADA_INICIAL);
                oSheet.Cells[R, 19] = CleanInvalidXmlChars(cn.FAIXA_ARRECADA_ATUAL);
                oSheet.Cells[R, 20] = CleanInvalidXmlChars(cn.RAIZ_GRUPO);
                oSheet.Cells[R, 21] = CleanInvalidXmlChars(cn.GRUPO);
                oSheet.Cells[R, 22] = CleanInvalidXmlChars(cn.RAIZ);
                oSheet.Cells[R, 23] = CleanInvalidXmlChars(cn.CNPJ);
                oSheet.Cells[R, 24] = CleanInvalidXmlChars(cn.NOME);
                oSheet.Cells[R, 25] = CleanInvalidXmlChars(cn.NOME_CLIENTE);
                oSheet.Cells[R, 26] = CleanInvalidXmlChars(cn.TIPO);
                oSheet.Cells[R, 27] = CleanInvalidXmlChars(cn.EMPRESA);
                oSheet.Cells[R, 28] = CleanInvalidXmlChars(cn.CONTA);
                oSheet.Cells[R, 29] = CleanInvalidXmlChars(cn.TEL);
                oSheet.Cells[R, 30] = CleanInvalidXmlChars(cn.NRC);
                oSheet.Cells[R, 31] = CleanInvalidXmlChars(cn.CLASSERV);
                oSheet.Cells[R, 32] = CleanInvalidXmlChars(cn.TITULO);
                oSheet.Cells[R, 33] = CleanInvalidXmlChars(cn.FILIAL);
                oSheet.Cells[R, 34] = CleanInvalidXmlChars(cn.LJ_CLI);
                oSheet.Cells[R, 35] = CleanInvalidXmlChars(cn.COD_CLI);
                oSheet.Cells[R, 36] = CleanInvalidXmlChars(cn.DOCUMENTO_SAP);
                oSheet.Cells[R, 37] = CleanInvalidXmlChars(cn.DOC_FAT);
                oSheet.Cells[R, 38] = CleanInvalidXmlChars(cn.N_DOC_DE_PARA_ATLYS);
                oSheet.Cells[R, 39] = CleanInvalidXmlChars(cn.NOTA_FISCAL);
                oSheet.Cells[R, 40] = CleanInvalidXmlChars(cn.VENC_ATUAL);
                oSheet.Cells[R, 41] = CleanInvalidXmlChars(cn.VENC_ORIGINAL);
                oSheet.Cells[R, 42] = CleanInvalidXmlChars(cn.DT_PROCESS);
                oSheet.Cells[R, 43] = CleanInvalidXmlChars(cn.ANOMES);
                oSheet.Cells[R, 44] = CleanInvalidXmlChars(cn.DIA_VENCIMENTO_LOTE);
                oSheet.Cells[R, 45] = CleanInvalidXmlChars(cn.NUMERO_LOTE);
                oSheet.Cells[R, 46] = CleanInvalidXmlChars(cn.VALOR_LOTE);
                oSheet.Cells[R, 47] = CleanInvalidXmlChars(cn.SALDO_CAR_26);
                oSheet.Cells[R, 48] = CleanInvalidXmlChars(cn.SALDO_CAR_05);
                oSheet.Cells[R, 49] = CleanInvalidXmlChars(cn.SALDO_CAR_30);
                oSheet.Cells[R, 50] = CleanInvalidXmlChars(cn.SALDO_CAR_14);
                oSheet.Cells[R, 51] = CleanInvalidXmlChars(cn.SALDO_CAR_21);
                oSheet.Cells[R, 52] = CleanInvalidXmlChars(cn.SALDO_CAR_25);
                oSheet.Cells[R, 53] = CleanInvalidXmlChars(cn.SALDO_TOTAL);
                oSheet.Cells[R, 54] = CleanInvalidXmlChars(cn.VALOR_PAGAMENTO);
                oSheet.Cells[R, 55] = CleanInvalidXmlChars(cn.VALOR_AJUSTE);
                oSheet.Cells[R, 56] = CleanInvalidXmlChars(cn.DT_ATRIB);
                oSheet.Cells[R, 57] = CleanInvalidXmlChars(cn.SALDO_ATUAL);
                oSheet.Cells[R, 58] = CleanInvalidXmlChars(cn.CICLO);
                oSheet.Cells[R, 59] = CleanInvalidXmlChars(cn.UF);
                oSheet.Cells[R, 60] = CleanInvalidXmlChars(cn.STATUS);
                oSheet.Cells[R, 61] = CleanInvalidXmlChars(cn.CLASSE);
                oSheet.Cells[R, 62] = CleanInvalidXmlChars(cn.SEGMENTO_GERENCIA);
                oSheet.Cells[R, 63] = CleanInvalidXmlChars(cn.GN);
                oSheet.Cells[R, 64] = CleanInvalidXmlChars(cn.GV);
                oSheet.Cells[R, 65] = CleanInvalidXmlChars(cn.DIRETOR);
                oSheet.Cells[R, 66] = CleanInvalidXmlChars(cn.ANALISTA_TLF_VIVO);
                oSheet.Cells[R, 67] = CleanInvalidXmlChars(cn.INTRAGOV);
                oSheet.Cells[R, 68] = CleanInvalidXmlChars(cn.INTERCOMPANY);
                oSheet.Cells[R, 69] = CleanInvalidXmlChars(cn.PENDENTE_ID_ANALISE_CONTA);
                oSheet.Cells[R, 70] = CleanInvalidXmlChars(cn.PENDENTE_DATA_ANALISE_CONTA);
                oSheet.Cells[R, 71] = CleanInvalidXmlChars(cn.CONCLUIDO_ID_ANALISE_CONTA);
                oSheet.Cells[R, 72] = CleanInvalidXmlChars(cn.CONCLUIDO_DATA_ANALISE_CONTA);
                oSheet.Cells[R, 73] = CleanInvalidXmlChars(cn.REABERTO_ID_ANALISE_CONTA);
                oSheet.Cells[R, 74] = CleanInvalidXmlChars(cn.REABERTO_DATA_ANALISE_CONTA);
                oSheet.Cells[R, 75] = CleanInvalidXmlChars(cn.AREA_ATUACAO);
                oSheet.Cells[R, 76] = CleanInvalidXmlChars(cn.TASK_FORCE);
                oSheet.Cells[R, 77] = CleanInvalidXmlChars(cn.SEG_DESCR);
                oSheet.Cells[R, 78] = CleanInvalidXmlChars(cn.PARCELAMENTO);
                oSheet.Cells[R, 79] = CleanInvalidXmlChars(cn.CONTA_BONUS);
                oSheet.Cells[R, 80] = CleanInvalidXmlChars(cn.FORNECEDOR);
                oSheet.Cells[R, 81] = CleanInvalidXmlChars(cn.REGRA_PDD);
                oSheet.Cells[R, 82] = CleanInvalidXmlChars(cn.PROVISAO);
                oSheet.Cells[R, 83] = CleanInvalidXmlChars(cn.SITUACAO_SERVICO);
                oSheet.Cells[R, 84] = CleanInvalidXmlChars(cn.SALDO_FX_ENT_26);
                oSheet.Cells[R, 85] = CleanInvalidXmlChars(cn.SALDO_PDD_26);
                oSheet.Cells[R, 86] = CleanInvalidXmlChars(cn.SALDO_FX_ENT_30);
                oSheet.Cells[R, 87] = CleanInvalidXmlChars(cn.SALDO_PDD_30);
                oSheet.Cells[R, 88] = CleanInvalidXmlChars(cn.SALDO_FX_ENT_05);
                oSheet.Cells[R, 89] = CleanInvalidXmlChars(cn.SALDO_PDD_05);
                oSheet.Cells[R, 90] = CleanInvalidXmlChars(cn.SALDO_FX_ENT_14);
                oSheet.Cells[R, 91] = CleanInvalidXmlChars(cn.SALDO_PDD_14);
                oSheet.Cells[R, 92] = CleanInvalidXmlChars(cn.SALDO_FX_ENT_21);
                oSheet.Cells[R, 93] = CleanInvalidXmlChars(cn.SALDO_PDD_21);
                oSheet.Cells[R, 94] = CleanInvalidXmlChars(cn.SALDO_FX_ENT_25);
                oSheet.Cells[R, 95] = CleanInvalidXmlChars(cn.SALDO_PDD_25);
                oSheet.Cells[R, 96] = CleanInvalidXmlChars(cn.RECEBIVEL);
                R++;

                Console.WriteLine(R + @" ### carregar planilha");
            }


            oBook.SaveAs(fileName);
            oBook.Close();
            oApp.Quit();


        }


        private void carregarXML(List<Segmento> lstCn, string fileName)
        {
            long contador = 0;

            using (XmlWriter writer = XmlWriter.Create(fileName))
            {
                writer.WriteStartDocument();
                writer.WriteStartElement("Segmentos");

                #region Carregar_Arquivo
                foreach (Segmento cn in lstCn)
                {
                    writer.WriteStartElement("Segmento");
                    writer.WriteElementString("PROCV", CleanInvalidXmlChars(cn.PROCV));
                    writer.WriteElementString("ID", CleanInvalidXmlChars(cn.ID));
                    writer.WriteElementString("NOME_ANALISTA", CleanInvalidXmlChars(cn.NOME_ANALISTA));
                    //writer.WriteElementString("NOME_ANALISTA_TMP", CleanInvalidXmlChars(cn.NOME_ANALISTA_TMP));
                    //writer.WriteElementString("NOME_LIDER", CleanInvalidXmlChars(cn.NOME_LIDER));
                    writer.WriteElementString("FEEDBACK", CleanInvalidXmlChars(cn.FEEDBACK));
                    writer.WriteElementString("AREA_OFENSORA", CleanInvalidXmlChars(cn.AREA_OFENSORA));
                    writer.WriteElementString("TIPO_PAGTO", CleanInvalidXmlChars(cn.TIPO_PAGTO));
                    writer.WriteElementString("DT_PAGTO", CleanInvalidXmlChars(cn.DT_PAGTO));
                    writer.WriteElementString("VALOR_PAGTO", CleanInvalidXmlChars(cn.VALOR_PAGTO));
                    writer.WriteElementString("DT_AJUSTE", CleanInvalidXmlChars(cn.DT_AJUSTE));
                    writer.WriteElementString("VALOR_AJUSTADO", CleanInvalidXmlChars(cn.VALOR_AJUSTADO));
                    writer.WriteElementString("RESUMO_EXECUTIVO_PROBLEMA", CleanInvalidXmlChars(cn.RESUMO_EXECUTIVO_PROBLEMA));
                    writer.WriteElementString("RESUMO_EXECUTIVO_ACAO", CleanInvalidXmlChars(cn.RESUMO_EXECUTIVO_ACAO));
                    writer.WriteElementString("HISTORICO_DETALHADO", CleanInvalidXmlChars(cn.HISTORICO_DETALHADO));
                    writer.WriteElementString("DT_FOLLOW_UP", CleanInvalidXmlChars(cn.DT_FOLLOW_UP));
                    writer.WriteElementString("DT_CONTATO", CleanInvalidXmlChars(cn.DT_CONTATO));
                    writer.WriteElementString("RESPONSAVEL", CleanInvalidXmlChars(cn.RESPONSAVEL));
                    writer.WriteElementString("FAIXA_FORNECEDOR", CleanInvalidXmlChars(cn.FAIXA_FORNECEDOR));
                    writer.WriteElementString("FAIXA_FECHO", CleanInvalidXmlChars(cn.FAIXA_FECHO));
                    writer.WriteElementString("FAIXA_ARRECADA_INICIAL", CleanInvalidXmlChars(cn.FAIXA_ARRECADA_INICIAL));
                    writer.WriteElementString("FAIXA_ARRECADA_ATUAL", CleanInvalidXmlChars(cn.FAIXA_ARRECADA_ATUAL));
                    writer.WriteElementString("RAIZ_GRUPO", CleanInvalidXmlChars(cn.RAIZ_GRUPO));
                    writer.WriteElementString("GRUPO", CleanInvalidXmlChars(cn.GRUPO));
                    writer.WriteElementString("RAIZ", CleanInvalidXmlChars(cn.RAIZ));
                    writer.WriteElementString("CNPJ", CleanInvalidXmlChars(cn.CNPJ));
                    writer.WriteElementString("NOME", CleanInvalidXmlChars(cn.NOME));
                    writer.WriteElementString("NOME_CLIENTE", CleanInvalidXmlChars(cn.NOME_CLIENTE));
                    writer.WriteElementString("TIPO", CleanInvalidXmlChars(cn.TIPO));
                    writer.WriteElementString("EMPRESA", CleanInvalidXmlChars(cn.EMPRESA));
                    writer.WriteElementString("CONTA", CleanInvalidXmlChars(cn.CONTA));
                    writer.WriteElementString("TEL", CleanInvalidXmlChars(cn.TEL));
                    writer.WriteElementString("LOCAL", CleanInvalidXmlChars(cn.LOCAL));
                    writer.WriteElementString("TERMINAL", CleanInvalidXmlChars(cn.TERMINAL));
                    writer.WriteElementString("DV", CleanInvalidXmlChars(cn.DV));
                    writer.WriteElementString("NRC", CleanInvalidXmlChars(cn.NRC));
                    writer.WriteElementString("CLASSERV", CleanInvalidXmlChars(cn.CLASSERV));
                    writer.WriteElementString("TITULO", CleanInvalidXmlChars(cn.TITULO));
                    writer.WriteElementString("FILIAL", CleanInvalidXmlChars(cn.FILIAL));
                    writer.WriteElementString("LJ_CLI", CleanInvalidXmlChars(cn.LJ_CLI));
                    writer.WriteElementString("COD_CLI", CleanInvalidXmlChars(cn.COD_CLI));
                    writer.WriteElementString("DOCUMENTO_SAP", CleanInvalidXmlChars(cn.DOCUMENTO_SAP));
                    writer.WriteElementString("DOC_FAT", CleanInvalidXmlChars(cn.DOC_FAT));
                    writer.WriteElementString("N_DOC_DE_PARA_ATLYS", CleanInvalidXmlChars(cn.N_DOC_DE_PARA_ATLYS));
                    writer.WriteElementString("NOTA_FISCAL", CleanInvalidXmlChars(cn.NOTA_FISCAL));
                    writer.WriteElementString("VENC_ATUAL", CleanInvalidXmlChars(cn.VENC_ATUAL));
                    writer.WriteElementString("VENC_ORIGINAL", CleanInvalidXmlChars(cn.VENC_ORIGINAL));
                    writer.WriteElementString("DT_PROCESS", CleanInvalidXmlChars(cn.DT_PROCESS));
                    writer.WriteElementString("ANOMES", CleanInvalidXmlChars(cn.ANOMES));
                    writer.WriteElementString("DIA_VENCIMENTO_LOTE", CleanInvalidXmlChars(cn.DIA_VENCIMENTO_LOTE));
                    writer.WriteElementString("NUMERO_LOTE", CleanInvalidXmlChars(cn.NUMERO_LOTE));
                    writer.WriteElementString("VALOR_LOTE", CleanInvalidXmlChars(cn.VALOR_LOTE));
                    writer.WriteElementString("SALDO_CAR_26", CleanInvalidXmlChars(cn.SALDO_CAR_26));
                    writer.WriteElementString("SALDO_CAR_05", CleanInvalidXmlChars(cn.SALDO_CAR_05));
                    writer.WriteElementString("SALDO_CAR_30", CleanInvalidXmlChars(cn.SALDO_CAR_30));
                    writer.WriteElementString("SALDO_CAR_14", CleanInvalidXmlChars(cn.SALDO_CAR_14));
                    writer.WriteElementString("SALDO_CAR_21", CleanInvalidXmlChars(cn.SALDO_CAR_21));
                    writer.WriteElementString("SALDO_CAR_25", CleanInvalidXmlChars(cn.SALDO_CAR_25));
                    writer.WriteElementString("SALDO_TOTAL", CleanInvalidXmlChars(cn.SALDO_TOTAL));
                    writer.WriteElementString("SOMA_FXE_PDD_26", CleanInvalidXmlChars(cn.SOMA_FXE_PDD_26));
                    writer.WriteElementString("SOMA_FXE_PDD_30", CleanInvalidXmlChars(cn.SOMA_FXE_PDD_30));
                    writer.WriteElementString("SOMA_FXE_PDD_05", CleanInvalidXmlChars(cn.SOMA_FXE_PDD_05));
                    writer.WriteElementString("SOMA_FXE_PDD_14", CleanInvalidXmlChars(cn.SOMA_FXE_PDD_14));
                    writer.WriteElementString("SOMA_FXE_PDD_21", CleanInvalidXmlChars(cn.SOMA_FXE_PDD_21));
                    writer.WriteElementString("SOMA_FXE_PDD_25", CleanInvalidXmlChars(cn.SOMA_FXE_PDD_25));
                    writer.WriteElementString("VALOR_PAGAMENTO", CleanInvalidXmlChars(cn.VALOR_PAGAMENTO));
                    writer.WriteElementString("VALOR_AJUSTE", CleanInvalidXmlChars(cn.VALOR_AJUSTE));
                    writer.WriteElementString("DT_ATRIB", CleanInvalidXmlChars(cn.DT_ATRIB));
                    writer.WriteElementString("DTCORTE", CleanInvalidXmlChars(cn.DTCORTE));
                    writer.WriteElementString("SALDO_ATUAL", CleanInvalidXmlChars(cn.SALDO_ATUAL));
                    writer.WriteElementString("CICLO", CleanInvalidXmlChars(cn.CICLO));
                    writer.WriteElementString("UF", CleanInvalidXmlChars(cn.UF));
                    writer.WriteElementString("STATUS", CleanInvalidXmlChars(cn.STATUS));
                    writer.WriteElementString("CLASSE", CleanInvalidXmlChars(cn.CLASSE));
                    writer.WriteElementString("SEGMENTO_GERENCIA", CleanInvalidXmlChars(cn.SEGMENTO_GERENCIA));
                    writer.WriteElementString("GN", CleanInvalidXmlChars(cn.GN));
                    writer.WriteElementString("GV", CleanInvalidXmlChars(cn.GV));
                    writer.WriteElementString("DIRETOR", CleanInvalidXmlChars(cn.DIRETOR));
                    writer.WriteElementString("ANALISTA_TLF_VIVO", CleanInvalidXmlChars(cn.ANALISTA_TLF_VIVO));
                    writer.WriteElementString("INTRAGOV", CleanInvalidXmlChars(cn.INTRAGOV));
                    writer.WriteElementString("INTERCOMPANY", CleanInvalidXmlChars(cn.INTERCOMPANY));
                    writer.WriteElementString("FEEDBACK_00", CleanInvalidXmlChars(cn.FEEDBACK_00));
                    writer.WriteElementString("FEEDBACK_01", CleanInvalidXmlChars(cn.FEEDBACK_01));
                    writer.WriteElementString("FEEDBACK_02", CleanInvalidXmlChars(cn.FEEDBACK_02));
                    writer.WriteElementString("FEEDBACK_03", CleanInvalidXmlChars(cn.FEEDBACK_03));
                    writer.WriteElementString("FEEDBACK_04", CleanInvalidXmlChars(cn.FEEDBACK_04));
                    writer.WriteElementString("FEEDBACK_05", CleanInvalidXmlChars(cn.FEEDBACK_05));
                    writer.WriteElementString("PENDENTE_ID_ANALISE_CONTA", CleanInvalidXmlChars(cn.PENDENTE_ID_ANALISE_CONTA));
                    writer.WriteElementString("PENDENTE_DATA_ANALISE_CONTA", CleanInvalidXmlChars(cn.PENDENTE_DATA_ANALISE_CONTA));
                    writer.WriteElementString("CONCLUIDO_ID_ANALISE_CONTA", CleanInvalidXmlChars(cn.CONCLUIDO_ID_ANALISE_CONTA));
                    writer.WriteElementString("CONCLUIDO_DATA_ANALISE_CONTA", CleanInvalidXmlChars(cn.CONCLUIDO_DATA_ANALISE_CONTA));
                    writer.WriteElementString("REABERTO_ID_ANALISE_CONTA", CleanInvalidXmlChars(cn.REABERTO_ID_ANALISE_CONTA));
                    writer.WriteElementString("REABERTO_DATA_ANALISE_CONTA", CleanInvalidXmlChars(cn.REABERTO_DATA_ANALISE_CONTA));
                    writer.WriteElementString("QTD_REG_AGRUPADO", CleanInvalidXmlChars(cn.QTD_REG_AGRUPADO));
                    writer.WriteElementString("DT_ULT_ALTERACAO", CleanInvalidXmlChars(cn.DT_ULT_ALTERACAO));
                    writer.WriteElementString("USUARIO_ATUALIZACAO", CleanInvalidXmlChars(cn.USUARIO_ATUALIZACAO));
                    writer.WriteElementString("AREA_ATUACAO", CleanInvalidXmlChars(cn.AREA_ATUACAO));
                    writer.WriteElementString("TASK_FORCE", CleanInvalidXmlChars(cn.TASK_FORCE));
                    writer.WriteElementString("SEG_DESCR", CleanInvalidXmlChars(cn.SEG_DESCR));
                    writer.WriteElementString("PARCELAMENTO", CleanInvalidXmlChars(cn.PARCELAMENTO));
                    writer.WriteElementString("CONTA_BONUS", CleanInvalidXmlChars(cn.CONTA_BONUS));
                    writer.WriteElementString("FORNECEDOR", CleanInvalidXmlChars(cn.FORNECEDOR));
                    writer.WriteElementString("ESCALATION", CleanInvalidXmlChars(cn.ESCALATION));
                    writer.WriteElementString("REGRA_PDD", CleanInvalidXmlChars(cn.REGRA_PDD));
                    writer.WriteElementString("FAIXA_CORTE", CleanInvalidXmlChars(cn.FAIXA_CORTE));
                    writer.WriteElementString("PROVISAO", CleanInvalidXmlChars(cn.PROVISAO));
                    writer.WriteElementString("SITUACAO_SERVICO", CleanInvalidXmlChars(cn.SITUACAO_SERVICO));
                    writer.WriteElementString("ENDERECO", CleanInvalidXmlChars(cn.ENDERECO));
                    writer.WriteElementString("SALDO_FX_ENT_26", CleanInvalidXmlChars(cn.SALDO_FX_ENT_26));
                    writer.WriteElementString("SALDO_PDD_26", CleanInvalidXmlChars(cn.SALDO_PDD_26));
                    writer.WriteElementString("SALDO_FX_ENT_30", CleanInvalidXmlChars(cn.SALDO_FX_ENT_30));
                    writer.WriteElementString("SALDO_PDD_30", CleanInvalidXmlChars(cn.SALDO_PDD_30));
                    writer.WriteElementString("SALDO_FX_ENT_05", CleanInvalidXmlChars(cn.SALDO_FX_ENT_05));
                    writer.WriteElementString("SALDO_PDD_05", CleanInvalidXmlChars(cn.SALDO_PDD_05));
                    writer.WriteElementString("SALDO_FX_ENT_14", CleanInvalidXmlChars(cn.SALDO_FX_ENT_14));
                    writer.WriteElementString("SALDO_PDD_14", CleanInvalidXmlChars(cn.SALDO_PDD_14));
                    writer.WriteElementString("SALDO_FX_ENT_21", CleanInvalidXmlChars(cn.SALDO_FX_ENT_21));
                    writer.WriteElementString("SALDO_PDD_21", CleanInvalidXmlChars(cn.SALDO_PDD_21));
                    writer.WriteElementString("SALDO_FX_ENT_25", CleanInvalidXmlChars(cn.SALDO_FX_ENT_25));
                    writer.WriteElementString("SALDO_PDD_25", CleanInvalidXmlChars(cn.SALDO_PDD_25));
                    writer.WriteElementString("RECEBIVEL", CleanInvalidXmlChars(cn.RECEBIVEL));

                    writer.WriteEndElement();

                    ++contador;
                    Console.WriteLine(contador + @" >>> carregar arquivo");

                }
                #endregion Carregar_Arquivo

                writer.WriteEndElement();
                writer.WriteEndDocument();
            }



        }



        private void CarregarSegmentos(List<report_segmento> pLstCn, string sConsulta)
        {
            //long contador = 0;

            Banco bco = new Banco();
            bco.Selecao(sConsulta);

            report_segmento titulo = new report_segmento(
                                "PROCV",
                                "ID",
                                "NOME_ANALISTA",
                                "FEEDBACK",
                                "AREA_OFENSORA",
                                "TIPO_PAGTO",
                                "DT_PAGTO",
                                "VALOR_PAGTO",
                                "DT_AJUSTE",
                                "VALOR_AJUSTADO",
                                "RESUMO_EXECUTIVO_PROBLEMA",
                                "RESUMO_EXECUTIVO_ACAO",
                                "DT_FOLLOW_UP",
                                "DT_CONTATO",
                                "RESPONSAVEL",
                                "FAIXA_FORNECEDOR",
                                "FAIXA_FECHO",
                                "FAIXA_ARRECADA_INICIAL",
                                "FAIXA_ARRECADA_ATUAL",
                                "RAIZ_GRUPO",
                                "GRUPO",
                                "RAIZ",
                                "CNPJ",
                                "NOME",
                                "NOME_CLIENTE",
                                "TIPO",
                                "EMPRESA",
                                "CONTA",
                                "TEL",
                                "NRC",
                                "CLASSERV",
                                "TITULO",
                                "FILIAL",
                                "LJ_CLI",
                                "COD_CLI",
                                "DOCUMENTO_SAP",
                                "DOC_FAT",
                                "N_DOC_DE_PARA_ATLYS",
                                "NOTA_FISCAL",
                                "VENC_ATUAL",
                                "VENC_ORIGINAL",
                                "DT_PROCESS",
                                "ANOMES",
                                "DIA_VENCIMENTO_LOTE",
                                "NUMERO_LOTE",
                                "VALOR_LOTE",
                                "SALDO_CAR_26",
                                "SALDO_CAR_05",
                                "SALDO_CAR_30",
                                "SALDO_CAR_14",
                                "SALDO_CAR_21",
                                "SALDO_CAR_25",
                                "SALDO_TOTAL",
                                "VALOR_PAGAMENTO",
                                "VALOR_AJUSTE",
                                "dt_atrib",
                                "SALDO_ATUAL",
                                "CICLO",
                                "UF",
                                "STATUS",
                                "CLASSE",
                                "SEGMENTO_GERENCIA",
                                "GN",
                                "GV",
                                "DIRETOR",
                                "ANALISTA_TLF_VIVO",
                                "INTRAGOV",
                                "INTERCOMPANY",
                                "PENDENTE_ID_ANALISE_CONTA",
                                "PENDENTE_DATA_ANALISE_CONTA",
                                "CONCLUIDO_ID_ANALISE_CONTA",
                                "CONCLUIDO_DATA_ANALISE_CONTA",
                                "REABERTO_ID_ANALISE_CONTA",
                                "REABERTO_DATA_ANALISE_CONTA",
                                "AREA_ATUACAO",
                                "TASK_FORCE",
                                "SEG_DESCR",
                                "PARCELAMENTO",
                                "CONTA_BONUS",
                                "FORNECEDOR",
                                "REGRA_PDD",
                                "PROVISAO",
                                "SITUACAO_SERVICO",
                                "SALDO_FX_ENT_26",
                                "SALDO_PDD_26",
                                "SALDO_FX_ENT_30",
                                "SALDO_PDD_30",
                                "SALDO_FX_ENT_05",
                                "SALDO_PDD_05",
                                "SALDO_FX_ENT_14",
                                "SALDO_PDD_14",
                                "SALDO_FX_ENT_21",
                                "SALDO_PDD_21",
                                "SALDO_FX_ENT_25",
                                "SALDO_PDD_25",
                                "RECEBIVEL"
                            );
            pLstCn.Add(titulo);




            #region Carregar_Dados
            while (bco.Rdr.Read())
            {
                report_segmento cn = new report_segmento(
                        bco.Rdr["PROCV"].ToString(),
                        bco.Rdr["ID"].ToString(),
                        bco.Rdr["NOME_ANALISTA"].ToString(),
                        bco.Rdr["FEEDBACK"].ToString(),
                        bco.Rdr["AREA_OFENSORA"].ToString(),
                        bco.Rdr["TIPO_PAGTO"].ToString(),
                        bco.Rdr["DT_PAGTO"].ToString(),
                        bco.Rdr["VALOR_PAGTO"].ToString(),
                        bco.Rdr["DT_AJUSTE"].ToString(),
                        bco.Rdr["VALOR_AJUSTADO"].ToString(),
                        bco.Rdr["RESUMO_EXECUTIVO_PROBLEMA"].ToString(),
                        bco.Rdr["RESUMO_EXECUTIVO_ACAO"].ToString(),
                        bco.Rdr["DT_FOLLOW_UP"].ToString(),
                        bco.Rdr["DT_CONTATO"].ToString(),
                        bco.Rdr["RESPONSAVEL"].ToString(),
                        bco.Rdr["FAIXA_FORNECEDOR"].ToString(),
                        bco.Rdr["FAIXA_FECHO"].ToString(),
                        bco.Rdr["FAIXA_ARRECADA_INICIAL"].ToString(),
                        bco.Rdr["FAIXA_ARRECADA_ATUAL"].ToString(),
                        bco.Rdr["RAIZ_GRUPO"].ToString(),
                        bco.Rdr["GRUPO"].ToString(),
                        bco.Rdr["RAIZ"].ToString(),
                        bco.Rdr["CNPJ"].ToString(),
                        bco.Rdr["NOME"].ToString(),
                        bco.Rdr["NOME_CLIENTE"].ToString(),
                        bco.Rdr["TIPO"].ToString(),
                        bco.Rdr["EMPRESA"].ToString(),
                        bco.Rdr["CONTA"].ToString(),
                        bco.Rdr["TEL"].ToString(),
                        bco.Rdr["NRC"].ToString(),
                        bco.Rdr["CLASSERV"].ToString(),
                        bco.Rdr["TITULO"].ToString(),
                        bco.Rdr["FILIAL"].ToString(),
                        bco.Rdr["LJ_CLI"].ToString(),
                        bco.Rdr["COD_CLI"].ToString(),
                        bco.Rdr["DOCUMENTO_SAP"].ToString(),
                        bco.Rdr["DOC_FAT"].ToString(),
                        bco.Rdr["N_DOC_DE_PARA_ATLYS"].ToString(),
                        bco.Rdr["NOTA_FISCAL"].ToString(),
                        bco.Rdr["VENC_ATUAL"].ToString(),
                        bco.Rdr["VENC_ORIGINAL"].ToString(),
                        bco.Rdr["DT_PROCESS"].ToString(),
                        bco.Rdr["ANOMES"].ToString(),
                        bco.Rdr["DIA_VENCIMENTO_LOTE"].ToString(),
                        bco.Rdr["NUMERO_LOTE"].ToString(),
                        bco.Rdr["VALOR_LOTE"].ToString(),
                        bco.Rdr["SALDO_CAR_26"].ToString(),
                        bco.Rdr["SALDO_CAR_05"].ToString(),
                        bco.Rdr["SALDO_CAR_30"].ToString(),
                        bco.Rdr["SALDO_CAR_14"].ToString(),
                        bco.Rdr["SALDO_CAR_21"].ToString(),
                        bco.Rdr["SALDO_CAR_25"].ToString(),
                        bco.Rdr["SALDO_TOTAL"].ToString(),
                        bco.Rdr["VALOR_PAGAMENTO"].ToString(),
                        bco.Rdr["VALOR_AJUSTE"].ToString(),
                        bco.Rdr["dt_atrib"].ToString(),
                        bco.Rdr["SALDO_ATUAL"].ToString(),
                        bco.Rdr["CICLO"].ToString(),
                        bco.Rdr["UF"].ToString(),
                        bco.Rdr["STATUS"].ToString(),
                        bco.Rdr["CLASSE"].ToString(),
                        bco.Rdr["SEGMENTO_GERENCIA"].ToString(),
                        bco.Rdr["GN"].ToString(),
                        bco.Rdr["GV"].ToString(),
                        bco.Rdr["DIRETOR"].ToString(),
                        bco.Rdr["ANALISTA_TLF_VIVO"].ToString(),
                        bco.Rdr["INTRAGOV"].ToString(),
                        bco.Rdr["INTERCOMPANY"].ToString(),
                        bco.Rdr["PENDENTE_ID_ANALISE_CONTA"].ToString(),
                        bco.Rdr["PENDENTE_DATA_ANALISE_CONTA"].ToString(),
                        bco.Rdr["CONCLUIDO_ID_ANALISE_CONTA"].ToString(),
                        bco.Rdr["CONCLUIDO_DATA_ANALISE_CONTA"].ToString(),
                        bco.Rdr["REABERTO_ID_ANALISE_CONTA"].ToString(),
                        bco.Rdr["REABERTO_DATA_ANALISE_CONTA"].ToString(),
                        bco.Rdr["AREA_ATUACAO"].ToString(),
                        bco.Rdr["TASK_FORCE"].ToString(),
                        bco.Rdr["SEG_DESCR"].ToString(),
                        bco.Rdr["PARCELAMENTO"].ToString(),
                        bco.Rdr["CONTA_BONUS"].ToString(),
                        bco.Rdr["FORNECEDOR"].ToString(),
                        bco.Rdr["REGRA_PDD"].ToString(),
                        bco.Rdr["PROVISAO"].ToString(),
                        bco.Rdr["SITUACAO_SERVICO"].ToString(),
                        bco.Rdr["SALDO_FX_ENT_26"].ToString(),
                        bco.Rdr["SALDO_PDD_26"].ToString(),
                        bco.Rdr["SALDO_FX_ENT_30"].ToString(),
                        bco.Rdr["SALDO_PDD_30"].ToString(),
                        bco.Rdr["SALDO_FX_ENT_05"].ToString(),
                        bco.Rdr["SALDO_PDD_05"].ToString(),
                        bco.Rdr["SALDO_FX_ENT_14"].ToString(),
                        bco.Rdr["SALDO_PDD_14"].ToString(),
                        bco.Rdr["SALDO_FX_ENT_21"].ToString(),
                        bco.Rdr["SALDO_PDD_21"].ToString(),
                        bco.Rdr["SALDO_FX_ENT_25"].ToString(),
                        bco.Rdr["SALDO_PDD_25"].ToString(),
                        bco.Rdr["RECEBIVEL"].ToString()

                    );

                #endregion Carregar_Dados

                pLstCn.Add(cn);

                //++contador;
                //Console.WriteLine(contador + @" ### carregar acordos");
            }
            bco.Fechar();
        }


        private void CarregarAcordos(List<Segmento> pLstCn, string sConsulta)
        {
            //long contador = 0;

            Banco bco = new Banco();
            bco.Selecao(sConsulta);

            #region Carregar_Dados
            while (bco.Rdr.Read())
            {
                Segmento cn = new Segmento(
                    bco.Rdr["PROCV"].ToString()
                    , bco.Rdr["ID"].ToString()
                    , bco.Rdr["NOME_ANALISTA"].ToString()
                    //, bco.Rdr["NOME_ANALISTA_TMP"].ToString()
                    //, bco.Rdr["NOME_LIDER"].ToString()
                    , bco.Rdr["FEEDBACK"].ToString()
                    , bco.Rdr["AREA_OFENSORA"].ToString()
                    , bco.Rdr["TIPO_PAGTO"].ToString()
                    , bco.Rdr["DT_PAGTO"].ToString()
                    , bco.Rdr["VALOR_PAGTO"].ToString()
                    , bco.Rdr["DT_AJUSTE"].ToString()
                    , bco.Rdr["VALOR_AJUSTADO"].ToString()
                    , bco.Rdr["RESUMO_EXECUTIVO_PROBLEMA"].ToString()
                    , bco.Rdr["RESUMO_EXECUTIVO_ACAO"].ToString()
                    , bco.Rdr["HISTORICO_DETALHADO"].ToString()
                    , bco.Rdr["DT_FOLLOW_UP"].ToString()
                    , bco.Rdr["DT_CONTATO"].ToString()
                    , bco.Rdr["RESPONSAVEL"].ToString()
                    , bco.Rdr["FAIXA_FORNECEDOR"].ToString()
                    , bco.Rdr["FAIXA_FECHO"].ToString()
                    , bco.Rdr["FAIXA_ARRECADA_INICIAL"].ToString()
                    , bco.Rdr["FAIXA_ARRECADA_ATUAL"].ToString()
                    , bco.Rdr["RAIZ_GRUPO"].ToString()
                    , bco.Rdr["GRUPO"].ToString()
                    , bco.Rdr["RAIZ"].ToString()
                    , bco.Rdr["CNPJ"].ToString()
                    , bco.Rdr["NOME"].ToString()
                    , bco.Rdr["NOME_CLIENTE"].ToString()
                    , bco.Rdr["TIPO"].ToString()
                    , bco.Rdr["EMPRESA"].ToString()
                    , bco.Rdr["CONTA"].ToString()
                    , bco.Rdr["TEL"].ToString()
                    , bco.Rdr["LOCAL"].ToString()
                    , bco.Rdr["TERMINAL"].ToString()
                    , bco.Rdr["DV"].ToString()
                    , bco.Rdr["NRC"].ToString()
                    , bco.Rdr["CLASSERV"].ToString()
                    , bco.Rdr["TITULO"].ToString()
                    , bco.Rdr["FILIAL"].ToString()
                    , bco.Rdr["LJ_CLI"].ToString()
                    , bco.Rdr["COD_CLI"].ToString()
                    , bco.Rdr["DOCUMENTO_SAP"].ToString()
                    , bco.Rdr["DOC_FAT"].ToString()
                    , bco.Rdr["N_DOC_DE_PARA_ATLYS"].ToString()
                    , bco.Rdr["NOTA_FISCAL"].ToString()
                    , bco.Rdr["VENC_ATUAL"].ToString()
                    , bco.Rdr["VENC_ORIGINAL"].ToString()
                    , bco.Rdr["DT_PROCESS"].ToString()
                    , bco.Rdr["ANOMES"].ToString()
                    , bco.Rdr["DIA_VENCIMENTO_LOTE"].ToString()
                    , bco.Rdr["NUMERO_LOTE"].ToString()
                    , bco.Rdr["VALOR_LOTE"].ToString()
                    , bco.Rdr["SALDO_CAR_26"].ToString()
                    , bco.Rdr["SALDO_CAR_05"].ToString()
                    , bco.Rdr["SALDO_CAR_30"].ToString()
                    , bco.Rdr["SALDO_CAR_14"].ToString()
                    , bco.Rdr["SALDO_CAR_21"].ToString()
                    , bco.Rdr["SALDO_CAR_25"].ToString()
                    , bco.Rdr["SALDO_TOTAL"].ToString()
                    , bco.Rdr["SOMA_FXE_PDD_26"].ToString()
                    , bco.Rdr["SOMA_FXE_PDD_30"].ToString()
                    , bco.Rdr["SOMA_FXE_PDD_05"].ToString()
                    , bco.Rdr["SOMA_FXE_PDD_14"].ToString()
                    , bco.Rdr["SOMA_FXE_PDD_21"].ToString()
                    , bco.Rdr["SOMA_FXE_PDD_25"].ToString()
                    , bco.Rdr["VALOR_PAGAMENTO"].ToString()
                    , bco.Rdr["VALOR_AJUSTE"].ToString()
                    , bco.Rdr["DT_ATRIB"].ToString()
                    , bco.Rdr["DTCORTE"].ToString()
                    , bco.Rdr["SALDO_ATUAL"].ToString()
                    , bco.Rdr["CICLO"].ToString()
                    , bco.Rdr["UF"].ToString()
                    , bco.Rdr["STATUS"].ToString()
                    , bco.Rdr["CLASSE"].ToString()
                    , bco.Rdr["SEGMENTO_GERENCIA"].ToString()
                    , bco.Rdr["GN"].ToString()
                    , bco.Rdr["GV"].ToString()
                    , bco.Rdr["DIRETOR"].ToString()
                    , bco.Rdr["ANALISTA_TLF_VIVO"].ToString()
                    , bco.Rdr["INTRAGOV"].ToString()
                    , bco.Rdr["INTERCOMPANY"].ToString()
                    , bco.Rdr["FEEDBACK_00"].ToString()
                    , bco.Rdr["FEEDBACK_01"].ToString()
                    , bco.Rdr["FEEDBACK_02"].ToString()
                    , bco.Rdr["FEEDBACK_03"].ToString()
                    , bco.Rdr["FEEDBACK_04"].ToString()
                    , bco.Rdr["FEEDBACK_05"].ToString()
                    , bco.Rdr["PENDENTE_ID_ANALISE_CONTA"].ToString()
                    , bco.Rdr["PENDENTE_DATA_ANALISE_CONTA"].ToString()
                    , bco.Rdr["CONCLUIDO_ID_ANALISE_CONTA"].ToString()
                    , bco.Rdr["CONCLUIDO_DATA_ANALISE_CONTA"].ToString()
                    , bco.Rdr["REABERTO_ID_ANALISE_CONTA"].ToString()
                    , bco.Rdr["REABERTO_DATA_ANALISE_CONTA"].ToString()
                    , bco.Rdr["QTD_REG_AGRUPADO"].ToString()
                    , bco.Rdr["DT_ULT_ALTERACAO"].ToString()
                    , bco.Rdr["USUARIO_ATUALIZACAO"].ToString()
                    , bco.Rdr["AREA_ATUACAO"].ToString()
                    , bco.Rdr["TASK_FORCE"].ToString()
                    , bco.Rdr["SEG_DESCR"].ToString()
                    , bco.Rdr["PARCELAMENTO"].ToString()
                    , bco.Rdr["CONTA_BONUS"].ToString()
                    , bco.Rdr["FORNECEDOR"].ToString()
                    , bco.Rdr["ESCALATION"].ToString()
                    , bco.Rdr["REGRA_PDD"].ToString()
                    , bco.Rdr["FAIXA_CORTE"].ToString()
                    , bco.Rdr["PROVISAO"].ToString()
                    , bco.Rdr["SITUACAO_SERVICO"].ToString()
                    , bco.Rdr["ENDERECO"].ToString()
                    , bco.Rdr["SALDO_FX_ENT_26"].ToString()
                    , bco.Rdr["SALDO_PDD_26"].ToString()
                    , bco.Rdr["SALDO_FX_ENT_30"].ToString()
                    , bco.Rdr["SALDO_PDD_30"].ToString()
                    , bco.Rdr["SALDO_FX_ENT_05"].ToString()
                    , bco.Rdr["SALDO_PDD_05"].ToString()
                    , bco.Rdr["SALDO_FX_ENT_14"].ToString()
                    , bco.Rdr["SALDO_PDD_14"].ToString()
                    , bco.Rdr["SALDO_FX_ENT_21"].ToString()
                    , bco.Rdr["SALDO_PDD_21"].ToString()
                    , bco.Rdr["SALDO_FX_ENT_25"].ToString()
                    , bco.Rdr["SALDO_PDD_25"].ToString()
                    , bco.Rdr["RECEBIVEL"].ToString()
                    );

                #endregion Carregar_Dados

                pLstCn.Add(cn);

                //++contador;
                //Console.WriteLine(contador + @" ### carregar acordos");
            }
            bco.Fechar();
        }

        public static String TestString(string s)
        {
            if (String.IsNullOrEmpty(s))
                return "";
            else
                return s;
        }

        public static string CleanInvalidXmlChars(string text)
        {
            // From xml spec valid chars: 
            // #x9 | #xA | #xD | [#x20-#xD7FF] | [#xE000-#xFFFD] | [#x10000-#x10FFFF]     
            // any Unicode character, excluding the surrogate blocks, FFFE, and FFFF. 
            string re = @"[^\x09\x0A\x0D\x20-\xD7FF\xE000-\xFFFD\x10000-x10FFFF]";
            return Regex.Replace(text, re, "");
        }





        //#region EXTRACAO_01


        //List<List<string>> lstExtracao = new List<List<string>>();
        //List<string> lstRegistro;
        ////long contador = 0;
        //string sSQL = "SELECT * FROM [DB_SISCOB].[transito].[tmp_VW_RELATORIO_WEB_MIS_VPE_FIXA_SIM]";


        //bco.Selecao(sSQL);


        ////// ### ( listar campos de consulta ) ###############################################################
        //List<string> lstCabecalho = new List<string>();
        //for (int i = 0; i < bco.Rdr.FieldCount; i++)
        //{
        //    //Console.WriteLine(bco.Rdr.GetName(i).ToString());
        //    lstCabecalho.Add(bco.Rdr.GetName(i).ToString());
        //}
        //Console.WriteLine(@" >>> LISTAR CAMPOS - OK");
        ////// ### ( listar campos de consulta ) ###############################################################



        ////// ### ( listar registros ) ########################################################################
        //while (bco.Rdr.Read())
        //{
        //    lstRegistro = new List<string>();

        //    for (int i = 0; i < bco.Rdr.FieldCount; i++)
        //    {
        //        lstRegistro.Add(bco.Rdr[i].ToString());
        //    }
        //    lstExtracao.Add(lstRegistro);
        //}

        //Console.WriteLine(@" >>> LISTAR REGISTROS - OK");
        ////// ### ( listar registros ) ########################################################################


        //bco.Fechar();
        //Console.WriteLine(@" >>> FECHAR BANCO - OK");




        ////// ### ( criar arquivo ) ########################################################################

        //using (XmlWriter writer = XmlWriter.Create(sPath + "\\VPE_FIXA_SIM.xml"))
        //{

        //    writer.WriteStartDocument();
        //    writer.WriteStartElement("Registros");

        //    foreach (var registro in lstExtracao)
        //    {
        //        writer.WriteStartElement("Registro");
        //        for (int i = 0; i < registro.Count; i++)
        //        {
        //            writer.WriteElementString(lstCabecalho[i].ToString(), CleanInvalidXmlChars(registro[i].ToString()));
        //        }
        //        writer.WriteEndElement();
        //    }

        //    writer.WriteEndElement();
        //    writer.WriteEndDocument();
        //}
        //Console.WriteLine(@" >>> CRIAR ARQUIVO - OK");
        ////// ### ( criar arquivo ) ########################################################################


        //#endregion




    }
}
