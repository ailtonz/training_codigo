using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Excel = Microsoft.Office.Interop.Excel; 

namespace excel
{
    class excel
    {
        static void Main(string[] args)
        {

            excel rd = new excel();
            rd.upload_excel();

        }

        public void upload_excel() {

            try
            {

                System.Data.OleDb.OleDbConnection MyConnection;

                System.Data.OleDb.OleDbCommand myCommand = new System.Data.OleDb.OleDbCommand();

                string sql = null;
                string cnn = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=Z:\\_siscob\\CENARIO_MODELO.xlsm;Extended Properties='Excel 12.0 Xml;HDR=YES';";
                MyConnection = new System.Data.OleDb.OleDbConnection(cnn);

                MyConnection.Open();

                myCommand.Connection = MyConnection;

                sql = "Insert into [dados$] (PROCV,id) values('5','e')";

                myCommand.CommandText = sql;

                myCommand.ExecuteNonQuery();

                MyConnection.Close();

            }

            finally
            {

                Console.ReadKey();// ente

            }

        
        
        }

    }
}
