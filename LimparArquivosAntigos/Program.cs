using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;
using System.Data.SqlClient;



namespace Limpeza
{
    class Program
    {
        static void Main(string[] args)
        {
            //Diretorio dir = new Diretorio(@"c:\tmp\testes\", "*.zip", 1);
            //dir.Limpar();

            Program rd = new Program();
            rd.SimpleRead();
            

        }

        public void SimpleRead()
        {

            SqlDataReader rdr = null;
            SqlConnection conn = new SqlConnection("Server=TLF-PRD-WBD04.cloudapp.net;Database=db_SISCOB;User ID=a.dasilva;Password=41L70N!$");
            SqlCommand cmd = new SqlCommand("SELECT [DESCRICAO] ,[DESCRICAO_02] ,[DESCRICAO_03]  FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE]  WHERE [TIPO] = 'LIMPAR_DIRETORIOS' ", conn);

            try
            {
                // open the connection
                conn.Open();

                // 1. get an instance of the SqlDataReader
                rdr = cmd.ExecuteReader();

                // 2. print necessary columns of each  record
                while (rdr.Read())
                {
                    // get the results of each column
                    string diretorio = (string)rdr["DESCRICAO"];
                    string tipo = (string)rdr["DESCRICAO_02"];
                    string permanencia = (string)rdr["DESCRICAO_03"];

                    Diretorio dir = new Diretorio(diretorio, tipo, Convert.ToInt32(permanencia));
                    dir.Limpar();

                }
                //Console.ReadKey();// enter
                //Console.ReadLine();// entrada de dados

            }

            finally
            {
                // 3. close the reader
                if (rdr != null)
                {
                    rdr.Close();
                }

                // close the connection
                if (conn != null)
                {
                    conn.Close();
                }
            }




        }


    }
}
