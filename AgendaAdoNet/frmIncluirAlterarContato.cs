using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using AgendaAdoNet.Classes;
using AgendaAdoNet.DAO;

namespace AgendaAdoNet
{
    public partial class frmIncluirAlterarContato : Form
    {
        private Contato contato;
        public frmIncluirAlterarContato(Contato contato = null)
        {
            this.contato = contato;
            InitializeComponent();
        }

        public frmIncluirAlterarContato()
        {
            InitializeComponent();
        }

        private void frmIncluirAlterarContato_Load(object sender, EventArgs e)
        {
            if (this.contato != null)
            {
                txtNome.Text = this.contato.Nome;
                txtEmail.Text = this.contato.Email;
                txtTelefone.Text = this.contato.Telefone.ToString();
            }
            else
            {
                txtNome.Text = string.Empty;
                txtEmail.Text = string.Empty;
                txtTelefone.Text = string.Empty;
            }
            txtNome.Focus();
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnSalvar_Click(object sender, EventArgs e)
        {
            ContatoDAO contatoDao = new ContatoDAO();
            if (this.contato == null)
            {
                Contato contato = new Contato
                {
                    Nome = txtNome.Text,
                    Email = txtEmail.Text,
                    Telefone = Convert.ToInt64(txtTelefone.Text)
                };
                contatoDao.Inserir(contato);
            }
            else
            {
                this.contato.Nome = txtNome.Text;
                this.contato.Email = txtEmail.Text;
                this.contato.Telefone = Convert.ToInt32(txtTelefone.Text);
                contatoDao.Atualizar(this.contato);
            }
            this.Close();
        }
    }
}
