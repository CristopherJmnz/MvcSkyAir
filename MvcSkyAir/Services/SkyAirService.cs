using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Net.Http.Headers;
using System.Text;
using NugetModelSkyAir.Models;
using MvcSkyAir.Repositories;
using Azure.Core;

namespace MvcSkyAir.Services
{
    public class SkyAirService :ISkyAirRepository
    {
        private string ApiUrl;
        private MediaTypeWithQualityHeaderValue Header;
        public SkyAirService(IConfiguration config)
        {
            this.ApiUrl = config.GetValue<string>("ApiUrls:SkyAirApi");
            this.Header =
                new MediaTypeWithQualityHeaderValue("application/json");

        }


        public async Task<string> GetTokenAsync(string username
            , string password)
        {
            using (HttpClient client = new HttpClient())
            {
                string request = "api/auth/login";
                client.BaseAddress = new Uri(this.ApiUrl);
                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.Header);
                LoginModel model = new LoginModel
                {
                    UserName = username,
                    Password = password
                };
                string jsonData = JsonConvert.SerializeObject(model);
                StringContent content =
                    new StringContent(jsonData, Encoding.UTF8,
                    "application/json");
                HttpResponseMessage response = await
                    client.PostAsync(request, content);
                if (response.IsSuccessStatusCode)
                {
                    string data = await response.Content.ReadAsStringAsync();
                    JObject keys = JObject.Parse(data);
                    string token = keys.GetValue("response").ToString();
                    return token;
                }
                else
                {
                    return null;
                }
            }
        }


        public async Task<T> CallApiAsync<T>(string request)
        {
            using (HttpClient client = new HttpClient())
            {
                client.BaseAddress = new Uri(this.ApiUrl);
                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.Header);
                HttpResponseMessage response = await client.GetAsync(request);
                if (response.IsSuccessStatusCode)
                {
                    T data = await response.Content.ReadAsAsync<T>();
                    return data;
                }
                else
                {
                    return default(T);
                }

            }
        }

        private async Task<T> CallApiAsync<T>
            (string request, string token)
        {
            using (HttpClient client = new HttpClient())
            {
                client.BaseAddress = new Uri(this.ApiUrl);
                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.Header);
                client.DefaultRequestHeaders.Add
                    ("Authorization", "bearer " + token);
                HttpResponseMessage response =
                    await client.GetAsync(request);
                if (response.IsSuccessStatusCode)
                {
                    T data = await response.Content.ReadAsAsync<T>();
                    return data;
                }
                else
                {
                    return default(T);
                }
            }
        }

        public async Task<List<Continente>> GetAllContinentesAsync()
        {
            string request = "api/Continentes/GetContinentes";
            return await this.CallApiAsync<List<Continente>>(request);
        }

        public async Task<List<string>> GetContinentesNameAsync()
        {
            return null;
        }

        public async Task<List<Pais>> GetAllPaisesAsync()
        {
            return null;
        }

        public async Task<Pais> FindPaisByIdAsync(int idPais)
        {
            return null;
        }

        public async Task<List<Pais>> GetPaisesByContinenteAsync(int idContinente)
        {
            return null;
        }

        public async Task<List<CiudadView>> GetAllCiudadesViewAsync()
        {
            string request = "api/CiudadView/GetAllCiudadesView";

            return await this.CallApiAsync<List<CiudadView>>(request);
        }

        public async Task<List<CiudadView>> GetCiudadesViewByContinenteAsync(int idContinente)
        {
            return null;
        }

        public async Task<CiudadView> FindCiudadViewByIdAsync(int idCiudad)
        {
            string request = "api/CiudadView/FindCiudadViewById/" + idCiudad;

            return await this.CallApiAsync<CiudadView>(request); ;
        }

        public async Task<CiudadView> FindCiudadViewByNameAsync(string nombre)
        {
            return null;
        }

        public async Task<List<VueloView>> GetAllVuelosViewAsync()
        {
            return null;
        }

        public async Task<List<VueloView>> GetVuelosViewByContinente(int idContinente)
        {
            return null;
        }

        public async Task<List<VueloView>> GetVuelosViewByPais(int idPais)
        {
            return null;
        }

        public async Task<List<VueloView>> GetVuelosViewByCiudad(int idCiudad)
        {
            return null;
        }

        public async Task<ModelPaginacionVuelosView> GetVuelosPaginacion(int posicion)
        {
            return null;
        }

        public async Task<VueloView> FindVueloViewByIdAsync(int idVuelo)
        {
            return null;
        }

        public async Task<List<VueloView>> SearchVueloAsync(string origen, string destino, DateTime fechaIda, int kids, int adultos)
        {
            return null;
        }

        public async Task<List<VueloView>> SearchVueloAsync(string origen, string destino, DateTime fechaIda, DateTime fechaVuelta, int kids, int adultos)
        {
            return null;
        }

        public async Task<Ciudad> FindCiudadByIdAsync(int idCiudad)
        {
            return null;
        }

        public async Task<List<Ciudad>> GetAllCiudadesAsync()
        {
            return null;
        }

        public async Task<List<Avion>> GetAvionesAsync()
        {
            return null;
        }

        public async Task CreateAvion(string modelo, int capacidad, int velocidad)
        {
           
        }

        public async Task<int> GetMaxAvionIdAsync()
        {
            return 0;
        }

        public async Task CancelarVuelo(int idVuelo)
        {
            
        }

        public async Task CambiarEstadoVuelo(int idVuelo, int idEstado)
        {
            
        }

        public async Task<Vuelo> FindVueloByIdAsync(int idVuelo)
        {
            return null;
        }

        public async Task CreateVuelo(int idAvion, int idOrigen, int idDestino, DateTime fechaSalida, decimal precioEstandar, int idEstado)
        {
            
        }

        public async Task RestarAsientoAsync(int idVuelo)
        {
            
        }

        public async Task<int> GetMaxIdVuelo()
        {
            return 0;
        }

        public async Task<List<EstadoVuelo>> GetEstadosVueloAsync()
        {
            return null;
        }

        public async Task<List<TipoClase>> GetClasesAsync()
        {
            return null;
        }

        public async Task<int> GetMaxBilleteIdAsync()
        {
            return 0;
        }

        public async Task<Billete> CreateBilleteAsync(int idVuelo, int equipajeMano, int equipajeCabina, string asiento, decimal precio, string nombre, string documento, string apellido, string email, string telefonoContacto, int idClase)
        {
            return null;
        }

        public async Task<List<string>> GetAsientosBilletesByVuelo(int idVuelo)
        {
            return null;
        }

        public async Task<BilleteVueloView> FindBilleteViewByApellidoAndIdVueloAsync(string codVuelo, string apellido)
        {
            return null;
        }

        public async Task<BilleteVueloView> FindBilleteViewByIdAsync(int idBillete)
        {
            return null;
        }

        public async Task<List<BilleteVueloView>> GetBilletesViewById(List<int> idBilletes)
        {
            return null;
        }

        public async Task<Usuario> LogInEmpleadoAsync(string email, string password)
        {
            return null;
        }
    }
}
