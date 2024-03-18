using MvcSkyAir.Models;

namespace MvcSkyAir.Repositories
{
    public interface ISkyAirRepository
    {
        #region CONTINENTES
        Task<List<Continente>> GetAllContinentesAsync();
        Task<List<string>> GetContinentesNameAsync();

        #endregion

        #region PAISES
        Task<List<Pais>> GetAllPaisesAsync();
        Task<List<Pais>> GetPaisesByContinenteAsync(int idContinente);

        #endregion

        #region CIUDADES VIEW
        Task<List<CiudadView>> GetAllCiudadesViewAsync();
        Task<List<CiudadView>> GetCiudadesViewByContinenteAsync(int idContinente);
        Task<CiudadView> FindCiudadViewByIdAsync(int idCiudad);
        Task<CiudadView> FindCiudadViewByNameAsync(string nombre);


        #endregion

        #region VUELOS VIEW
        Task<VueloView> FindVueloViewByIdAsync(int idVuelo);
        Task<List<VueloView>> SearchVueloAsync(string origen, string destino, DateTime fechaIda, int kids, int adultos);
        Task<List<VueloView>> SearchVueloAsync(string origen, string destino, DateTime fechaIda, DateTime fechaVuelta, int kids, int adultos);
        #endregion

        #region TIPO CLASES

        Task<List<TipoClase>> GetClasesAsync();
        #endregion


        #region BILLETES
        Task<int> GetMaxBilleteIdAsync();
        Task CreateBilleteAsync
            (int idVuelo, int equipajeMano, int equipajeCabina, string asiento,
            decimal precio, string nombre, string documento, string apellido,
            string email, string telefonoContacto, int idClase);
        Task<List<string>> GetAsientosBilletesByVuelo(int idVuelo);

        #endregion

        #region BilleteVueloView
        Task<BilleteVueloView> FindBilleteViewByApellidoAndIdVueloAsync(int idVuelo, string apellido);
        Task<BilleteVueloView> FindBilleteViewByIdAsync(int idBillete);
        #endregion
    }
}
