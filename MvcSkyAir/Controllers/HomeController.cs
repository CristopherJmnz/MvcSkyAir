using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;
using NugetModelSkyAir.Models;
using MvcSkyAir.Repositories;

namespace MvcSkyAir.Controllers
{
    public class HomeController : Controller
    {
        private ISkyAirRepository repo;
        private IMemoryCache memoryCache;
        private ISkyAirRepository service;
        public HomeController(ISkyAirRepository repo,
            IMemoryCache memoryCache,
            ISkyAirRepository service)
        {
            this.repo = repo;
            this.memoryCache = memoryCache;
            this.service = service;
        }
        public async Task<IActionResult> Index()
        {
            List<CiudadView> ciudades;
            if (this.memoryCache.Get("CIUDADES") != null)
            {
                ciudades = this.memoryCache.Get<List<CiudadView>>("CIUDADES");
            }
            else
            {
                ciudades = await this.service.GetAllCiudadesViewAsync();
                this.memoryCache.Set("CIUDADES", ciudades);
            }
            return View(ciudades);
        }
        
        public async Task<IActionResult> Details(int idCiudad)
        {
            Ciudad ciudad = await this.service.FindCiudadByIdAsync(idCiudad);
            return View(ciudad);
        }

    }
}
