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
            return View(vuelos);
        }

        public async Task<IActionResult> Clases(int idVuelo)
        {
            ModelVueloClases model = new ModelVueloClases
            {
                Clases = await this.repo.GetClasesAsync(),
                VueloView = await this.repo.FindVueloViewByIdAsync(idVuelo)
            };
            //List<int> a = new List<int>();
            return PartialView("_ClasesPartial", model);
        }
    }
}
