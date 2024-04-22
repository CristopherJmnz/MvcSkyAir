using Microsoft.AspNetCore.Mvc;
using NugetModelSkyAir.Models;
using MvcSkyAir.Repositories;
using DinkToPdf.Contracts;
using DinkToPdf;
using Microsoft.AspNetCore.Http.Extensions;
using System;


namespace MvcSkyAir.Controllers
{
    public class VuelosController : Controller
    {
        private ISkyAirRepository repo;
        private IConverter converter;
        public VuelosController(ISkyAirRepository repo, IConverter converter)
        {
            this.converter = converter;
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
            List<int>idBilletes=new List<int>();
            for (int i = 0; i < nombre.Count; i++)
            {
                Billete billete=await this.repo.CreateBilleteAsync
                    (idVuelo, equipajeMano, equipajeCabina, asientos[i],
                    precio, nombre[i], documento[i], apellido[i], email[i],
                    telefonoContacto[i], idClase);
                idBilletes.Add(billete.IdBillete);
            }
            TempData["COMPRADO"] = "TU COMPRA SE HA REALIZADO CORRECTAMENTE";
            return RedirectToAction("DetallesViaje", new { idBillete= idBilletes });
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


        public async Task<IActionResult> BilletesPartial(List<int>idBillete)
        {
            List<BilleteVueloView> billetes = await this.repo.GetBilletesViewById(idBillete);
            return PartialView("_BilletePartial", billetes);
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
        public async Task<IActionResult> GestionarReserva(string apellido, string codvuelo)
        {
            BilleteVueloView billeteView = await this.repo.FindBilleteViewByApellidoAndIdVueloAsync(codvuelo, apellido);
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
        //    BilleteVueloView billeteView = await this.repo.FindBilleteViewByIdAsync(idBillete);
        //    return View(billeteView);
        //}

        public async Task<IActionResult> DetallesViaje(List<int> idBillete)
        {
            List<BilleteVueloView> billetes = await this.repo.GetBilletesViewById(idBillete);
            return View(billetes);
        }

        public async Task<IActionResult>BilleteToPdf(List<int> idBillete)
        {
            List<BilleteVueloView> billetes = await this.repo.GetBilletesViewById(idBillete);
            return View(billetes);
        }

        public IActionResult DescargarPDF(string url)
        {
            string pagina_actual = HttpContext.Request.Path + "?" + url;
            string url_pagina = HttpContext.Request.GetEncodedUrl();
            List<string> stringGood = url_pagina.Split('/').ToList();

            url_pagina = url_pagina.Replace(stringGood.ElementAt(4), "");
            url_pagina = $"{url_pagina}BilleteToPdf?" + url;

            var pdf = new HtmlToPdfDocument()
            {
                GlobalSettings = new GlobalSettings()
                {
                    PaperSize = PaperKind.A4,
                    Orientation = Orientation.Portrait,
                    
                },
                Objects = {
                    new ObjectSettings(){
                        Page = url_pagina
                    }
                }
            };

            var archivoPDF = this.converter.Convert(pdf);
            string nombrePDF = "Billete_" + DateTime.Now.ToString("ddMMyyyyHHmmss") + ".pdf";

            return File(archivoPDF, "application/pdf", nombrePDF);
        }
    }
}
