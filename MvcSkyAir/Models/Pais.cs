using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace MvcSkyAir.Models
{
    [Table("PAISES")]
    public class Pais
    {
        [Key]
        [Column("ID_PAIS")]
        public int IdPais { get; set; }
        [Column("NOMBRE")]
        public string Nombre { get; set; }
        [Column("LATITUD")]
        public decimal Latitud { get; set; }
        [Column("LONGITUD")]
        public decimal Longitud { get; set; }
        [Column("ID_CONTINENTE")]
        public int IdContinente { get; set; }
        
    }
}
