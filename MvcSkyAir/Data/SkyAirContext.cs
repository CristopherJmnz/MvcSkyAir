using Microsoft.EntityFrameworkCore;
using MvcSkyAir.Models;

namespace MvcSkyAir.Data
{
    public class SkyAirContext : DbContext
    {
        public SkyAirContext(DbContextOptions options):base(options)
        {
            
        }
        public DbSet<Continente> Continentes { get; set; }
        public DbSet<Pais> Paises { get; set; }
        public DbSet<Ciudad> Ciudades { get; set; }
        public DbSet<CiudadView> CiudadesView { get; set; }
        public DbSet<VueloView> VuelosView{ get; set; }
        public DbSet<TipoClase> Clases{ get; set; }
    }
}
