using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MvcSkyAir.Models
{
    [Table("V_CIUDADES")]
    public class CiudadView
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
        [Column("PAIS")]
        public string Pais { get; set; }
        [Column("ID_CONTINENTE")]
        public int IdContinente { get; set; }
        [Column("CONTINENTE")]
        public string Continente { get; set; }
    }
}
