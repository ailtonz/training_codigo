using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.IO;

using System.Data;
using System.Data.SqlClient;


namespace consoleXml
{
    class Program
    {

        //string sFilePath = @"C:/tmp/Agenda.xml";

        static void Main(string[] args)
        {
            //exportDados();

            //Program rd = new Program();
            //rd.CarregarTitulo();

            Program Contato = new Program();
            Contato.exportDados();


            Console.ReadKey();
        }
                
        private void exportDados()
        {

            SqlDataReader rdr = null;
            SqlConnection conn = new SqlConnection("Server=TLF-PRD-WBD04.cloudapp.net;Database=db_SISCOB;User ID=a.dasilva;Password=41L70N!$");
            SqlCommand cmd = new SqlCommand("SELECT Procv,Id,Nome_analista,Resumo_executivo_acao,HISTORICO_DETALHAD FROM [DB_SISCOB].[APP_EXCEL].[VW_CONSUMO_CONSOLIDADO_ANALISTA_teste] WHERE RAIZ_GRUPO = 4061082582  AND (ID_ANALISTA = 41 OR ID_ANALISTA_TMP = 41) ", conn);
            long contador=0;

            try
            {
                // open the connection
                conn.Open();

                // 1. get an instance of the SqlDataReader
                rdr = cmd.ExecuteReader();

                // 2. print necessary columns of each  record
                while (rdr.Read())
                {


                    ArquivoXml rd = new ArquivoXml(

                        rdr["Procv"].ToString()
                        , rdr["Id"].ToString()
                        , rdr["Nome_analista"].ToString()
                        , rdr["Resumo_executivo_acao"].ToString()
                        , rdr["HISTORICO_DETALHADO"].ToString()


                        , "C:\\tmp\\cenario.xml"
                        , "C:\\tmp\\cenario.xml"

                        );

                    rd.CriarContato();


                    ++contador;
                    Console.WriteLine(contador);

                }
                //Console.ReadKey();// enter
                //Console.ReadLine();// entrada de dados
            }


            catch (Exception e ){
                Console.WriteLine(e.Message.ToString());
            }
            finally
            {
                // 3. close the reader
                if (rdr != null)
                { rdr.Close(); }

                // close the connection
                if (conn != null)
                {
                    conn.Close();
                }
            }


        }

    }
}
