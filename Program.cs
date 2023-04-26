using MySqlConnector;
using System.Net;
using Titanium.Web.Proxy;
using Titanium.Web.Proxy.EventArguments;
using Titanium.Web.Proxy.Models;


namespace PraksaStreznik
{
    internal class Program
    {
        public static MySqlConnection conn;
        static void Main(string[] args)
        {
            string connString = "";
            using (StreamReader sr = new StreamReader("conf.txt")){
                while (!sr.EndOfStream) {
                connString = sr.ReadLine();
                }
            }
            //Connect to mysql
            Console.WriteLine(connString);
            conn = new MySqlConnection(connString);
            conn.Open();
            Console.WriteLine("Connected to mysql");



            //Start proxy
            var proxyServer = new ProxyServer(userTrustRootCertificate: true);
            var httpProxy = new ExplicitProxyEndPoint(IPAddress.Any, 8080, decryptSsl: true);

            proxyServer.BeforeResponse += OnBeforeResponse;

            proxyServer.AddEndPoint(httpProxy);
            proxyServer.Start();


            Console.WriteLine("Server started on port 8080");
            Console.ReadLine();


            proxyServer.Stop();
        }

        public static async Task OnBeforeResponse(object sender, SessionEventArgs ev)
        {
            var request = ev.HttpClient.Request;
            var response = ev.HttpClient.Response;
                
                try{
                if (response.ContentType?.ToLower().Contains("text/html") == true) {

                await Console.Out.WriteLineAsync(ev.HttpClient.Request.Url);
                string sql = "INSERT INTO uservisits values(NULL, now(), '"+ ev.ClientRemoteEndPoint.Address.ToString()+"', '"+ ev.HttpClient.Request.RequestUri.ToString() + "', '" + ev.HttpClient.Request.RequestUri.Host.ToString()+ "'); ";
                using var command = new MySqlCommand(sql, conn);
                using var reader = command.ExecuteReader();
                }
            }
                catch { }


        }
    }
}




