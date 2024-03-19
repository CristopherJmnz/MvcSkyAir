using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace MvcSkyAir.Filters
{
    public class AuthorizeUsersAttribute : AuthorizeAttribute
        , IAuthorizationFilter
    {
        public void OnAuthorization(AuthorizationFilterContext context)
        {
            var user = context.HttpContext.User;
            if (user.Identity.IsAuthenticated == false)
            {
                //ENVIAMOS A LA VISTA LOGIN
                context.Result = this.GetRoute("Managed", "Login");
            }
            else
            {
                //QUIERO COMPROBAR EL ROLE DEL USUARIO PARA 
                //PERMITIRLE ACCESO
                if (user.IsInRole("ADMIN") == false)
                {
                    context.Result = this.GetRoute("Managed", "ErrorAcceso");
                }
            }

        }

        private RedirectToRouteResult GetRoute
            (string controller, string action)
        {
            RouteValueDictionary ruta =
                new RouteValueDictionary(
                    new { controller = controller, action = action });
            RedirectToRouteResult result =
                new RedirectToRouteResult(ruta);
            return result;
        }

    }
}
