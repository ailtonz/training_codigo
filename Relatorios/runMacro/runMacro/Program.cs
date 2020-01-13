using System;
using Microsoft.Office.Interop.Excel;
using System.IO;

namespace runMacro
{
    class Program
    {
        static int Main(string[] args)
        {

            string sPath = System.IO.Directory.GetCurrentDirectory();

            // Define your Excel Objects
            Application xlApp = new Application();
            Workbook xlWorkBook = null;


            //if (args.Length == 0)
            //{
            //    Console.WriteLine("Por favor entre com o nome do arquivo para processar");
            //    return 1;
            //}


            //Start Excel and open the workbook.
            foreach (string file in Directory.EnumerateFiles(
            sPath, "CAR_ONLINE_INTERCOMPANY_FIXA_MOVEL.xlsm", SearchOption.AllDirectories))
            {
                Console.WriteLine(file);
                xlWorkBook = xlApp.Workbooks.Open(file);
                xlApp.Run("ExtracaoDeDados", Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing);

            }



            ////Start Excel and open the workbook.
            //foreach (string file in Directory.EnumerateFiles(
            //sPath, "*.xlsm", SearchOption.AllDirectories))
            //{
            //    Console.WriteLine(file);
            //    //xlWorkBook = xlApp.Workbooks.Open(sPath + @"\FOCO_VPK_FIXA_MOVEL.xlsm");
            //    xlWorkBook = xlApp.Workbooks.Open(file);
            //    xlApp.Run("ExtracaoDeDados", Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing);

            //}



            //Run the macros by supplying the necessary arguments
            //xlApp.Run("LookupHLink");



            //xlWorkBook.Save();
            //Clean-up: Close the workbook
            xlWorkBook.Close(false);

            //Quit the Excel Application
            xlApp.Quit();


            //~~> Clean Up
            //releaseObject(xlApp);
            //releaseObject(xlWorkBook);


            //Console.ReadKey();

            return 1;


        }


    }
}
