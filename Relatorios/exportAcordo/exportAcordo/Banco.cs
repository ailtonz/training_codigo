using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Xml;
using System.Text.RegularExpressions;
using System.Diagnostics;

namespace exportAcordo
{
    class Banco
    {
        public SqlDataReader Rdr { get; set; }
        public SqlConnection Cnn { get; set; }
        public SqlCommand Cmd { get; set; }
        public string CnnString { get; set; }
        public string ArquivoNome { get; set; }
        public string ArquivoCaminho { get; set; }
        public string AppCompactacao { get; set; }
        public string Solicitacao { get; set; }

        public void Selecao(string sConsulta)
        {
            Fechar();
            Abrir();

            Cmd = new SqlCommand(sConsulta, Cnn);
            Rdr = Cmd.ExecuteReader();

        }

        public void carregarSolicitacao(string ID_ANALISTA)
        {
            //string sSolicitacao = "SELECT TOP 1 [NM_ARQUIVO],[DIRETORIO],[QUERY_RESUMO] FROM [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_SEGMENTO] WHERE [ID_ANALISTA] = " + ID_ANALISTA + " ORDER BY ID DESC";
            string sSolicitacao = "SELECT TOP 1 (SELECT TOP 1 [DESCRICAO] FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] where tipo = 'APP_COMPACT' ORDER BY ID DESC) AS APP, [NM_ARQUIVO],[DIRETORIO],[QUERY_RESUMO] FROM [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_ACORDOS] WHERE [ID_ANALISTA] = " + ID_ANALISTA + " ORDER BY ID DESC";
            Selecao(sSolicitacao);

            while (Rdr.Read())
            {
                ArquivoNome = Rdr["NM_ARQUIVO"].ToString();
                ArquivoCaminho = Rdr["DIRETORIO"].ToString();
                Solicitacao = @"Select tmp.* from (" + Rdr["QUERY_RESUMO"].ToString() + ") tmp";
                AppCompactacao = Rdr["APP"].ToString(); //AppCompactacao = @"C:\tmp\OneDrive\_wkspace\App\7-ZipPortable\App\7-Zip\7zG.exe"; 
            }
        }

        public void arquivoCriarXml(string sSQL,string sFileName) {

            Banco bco = new Banco();
            bco.Selecao(sSQL);

            long contador = 0;
            long acumulador = 0;


            // carregar cabecalho
            List<string> lstCabecalho = new List<string>(); for (int i = 0; i < bco.Rdr.FieldCount; i++) { lstCabecalho.Add(bco.Rdr.GetName(i).ToString()); }
            Console.WriteLine(@" >>> LISTAR CABECALHOS - OK");

            // criar arquivo
            //string sPath = System.IO.Directory.GetCurrentDirectory();
            using (XmlWriter writer = XmlWriter.Create(sFileName)) 
            {
                writer.WriteStartDocument(); writer.WriteStartElement("Registros"); // inicio do documento
                while (bco.Rdr.Read()) // listar registros
                {

                    contador++;
                    acumulador++;

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

        }
        
        public void arquivoCompactar(string sourceName, string targetName)
        {

            ProcessStartInfo p = new ProcessStartInfo();
            p.FileName = AppCompactacao;
            p.Arguments = "a \"" + targetName + "\" \"" + sourceName + "\" -mx=9";
            p.WindowStyle = ProcessWindowStyle.Hidden;
            Process x = Process.Start(p);
            x.WaitForExit();

        }

        //public   void arquivoCriarXml(string IdentificarDoArquivo)
        //{

        //    List<string> lstCabecalho = new List<string>(); for (int i = 0; i < Rdr.FieldCount; i++) { lstCabecalho.Add(Rdr.GetName(i).ToString()); }

        //    using (XmlWriter writer = XmlWriter.Create(IdentificarDoArquivo)) // criar arquivo
        //    {
        //        writer.WriteStartDocument(); writer.WriteStartElement("Registros"); // inicio do documento
        //        while (Rdr.Read()) // listar registros
        //        {
        //            writer.WriteStartElement("Registro"); // inicio do elemento
        //            for (int i = 0; i < Rdr.FieldCount; i++) { writer.WriteElementString(lstCabecalho[i].ToString(), CleanInvalidXmlChars(Rdr[i].ToString())); } // escrita do registro
        //            writer.WriteEndElement(); // terminio do elemento
        //        }
        //        writer.WriteEndElement(); writer.WriteEndDocument();
        //    }
        //}

        public static string CleanInvalidXmlChars(string text)
        {
            // From xml spec valid chars: 
            // #x9 | #xA | #xD | [#x20-#xD7FF] | [#xE000-#xFFFD] | [#x10000-#x10FFFF]     
            // any Unicode character, excluding the surrogate blocks, FFFE, and FFFF. 
            string re = @"[^\x09\x0A\x0D\x20-\xD7FF\xE000-\xFFFD\x10000-x10FFFF]";
            return Regex.Replace(text, re, "");
        }


        private void Abrir()
        {

            // "Server=172.16.0.13;Database=db_SISCOB;User ID=a.dasilva;Password=41L70N!$"

            Cnn = new SqlConnection("Server=172.16.0.13;Database=DB_SISCOB;User ID=a.dasilva;Password=41L70N!$;Connection Timeout=0");
            try
            {
                //Cnn.ConnectionTimeout = 0;
                Cnn.Open();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message.ToString());
            }

        }

        public void Fechar()
        {

            if (Rdr != null)
            {
                Rdr.Close();
            }

            if (Cnn != null)
            {
                Cnn.Close();
            }
        }





    }
}
