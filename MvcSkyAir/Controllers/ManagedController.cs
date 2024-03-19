using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using MvcSkyAir.Repositories;
using MvcSkyAir.Models;

namespace MvcSkyAir.Controllers
{
    public class ManagedController : Controller
    {
        private ISkyAirRepository repo;
        public ManagedController(ISkyAirRepository repo)
        {
            this.repo = repo;
        }
        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Login
            (string email, string password)
        {
            Usuario user = await
                this.repo.LogInEmpleadoAsync(email, password);
            if (user != null)
            {
                //SEGURIDAD
                ClaimsIdentity identity =
                    new ClaimsIdentity(
                        CookieAuthenticationDefaults.AuthenticationScheme,
                        ClaimTypes.Name, ClaimTypes.Role);
                //CREAMOS EL CLAIM PARA EL NOMBRE (APELLIDO)
                Claim claimName =
                    new Claim(ClaimTypes.Name, user.Nombre);
                Claim claimRole = new Claim(ClaimTypes.Role,"ADMIN");
                identity.AddClaim(claimRole);
                identity.AddClaim(claimName);
                //COMO POR AHORA NO VOY A UTILIZAR NI SE UTILIZAR ROLES
                //NO LO INCLUIMOS
                ClaimsPrincipal userPrincipal =
                    new ClaimsPrincipal(identity);
                await HttpContext.SignInAsync(
                    CookieAuthenticationDefaults.AuthenticationScheme,
                    userPrincipal);
                //LO VAMOS A LLEVAR A UNA VISTA QUE TODAVIA NO TENEMOS
                //QUE SERA EL PERFIL DEL EMPLEADO
                TempData["BIENVENIDA"]="Bienvenido" + user.Nombre;
                return RedirectToAction("DataVuelos", "Usuarios");
            }
            else
            {
                ViewData["MENSAJE"] = "Usuario/Password incorrectos";
                return View();
            }
        }

        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync
                (CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("Index", "Home");
        }

        public async Task<IActionResult> ErrorAcceso()
        {
            return View();
        }
    }
}
