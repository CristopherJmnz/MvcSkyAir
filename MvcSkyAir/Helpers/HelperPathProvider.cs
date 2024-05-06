using Microsoft.AspNetCore.Hosting.Server.Features;
using Microsoft.AspNetCore.Hosting.Server;

namespace MvcSkyAir.Helpers
{
    public enum Folders { Images = 0, Facturas = 1, Uploads = 2, Temporal = 3, Mails = 4, PdfLibrary = 5 }
    public class HelperPathProvider
    {
        private IServer server;
        //NECESITAMOS ACCEDER AL SISTEMA DE ARCHIVOS DEL WEB SERVER (wwwroot)
        private IWebHostEnvironment hostEnvironment;

        public HelperPathProvider(IWebHostEnvironment hostEnvironment
            , IServer server)
        {
            this.server = server;
            this.hostEnvironment = hostEnvironment;
        }

        //CREAMOS UN METODO PRIVADO QUE NOS DEVUELVA EL 
        //NOMBRE DE LA CARPETA DEPENDIENDO DEL Folder
        private string GetFolderPath(Folders folder)
        {
            string carpeta = "";
            if (folder == Folders.Images)
            {
                carpeta = "images";
            }
            else if (folder == Folders.Temporal)
            {
                carpeta = "temp";
            }
            else if (folder == Folders.Facturas)
            {
                carpeta = "facturas";
            }
            else if (folder == Folders.Uploads)
            {
                carpeta = "uploads";
            }
            else if (folder == Folders.Mails)
            {
                carpeta = "mails";
            }
            else if (folder == Folders.PdfLibrary)
            {
                carpeta = "PdfLibrarie";
            }
            return carpeta;
        }

        public string MapPath(string fileName, Folders folder)
        {
            string carpeta = this.GetFolderPath(folder);
            string rootPath = this.hostEnvironment.WebRootPath;
            string path = Path.Combine(rootPath, carpeta, fileName);
            return path;
        }

        public string MapUrlPath(string fileName, Folders folder)
        {
            string carpeta = this.GetFolderPath(folder);
            var addresses =
                server.Features.Get<IServerAddressesFeature>().Addresses;
            string serverUrl = addresses.FirstOrDefault();
            string urlPath = serverUrl + "/" + carpeta + "/" + fileName;
            return urlPath;
        }

        public string MapUrlPath(string parameters, string action, string controller)
        {
            var addresses =
                server.Features.Get<IServerAddressesFeature>().Addresses;
            string serverUrl = addresses.FirstOrDefault();
            string urlPath = serverUrl + "/" + controller + "/" + action + "?" + parameters;
            return urlPath;
        }
    }
}
