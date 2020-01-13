
using System.IO;
using Excel = Microsoft.Office.Interop.Excel;

namespace runVBA_teste
{
    class Program
    {
        Excel.Application oApp;
        Excel.Worksheet oSheet;
        Excel.Workbook oBook;

        static void Main(string[] args)
        {

            string fileTest = "c:\\tmp\\teste.xlsx";


            Program obj = new Program();
            obj.formatarCampos(fileTest);


            //if (File.Exists(fileTest))
            //{
            //    File.Delete(fileTest);
            //}

            //Excel.Application oApp;
            //Excel.Worksheet oSheet;
            //Excel.Workbook oBook;

            //oApp = new Excel.Application();
            //oBook = oApp.Workbooks.Add();
            //oSheet = oBook.Worksheets[1];
            //oSheet.Cells[1, 1] = "ok";
            //oSheet.Name = "shtDados";

            //oBook.SaveAs(fileTest);
            //oBook.Close();
            //oApp.Quit();
        }

        public void formatarCampos(string fileName)
        {


            if (File.Exists(fileName))
            {


                oApp = new Excel.Application();
                oBook = oApp.Workbooks.Add();
                oSheet = oBook.Worksheets[1];






                oBook.SaveAs(fileName);
                oBook.Close();
                oApp.Quit();

            }
        }


    }


}
