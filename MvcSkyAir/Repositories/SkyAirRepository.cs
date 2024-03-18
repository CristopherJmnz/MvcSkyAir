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
                .Where(x => x.IdContinente == idContinente).ToListAsync();
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



        #region CLASES

        public async Task<List<TipoClase>> GetClasesAsync()
        {
            return await this.context.Clases.ToListAsync();
        }

        public async Task<TipoClase> FindClaseAsync(int idClase)
        {
            return await this.context.Clases.FirstOrDefaultAsync(x=>x.IdTipoClase==idClase);
        }

        #endregion


        #region Billetes

        public async Task<List<string>> GetAsientosBilletesByVuelo(int idVuelo)
        {
            var consulta = from datos in this.context.Billetes
                           where datos.IdVuelo == idVuelo
                           select datos.Asiento;
            var a=await consulta.ToListAsync();
            return a;
        }

        public async Task<int> GetMaxBilleteIdAsync()
        {
            return this.context.Billetes.Max(x => x.IdBillete) + 1;
        }

        public async Task CreateBilleteAsync
            (int idVuelo, int equipajeMano, int equipajeCabina, string asiento,
            decimal precio, string nombre, string documento, string apellido,
            string email, string telefonoContacto, int idClase)
        {
            TipoClase clase = await this.FindClaseAsync(idClase);
            if (equipajeCabina==0)
            {
                equipajeCabina = clase.EquipajeCabina;
            }
            if (equipajeMano == 0)
            {
                equipajeMano = clase.EquipajeMano;
            }
            Billete billete = new Billete
            {
                Apellido = apellido,
                Asiento = asiento,
                Precio = precio,
                DocumentoIdentidad = documento,
                Email = email,
                EquipajeCabina = equipajeCabina,
                EquipajeMano = equipajeMano,
                FechaCompra = DateTime.Now,
                IdClase = idClase,
                IdVuelo = idVuelo,
                Nombre = nombre,
                TelefonoContacto = telefonoContacto,
                IdBillete= await this.GetMaxBilleteIdAsync()
            };
            this.context.Billetes.Add(billete);
            await this.context.SaveChangesAsync();
        }

        #endregion


        #region BilleteVueloView

        public async Task<BilleteVueloView> FindBilleteViewByApellidoAndIdVueloAsync(int idVuelo,string apellido)
        {
            return await this.context.BilletesView
                .FirstOrDefaultAsync(x => x.IdVuelo == idVuelo && x.Apellido == apellido);
        }

        public async Task<BilleteVueloView> FindBilleteViewByIdAsync(int idBillete)
        {
            return await this.context.BilletesView
                .FirstOrDefaultAsync(x => x.IdBillete == idBillete);
        }

        #endregion
    }
}
