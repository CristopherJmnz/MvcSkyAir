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
            ViewData["PASAJEROS"] = kids + adultos;
            return View(vuelos);
        }
        [ValidateAntiForgeryToken]
        [HttpPost]
        public async Task<IActionResult> Pagar(int idVuelo, int equipajeMano, int equipajeCabina, List<string> asientos,
            decimal precio, List<string> nombre, List<string> documento, List<string> apellido,
            List<string> email, List<string> telefonoContacto, int idClase)
        {
            for (int i = 0; i < nombre.Count; i++)
            {
                await this.repo.CreateBilleteAsync
                    (idVuelo, equipajeMano, equipajeCabina, asientos[i],
                    precio, nombre[i], documento[i], apellido[i], email[i],
                    telefonoContacto[i], idClase);
            }
            TempData["COMPRADO"] = "TU COMPRA SE HA REALIZADO CORRECTAMENTE";
            return RedirectToAction("Index", "Home");
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
        public IActionResult PasajerosPartial(int pasajeros)
        {
            return PartialView("_PasajerosPartial", pasajeros);
        }

        public IActionResult PagoPartial(int pasajeros, List<string> asientos, string clase, int precio)
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

        public IActionResult GestionarReserva()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> GestionarReserva(string apellido, int idVuelo)
        {
            BilleteVueloView billeteView = await this.repo.FindBilleteViewByApellidoAndIdVueloAsync(idVuelo, apellido);
            if (billeteView != null)
            {
                return RedirectToAction("DetallesViaje", new { idBillete = billeteView.IdBillete });
            }
            else
            {
                return View();
            }
        }

        public async Task<IActionResult> DetallesViaje(int idBillete)
        {
            BilleteVueloView billeteView = await this.repo.FindBilleteViewByIdAsync(idBillete);
            return View(billeteView);
        }
    }
}
