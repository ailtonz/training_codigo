using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text.RegularExpressions;
using System.Diagnostics;


namespace Generico
{
    public static class Banco
    {

        #region Propriedades

        public static SqlConnection conexao { get; private set; }
        //private SqlCommand comando
        private static SqlCommand comando { get; set; }
        //public static DataTable dados { get; set; }

        #endregion

        /// <summary>
        /// Método para conectar o banco.
        /// </summary>
        /// <returns></returns>
        public static bool Conectar()
        {

            string connectionString =  ConfigurationManager.ConnectionStrings["Server"].ConnectionString;
            conexao = new SqlConnection(connectionString);
            try
            {
                conexao.Open();
                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message.ToString());
                return false;
            }
        }

        /// <summary>
        /// Método para desconectar o banco.
        /// </summary>
        /// <returns></returns>
        public static bool Desconectar()
        {
            if (conexao != null)
            {
                conexao.Close();
                return false;
            }
            else
            {
                return true;
            }
        }

        /// <summary>
        /// Método que retorna o resultado da consulta sql em um SqlDataReader
        /// </summary>
        /// <param name="strComando"></param>
        /// <returns> SqlDataReader </returns>
        public static SqlDataReader carregarDados(string strComando)
        {
            Conectar();
            comando = new SqlCommand(strComando, conexao);
            try
            {
                var CarregarDados = comando.ExecuteReader(CommandBehavior.CloseConnection);
                return CarregarDados;
            }
            catch (Exception e)
            {

                Console.WriteLine(e.Message.ToString());
                return null;
            }
        }

        /// <summary>
        /// Método que executa uma instrução sql.
        /// </summary>
        /// <param name="strComando"></param>
        public static void executarInstrucao(String strComando)
        {
            try
            {
                Conectar();
                comando = new SqlCommand(strComando, conexao);
                comando.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message.ToString());
            }
        }


        public static string CleanInvalidXmlChars(string text)
        {
            // From xml spec valid chars: 
            // #x9 | #xA | #xD | [#x20-#xD7FF] | [#xE000-#xFFFD] | [#x10000-#x10FFFF]     
            // any Unicode character, excluding the surrogate blocks, FFFE, and FFFF. 
            string re = @"[^\x09\x0A\x0D\x20-\xD7FF\xE000-\xFFFD\x10000-x10FFFF]";
            return Regex.Replace(text, re, "");
        }


        public void arquivoCompactar(string sourceName, string targetName)
        {

            ProcessStartInfo p = new ProcessStartInfo();
            p.FileName = AppCompactacao;
            p.Arguments = "a \"" + targetName + "\" \"" + sourceName + "\" -mx=9";
            p.WindowStyle = ProcessWindowStyle.Hidden;
            Process x = Process.Start(p);
            x.WaitForExit();

        }

        ///// <summary>
        ///// Método que executa a query sql e retorna o identity.
        ///// </summary>
        ///// <param name="strComando"></param>
        ///// <returns></returns>
        //public static int executarIdentity(String strComando)
        //{
        //    try
        //    {
        //        Conectar();
        //        comando = new SqlCommand(strComando, conexao);
        //        comando.CommandType = CommandType.Text;

        //        //Executa a query sql.

        //        return Convert.ToInt32(comando.ExecuteScalar());

        //    }
        //    catch (Exception e)
        //    {
        //        Console.WriteLine(e.Message.ToString());
        //        return 0; // Duvida sobre este retorno

        //    }
        //}


    }
}
