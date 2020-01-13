using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Text.RegularExpressions;

using System.Data;
using System.Data.SqlClient;

using System.IO;
using System.IO.Compression;



//teste de uso.
namespace exportarAcordo
{
    class Program
    {

        static int Main(string[] args) //string[] args
        {
            string sPath = System.IO.Directory.GetCurrentDirectory(); //String sFile = bco.ArquivoCaminho + bco.ArquivoNome;
            Banco bco = new Banco();

            if (args.Length == 0)
            {
                System.Console.WriteLine("Por favor entre com o ID de analista");
                return 1;
            }

            bco.arquivoCriarXml(args[0]);
            //bco.arquivoCriarXml("98");

            //bco.arquivoCompactar(bco.ArquivoNome, bco.ArquivoNome.Substring(0, bco.ArquivoNome.Length - 3) + "7z");


            bco.Fechar();
            return 1;

        }


        //public static String TestString(string s)
        //{
        //    if (String.IsNullOrEmpty(s))
        //        return "";
        //    else
        //        return s;
        //}


        //public static string CleanInvalidXmlChars(string text)
        //{
        //    // From xml spec valid chars: 
        //    // #x9 | #xA | #xD | [#x20-#xD7FF] | [#xE000-#xFFFD] | [#x10000-#x10FFFF]     
        //    // any Unicode character, excluding the surrogate blocks, FFFE, and FFFF. 
        //    string re = @"[^\x09\x0A\x0D\x20-\xD7FF\xE000-\xFFFD\x10000-x10FFFF]";
        //    return Regex.Replace(text, re, "");
        //}

    }
}
