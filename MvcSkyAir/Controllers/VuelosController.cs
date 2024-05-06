using Microsoft.AspNetCore.Mvc;
using NugetModelSkyAir.Models;
using MvcSkyAir.Repositories;
using DinkToPdf.Contracts;
using DinkToPdf;
using Microsoft.AspNetCore.Http.Extensions;
using System;
using Rotativa.AspNetCore;
using MvcSkyAir.Services;


namespace MvcSkyAir.Controllers
{
    public class VuelosController : Controller
    {
        private ISkyAirRepository service;
        private LogicAppService logicAppService;
        public VuelosController(ISkyAirRepository service, LogicAppService logicAppService)
        {
            this.logicAppService = logicAppService;
            this.service = service;
        }
        public IActionResult Vuelos()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> Vuelos(string origen, string destino,
            DateTime fechaIda, DateTime fechaVuelta, int adultos, int kids)
        {
            List<VueloView> vuelos = await this.service.SearchVueloAsync(origen, destino, fechaIda, kids, adultos);
            ViewData["PASAJEROS"] = kids + adultos;
            return View(vuelos);
        }
        [HttpPost]
        public async Task<IActionResult> Pagar(int idVuelo, int equipajeMano, int equipajeCabina, List<string> asientos,
            decimal precio, List<string> nombre, List<string> documento, List<string> apellido,
            List<string> mail, List<string> telefonoContacto, int idClase)
        {
            List<int> idBilletes = new List<int>();
            for (int i = 0; i < nombre.Count; i++)
            {
                Billete billete = await this.service.CreateBilleteAsync
                    (idVuelo, equipajeMano, equipajeCabina, asientos[i],
                    precio, nombre[i], documento[i], apellido[i], mail[i],
                    telefonoContacto[i], idClase);
                idBilletes.Add(billete.IdBillete);
            }
            TempData["COMPRADO"] = "TU COMPRA SE HA REALIZADO CORRECTAMENTE";
            return RedirectToAction("DetallesViaje", new { idBillete = idBilletes });
        }

        public async Task<IActionResult> Clases(int idVuelo)
        {
            ModelVueloClases model = new ModelVueloClases
            {
                Clases = await this.service.GetClasesAsync(),
                VueloView = await this.service.FindVueloViewByIdAsync(idVuelo)
            };
            return PartialView("_ClasesPartial", model);
        }

        public async Task<IActionResult> AsientosPartial(int idVuelo)
        {
            VueloView vuelo = await this.service.FindVueloViewByIdAsync(idVuelo);
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


        public async Task<IActionResult> BilletesPartial(List<int> idBillete)
        {
            List<BilleteVueloView> billetes = await this.service.GetBilletesViewById(idBillete);
            return PartialView("_BilletePartial", billetes);
        }

        public async Task<ActionResult> ObtenerAsientos(int idVuelo)
        {
            // Tu lógica para obtener la capacidad del vuelo
            List<string> asientos = await this.service.GetAsientosBilletesByVuelo(idVuelo);
            return Json(asientos);
        }

        public IActionResult GestionarReserva()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> GestionarReserva(string apellido, string codvuelo)
        {
            BilleteVueloView billeteView = await this.service.FindBilleteViewByApellidoAndIdVueloAsync(codvuelo, apellido);
            if (billeteView != null)
            {
                return RedirectToAction("DetallesViaje", new { idBillete = billeteView.IdBillete });
            }
            else
            {
                ViewData["MENSAJE"] = "No se encuentra ninguna reserva con el apellido " +
                      apellido + " y código de vuelo " + codvuelo;
                return View();
            }
        }

        //public async Task<IActionResult> DetallesViaje(int idBillete)
        //{
        //    BilleteVueloView billeteView = await this.service.FindBilleteViewByIdAsync(idBillete);
        //    return View(billeteView);
        //}

        public async Task<IActionResult> DetallesViaje(List<int> idBillete)
        {
            List<BilleteVueloView> billetes = await this.service.GetBilletesViewById(idBillete);
            return View(billetes);
        }

        public async Task<IActionResult> BilleteToPdf(List<int> idBillete)
        {
            List<BilleteVueloView> billetes = await this.service.GetBilletesViewById(idBillete);
            string nombrePDF = "Billete_" + DateTime.Now.ToString("ddMMyyyyHHmmss") + ".pdf";
            this.logicAppService.CreatePdf("hacer la url https://api.com?idBillete=2&idBillete=3");
            return new ViewAsPdf("BilleteToPdf", billetes)
            {
                FileName = nombrePDF,
                PageOrientation = Rotativa.AspNetCore.Options.Orientation.Portrait,
                PageSize = Rotativa.AspNetCore.Options.Size.A4
            };
        }

        public IActionResult DescargarPDF(string url)
        {
            List<int> ids = new List<int>();
            string[] parameters = url.Split("&");
            foreach (string text in parameters)
            {
                int num = int.Parse(text.Split("=")[1]);
                ids.Add(num);
            }
            return RedirectToAction("BilleteToPdf", new { idBillete = ids });
        }
    }
}
