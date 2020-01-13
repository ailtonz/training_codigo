using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace Limpeza
{
    class Diretorio
    {
        private string Caminho { get; set; }
        private string ArquivoOuTipo { get; set; }
        private int TempoDePermanencia { get; set; }

        public Diretorio(string caminho, string tipo, int tempo)
        {
            this.Caminho = caminho;
            this.ArquivoOuTipo = tipo;
            this.TempoDePermanencia = tempo;
        }

        public void Limpar()
        {

            string[] filePaths = Directory.GetFiles(this.Caminho, this.ArquivoOuTipo);
            foreach (string file in filePaths)
            {
                FileInfo info = new FileInfo(file);
                int val = (DateTime.Today - info.LastWriteTime.Date).Days;

                try
                {
                    if (val >= this.TempoDePermanencia)
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
