using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;
using System.IO;


namespace fileCompact
{
    class Program
    {
        static void Main(string[] args)
        {

            //string arquivoCaminho = @"c:\\tmp\";
            string ArquivoOuTipo = @"*.xlsx";


            string[] filePaths = Directory.GetFiles(System.IO.Directory.GetCurrentDirectory(), ArquivoOuTipo);
            foreach (string file in filePaths)
            {
                FileInfo info = new FileInfo(file);
                string sourceName = info.ToString();
                string targetName = "";
                string sDate = DateTime.Today.Year +"" +  DateTime.Today.Month + "" + DateTime.Today.Day;

                int val = (DateTime.Today - info.LastWriteTime.Date).Days;

                try
                {

                    targetName = sourceName.Substring(0, sourceName.Length - 4) + "7z";

                    arquivoCompactar(sourceName, targetName);

                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);


                }

            }

        }

        public static void arquivoCompactar(string sourceName, string targetName)
        {

            ProcessStartInfo p = new ProcessStartInfo();
            p.FileName = @"7z.exe";
            p.Arguments = "a \"" + targetName + "\" \"" + sourceName + "\" -mx=9";
            p.WindowStyle = ProcessWindowStyle.Hidden;
            Process x = Process.Start(p);
            x.WaitForExit();

        }



    }
}
