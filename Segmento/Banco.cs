using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;
using System.Data.SqlClient;


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
        public string Solicitacao { get; set; }

        public void Selecao(string sConsulta)
        {
            Abrir();

            Cmd = new SqlCommand(sConsulta, Cnn);
            Rdr = Cmd.ExecuteReader();

        }


        public void carregarSolicitacao(string ID_ANALISTA)
        {
            Abrir();

            string sSolicitacao = "SELECT TOP 1 [NM_ARQUIVO],[DIRETORIO],[QUERY_RESUMO] FROM [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_ACORDOS] WHERE [ID_ANALISTA] = " + ID_ANALISTA + " ORDER BY ID DESC";
            //string sSolicitacao = "SELECT TOP 1 [NM_ARQUIVO],[DIRETORIO],[QUERY_RESUMO] FROM [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_ACORDOS] WHERE [ID_ANALISTA] = 23 ORDER BY ID DESC";


            Cmd = new SqlCommand(sSolicitacao, Cnn);
            Rdr = Cmd.ExecuteReader();

            while (Rdr.Read())
            {
                ArquivoNome     = Rdr["NM_ARQUIVO"].ToString();
                ArquivoCaminho  = Rdr["DIRETORIO"].ToString();
                Solicitacao     = Rdr["QUERY_RESUMO"].ToString();
            }

            //Fechar();

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
