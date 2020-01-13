using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.SqlClient;
using System.Xml;
using System.Xml.Linq;
using System.Data;
using System.Text.RegularExpressions;

namespace exportMIS
{

    class Program
    {

        public string Solicitacao { get; set; }
        public string Arquivo_Nome { get; set; }
        public string Arquivo_Caminho { get; set; }

        static int Main(string[] args)
        {

            //if (args.Length == 0)
            //{
            //    System.Console.WriteLine("Por favor entre com o ID de analista");
            //    return 1;
            //}

            string sConsulta = "SELECT top 100000 * FROM [BKP].[TB_MIS_VPE_FIXA_TUDO] ";

            Program fx = new Program();
            fx.carregarSolicitacao("1");
            //fx.carregarSolicitacao(args[0]);


            sConsulta = sConsulta + fx.Solicitacao;

            fx.arquivoCriar(sConsulta, fx.Arquivo_Caminho + fx.Arquivo_Nome);

            Console.WriteLine("### FIM ###");
            Console.ReadKey();

            return 1;

        }

        public void carregarSolicitacao(string ID_ANALISTA)
        {

            string sSolicitacao = "SELECT TOP 1 [NM_ARQUIVO],[DIRETORIO],[QUERY_RESUMO] FROM [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_SEGMENTO] WHERE [ID_ANALISTA] = " + ID_ANALISTA + " ORDER BY ID DESC";
            SqlDataReader rd = Banco.carregarDados(sSolicitacao);

            while (rd.Read())
            {
                Solicitacao     = rd["QUERY_RESUMO"].ToString();
                Arquivo_Caminho = rd["DIRETORIO"].ToString();
                Arquivo_Nome    = rd["NM_ARQUIVO"].ToString();
            }

        }


        public void arquivoCriar(string sConsulta, string sFile)
        {
            SqlDataReader rd = Banco.carregarDados(sConsulta);

            long contador = 0;

            using (XmlWriter writer = XmlWriter.Create(sFile))
            {
                writer.WriteStartDocument();
                writer.WriteStartElement("Registros");

                while (rd.Read())
                {

                    writer.WriteStartElement("Registro");
                    writer.WriteElementString("PROCV", rd["PROCV"].ToString());
                    writer.WriteElementString("ID", rd["ID"].ToString());
                    writer.WriteElementString("NOME_ANALISTA", rd["NOME_ANALISTA"].ToString());
                    writer.WriteElementString("NOME_ANALISTA_TMP", rd["NOME_ANALISTA_TMP"].ToString());
                    writer.WriteElementString("NOME_LIDER", rd["NOME_LIDER"].ToString());
                    writer.WriteElementString("FEEDBACK", rd["FEEDBACK"].ToString());
                    writer.WriteElementString("AREA_OFENSORA", rd["AREA_OFENSORA"].ToString());
                    writer.WriteElementString("TIPO_PAGTO", rd["TIPO_PAGTO"].ToString());
                    writer.WriteElementString("DT_PAGTO", rd["DT_PAGTO"].ToString());
                    writer.WriteElementString("VALOR_PAGTO", rd["VALOR_PAGTO"].ToString());
                    writer.WriteElementString("DT_AJUSTE", rd["DT_AJUSTE"].ToString());
                    writer.WriteElementString("VALOR_AJUSTADO", rd["VALOR_AJUSTADO"].ToString());
                    writer.WriteElementString("RESUMO_EXECUTIVO_PROBLEMA", rd["RESUMO_EXECUTIVO_PROBLEMA"].ToString());
                    writer.WriteElementString("RESUMO_EXECUTIVO_ACAO", rd["RESUMO_EXECUTIVO_ACAO"].ToString());
                    writer.WriteElementString("HISTORICO_DETALHADO", rd["HISTORICO_DETALHADO"].ToString());
                    writer.WriteElementString("DT_FOLLOW_UP", rd["DT_FOLLOW_UP"].ToString());
                    writer.WriteElementString("DT_CONTATO", rd["DT_CONTATO"].ToString());
                    writer.WriteElementString("RESPONSAVEL", rd["RESPONSAVEL"].ToString());
                    writer.WriteElementString("FAIXA_FORNECEDOR", rd["FAIXA_FORNECEDOR"].ToString());
                    writer.WriteElementString("FAIXA_FECHO", rd["FAIXA_FECHO"].ToString());
                    writer.WriteElementString("FAIXA_ARRECADA_INICIAL", rd["FAIXA_ARRECADA_INICIAL"].ToString());
                    writer.WriteElementString("FAIXA_ARRECADA_ATUAL", rd["FAIXA_ARRECADA_ATUAL"].ToString());
                    writer.WriteElementString("RAIZ_GRUPO", rd["RAIZ_GRUPO"].ToString());
                    writer.WriteElementString("GRUPO", rd["GRUPO"].ToString());
                    writer.WriteElementString("RAIZ", rd["RAIZ"].ToString());
                    writer.WriteElementString("CNPJ", rd["CNPJ"].ToString());
                    writer.WriteElementString("NOME", CleanInvalidXmlChars(rd["NOME"].ToString()));
                    writer.WriteElementString("NOME_CLIENTE", rd["NOME_CLIENTE"].ToString());
                    writer.WriteElementString("TIPO", rd["TIPO"].ToString());
                    writer.WriteElementString("EMPRESA", rd["EMPRESA"].ToString());
                    writer.WriteElementString("CONTA", rd["CONTA"].ToString());
                    writer.WriteElementString("TEL", rd["TEL"].ToString());
                    writer.WriteElementString("LOCAL", rd["LOCAL"].ToString());
                    writer.WriteElementString("TERMINAL", rd["TERMINAL"].ToString());
                    writer.WriteElementString("DV", rd["DV"].ToString());
                    writer.WriteElementString("NRC", rd["NRC"].ToString());
                    writer.WriteElementString("CLASSERV", rd["CLASSERV"].ToString());
                    writer.WriteElementString("TITULO", rd["TITULO"].ToString());
                    writer.WriteElementString("FILIAL", rd["FILIAL"].ToString());
                    writer.WriteElementString("LJ_CLI", rd["LJ_CLI"].ToString());
                    writer.WriteElementString("COD_CLI", rd["COD_CLI"].ToString());
                    writer.WriteElementString("DOCUMENTO_SAP", rd["DOCUMENTO_SAP"].ToString());
                    writer.WriteElementString("DOC_FAT", rd["DOC_FAT"].ToString());
                    writer.WriteElementString("N_DOC_DE_PARA_ATLYS", rd["N_DOC_DE_PARA_ATLYS"].ToString());
                    writer.WriteElementString("NOTA_FISCAL", rd["NOTA_FISCAL"].ToString());
                    writer.WriteElementString("VENC_ATUAL", rd["VENC_ATUAL"].ToString());
                    writer.WriteElementString("VENC_ORIGINAL", rd["VENC_ORIGINAL"].ToString());
                    writer.WriteElementString("DT_PROCESS", rd["DT_PROCESS"].ToString());
                    writer.WriteElementString("ANOMES", rd["ANOMES"].ToString());
                    writer.WriteElementString("DIA_VENCIMENTO_LOTE", rd["DIA_VENCIMENTO_LOTE"].ToString());
                    writer.WriteElementString("NUMERO_LOTE", rd["NUMERO_LOTE"].ToString());
                    writer.WriteElementString("VALOR_LOTE", rd["VALOR_LOTE"].ToString());
                    writer.WriteElementString("SALDO_CAR_26", rd["SALDO_CAR_26"].ToString());
                    writer.WriteElementString("SALDO_CAR_05", rd["SALDO_CAR_05"].ToString());
                    writer.WriteElementString("SALDO_CAR_30", rd["SALDO_CAR_30"].ToString());
                    writer.WriteElementString("SALDO_CAR_14", rd["SALDO_CAR_14"].ToString());
                    writer.WriteElementString("SALDO_CAR_21", rd["SALDO_CAR_21"].ToString());
                    writer.WriteElementString("SALDO_CAR_25", rd["SALDO_CAR_25"].ToString());
                    writer.WriteElementString("SALDO_TOTAL", rd["SALDO_TOTAL"].ToString());
                    writer.WriteElementString("SOMA_FXE_PDD_26", rd["SOMA_FXE_PDD_26"].ToString());
                    writer.WriteElementString("SOMA_FXE_PDD_30", rd["SOMA_FXE_PDD_30"].ToString());
                    writer.WriteElementString("SOMA_FXE_PDD_05", rd["SOMA_FXE_PDD_05"].ToString());
                    writer.WriteElementString("SOMA_FXE_PDD_14", rd["SOMA_FXE_PDD_14"].ToString());
                    writer.WriteElementString("SOMA_FXE_PDD_21", rd["SOMA_FXE_PDD_21"].ToString());
                    writer.WriteElementString("SOMA_FXE_PDD_25", rd["SOMA_FXE_PDD_25"].ToString());
                    writer.WriteElementString("VALOR_PAGAMENTO", rd["VALOR_PAGAMENTO"].ToString());
                    writer.WriteElementString("VALOR_AJUSTE", rd["VALOR_AJUSTE"].ToString());
                    writer.WriteElementString("dt_atrib", rd["dt_atrib"].ToString());
                    writer.WriteElementString("DTCORTE", rd["DTCORTE"].ToString());
                    writer.WriteElementString("SALDO_ATUAL", rd["SALDO_ATUAL"].ToString());
                    writer.WriteElementString("CICLO", rd["CICLO"].ToString());
                    writer.WriteElementString("UF", rd["UF"].ToString());
                    writer.WriteElementString("STATUS", rd["STATUS"].ToString());
                    writer.WriteElementString("CLASSE", rd["CLASSE"].ToString());
                    writer.WriteElementString("SEGMENTO_GERENCIA", rd["SEGMENTO_GERENCIA"].ToString());
                    writer.WriteElementString("GN", rd["GN"].ToString());
                    writer.WriteElementString("GV", rd["GV"].ToString());
                    writer.WriteElementString("DIRETOR", rd["DIRETOR"].ToString());
                    writer.WriteElementString("ANALISTA_TLF_VIVO", rd["ANALISTA_TLF_VIVO"].ToString());
                    writer.WriteElementString("INTRAGOV", rd["INTRAGOV"].ToString());
                    writer.WriteElementString("INTERCOMPANY", rd["INTERCOMPANY"].ToString());
                    writer.WriteElementString("FEEDBACK_00", rd["FEEDBACK_00"].ToString());
                    writer.WriteElementString("FEEDBACK_01", rd["FEEDBACK_01"].ToString());
                    writer.WriteElementString("FEEDBACK_02", rd["FEEDBACK_02"].ToString());
                    writer.WriteElementString("FEEDBACK_03", rd["FEEDBACK_03"].ToString());
                    writer.WriteElementString("FEEDBACK_04", rd["FEEDBACK_04"].ToString());
                    writer.WriteElementString("FEEDBACK_05", rd["FEEDBACK_05"].ToString());
                    writer.WriteElementString("PENDENTE_ID_ANALISE_CONTA", rd["PENDENTE_ID_ANALISE_CONTA"].ToString());
                    writer.WriteElementString("PENDENTE_DATA_ANALISE_CONTA", rd["PENDENTE_DATA_ANALISE_CONTA"].ToString());
                    writer.WriteElementString("CONCLUIDO_ID_ANALISE_CONTA", rd["CONCLUIDO_ID_ANALISE_CONTA"].ToString());
                    writer.WriteElementString("CONCLUIDO_DATA_ANALISE_CONTA", rd["CONCLUIDO_DATA_ANALISE_CONTA"].ToString());
                    writer.WriteElementString("REABERTO_ID_ANALISE_CONTA", rd["REABERTO_ID_ANALISE_CONTA"].ToString());
                    writer.WriteElementString("REABERTO_DATA_ANALISE_CONTA", rd["REABERTO_DATA_ANALISE_CONTA"].ToString());
                    writer.WriteElementString("QTD_REG_AGRUPADO", rd["QTD_REG_AGRUPADO"].ToString());
                    writer.WriteElementString("DT_ULT_ALTERACAO", rd["DT_ULT_ALTERACAO"].ToString());
                    writer.WriteElementString("USUARIO_ATUALIZACAO", rd["USUARIO_ATUALIZACAO"].ToString());
                    writer.WriteElementString("AREA_ATUACAO", rd["AREA_ATUACAO"].ToString());
                    writer.WriteElementString("TASK_FORCE", rd["TASK_FORCE"].ToString());
                    writer.WriteElementString("SEG_DESCR", rd["SEG_DESCR"].ToString());
                    writer.WriteElementString("PARCELAMENTO", rd["PARCELAMENTO"].ToString());
                    writer.WriteElementString("CONTA_BONUS", rd["CONTA_BONUS"].ToString());
                    writer.WriteElementString("FORNECEDOR", rd["FORNECEDOR"].ToString());
                    writer.WriteElementString("ESCALATION", rd["ESCALATION"].ToString());
                    writer.WriteElementString("REGRA_PDD", rd["REGRA_PDD"].ToString());
                    writer.WriteElementString("FAIXA_CORTE", rd["FAIXA_CORTE"].ToString());
                    writer.WriteElementString("PROVISAO", rd["PROVISAO"].ToString());
                    writer.WriteElementString("SITUACAO_SERVICO", rd["SITUACAO_SERVICO"].ToString());
                    writer.WriteElementString("ENDERECO", rd["ENDERECO"].ToString());
                    writer.WriteElementString("SALDO_FX_ENT_26", rd["SALDO_FX_ENT_26"].ToString());
                    writer.WriteElementString("SALDO_PDD_26", rd["SALDO_PDD_26"].ToString());
                    writer.WriteElementString("SALDO_FX_ENT_30", rd["SALDO_FX_ENT_30"].ToString());
                    writer.WriteElementString("SALDO_PDD_30", rd["SALDO_PDD_30"].ToString());
                    writer.WriteElementString("SALDO_FX_ENT_05", rd["SALDO_FX_ENT_05"].ToString());
                    writer.WriteElementString("SALDO_PDD_05", rd["SALDO_PDD_05"].ToString());
                    writer.WriteElementString("SALDO_FX_ENT_14", rd["SALDO_FX_ENT_14"].ToString());
                    writer.WriteElementString("SALDO_PDD_14", rd["SALDO_PDD_14"].ToString());
                    writer.WriteElementString("SALDO_FX_ENT_21", rd["SALDO_FX_ENT_21"].ToString());
                    writer.WriteElementString("SALDO_PDD_21", rd["SALDO_PDD_21"].ToString());
                    writer.WriteElementString("SALDO_FX_ENT_25", rd["SALDO_FX_ENT_25"].ToString());
                    writer.WriteElementString("SALDO_PDD_25", rd["SALDO_PDD_25"].ToString());
                    writer.WriteElementString("RECEBIVEL", rd["RECEBIVEL"].ToString());
                    writer.WriteEndElement();
                    ++contador;
                    Console.WriteLine(contador);
                }

                writer.WriteEndElement();
                writer.WriteEndDocument();
            }

        }



        public static string CleanInvalidXmlChars(string text)
        {
            // From xml spec valid chars: 
            // #x9 | #xA | #xD | [#x20-#xD7FF] | [#xE000-#xFFFD] | [#x10000-#x10FFFF]     
            // any Unicode character, excluding the surrogate blocks, FFFE, and FFFF. 
            string re = @"[^\x09\x0A\x0D\x20-\xD7FF\xE000-\xFFFD\x10000-x10FFFF]";
            return Regex.Replace(text, re, "");
        }





    }
}
