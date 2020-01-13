using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace Employee
{
    class Program
    {
        class Employee
        {
           
            // propriedades
            private int _id;
            string _firstName;
            string _lastName;
            int _salary;

            // métodos // contrutor
            public Employee(int id, string firstName, string lastName, int salary)
            {
                this._id = id;
                this._firstName = firstName;
                this._lastName = lastName;
                this._salary = salary;
            }

            // métodos
            public int Id { get { return _id; } }
            public string FirstName { get { return _firstName; } }
            public string LastName { get { return _lastName; } }
            public int Salary { get { return _salary; } }
        }

        static void Main()
        {
            Employee[] employees = new Employee[4];
            employees[0] = new Employee(1, "David", "Smith", 10000);
            employees[1] = new Employee(3, "Mark", "Drinkwater", 30000);
            employees[2] = new Employee(4, "Norah", "Miller", 20000);
            employees[3] = new Employee(12, "Cecil", "Walker", 120000);

            using (XmlWriter writer = XmlWriter.Create("c:/tmp/employees.xml"))
            {
                writer.WriteStartDocument();
                writer.WriteStartElement("Employees");

                foreach (Employee employee in employees)
                {
                    writer.WriteStartElement("Employee");

                    writer.WriteElementString("ID", employee.Id.ToString());
                    writer.WriteElementString("FirstName", employee.FirstName);
                    writer.WriteElementString("LastName", employee.LastName);
                    writer.WriteElementString("Salary", employee.Salary.ToString());

                    writer.WriteEndElement();
                }

                writer.WriteEndElement();
                writer.WriteEndDocument();
            }
        }
    }
}


//private string _PROCV;
//private string _ID;
//private string _NOME_ANALISTA;
//private string _NOME_ANALISTA_TMP;
//private string _FEEDBACK;
//private string _AREA_OFENSORA;
//private string _TIPO_PAGTO;
//private string _DT_PAGTO;
//,REPLACE(CONVERT(VARCHAR(20), VALOR_PAGTO), ''.'', '','') as VALOR_PAGTO
//,DT_AJUSTE
//,REPLACE(CONVERT(VARCHAR(20), VALOR_AJUSTADO), ''.'', '','') as VALOR_AJUSTADO
//,CONVERT(VARCHAR(255), RESUMO_EXECUTIVO_ACAO) as RESUMO_EXECUTIVO_ACAO
//,CONVERT(VARCHAR(255), RESUMO_EXECUTIVO_PROBLEMA) as RESUMO_EXECUTIVO_PROBLEMA
//,CONVERT(VARCHAR(255), HISTORICO_DETALHADO) as HISTORICO_DETALHADO
//,DT_FOLLOW_UP
//,DT_ENCERRAMENTO
//,DT_CONTATO
//,CONVERT(VARCHAR(255), RESPONSAVEL) as RESPONSAVEL
//,FAIXA_FORNECEDOR
//,FAIXA_FECHO
//,FAIXA_ARRECADA_INICIAL
//,FAIXA_ARRECADA_ATUAL
//,RAIZ_GRUPO
//,GRUPO
//,RAIZ
//,CNPJ
//,NOME
//,NOME_CLIENTE
//,TIPO
//,EMPRESA
//,CONTA
//,TEL
//,LOCAL
//,TERMINAL
//,DV
//,NRC
//,CLASSERV
//,TITULO
//,FILIAL
//,LJ_CLI
//,COD_CLI
//,DOCUMENTO_SAP
//,DOC_FAT
//,N_DOC_DE_PARA_ATLYS
//,NOTA_FISCAL
//,VENC_ATUAL
//,VENC_ORIGINAL
//,DT_PROCESS
//,ANOMES
//,DIA_VENCIMENTO_LOTE
//,NUMERO_LOTE
//,REPLACE(CONVERT(VARCHAR(20), VALOR_LOTE), ''.'', '','') as VALOR_LOTE
//,REPLACE(CONVERT(VARCHAR(20), SALDO_CAR_26), ''.'', '','') as SALDO_CAR_26
//,REPLACE(CONVERT(VARCHAR(20), SALDO_CAR_05), ''.'', '','') as SALDO_CAR_05
//,REPLACE(CONVERT(VARCHAR(20), SALDO_CAR_14), ''.'', '','') as SALDO_CAR_14
//,REPLACE(CONVERT(VARCHAR(20), SALDO_CAR_21), ''.'', '','') as SALDO_CAR_21
//,REPLACE(CONVERT(VARCHAR(20), SALDO_CAR_25), ''.'', '','') as SALDO_CAR_25
//,REPLACE(CONVERT(VARCHAR(20), SALDO_TOTAL), ''.'', '','') as SALDO_TOTAL
//,REPLACE(CONVERT(VARCHAR(20), SOMA_FXE_PDD_26), ''.'', '','') as SOMA_FXE_PDD_26
//,REPLACE(CONVERT(VARCHAR(20), SOMA_FXE_PDD_05), ''.'', '','') as SOMA_FXE_PDD_05
//,REPLACE(CONVERT(VARCHAR(20), SOMA_FXE_PDD_14), ''.'', '','') as SOMA_FXE_PDD_14
//,REPLACE(CONVERT(VARCHAR(20), SOMA_FXE_PDD_21), ''.'', '','') as SOMA_FXE_PDD_21
//,REPLACE(CONVERT(VARCHAR(20), SOMA_FXE_PDD_25), ''.'', '','') as SOMA_FXE_PDD_25
//,REPLACE(CONVERT(VARCHAR(20), VALOR_PAGAMENTO), ''.'', '','') as VALOR_PAGAMENTO
//,REPLACE(CONVERT(VARCHAR(20), VALOR_AJUSTE), ''.'', '','') as VALOR_AJUSTE
//,REPLACE(CONVERT(VARCHAR(20), SALDO_ATUAL), ''.'', '','') as SALDO_ATUAL
//,CICLO
//,UF
//,STATUS
//,CLASSE
//,SEGMENTO_GERENCIA
//,GN
//,GV
//,DIRETOR
//,ANALISTA_TLF_VIVO
//,INTRAGOV
//,INTERCOMPANY
//,FEEDBACK_00
//,FEEDBACK_01
//,FEEDBACK_02
//,FEEDBACK_03
//,FEEDBACK_04
//,FEEDBACK_05
//,PENDENTE_ID_ANALISE_CONTA
//,PENDENTE_DATA_ANALISE_CONTA
//,CONCLUIDO_ID_ANALISE_CONTA
//,CONCLUIDO_DATA_ANALISE_CONTA
//,REABERTO_ID_ANALISE_CONTA
//,REABERTO_DATA_ANALISE_CONTA
//,QTD_REG_AGRUPADO
//,DT_ULT_ALTERACAO
//,CONVERT(VARCHAR(255), USUARIO_ATUALIZACAO) as USUARIO_ATUALIZACAO
//,ID_ANALISTA
//,ID_ANALISTA_TMP
//,AREA_ATUACAO
//,TASK_FORCE
//,SEG_DESCR
//,PARCELAMENTO
//,ESCALATION
//,CONTA_BONUS
//,OBS
//,PENDENTE_ID_ANALISE_CONTA