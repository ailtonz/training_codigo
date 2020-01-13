using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace exportarDados
{
    class Program
    {
        static void Main()
        {
            List<List<String>> lstDados = new List<List<String>>();
            CarregarDados Exportacao = new CarregarDados();
            Exportacao.CargaDeDados(lstDados);

            String tmp = "c:/tmp/teste_uso.xlsx";

            //WorkbookInsertText plan = new WorkbookInsertText();
            int i = 0;
            
            // REGISTRO
            foreach (List<String> rg in lstDados) {
                // COLUNAS
                foreach (var col in rg)
                {
                    ++i;
                    Exportacao.InsertText(tmp, col, getColumnLetter(i).ToString(), (uint)i);
                    
                }
                //Console.ReadKey();
            }

            
        }

        public static string getColumnLetter(int pColumnNumber)
        {
            int auxResto;
            int auxASC;
            string auxResult;

            auxASC = 64;
            auxResto = pColumnNumber / 27;

            if (auxResto > 0)
            {
                auxResult = String.Concat((char)((auxResto + auxASC)), (char)((pColumnNumber - (auxResto * 26) + auxASC)));
            }
            else
            {
                auxResult = String.Concat((char)(pColumnNumber + auxASC));
            }

            return auxResult.ToString();

        }





    }
}
