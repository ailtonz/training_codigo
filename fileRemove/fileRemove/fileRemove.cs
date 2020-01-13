using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace fileRemove
{
    class fileRemove
    {
        static void Main(string[] args)
        {
            string[] filePaths = Directory.GetFiles(@"C:\tmp\testes\", "*.zip");
            foreach (string file in filePaths)
            {
                FileInfo info = new FileInfo(file);
                int val = (info.LastWriteTime - DateTime.Now).Days;

                try
                {
                    if (val < -7)
                    {
                        info.Delete();
                    }
                }
                catch
                { }
                
            }

        }
    }
}
