using Microsoft.AspNetCore.Mvc;

namespace MvcSkyAir.Controllers
{
    public class UsuariosController : Controller
    {
        public IActionResult LogIn()
        {
            return View();
        }
        public IActionResult LogIn(string username,string password)
        {
            return View();
        }
    }
}
