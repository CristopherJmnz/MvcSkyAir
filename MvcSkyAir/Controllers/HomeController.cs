using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;
using MvcSkyAir.Models;
using MvcSkyAir.Repositories;

namespace MvcSkyAir.Controllers
{
    public class HomeController : Controller
    {
        private ISkyAirRepository repo;
        private IMemoryCache memoryCache;
        public HomeController(ISkyAirRepository repo, IMemoryCache memoryCache)
        {
            this.repo = repo;
            this.memoryCache = memoryCache;
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
                ciudades = await this.repo.GetAllCiudadesViewAsync();
                this.memoryCache.Set("CIUDADES", ciudades);
            }
            return View(ciudades);
        }
        

    }
}
