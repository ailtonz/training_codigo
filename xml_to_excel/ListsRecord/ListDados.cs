using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;
using System.Data.SqlClient;

namespace ListsRecord
{
    class ListDados
    {
        static void Main()
        {

            SqlDataReader rdr = null;
            SqlConnection conn = new SqlConnection("Server=172.16.0.13;Database=db_SISCOB;User ID=a.dasilva;Password=41L70N!$");
            SqlCommand cmd = new SqlCommand("SELECT * FROM [DB_SISCOB].[APP_EXCEL].[VW_CONSUMO_CONSOLIDADO_ANALISTA_teste] WHERE RAIZ_GRUPO = '60872173'  AND (ID_ANALISTA = 23 OR ID_ANALISTA_TMP = 54) ", conn);
            //long contador = 0;

            try
            {
                // open the connection
                conn.Open();

                // 1. get an instance of the SqlDataReader
                rdr = cmd.ExecuteReader();

                List<List<String>> registros = new List<List<String>>();

                // CARREGAR TITULOS DE CAMPOS
                List<String> lstTitulos = new List<string>();
                for (int i = 0; i < rdr.FieldCount; i++)
                {
                    lstTitulos.Add(rdr.GetName(i).ToString());
                }
                registros.Add(lstTitulos);


                // 2. print necessary columns of each  record
                while (rdr.Read())
                {
                    // CARREGAR REGISTRO
                    List<String> lstRegistro = new List<string>();
                    for (int i = 0; i < rdr.FieldCount; i++)
                    {
                        lstRegistro.Add(rdr[i].ToString());
                    }
                    registros.Add(lstRegistro);
                }
            }

            catch (Exception e)
            {
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
