using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using AgendaAdoNet.Classes;


namespace AgendaAdoNet.DAO
{
    public class ContatoDAO
    {
        public DataTable GetContatos()
        {
            DbConnection conexao = DAOUtils.GetConexao();
            DbCommand comando = DAOUtils.GetComando(conexao);
            comando.CommandType = CommandType.Text;
            comando.CommandText = "SELECT * FROM [AulasCSharp].[dbo].[TB_CONTATO];";
            DbDataReader reader = DAOUtils.GetDataReader(comando);
            DataTable dataTable = new DataTable();
            dataTable.Load(reader);
            return dataTable;
        }

        public DataSet GetContatosSet()
        {
            DbConnection conexao = DAOUtils.GetConexao();
            DbCommand comando = DAOUtils.GetComando(conexao);
            comando.CommandType = CommandType.Text;
            comando.CommandText = "SELECT * FROM [AulasCSharp].[dbo].[TB_CONTATO];";
            DbDataAdapter adapter = new SqlDataAdapter((SqlCommand)comando);
            DataSet ds = new DataSet();
            adapter.Fill(ds, "TB_CONTATO");
            return ds;
            
            //DbDataReader reader = DAOUtils.GetDataReader(comando);
            //DataTable dataTable = new DataTable();
            //dataTable.Load(reader);
            //return dataTable;
        }

        public void Excluir(int id)
        {
            DbConnection conexao = DAOUtils.GetConexao();
            DbCommand comando = DAOUtils.GetComando(conexao);
            comando.CommandType = CommandType.Text;
            comando.CommandText = "DELETE FROM TB_CONTATO WHERE ID = @id";
            comando.Parameters.Add(new SqlParameter("@id", id));
            comando.ExecuteNonQuery(); 
        }

        public void Inserir(Contato contato)
        {
            DbConnection conexao = DAOUtils.GetConexao();
            DbCommand comando = DAOUtils.GetComando(conexao);
            comando.CommandType = CommandType.Text;
            comando.CommandText = "INSERT INTO [AulasCSharp].[dbo].[TB_CONTATO] ([NOME],[EMAIL],[TELEFONE]) VALUES (@nome,@email,@telefone)";
            comando.Parameters.Add(new SqlParameter("@nome", contato.Nome));
            comando.Parameters.Add(new SqlParameter("@email", contato.Email));
            comando.Parameters.Add(new SqlParameter("@telefone", contato.Telefone));
            comando.ExecuteNonQuery(); 
        }

        public void Atualizar(Contato contato)
        {
            DbConnection conexao = DAOUtils.GetConexao();
            DbCommand comando = DAOUtils.GetComando(conexao);
            comando.CommandType = CommandType.Text;
            comando.CommandText = "UPDATE TB_CONTATO SET [NOME] = @nome, [EMAIL] = @email, [TELEFONE] = @telefone WHERE ID = @id";
            comando.Parameters.Add(new SqlParameter("@id", contato.Id));
            comando.Parameters.Add(new SqlParameter("@nome", contato.Nome));
            comando.Parameters.Add(new SqlParameter("@email", contato.Email));
            comando.Parameters.Add(new SqlParameter("@telefone", contato.Telefone));
            comando.ExecuteNonQuery();
        }
    }   
}
