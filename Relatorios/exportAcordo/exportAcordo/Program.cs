namespace exportAcordo
{
    class Program
    {
        static int Main(string[] args)
        {

            Banco bco = new Banco();
            if (args.Length == 0)
            {
                System.Console.WriteLine("Por favor entre com o ID de analista");
                return 1;
            }

            bco.carregarSolicitacao(args[0]);
            bco.arquivoCriarXml(bco.Solicitacao,bco.ArquivoNome);
            //bco.arquivoCompactar(bco.ArquivoCaminho + "\\" + bco.ArquivoNome, bco.ArquivoCaminho + "\\" + bco.ArquivoNome.Substring(0, bco.ArquivoNome.Length - 3) + "7z");

            return 1;

        }



    }
}
