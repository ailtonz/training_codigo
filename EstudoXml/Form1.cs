using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Xml;
using System.IO;

namespace EstudoXml
{
    public partial class frmAgenda : Form
    {

        string sFilePath = "C:/tmp/Agenda.xml";

        public frmAgenda()
        {
            InitializeComponent();
        }

        private void frmAgenda_Load(object sender, EventArgs e)
        {

            lbltitulo.text = carregartitulo();
            carregarcontato();
            criarcontato();

        }

        private string CarregarTitulo()
        {
            XmlDocument xmlDocument = new XmlDocument();
            xmlDocument.Load(sFilePath);
            XmlNode noTitulo = xmlDocument.SelectSingleNode("/agenda/titulo");
            return noTitulo.InnerText;
        }

        private void CarregarContato()
        {
            XmlDocument xmlDocument = new XmlDocument();
            xmlDocument.Load(sFilePath);
            XmlNodeList contatos = xmlDocument.SelectNodes("/agenda/contatos/contato");
            foreach (XmlNode contato in contatos)
            { 
                string representacaoContato = "";
                string id = contato.Attributes["id"].Value;
                string nome = contato.Attributes["nome"].Value;
                string idade = contato.Attributes["idade"].Value;
                representacaoContato = nome + ", " + idade + ", " + id;
                lbxContatos.Items.Add(representacaoContato);
            }

        }

        private void CriarContato()
        {
            XmlDocument xmlDocument = new XmlDocument();
            xmlDocument.Load(sFilePath);
            
            XmlAttribute atributoId = xmlDocument.CreateAttribute("id");
            atributoId.Value = "5";

            XmlAttribute atributoNome = xmlDocument.CreateAttribute("nome");
            atributoNome.Value = "Teste Novo Nome";

            XmlAttribute atributoIdade = xmlDocument.CreateAttribute("idade");
            atributoIdade.Value = "45";

            XmlNode novoContato = xmlDocument.CreateElement("contato");
            novoContato.Attributes.Append(atributoId);
            novoContato.Attributes.Append(atributoNome);
            novoContato.Attributes.Append(atributoIdade);
            XmlNode contatos = xmlDocument.SelectSingleNode("/agenda/contatos");
            contatos.AppendChild(novoContato);
            xmlDocument.Save(@"C:\tmp\Agenda.xml");

        }

        private void button1_Click(object sender, EventArgs e)
        {

        }


    }
}
