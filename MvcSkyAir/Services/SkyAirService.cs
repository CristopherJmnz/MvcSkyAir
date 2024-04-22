using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Net.Http.Headers;
using System.Text;
using NugetModelSkyAir.Models;
using MvcSkyAir.Repositories;
using MvcSkyAir.Helpers;

namespace MvcSkyAir.Services
{
    public class SkyAirService : ISkyAirRepository
    {
        private string ApiUrl;
        private MediaTypeWithQualityHeaderValue Header;
        private IHttpContextAccessor httpContextAccessor;
        public SkyAirService(IConfiguration config, IHttpContextAccessor httpContextAccessor)
        {
            this.ApiUrl = config.GetValue<string>("ApiUrls:SkyAirApi");
            this.Header =
                new MediaTypeWithQualityHeaderValue("application/json");
            this.httpContextAccessor = httpContextAccessor;
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
            string request = "api/Continentes/GetContinentesNames";
            return await this.CallApiAsync<List<string>>(request);
        }

        public async Task<List<Pais>> GetAllPaisesAsync()
        {
            string request = "api/Paises/GetAllPaises";
            return await this.CallApiAsync<List<Pais>>(request);
        }

        public async Task<Pais> FindPaisByIdAsync(int idPais)
        {
            string request = "api/Paises/FindPaisById/" + idPais;
            return await this.CallApiAsync<Pais>(request);
        }

        public async Task<List<Pais>> GetPaisesByContinenteAsync(int idContinente)
        {
            string request = "api/Paises/GetPaisesByContinente";
            return await this.CallApiAsync<List<Pais>>(request);
        }

        public async Task<List<CiudadView>> GetAllCiudadesViewAsync()
        {
            string request = "api/CiudadView/GetAllCiudadesView";

            return await this.CallApiAsync<List<CiudadView>>(request);
        }

        public async Task<List<CiudadView>> GetCiudadesViewByContinenteAsync(int idContinente)
        {
            string request = "api/CiudadView/GetCiudadesViewByContinente/" + idContinente;
            return await this.CallApiAsync<List<CiudadView>>(request);
        }

        public async Task<CiudadView> FindCiudadViewByIdAsync(int idCiudad)
        {
            string request = "api/CiudadView/FindCiudadViewById/" + idCiudad;

            return await this.CallApiAsync<CiudadView>(request); ;
        }

        public async Task<CiudadView> FindCiudadViewByNameAsync(string nombre)
        {
            string request = "api/CiudadView/FindCiudadViewByName/" + nombre;
            return await this.CallApiAsync<CiudadView>(request);
        }

        public async Task<List<VueloView>> GetAllVuelosViewAsync()
        {
            string request = "api/VuelosView/GetAllVuelosView";
            return await this.CallApiAsync<List<VueloView>>(request);
        }

        public async Task<List<VueloView>> GetVuelosViewByContinente(int idContinente)
        {
            string request = "api/VuelosView/GetVuelosViewByContinente/" + idContinente;
            return await this.CallApiAsync<List<VueloView>>(request);
        }

        public async Task<List<VueloView>> GetVuelosViewByPais(int idPais)
        {
            string request = "api/VuelosView/GetVuelosViewByPais/" + idPais;
            return await this.CallApiAsync<List<VueloView>>(request);
        }

        public async Task<List<VueloView>> GetVuelosViewByCiudad(int idCiudad)
        {
            string request = "api/VuelosView/GetVuelosViewByCiudad/" + idCiudad;
            return await this.CallApiAsync<List<VueloView>>(request);
        }

        public async Task<ModelPaginacionVuelosView> GetVuelosPaginacion(int posicion)
        {
            string request = "api/VuelosView/GetVuelosPaginacion/" + posicion;
            return await this.CallApiAsync<ModelPaginacionVuelosView>(request);
        }

        public async Task<VueloView> FindVueloViewByIdAsync(int idVuelo)
        {
            string request = "api/VuelosView/FindVueloViewById/" + idVuelo;
            return await this.CallApiAsync<VueloView>(request);
        }

        public async Task<List<VueloView>> SearchVueloAsync(string origen, string destino, DateTime fechaIda, int kids, int adultos)
        {
            string request = "api/VuelosView/SearchVuelo";

            ModelSearchVuelo model = new ModelSearchVuelo()
            {
                Adultos = adultos,
                Destino = destino,
                FechaIda = fechaIda,
                Kids = kids,
                Origen = origen
            };

            using (HttpClient client = new HttpClient())
            {
                client.BaseAddress = new Uri(this.ApiUrl);
                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.Header);
                StringContent content = this.GetContentModel<ModelSearchVuelo>(model);
                HttpResponseMessage response =
                    await client.PostAsync(request, content);
                if (response.IsSuccessStatusCode)
                {
                    List<VueloView> data = await response.Content.ReadAsAsync<List<VueloView>>();
                    return data;
                }
                else
                {
                    return null;
                }
            }
            
        }

        public async Task<List<VueloView>> SearchVueloAsync(string origen, string destino, DateTime fechaIda, DateTime fechaVuelta, int kids, int adultos)
        {
            string request = "";
            return await this.CallApiAsync<List<VueloView>>(request);
        }

        public async Task<Ciudad> FindCiudadByIdAsync(int idCiudad)
        {
            string request = "api/Ciudad/FindCiudadById/" + idCiudad;
            return await this.CallApiAsync<Ciudad>(request);
        }

        public async Task<List<Ciudad>> GetAllCiudadesAsync()
        {
            string request = "api/Ciudad/GetAllCiudades";
            return await this.CallApiAsync<List<Ciudad>>(request);
        }

        public async Task<List<Avion>> GetAvionesAsync()
        {
            string request = "api/Aviones/GetAviones";
            return await this.CallApiAsync<List<Avion>>(request);
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
            string token =
                this.httpContextAccessor
                .HttpContext.User
                .FindFirst(x => x.Type == "TOKEN").Value;
            string request = "api/Vuelos/CancelarVuelo/" + idVuelo;
            using (HttpClient client = new HttpClient())
            {
                client.BaseAddress = new Uri(this.ApiUrl);
                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.Header);
                client.DefaultRequestHeaders.Add
                    ("Authorization", "bearer " + token);
                HttpResponseMessage response =
                    await client.PutAsync(request, null);
            }
        }

        public async Task CambiarEstadoVuelo(int idVuelo, int idEstado)
        {
            string token =
                this.httpContextAccessor
                .HttpContext.User
                .FindFirst(x => x.Type == "TOKEN").Value;
            string request = $"api/Vuelos/CambiarEstadoVuelo/{idVuelo}/{idEstado}";
            using (HttpClient client = new HttpClient())
            {
                client.BaseAddress = new Uri(this.ApiUrl);
                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.Header);
                client.DefaultRequestHeaders.Add
                    ("Authorization", "bearer " + token);
                HttpResponseMessage response =
                    await client.PutAsync(request, null);
            }
        }

        public async Task<Vuelo> FindVueloByIdAsync(int idVuelo)
        {
            string request = $"api/Vuelos/FindVueloById/{idVuelo}";
            return await this.CallApiAsync<Vuelo>(request);
        }

        public async Task CreateVuelo(int idAvion, int idOrigen, int idDestino, DateTime fechaSalida,
            decimal precioEstandar, int idEstado)
        {
            string request = "api/Vuelos/CreateVuelo";
            Vuelo vuelo = new Vuelo()
            {
                IdAvion = idAvion,
                IdOrigen = idOrigen,
                IdDestino = idDestino,
                FechaSalida = fechaSalida,
                PrecioEstandar = precioEstandar,
                IdEstado = idEstado,
            };
            string token =
                this.httpContextAccessor
                .HttpContext.User
                .FindFirst(x => x.Type == "TOKEN").Value;

            using (HttpClient client = new HttpClient())
            {
                client.BaseAddress = new Uri(this.ApiUrl);
                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.Header);
                client.DefaultRequestHeaders.Add
                    ("Authorization", "bearer " + token);
                StringContent content = this.GetContentModel<Vuelo>(vuelo);
                HttpResponseMessage response =
                    await client.PostAsync(request, content);
            }
        }

        private StringContent GetContentModel<T>(T data)
        {
            string jsonModel = JsonConvert.SerializeObject(data);
            StringContent content =
                new StringContent
                (jsonModel, Encoding.UTF8, "application/json");
            return content;
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
            string request = "api/EstadosVuelo/GetEstadosVuelo";
            return await this.CallApiAsync<List<EstadoVuelo>>(request);
        }

        public async Task<List<TipoClase>> GetClasesAsync()
        {
            string request = "api/TiposClase/GetTiposClase";
            return await this.CallApiAsync<List<TipoClase>>(request);
        }

        public async Task<int> GetMaxBilleteIdAsync()
        {
            return 0;
        }

        public async Task<Billete> CreateBilleteAsync
            (int idVuelo, int equipajeMano, int equipajeCabina,
            string asiento, decimal precio, string nombre, string documento,
            string apellido, string email, string telefonoContacto, int idClase)
        {
            string request = "api/Billetes/CreateBillete";
            Billete billete = new Billete()
            {
                IdBillete = 0,
                DocumentoIdentidad = documento,
                Nombre = nombre,
                FechaCompra = DateTime.UtcNow,
                Precio = precio,
                IdVuelo = idVuelo,
                EquipajeMano = equipajeMano,
                EquipajeCabina = equipajeCabina,
                Apellido = apellido,
                Email = email,
                TelefonoContacto = telefonoContacto,
                IdClase = idClase,
                Asiento = asiento,
            };
            using (HttpClient client = new HttpClient())
            {
                client.BaseAddress = new Uri(this.ApiUrl);
                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.Header);
                StringContent content = this.GetContentModel<Billete>(billete);
                HttpResponseMessage response =
                    await client.PostAsync(request, content);
                if (response.IsSuccessStatusCode)
                {
                    Billete data = await response.Content.ReadAsAsync<Billete>();
                    return data;
                }
                else
                {
                    return null;
                }
            }
        }

        public async Task<List<string>> GetAsientosBilletesByVuelo(int idVuelo)
        {
            string request = $"api/Billetes/GetAsientosBillete/{idVuelo}";
            return await this.CallApiAsync<List<string>>(request);
        }

        public async Task<BilleteVueloView> FindBilleteViewByApellidoAndIdVueloAsync(string codVuelo, string apellido)
        {
            string request = 
                $"api/BilleteVueloView/FindBilleteByCodigoVueloAndApellido/" +
                $"{apellido}/{codVuelo}";
            return await this.CallApiAsync<BilleteVueloView>(request);
        }

        public async Task<BilleteVueloView> FindBilleteViewByIdAsync(int idBillete)
        {
            string request = $"api/BilleteVueloView/FindBilleteView/{idBillete}";
            return await this.CallApiAsync<BilleteVueloView>(request);
        }

        public async Task<List<BilleteVueloView>> GetBilletesViewById(List<int> idBilletes)
        {
            string queryParams= CollectionToQuery(idBilletes, "idBillete");
            string request = "api/BilleteVueloView/GetBilletesViewById?"+queryParams;
            return await this.CallApiAsync<List<BilleteVueloView>>(request);
        }

        public async Task<Usuario> LogInAsync(string email, string password)
        {
            string request = "api/Usuarios/Login";
            LoginModel model = new LoginModel
            { UserName = email, Password = password };
            using (HttpClient client = new HttpClient())
            {
                client.BaseAddress = new Uri(this.ApiUrl);
                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Accept.Add
                    (new MediaTypeWithQualityHeaderValue("application/json"));
                //CONVERTIMOS NUESTRO MODEL A JSON
                
                StringContent content = GetContentModel<LoginModel>(model);
                    
                HttpResponseMessage response = await
                    client.PostAsync(request, content);
                if (response.IsSuccessStatusCode)
                {
                    Usuario data = await
                        response.Content.ReadAsAsync<Usuario>();
                    return data;
                }
                else
                {
                    return null;
                }
            }

        }


        private string CollectionToQuery(List<int>data,string name)
        {
            string result = "";
            foreach (var item in data)
            {
                result += name + "=" + item + "&";
            }
            result = result.TrimEnd('&');
            return result;
        }
    }
}
