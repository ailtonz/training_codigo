using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;

namespace JobsFiles
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void btnRUN_Click(object sender, EventArgs e)
        {
            //string[] filePaths = Directory.GetFiles(@"\\10.128.222.63\Relatorios\", "*.7z", SearchOption.AllDirectories);
            //string[] filePaths = Directory.GetFiles(@"\\10.128.222.63\Relatorios\_RELATORIOS\", "*.7z");
            string[] filePaths = Directory.GetFiles(@"\\10.128.222.63\Relatorios\_RELATORIOS\", "*.7z");
            
            lstResult.Items.Clear();

            foreach (string file in filePaths) {
                FileInfo info = new FileInfo(file);
                int val = (info.CreationTime - DateTime.Now).Days;

                if(val <-7){
                    lstResult.Items.Add(file + " | " + (info.CreationTime - DateTime.Now).Days);
                    info.Delete();
                }

            }
            MessageBox.Show("ok");
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
        }

        private void btnTester_Click(object sender, EventArgs e)
        {

            string sPath = "C:/Users/a.dasilva/Desktop/teste.txt";
            string[] stringArray = new string[]
            {
            "option batch abort",
            "option confirm off",
            "open ftps://80397306:41L70N*(&@10.238.3.56:990/ -passive=on",
            "cd 'ciclo de receita\\transito'",
            "option transfer binary",
            "put \\\\10.128.222.63\\siscob\\TRANSF_DADOS\\dados\\TB_CAR_FIXA_IMPORT.txt",
            "close",
            "exit",
            };

            System.IO.File.WriteAllLines(sPath, stringArray);

            MessageBox.Show("ok!");
            

        }
    }
}
