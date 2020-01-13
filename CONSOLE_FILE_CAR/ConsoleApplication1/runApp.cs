using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace ConsoleApplication1
{
    class runApp
    {
        static void Main(string[] args)
        {

            ReadFromFile fl = new ReadFromFile();
            fl.readFirstLine();


            //Program rd = new Program();
            //rd.SimpleRead();

        }
               

        public void SimpleRead()
        {

            // declare the SqlDataReader, which is used in
            // both the try block and the finally block
            SqlDataReader rdr = null;

            // create a connection object
            SqlConnection conn = new SqlConnection("Data Source=10.128.222.66;Initial Catalog=SISCOB;User ID=SISCOB_HML;Password=@Cc3nture.[0m$3");

            // create a command object
            SqlCommand cmd = new SqlCommand("select top 10 * from [SISCOB].[dbo].[TB_PERFIL]", conn);

            try
            {
                // open the connection
                conn.Open();

                // 1. get an instance of the SqlDataReader
                rdr = cmd.ExecuteReader();

                // print a set of column headers
                Console.WriteLine("Contact Name             City                Company Name");
                Console.WriteLine("------------             ------------        ------------");

                // 2. print necessary columns of each  record
                while (rdr.Read())
                {
                    // get the results of each column
                    //string contact = (bigint)rdr["ID"];
                    string company = (string)rdr["DESCRICAO"];
                    //string city    = (string)rdr["City"];

                    // print out the results
                    //Console.Write("{0,-25}", contact);
                    //Console.Write("{0,-20}", city);
                    Console.Write("{0,-25}", company);
                    Console.WriteLine();
                }
                Console.ReadKey();// enter
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


