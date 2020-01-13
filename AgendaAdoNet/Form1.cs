using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using AgendaAdoNet.DAO;
using AgendaAdoNet.Classes;

namespace AgendaAdoNet
{
    public partial class frmAgenda : Form
    {
        public frmAgenda()
        {
            InitializeComponent();
        }

        private void frmAgenda_Load(object sender, EventArgs e)
        {
            ContatoDAO contatoDao = new ContatoDAO();
            DataTable dataTable = contatoDao.GetContatos();
            dgvAgenda.DataSource = dataTable;
            //DataSet ds = contatoDao.GetContatosSet();
            //dgvAgenda.DataSource = ds.Tables["TB_CONTATO"];
            dgvAgenda.Refresh();
            CarregarDataGridView();
        }

        private void btnExcluir_Click(object sender, EventArgs e)
        {

            //if (dgvAgenda.RowCount > 0)
            if (dgvAgenda.CurrentCell != null)
            {

                if (MessageBox.Show("Deseja Realizar a Exclusão do Registro", "Excluir Registro", MessageBoxButtons.YesNo) == DialogResult.Yes)
                {
                    int id = Convert.ToInt32(dgvAgenda.CurrentRow.Cells[0].Value);
                    ContatoDAO contatoDao = new ContatoDAO();
                    contatoDao.Excluir(id);
                    CarregarDataGridView();
                }
            }
            else
            {
                MessageBox.Show("Não Existe Nenhum Registro Selecionado Para Realizar a Exclusão!", "Excluir Registro", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }

        }

        private void CarregarDataGridView()
        {
            ContatoDAO contatoDao = new ContatoDAO();
            DataTable dataTable = contatoDao.GetContatos();
            dgvAgenda.DataSource = dataTable;
            dgvAgenda.Refresh();
        }

        private void btnAdiciobar_Click(object sender, EventArgs e)
        {
            frmIncluirAlterarContato form = new frmIncluirAlterarContato();
            form.ShowDialog();
            CarregarDataGridView();
        }

        private void btnAlterar_Click(object sender, EventArgs e)
        {
            Contato contato = new Contato
            //contato.Id = Convert.ToInt32(dgvAgenda.CurrentRow.Cells[0].Value);
            //contato.Nome = dgvAgenda.CurrentRow.Cells[1].Value.ToString();
            //contato.Email = dgvAgenda.CurrentRow.Cells[2].Value.ToString();
            //contato.Telefone = Convert.ToInt64(dgvAgenda.CurrentRow.Cells[3].Value);

            {
                Id = Convert.ToInt32(dgvAgenda.CurrentRow.Cells[0].Value),
                Nome = dgvAgenda.CurrentRow.Cells[1].Value.ToString(),
                Email = dgvAgenda.CurrentRow.Cells[2].Value.ToString(),
                Telefone = Convert.ToInt32(dgvAgenda.CurrentRow.Cells[3].Value)
            };

            frmIncluirAlterarContato form = new frmIncluirAlterarContato(contato);
            form.ShowDialog();
            CarregarDataGridView();
        }

       
    }
}
