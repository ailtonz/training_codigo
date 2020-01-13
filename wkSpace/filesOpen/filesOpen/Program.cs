using System;
using System.IO;
using Microsoft.Office.Interop.Excel;

namespace filesOpen
{
    class Program
    {
        static void Main(string[] args)
        {


            string arquivoCaminho = @"c:\\tmp\";
            string ArquivoOuTipo = @"*.xlsx";


            string[] filePaths = Directory.GetFiles(arquivoCaminho, ArquivoOuTipo);
            foreach (string file in filePaths)
            {
                FileInfo info = new FileInfo(file);


                int val = (DateTime.Today - info.LastWriteTime.Date).Days;

                try
                {

                    abrir3(info.ToString());


                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                    

                }

            }

        }


        private static void abrir(string path)
        {

            Microsoft.Office.Interop.Excel.Application oXL;
            Microsoft.Office.Interop.Excel.Workbook mWorkBook;
            Microsoft.Office.Interop.Excel.Sheets mWorkSheets;

            oXL = new Microsoft.Office.Interop.Excel.Application();
            //oXL.Visible = true;
            oXL.DisplayAlerts = false;
            mWorkBook = oXL.Workbooks.Open(path, 0, false, 5, "", "", false, Microsoft.Office.Interop.Excel.XlPlatform.xlWindows, "", true, false, 0, true, false, false);
            //Get all the sheets in the workbook
            mWorkSheets = mWorkBook.Worksheets;
            foreach (Microsoft.Office.Interop.Excel.Worksheet pivotSheet in mWorkSheets)
            {
                Microsoft.Office.Interop.Excel.PivotTables pivotTables = pivotSheet.PivotTables();
                int pivotTablesCount = pivotTables.Count;
                if (pivotTablesCount > 0)
                {
                    for (int i = 1; i <= pivotTablesCount; i++)
                    {
                        pivotTables.Item(i).RefreshTable(); //The Item method throws an exception
                    }
                }
            }

        }


        private static void abrir2(string path) {
            Microsoft.Office.Interop.Excel.Application xlApp;
            Microsoft.Office.Interop.Excel.Workbook xlWorkbook;
            Microsoft.Office.Interop.Excel.Sheets xlWorksheet;


            //Create COM Objects. Create a COM object for everything that is referenced
            xlApp = new Microsoft.Office.Interop.Excel.Application();
            xlWorkbook = xlApp.Workbooks.Open(path);
            xlWorksheet = xlWorkbook.Sheets[1];
        }

        private static void abrir3(string path)
        {
            Application xlApp = new Application();
            Workbook xlWorkBook = null;


            //Start Excel and open the workbook.
            xlWorkBook = xlApp.Workbooks.Open(path);

            xlWorkBook.Close(false);

            xlApp.Quit();

        }






    }
}
