using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using MvcSkyAir.Data;
using MvcSkyAir.Models;
using System.Data;

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

        #region CIUDADES

        public async Task<List<Ciudad>> GetAllCiudadesAsync()
        {
            return await this.context.Ciudades.ToListAsync();
        }


        #endregion

        #region AVIONES

        public async Task<List<Avion>>GetAvionesAsync()
        {
            return await this.context.Aviones.ToListAsync();
        }

        #endregion

        #region VUELOSVIEW

        public async Task<List<VueloView>> GetAllVuelosViewAsync()
        {
            return await this.context.VuelosView.ToListAsync();
        }
        public async Task<List<VueloView>> GetVuelosViewByContinente(int idContinente)
        {
            return null;
        }
        public async Task<List<VueloView>> GetVuelosViewByPais(int idPais)
        {
            return null;
        }
        public async Task<List<VueloView>> GetVuelosViewByCiudad(int idCiudad)
        {
            return null;
        }

        public async Task<ModelPaginacionVuelosView> GetVuelosPaginacion(int posicion)
        {
            
                string sql = "SP_PAGINAR_VUELOS @posicion, @registros out";
                SqlParameter pamPosicion = new SqlParameter("@posicion", posicion);
                SqlParameter pamRegistros = new SqlParameter("@registros", -1);
                pamRegistros.Direction = ParameterDirection.Output;
                var consulta = this.context.VuelosView.FromSqlRaw(sql,pamPosicion, pamRegistros);
                ModelPaginacionVuelosView model = new ModelPaginacionVuelosView
                {
                    Vuelos = await consulta.ToListAsync(),
                    NumeroRegistros = (int)pamRegistros.Value
                };
                return model;
        }

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

        #region VUELOS

        public async Task<Vuelo> FindVueloByIdAsync(int idVuelo)
        {
            return await this.context.Vuelos
                .FirstOrDefaultAsync(x => x.IdVuelo == idVuelo);
        }
        public async Task CreateVuelo
    (int idAvion, int idOrigen, int idDestino,
    DateTime fechaSalida, decimal precioEstandar, int idEstado)
{
    string sql = "EXEC SP_INSERT_VUELO @idavion, @idorigen, @iddestino, @fechasalida, @precioestandar, @idestado";
    SqlParameter pamidAvion = new SqlParameter("@idavion", idAvion);
    SqlParameter pamidOrigen = new SqlParameter("@idorigen", idOrigen);
    SqlParameter pamidDestino = new SqlParameter("@iddestino", idDestino);
    SqlParameter pamFechaSalida = new SqlParameter("@fechasalida", fechaSalida);
    SqlParameter pamPrecio = new SqlParameter("@precioestandar", precioEstandar);
    SqlParameter pamIdEstado = new SqlParameter("@idestado", idEstado);

    // Asegúrate de que tu contexto esté configurado para usar el proveedor de SQL Server
    await context.Database.ExecuteSqlRawAsync(sql, pamidAvion, pamidOrigen, pamidDestino, pamFechaSalida, pamPrecio, pamIdEstado);
}


        public async Task CancelarVuelo(int idVuelo)
        {
            Vuelo vuelo = await this.FindVueloByIdAsync(idVuelo);
            vuelo.IdEstado = 3;
            await this.context.SaveChangesAsync();
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

        #region USUARIOS

        public async Task<Usuario> LogInEmpleadoAsync(string email, string password)
        {
            return await this.context.Usuarios
                .FirstOrDefaultAsync(x=>x.Email==email && x.Password==password);
        }

        #endregion
    }
}
