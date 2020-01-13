using System;
using System.Collections.Generic;
using System.Xml;


namespace exportarAcordo
{
    class Program
    {

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
            public String nrc { get { return _feedback; } }
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
            public String regra_pdd{ get { return _Regra_PDD; } }
            public String situacao_servico { get { return _SITUACAO_SERVICO; } }

        }


        static int Main(string[] args) //string[] args
        {

            List<Acordos> lstCn = new List<Acordos>();

            Banco bco = new Banco();


            if (args.Length == 0)
            {
                Console.WriteLine("Por favor entre com o ID de analista");
                return 1;
            }

            bco.carregarSolicitacao(args[0]);


            Program carregarDados = new Program();
            carregarDados.CarregarAcordos(lstCn,bco.Solicitacao);


            #region Construção do arquivo
            //long contador = 0;
            ////172.16.0.11/siscob/ACORDO

            // bco.NomeArquivo
            // "c:/tmp/60872173.xml"
            //string tmpPath = "c:/tmp/" + bco.ArquivoNome;
            string tmpPath = bco.ArquivoNome;


            using (XmlWriter writer = XmlWriter.Create(tmpPath))
            {
                writer.WriteStartDocument();
                writer.WriteStartElement("Acordos");

                foreach (Acordos cn in lstCn)
                {
                    writer.WriteStartElement("Acordo");

                    writer.WriteElementString("procv", cn.procv);
                    writer.WriteElementString("id", cn.id.ToString());
                    writer.WriteElementString("nome_analista", cn.nome_analista);
                    writer.WriteElementString("nome_analista_tmp", cn.nome_analista_tmp);
                    writer.WriteElementString("feedback", cn.feedback);
                    writer.WriteElementString("area_ofensora", cn.area_ofensora);
                    writer.WriteElementString("tipo_pagto", cn.tipo_pagto);
                    writer.WriteElementString("dt_pagto", cn.dt_pagto);
                    writer.WriteElementString("valor_pagto", cn.valor_pagto);
                    writer.WriteElementString("dt_ajuste", cn.dt_ajuste);
                    writer.WriteElementString("valor_ajustado", cn.valor_ajustado);
                    writer.WriteElementString("resumo_executivo_acao", cn.resumo_executivo_acao);
                    writer.WriteElementString("resumo_executivo_problema", cn.resumo_executivo_problema);
                    writer.WriteElementString("historico_detalhado", cn.historico_detalhado);
                    writer.WriteElementString("dt_follow_up", cn.dt_follow_up);
                    writer.WriteElementString("dt_encerramento", cn.dt_encerramento);
                    writer.WriteElementString("dt_contato", cn.dt_contato);
                    writer.WriteElementString("responsavel", cn.responsavel);
                    writer.WriteElementString("faixa_fornecedor", cn.faixa_fornecedor);
                    writer.WriteElementString("faixa_fecho", cn.faixa_fecho);
                    writer.WriteElementString("faixa_arrecada_inicial", cn.faixa_arrecada_inicial);
                    writer.WriteElementString("faixa_arrecada_atual", cn.faixa_arrecada_atual);
                    writer.WriteElementString("raiz_grupo", cn.raiz_grupo);
                    writer.WriteElementString("grupo", cn.grupo);
                    writer.WriteElementString("raiz", cn.raiz);
                    writer.WriteElementString("cnpj", cn.cnpj);
                    writer.WriteElementString("nome", cn.nome);
                    writer.WriteElementString("nome_cliente", cn.nome_cliente);
                    writer.WriteElementString("tipo", cn.tipo);
                    writer.WriteElementString("empresa", cn.empresa);
                    writer.WriteElementString("conta", cn.conta);
                    writer.WriteElementString("tel", cn.tel);
                    writer.WriteElementString("local", cn.local);
                    writer.WriteElementString("terminal", cn.terminal);
                    writer.WriteElementString("dv", cn.dv);
                    writer.WriteElementString("nrc", cn.nrc);
                    writer.WriteElementString("classerv", cn.classerv);
                    writer.WriteElementString("titulo", cn.titulo);
                    writer.WriteElementString("filial", cn.filial);
                    writer.WriteElementString("lj_cli", cn.lj_cli);
                    writer.WriteElementString("cod_cli", cn.cod_cli);
                    writer.WriteElementString("documento_sap", cn.documento_sap);
                    writer.WriteElementString("doc_fat", cn.doc_fat);
                    writer.WriteElementString("n_doc_de_para_atlys", cn.n_doc_de_para_atlys);
                    writer.WriteElementString("nota_fiscal", cn.nota_fiscal);
                    writer.WriteElementString("venc_atual", cn.venc_atual);
                    writer.WriteElementString("venc_original", cn.venc_original);
                    writer.WriteElementString("dt_process", cn.dt_process);
                    writer.WriteElementString("anomes", cn.anomes);
                    writer.WriteElementString("dia_vencimento_lote", cn.dia_vencimento_lote);
                    writer.WriteElementString("numero_lote", cn.numero_lote);
                    writer.WriteElementString("valor_lote", cn.valor_lote);
                    writer.WriteElementString("saldo_car_26", cn.saldo_car_26);
                    writer.WriteElementString("saldo_car_30", cn.saldo_car_30);
                    writer.WriteElementString("saldo_car_05", cn.saldo_car_05);
                    writer.WriteElementString("saldo_car_14", cn.saldo_car_14);
                    writer.WriteElementString("saldo_car_21", cn.saldo_car_21);
                    writer.WriteElementString("saldo_car_25", cn.saldo_car_25);
                    writer.WriteElementString("saldo_total", cn.saldo_total);
                    writer.WriteElementString("soma_fxe_pdd_26", cn.soma_fxe_pdd_26);
                    writer.WriteElementString("soma_fxe_pdd_30", cn.soma_fxe_pdd_30);
                    writer.WriteElementString("soma_fxe_pdd_05", cn.soma_fxe_pdd_05);
                    writer.WriteElementString("soma_fxe_pdd_14", cn.soma_fxe_pdd_14);
                    writer.WriteElementString("soma_fxe_pdd_21", cn.soma_fxe_pdd_21);
                    writer.WriteElementString("soma_fxe_pdd_25", cn.soma_fxe_pdd_25);
                    writer.WriteElementString("valor_pagamento", cn.valor_pagamento);
                    writer.WriteElementString("valor_ajuste", cn.valor_ajuste);
                    writer.WriteElementString("saldo_atual", cn.saldo_atual);
                    writer.WriteElementString("ciclo", cn.ciclo);
                    writer.WriteElementString("uf", cn.uf);
                    writer.WriteElementString("status", cn.status);
                    writer.WriteElementString("classe", cn.classe);
                    writer.WriteElementString("segmento_gerencia", cn.segmento_gerencia);
                    writer.WriteElementString("gn", cn.gn);
                    writer.WriteElementString("gv", cn.gv);
                    writer.WriteElementString("diretor", cn.diretor);
                    writer.WriteElementString("analista_tlf_vivo", cn.analista_tlf_vivo);
                    writer.WriteElementString("intragov", cn.intragov);
                    writer.WriteElementString("intercompany", cn.intercompany);
                    writer.WriteElementString("feedback_00", cn.feedback_00);
                    writer.WriteElementString("feedback_01", cn.feedback_01);
                    writer.WriteElementString("feedback_02", cn.feedback_02);
                    writer.WriteElementString("feedback_03", cn.feedback_03);
                    writer.WriteElementString("feedback_04", cn.feedback_04);
                    writer.WriteElementString("feedback_05", cn.feedback_05);
                    writer.WriteElementString("pendente_id_analise_conta", cn.pendente_id_analise_conta);
                    writer.WriteElementString("pendente_data_analise_conta", cn.pendente_data_analise_conta);
                    writer.WriteElementString("concluido_id_analise_conta", cn.concluido_id_analise_conta);
                    writer.WriteElementString("concluido_data_analise_conta", cn.concluido_data_analise_conta);
                    writer.WriteElementString("reaberto_id_analise_conta", cn.reaberto_id_analise_conta);
                    writer.WriteElementString("reaberto_data_analise_conta", cn.reaberto_data_analise_conta);
                    writer.WriteElementString("qtd_reg_agrupado", cn.qtd_reg_agrupado);
                    writer.WriteElementString("dt_ult_alteracao", cn.dt_ult_alteracao);
                    writer.WriteElementString("usuario_atualizacao", cn.usuario_atualizacao);
                    writer.WriteElementString("id_analista", cn.id_analista);
                    writer.WriteElementString("id_analista_tmp", cn.id_analista_tmp);
                    writer.WriteElementString("area_atuacao", cn.area_atuacao);
                    writer.WriteElementString("task_force", cn.task_force);
                    writer.WriteElementString("seg_descr", cn.seg_descr);
                    writer.WriteElementString("parcelamento", cn.parcelamento);
                    writer.WriteElementString("escalation", cn.escalation);
                    writer.WriteElementString("conta_bonus", cn.conta_bonus);
                    writer.WriteElementString("obs", cn.obs);
                    writer.WriteElementString("id_portal_demanda", cn.id_portal_demanda);
                    writer.WriteElementString("Faixa_Corte", cn.faixa_Corte);
                    writer.WriteElementString("Regra_PDD", cn.regra_pdd);
                    writer.WriteElementString("SITUACAO_SERVICO", cn.situacao_servico);


                    writer.WriteEndElement();

                    //++contador;
                    //Console.WriteLine(contador);

                }

                writer.WriteEndElement();
                writer.WriteEndDocument();
            }
            #endregion

            bco.Fechar();
            return 1;

        }


        private void CarregarAcordos(List<Acordos> pLstCn, string sConsulta)
        {
            Banco bco = new Banco();
            bco.Selecao(sConsulta) ;

            #region 
            while (bco.Rdr.Read())
            {
                Acordos cn = new Acordos(
                        bco.Rdr["procv"].ToString()
                        , bco.Rdr["id"].ToString()
                        , bco.Rdr["nome_analista"].ToString()
                        , bco.Rdr["nome_analista_tmp"].ToString()
                        , bco.Rdr["feedback"].ToString()
                        , bco.Rdr["area_ofensora"].ToString()
                        , bco.Rdr["tipo_pagto"].ToString()
                        , bco.Rdr["dt_pagto"].ToString()
                        , bco.Rdr["valor_pagto"].ToString()
                        , bco.Rdr["dt_ajuste"].ToString()
                        , bco.Rdr["valor_ajustado"].ToString()
                        , bco.Rdr["resumo_executivo_acao"].ToString()
                        , bco.Rdr["resumo_executivo_problema"].ToString()
                        , bco.Rdr["historico_detalhado"].ToString()
                        , bco.Rdr["dt_follow_up"].ToString()
                        , bco.Rdr["dt_encerramento"].ToString()
                        , bco.Rdr["dt_contato"].ToString()
                        , bco.Rdr["responsavel"].ToString()
                        , bco.Rdr["faixa_fornecedor"].ToString()
                        , bco.Rdr["faixa_fecho"].ToString()
                        , bco.Rdr["faixa_arrecada_inicial"].ToString()
                        , bco.Rdr["faixa_arrecada_atual"].ToString()
                        , bco.Rdr["raiz_grupo"].ToString()
                        , bco.Rdr["grupo"].ToString()
                        , bco.Rdr["raiz"].ToString()
                        , bco.Rdr["cnpj"].ToString()
                        , bco.Rdr["nome"].ToString()
                        , bco.Rdr["nome_cliente"].ToString()
                        , bco.Rdr["tipo"].ToString()
                        , bco.Rdr["empresa"].ToString()
                        , bco.Rdr["conta"].ToString()
                        , bco.Rdr["tel"].ToString()
                        , bco.Rdr["local"].ToString()
                        , bco.Rdr["terminal"].ToString()
                        , bco.Rdr["dv"].ToString()
                        , bco.Rdr["nrc"].ToString()
                        , bco.Rdr["classerv"].ToString()
                        , bco.Rdr["titulo"].ToString()
                        , bco.Rdr["filial"].ToString()
                        , bco.Rdr["lj_cli"].ToString()
                        , bco.Rdr["cod_cli"].ToString()
                        , bco.Rdr["documento_sap"].ToString()
                        , bco.Rdr["doc_fat"].ToString()
                        , bco.Rdr["n_doc_de_para_atlys"].ToString()
                        , bco.Rdr["nota_fiscal"].ToString()
                        , bco.Rdr["venc_atual"].ToString()
                        , bco.Rdr["venc_original"].ToString()
                        , bco.Rdr["dt_process"].ToString()
                        , bco.Rdr["anomes"].ToString()
                        , bco.Rdr["dia_vencimento_lote"].ToString()
                        , bco.Rdr["numero_lote"].ToString()
                        , bco.Rdr["valor_lote"].ToString()
                        , bco.Rdr["saldo_car_26"].ToString()
                        , bco.Rdr["saldo_car_30"].ToString()
                        , bco.Rdr["saldo_car_05"].ToString()
                        , bco.Rdr["saldo_car_14"].ToString()
                        , bco.Rdr["saldo_car_21"].ToString()
                        , bco.Rdr["saldo_car_25"].ToString()
                        , bco.Rdr["saldo_total"].ToString()
                        , bco.Rdr["soma_fxe_pdd_26"].ToString()
                        , bco.Rdr["soma_fxe_pdd_30"].ToString()
                        , bco.Rdr["soma_fxe_pdd_05"].ToString()
                        , bco.Rdr["soma_fxe_pdd_14"].ToString()
                        , bco.Rdr["soma_fxe_pdd_21"].ToString()
                        , bco.Rdr["soma_fxe_pdd_25"].ToString()
                        , bco.Rdr["valor_pagamento"].ToString()
                        , bco.Rdr["valor_ajuste"].ToString()
                        , bco.Rdr["saldo_atual"].ToString()
                        , bco.Rdr["ciclo"].ToString()
                        , bco.Rdr["uf"].ToString()
                        , bco.Rdr["status"].ToString()
                        , bco.Rdr["classe"].ToString()
                        , bco.Rdr["segmento_gerencia"].ToString()
                        , bco.Rdr["gn"].ToString()
                        , bco.Rdr["gv"].ToString()
                        , bco.Rdr["diretor"].ToString()
                        , bco.Rdr["analista_tlf_vivo"].ToString()
                        , bco.Rdr["intragov"].ToString()
                        , bco.Rdr["intercompany"].ToString()
                        , bco.Rdr["feedback_00"].ToString()
                        , bco.Rdr["feedback_01"].ToString()
                        , bco.Rdr["feedback_02"].ToString()
                        , bco.Rdr["feedback_03"].ToString()
                        , bco.Rdr["feedback_04"].ToString()
                        , bco.Rdr["feedback_05"].ToString()
                        , bco.Rdr["pendente_id_analise_conta"].ToString()
                        , bco.Rdr["pendente_data_analise_conta"].ToString()
                        , bco.Rdr["concluido_id_analise_conta"].ToString()
                        , bco.Rdr["concluido_data_analise_conta"].ToString()
                        , bco.Rdr["reaberto_id_analise_conta"].ToString()
                        , bco.Rdr["reaberto_data_analise_conta"].ToString()
                        , bco.Rdr["qtd_reg_agrupado"].ToString()
                        , bco.Rdr["dt_ult_alteracao"].ToString()
                        , bco.Rdr["usuario_atualizacao"].ToString()
                        , bco.Rdr["id_analista"].ToString()
                        , bco.Rdr["id_analista_tmp"].ToString()
                        , bco.Rdr["area_atuacao"].ToString()
                        , bco.Rdr["task_force"].ToString()
                        , bco.Rdr["seg_descr"].ToString()
                        , bco.Rdr["parcelamento"].ToString()
                        , bco.Rdr["escalation"].ToString()
                        , bco.Rdr["conta_bonus"].ToString()
                        , bco.Rdr["obs"].ToString()
                        , bco.Rdr["id_portal_demanda"].ToString()
                        , bco.Rdr["faixa_corte"].ToString()
                        , bco.Rdr["regra_pdd"].ToString()
                        , bco.Rdr["situacao_servico"].ToString()



                    );

                pLstCn.Add(cn);
                
                
                //++contador;
                //Console.WriteLine(contador);
            }


            bco.Fechar();

            #endregion
        }

        public static String TestString(string s)
        {
            if (String.IsNullOrEmpty(s))
                return "";
            else
                return s;
        }




    }
}
