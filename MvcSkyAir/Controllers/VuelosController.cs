using Microsoft.AspNetCore.Mvc;
using MvcSkyAir.Models;
using MvcSkyAir.Repositories;

namespace MvcSkyAir.Controllers
{
    public class VuelosController : Controller
    {
        private ISkyAirRepository repo;

        public VuelosController(ISkyAirRepository repo)
        {
            this.repo = repo;
        }
        public IActionResult Vuelos()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> Vuelos(string origen, string destino,
            DateTime fechaIda, DateTime fechaVuelta, int adultos, int kids)
        {
            List<VueloView> vuelos = await this.repo.SearchVueloAsync(origen, destino, fechaIda, kids, adultos);
            ViewData["PASAJEROS"]= kids+adultos;
            return View(vuelos);
        }

        public async Task<IActionResult> Clases(int idVuelo)
        {
            ModelVueloClases model = new ModelVueloClases
            {
                Clases = await this.repo.GetClasesAsync(),
                VueloView = await this.repo.FindVueloViewByIdAsync(idVuelo)
            };
            return PartialView("_ClasesPartial", model);
        }

        public async Task<IActionResult> AsientosPartial(int idVuelo)
        {
            VueloView vuelo = await this.repo.FindVueloViewByIdAsync(idVuelo);
            List<string> asientos = new List<string>();
            ModelVueloAsientos model = new ModelVueloAsientos
            {
                Asientos = asientos,
                Vuelo = vuelo
            };
            return PartialView("_AsientosPartial", model);
        }
        public async Task<IActionResult> PasajerosPartial(int pasajeros)
        {
            return PartialView("_PasajerosPartial", pasajeros);
        }

        public async Task<IActionResult> PagoPartial(int pasajeros, List<string>asientos, string clase,int precio)
        {
            ModelResumenPago model = new ModelResumenPago
            {
                Asientos = asientos,
                Clase = clase,
                Pasajeros = pasajeros,
                Precio = precio
            };
            return PartialView("_PagoPartial", model);
        }

        public async Task<ActionResult> ObtenerAsientos(int idVuelo)
        {
            // Tu lógica para obtener la capacidad del vuelo
            List<string> asientos = await this.repo.GetAsientosBilletesByVuelo(idVuelo);
            return Json(asientos);
        }
    }
}
