using Microsoft.EntityFrameworkCore;
using MvcSkyAir.Data;
using MvcSkyAir.Models;

namespace MvcSkyAir.Repositories
{
    public class SkyAirRepository : ISkyAirRepository
    {
        private SkyAirContext context;
        public SkyAirRepository(SkyAirContext context)
        {
            this.context = context;
        }

        #region CONTINENTES
        public async Task<List<Continente>> GetAllContinentesAsync()
        {
            return await this.context.Continentes.ToListAsync();
        }
        public async Task<List<string>> GetContinentesNameAsync()
        {
            var consulta = from datos in this.context.Continentes
                           select datos.Nombre;
            
            List<string> continentesNames = await consulta.Distinct().ToListAsync();
            return continentesNames;
        }


        #endregion

        #region Paises
        public async Task<List<Pais>> GetAllPaisesAsync()
        {
            return await this.context.Paises.ToListAsync();
        }

        public async Task<List<Pais>> GetPaisesByContinenteAsync(int idContinente)
        {
            return await
                this.context.Paises
                .Where(x=>x.IdContinente==idContinente).ToListAsync();
        }

        #endregion

        #region CIUDADES VIEW

        
        public async Task<List<CiudadView>> GetAllCiudadesViewAsync()
        {
            return await this.context.CiudadesView.ToListAsync();
        }

        public async Task<List<CiudadView>> GetCiudadesViewByContinenteAsync(int idContinente)
        {
            return await 
                this.context.CiudadesView
                .Where(x => x.IdContinente == idContinente).ToListAsync();
        }

        public async Task<CiudadView> FindCiudadViewByIdAsync(int idCiudad)
        {
            return await
            this.context.CiudadesView
                .Where(x => x.IdCiudad == idCiudad).FirstOrDefaultAsync();
        }

        public async Task<CiudadView> FindCiudadViewByNameAsync(string nombre)
        {
            return await
                this.context.CiudadesView
                .Where(x => x.Nombre == nombre).FirstOrDefaultAsync();
        }

        #endregion

        #region VUELOSVIEW

        public async Task<VueloView> FindVueloViewByIdAsync(int idVuelo)
        {
            return await this.context.VuelosView
                .FirstOrDefaultAsync(x => x.IdVuelo == idVuelo);
        }

        public async Task<List<VueloView>> SearchVueloAsync(string origen, string destino, DateTime fechaIda, int kids, int adultos)
        {
            CiudadView origin = await this.FindCiudadViewByNameAsync(origen);
            CiudadView destiny = await this.FindCiudadViewByNameAsync(destino);
            List<VueloView> vuelos = await this.context.VuelosView.
                Where(x => x.IdOrigen == origin.IdCiudad
                && x.IdDestino == destiny.IdCiudad
                && x.FechaSalida.Day == fechaIda.Day
                && x.CupoDisponible >= (kids + adultos)).ToListAsync();
            return vuelos.Count == 0 ? null : vuelos;
        }

        public async Task<List<VueloView>> SearchVueloAsync(string origen, string destino, DateTime fechaIda, DateTime fechaVuelta, int kids, int adultos)
        {
            return null;
        }

        #endregion


        public async Task<List<TipoClase>> GetClasesAsync()
        {
            return await this.context.Clases.ToListAsync();
        }
    }
}
