using Newtonsoft.Json;
using System.Net.Http.Headers;
using System.Text;

namespace MvcSkyAir.Services
{
    public class LogicAppService
    {
        private MediaTypeWithQualityHeaderValue header;

        public LogicAppService()
        {
            this.header =
                new MediaTypeWithQualityHeaderValue("application/json");
        }


        public async Task CreatePdf(string url)
        {
            string UrlLp
            = "https://prod-149.westeurope.logic.azure.com:443/workflows/60acfb0986cd493abd958b88cd5f153f/triggers/When_a_HTTP_request_is_received/paths/invoke?api-version=2016-10-01&sp=%2Ftriggers%2FWhen_a_HTTP_request_is_received%2Frun&sv=1.0&sig=mtgdcIyNtX5znqEGwa2q5yY-7PAWJeMRD2ACIINODJM";

            var model = new
            {
                url = url
            };
            using (HttpClient client = new HttpClient())
            {
                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.header);
                string json = JsonConvert.SerializeObject(model);
                StringContent content = new StringContent
                    (json, Encoding.UTF8, "application/json");
                HttpResponseMessage response =
                    await client.PostAsync(UrlLp, content);
                if (response.IsSuccessStatusCode)
                {
                    var data = response.Content;
                }
            }

        }
    }
}
