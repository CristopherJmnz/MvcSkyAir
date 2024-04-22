using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using MvcSkyAir.Repositories;
using NugetModelSkyAir.Models;

namespace MvcSkyAir.Controllers
{
    public class ManagedController : Controller
    {
        private ISkyAirRepository service;
        public ManagedController(ISkyAirRepository service)
        {
            this.service = service;
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
                this.service.LogInAsync(email, password);
            string token = await this.service
                .GetTokenAsync(email, password);
            if (user != null)
            {
                //SEGURIDAD
                ClaimsIdentity identity =
                    new ClaimsIdentity(
                        CookieAuthenticationDefaults.AuthenticationScheme,
                        ClaimTypes.Name, ClaimTypes.Role);
                Claim claimName =
                    new Claim(ClaimTypes.Name, user.Nombre);
                Claim claimRole = new Claim(ClaimTypes.Role,"ADMIN");
                Claim claimToken = new Claim("TOKEN",token);
                identity.AddClaim(claimRole);
                identity.AddClaim(claimName);
                identity.AddClaim(claimToken);
                ClaimsPrincipal userPrincipal =
                    new ClaimsPrincipal(identity);
                await HttpContext.SignInAsync(
                    CookieAuthenticationDefaults.AuthenticationScheme,
                    userPrincipal);
                TempData["BIENVENIDA"]="Bienvenido " + user.Nombre;
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
