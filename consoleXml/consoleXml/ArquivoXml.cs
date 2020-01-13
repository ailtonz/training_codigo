using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Xml;

namespace consoleXml
{
    class ArquivoXml
    {


        //ENCAPSULAMENTO - controlar e proteger as propriedades do metodo
        public String Procv { get; set; }
        public String Id { get; set; }
        public String Nome_analista { get; set; }
        public String Resumo_executivo_acao { get; set; }
        public String Historico_detalhado { get; set; }

        public String sFilePath { get; set; }
        public String sFilePathSave { get; set; }



        //POLIMORFISMO
        public  ArquivoXml() { } 
        
        public  ArquivoXml(
              String pProcv
            , String pId
            , String pNome_analista
            , String pResumo_executivo_acao
            , String pHistorico_detalhado

            , String pFilePath
            , String pFilePathSave

            ) {

                this.Procv = pProcv;
                this.Id = pId;
                this.Nome_analista = pNome_analista;
                this.Resumo_executivo_acao = pResumo_executivo_acao;
                this.Historico_detalhado = pHistorico_detalhado;
                
                this.sFilePath = pFilePath;
                this.sFilePathSave = pFilePathSave;
        }


        private String CarregarTitulo()
        {
            XmlDocument xmlDocument = new XmlDocument();
            xmlDocument.Load(this.sFilePath);

            XmlNode noTitulo = xmlDocument.SelectSingleNode("/agenda/titulo");
            return noTitulo.InnerText;
        }

        public void CriarContato()
        {
            //this.CarregarTitulo();

            XmlDocument xmlDocument = new XmlDocument();
            xmlDocument.Load(this.sFilePath);

            XmlAttribute atb_id = xmlDocument.CreateAttribute("id");
            atb_id.Value = this.Id;

            XmlAttribute atb_nome = xmlDocument.CreateAttribute("nome");
            atb_nome.Value = this.Nome_analista;

            XmlAttribute atb_idade = xmlDocument.CreateAttribute("resumo_executivo_acao");
            atb_idade.Value = this.Resumo_executivo_acao;

            XmlAttribute atb_historico = xmlDocument.CreateAttribute("historico_detalhado");
            atb_historico.Value = this.Historico_detalhado;

            XmlAttribute atb_hrs = xmlDocument.CreateAttribute("hrs");
            DateTime now = DateTime.Now;
            atb_hrs.Value = now.ToString();


            XmlNode novoContato = xmlDocument.CreateElement("contato");
            novoContato.Attributes.Append(atb_id);
            novoContato.Attributes.Append(atb_nome);
            novoContato.Attributes.Append(atb_idade);
            novoContato.Attributes.Append(atb_historico);
            novoContato.Attributes.Append(atb_hrs);

            XmlNode contatos = xmlDocument.SelectSingleNode("/agenda/contatos");
            contatos.AppendChild(novoContato);
            xmlDocument.Save(this.sFilePathSave);

        }

    }
}
