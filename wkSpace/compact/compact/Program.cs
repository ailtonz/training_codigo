using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.IO;
using System.IO.Compression;

namespace compact
{
    class Program
    {
        static void Main(string[] args)
        {
            string sPath = System.IO.Directory.GetCurrentDirectory();
            foreach (string file in Directory.EnumerateFiles(sPath, "*.xml", SearchOption.AllDirectories))
            {
                try
                {
                    ZipFile.CreateFromDirectory(sPath, file.Substring(0, file.Length - 3) + "zip");
                }
                catch (Exception)
                {

                }

                
            }

        }
    }
}
