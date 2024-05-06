using Microsoft.AspNetCore.Mvc;
using MvcSkyAir.Filters;
using NugetModelSkyAir.Models;
using MvcSkyAir.Repositories;

namespace MvcSkyAir.Controllers
{
    public class UsuariosController : Controller
    {
        private ISkyAirRepository service;
        public UsuariosController(ISkyAirRepository service)
        {
            this.service = service;
        }
        [AuthorizeUsers]
        public IActionResult Perfil()
        {
            return View();
        }

        [AuthorizeUsers]
        public async Task<IActionResult> DataVuelos()
        {
            List<VueloView> vuelos = await this.service.GetAllVuelosViewAsync();
            return View(vuelos);
        }

        public async Task<IActionResult> PaginarVuelosPartial(int? posicion)
        {
            if (posicion == null)
            {
                posicion = 1;
            }
            ModelPaginacionVuelosView model = await this.service.GetVuelosPaginacion(posicion.Value);
            int siguiente = posicion.Value + 1;
            if (siguiente > model.NumeroRegistros)
            {
                siguiente = 1;
            }
            int anterior = posicion.Value - 1;
            if (anterior < 1)
            {
                anterior = model.NumeroRegistros;
            }
            ViewData["POSICION"] = posicion;
            ViewData["ULTIMO"] = model.NumeroRegistros;
            ViewData["SIGUIENTE"] = siguiente;
            ViewData["ANTERIOR"] = anterior;
            ViewData["POSICION"] = posicion;
            return PartialView("_PaginarVuelosPartial",model);
        }

        public async Task<IActionResult> CreateVuelo()
        {
            List<CiudadView> ciudades=await this.service.GetAllCiudadesViewAsync();
            return View(ciudades);
        }

        [HttpPost]
        public async Task<IActionResult> CreateVuelo(Vuelo vuelo)
        {
            await this.service.CreateVuelo(vuelo.IdAvion,vuelo.IdOrigen,vuelo.IdDestino,vuelo.FechaSalida,vuelo.PrecioEstandar,1);
            return RedirectToAction("DataVuelos");
        }

        public async Task<IActionResult> CancelVuelo(int idVuelo)
        {
            await this.service.CancelarVuelo(idVuelo);
            return RedirectToAction("DataVuelos");
        }

        [HttpPost]
        public async Task<IActionResult> CambiarEstadoVuelo(int idVuelo,int idestado)
        {
            await this.service.CambiarEstadoVuelo(idVuelo,idestado);
            return RedirectToAction("DataVuelos");
        }
        public async Task<IActionResult> Flota()
        {
            List<Avion>aviones=await this.service.GetAvionesAsync();
            return View(aviones);
        }

        public async Task<IActionResult> CreateAvion()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> CreateAvion(Avion avion)
        {
            await this.service.CreateAvion(avion.Modelo,avion.Capacidad,avion.Velocidad);
            return RedirectToAction("Flota");
        }


    }
}
