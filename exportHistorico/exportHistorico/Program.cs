using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Xml;
using System.Xml.Linq;
using System.Data;

namespace exportHistorico
{

    public class registros
    {
        public string Nome { get; set; }
    }


    public class Student
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public int Number { get; set; }
        public string Email { get; set; }
    }


    class Program
    {
        static void Main(string[] args)
        {

            string sFile = "c:/tmp/tb_historico_v01.xml";

            string sConsulta = "Select top 10 * FROM [DB_SISCOB].[bkp].[TB_HISTORICO_v20170208_v1]";
            Program fx = new Program();
            fx.arquivoCriar(sConsulta, sFile);
            fx.arquivoImport(sFile);



            fx.teste01();


            Console.WriteLine("### FIM ###");
            Console.ReadKey();


        }




        private void teste01()
        {

            string xml = @"<?xml version=""1.0"" encoding=""UTF-8""?>
                            <urlset>    
                                <url>
                                    <loc>element1</loc>
                                    <changefreq>daily</changefreq>
                                    <priority>0.2</priority>
                                </url>
                                <url>
                                    <loc>element2</loc>
                                    <changefreq>daily</changefreq>
                                    <priority>0.2</priority>
                                </url>
                            </urlset>";

            XDocument doc = XDocument.Parse(xml);
            List<string> urlList = doc.Root
                                      .Elements("url")
                                      .Elements("loc")
                                      .Select(x => (string)x)
                                      .ToList();
            Console.WriteLine(urlList.Count);

        }


        private void arquivoImport(string sFile)
        {

            XmlTextReader reader = new XmlTextReader(sFile);

            while (reader.Read())
            {
                if (reader.IsStartElement())
                {
                    switch (reader.Name)
                    {
                        case "ID":
                            Console.WriteLine(reader.ReadString());
                            break;
                    }
                }
            }

        }

        private void arquivoLeitura(string sFile)
        {

            XmlTextReader reader = new XmlTextReader(sFile);

            while (reader.Read())
            {

                switch (reader.NodeType)
                {
                    case XmlNodeType.Element: // The node is an element.
                        Console.Write("<" + reader.Name);
                        Console.WriteLine(">");
                        break;
                    case XmlNodeType.Text: //Display the text in each element.
                        Console.WriteLine(reader.Value);
                        break;
                    case XmlNodeType.EndElement: //Display the end of the element.
                        Console.Write("</" + reader.Name);
                        Console.WriteLine(">");
                        break;
                }
            }

            //Console.ReadLine();



        }


        private void arquivoCriar(string sConsulta, string sFile)
        {
            SqlDataReader rd = Banco.carregarDados(sConsulta);

            long contador = 0;

            using (XmlWriter writer = XmlWriter.Create(sFile))
            {
                writer.WriteStartDocument();
                writer.WriteStartElement("Historicos");

                while (rd.Read())
                {

                    writer.WriteStartElement("Historico");
                    writer.WriteElementString("ID", rd["ID"].ToString());
                    writer.WriteElementString("ID_CONSOLIDADO", rd["ID_CONSOLIDADO"].ToString());
                    writer.WriteElementString("ID_SEMANA", rd["ID_SEMANA"].ToString());
                    writer.WriteElementString("ID_FOCO_FEEDBACK", rd["ID_FOCO_FEEDBACK"].ToString());
                    writer.WriteElementString("ID_TIPO_PAGAMENTO", rd["ID_TIPO_PAGAMENTO"].ToString());
                    writer.WriteElementString("ID_ANALISTA", rd["ID_ANALISTA"].ToString());
                    writer.WriteElementString("TIME_STAMP", rd["TIME_STAMP"].ToString());
                    writer.WriteElementString("DT_FOLLOW", rd["DT_FOLLOW"].ToString());
                    writer.WriteElementString("DT_CONTATO", rd["DT_CONTATO"].ToString());
                    writer.WriteElementString("DT_ENCERRAMENTO", rd["DT_ENCERRAMENTO"].ToString());
                    writer.WriteElementString("DT_ABERTURA", rd["DT_ABERTURA"].ToString());
                    writer.WriteElementString("DT_AJUSTE", rd["DT_AJUSTE"].ToString());
                    writer.WriteElementString("DT_PAGAMENTO", rd["DT_PAGAMENTO"].ToString());
                    writer.WriteElementString("VALOR_PAGO", rd["VALOR_PAGO"].ToString());
                    writer.WriteElementString("VALOR_AJUSTE", rd["VALOR_AJUSTE"].ToString());
                    writer.WriteElementString("LOTE", rd["LOTE"].ToString());
                    writer.WriteElementString("GESTAO_CONTA", rd["GESTAO_CONTA"].ToString());
                    writer.WriteElementString("RESPONSAVEL", rd["RESPONSAVEL"].ToString());
                    writer.WriteElementString("RESUMO_EXECUTIVO", rd["RESUMO_EXECUTIVO"].ToString());
                    writer.WriteElementString("HISTORICO_DETALHADO", rd["HISTORICO_DETALHADO"].ToString());
                    writer.WriteElementString("STATUS", rd["STATUS"].ToString());
                    writer.WriteElementString("RE_PROBLEMA", rd["RE_PROBLEMA"].ToString());
                    writer.WriteElementString("RE_ACAO", rd["RE_ACAO"].ToString());
                    writer.WriteElementString("HD_ACUMULADO", rd["HD_ACUMULADO"].ToString());
                    writer.WriteElementString("CBPM", rd["CBPM"].ToString());
                    writer.WriteElementString("ID_PORTAL_DEMANDA", rd["ID_PORTAL_DEMANDA"].ToString());
                    writer.WriteElementString("NUMERO_BOLETO", rd["NUMERO_BOLETO"].ToString());
                    writer.WriteElementString("DATA_EMISSAO_BOLETO", rd["DATA_EMISSAO_BOLETO"].ToString());
                    writer.WriteElementString("OBS", rd["OBS"].ToString());
                    writer.WriteElementString("ID_GESTAO_CONTA", rd["ID_GESTAO_CONTA"].ToString());
                    writer.WriteEndElement();
                    ++contador;
                    Console.WriteLine(contador);
                }

                writer.WriteEndElement();
                writer.WriteEndDocument();
            }


        }





    }
}
