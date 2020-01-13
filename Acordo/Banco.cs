using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Xml;
using System.Text.RegularExpressions;
using System.Diagnostics;


namespace exportarAcordo
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


        //public void carregarSolicitacao(string ID_ANALISTA)
        //{
        //    Abrir();

        //    string sSolicitacao = "SELECT TOP 1 (SELECT TOP 1 [DESCRICAO] FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] where tipo = 'APP_COMPACT' ORDER BY ID DESC) AS APP, [NM_ARQUIVO],[DIRETORIO],[QUERY_RESUMO] FROM [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_ACORDOS] WHERE [ID_ANALISTA] = " + ID_ANALISTA + " ORDER BY ID DESC";
        //    //string sSolicitacao = "SELECT TOP 1 [NM_ARQUIVO],[DIRETORIO],[QUERY_RESUMO] FROM [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_ACORDOS] WHERE [ID_ANALISTA] = 23 ORDER BY ID DESC";


        //    Cmd = new SqlCommand(sSolicitacao, Cnn);
        //    Rdr = Cmd.ExecuteReader();

        //    while (Rdr.Read())
        //    {
        //        ArquivoNome = Rdr["NM_ARQUIVO"].ToString();
        //        ArquivoCaminho = Rdr["DIRETORIO"].ToString();
        //        Solicitacao = Rdr["QUERY_RESUMO"].ToString();
        //        //AppCompactacao = Rdr["APP"].ToString();
        //        AppCompactacao = @"C:\tmp\OneDrive\_wkspace\App\7-ZipPortable\App\7-Zip\7zG.exe";

        //    }

        //    //Fechar();

        //    Selecao(Solicitacao);

        //}


        public void arquivoCompactar(string sourceName, string targetName)
        {
            ProcessStartInfo p = new ProcessStartInfo();
            //p.FileName = AppCompactacao;
            //p.FileName = @"C:\tmp\OneDrive\_wkspace\App\7-ZipPortable\App\7-Zip\7z.exe";
            p.FileName = @"\\\\172.16.0.11\\SISCOB\\ACORDO\\7z.exe";


            p.Arguments = "a \"" + "\\\\172.16.0.11\\SISCOB\\ACORDO\\" + targetName + "\" \"" + "\\\\172.16.0.11\\SISCOB\\ACORDO\\" + sourceName + "\" -mx=9";
            //p.Arguments = "a \"" + targetName + "\" \"" + sourceName + "\" -mx=9";

            p.WindowStyle = ProcessWindowStyle.Hidden;
            Process x = Process.Start(p);
            x.WaitForExit();

            Console.WriteLine(@" >>> COMPACTAR ARQUIVO - OK");
        }

        public void arquivoCriarXml(string idAnalista)
        {

            string sSolicitacao = "SELECT TOP 1 (SELECT TOP 1 [DESCRICAO] FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] where tipo = 'APP_COMPACT' ORDER BY ID DESC) AS APP, [NM_ARQUIVO],[DIRETORIO],[QUERY_RESUMO] FROM [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_ACORDOS] WHERE [ID_ANALISTA] = " + idAnalista + " ORDER BY ID DESC";
            //string sSolicitacao = "SELECT TOP 1 [NM_ARQUIVO],[DIRETORIO],[QUERY_RESUMO] FROM [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_ACORDOS] WHERE [ID_ANALISTA] = 23 ORDER BY ID DESC";

            // CARREGAR PARAMETOS
            Selecao(sSolicitacao);
            while (Rdr.Read())
            {
                ArquivoNome = Rdr["NM_ARQUIVO"].ToString();
                ArquivoCaminho = Rdr["DIRETORIO"].ToString();
                Solicitacao = Rdr["QUERY_RESUMO"].ToString();
                AppCompactacao = Rdr["APP"].ToString(); //AppCompactacao = @"C:\tmp\OneDrive\_wkspace\App\7-ZipPortable\App\7-Zip\7zG.exe";
            }

            // CARREGAR DADOS
            Selecao(Solicitacao); //Selecao(@"SELECT top 100 * FROM[APP_EXCEL].[VW_CONSUMO_CONSOLIDADO_ACORDO_COM_FILTROS] WHERE RAIZ_GRUPO = '4040432544'  and ID_TIPO IN(1, 2, 4, 5, 9)");

            long contador = 0;
            long acumulador = 0;

            //string sPath = System.IO.Directory.GetCurrentDirectory();
            //string sSQL = Solicitacao;
            Banco bco = new Banco();
            bco.Selecao(Solicitacao);

            // carregar cabecalho
            List<string> lstCabecalho = new List<string>();
            for (int i = 0; i < bco.Rdr.FieldCount; i++) { lstCabecalho.Add(bco.Rdr.GetName(i).ToString()); }

            Console.WriteLine(@" >>> LISTAR CABECALHOS - OK");

            // criar arquivo
            //using (XmlWriter writer = XmlWriter.Create(ArquivoNome))
            using (XmlWriter writer = XmlWriter.Create("\\\\172.16.0.11\\SISCOB\\ACORDO\\" + ArquivoNome))
            //using (XmlWriter writer = XmlWriter.Create(ArquivoNome))
            {
                writer.WriteStartDocument(); writer.WriteStartElement("Registros"); // inicio do documento
                while (bco.Rdr.Read()) // listar registros
                {
                    contador++; acumulador++; //lstRegistro = new List<string>(); // variaveis
                    writer.WriteStartElement("Registro"); // inicio do elemento

                    for (int i = 0; i < bco.Rdr.FieldCount; i++)
                    {
                        writer.WriteElementString(lstCabecalho[i].ToString(), CleanInvalidXmlChars(bco.Rdr[i].ToString()));
                    }

                    writer.WriteEndElement(); // terminio do elemento
                    if (contador > 10000) { Console.WriteLine(acumulador + @" >>> registro criados - OK"); contador = 0; } // mostrar evolução do processo 
                }
                writer.WriteEndElement(); writer.WriteEndDocument();
            }
            Console.WriteLine(@" >>> CRIAR ARQUIVO - OK");
        }

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

            Cnn = new SqlConnection("Server=172.16.0.13;Database=DB_SISCOB;User ID=a.dasilva;Password=41L70N!$");
            try
            {
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
