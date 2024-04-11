using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace MvcSkyAir.Models
{
    public class Ciudad
    {
        [Key]
        [Column("ID_CIUDAD")]
        public int IdCiudad { get; set; }
        [Column("NOMBRE")]
        public string Nombre { get; set; }
        [Column("LATITUD")]
        public decimal Latitud { get; set; }
        [Column("LONGITUD")]
        public decimal Longitud { get; set; }
        [Column("ID_PAIS")]
        public int IdPais { get; set; }
        [Column("ID_ZonaHoraria")]
        public int IdZonaHoraria { get; set; }
        [Column("DESCRIPCION")]
        public string Descripcion { get; set; }
        [Column("Imagen")]
        public string Imagen { get; set; }
    }
}
