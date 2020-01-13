using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace wfa_teste_01
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void btnSpeak_Click(object sender, EventArgs e)
        {
            int len = Talker.BlahBlahBlah(txtSayThis.Text, (int)numericUpDown1.Value);
            MessageBox.Show("The message length is " + len);
        }
    }
}
