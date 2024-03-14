using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MvcSkyAir.Models
{
    [Table("CONTINENTES")]
    public class Continente
    {
        [Key]
        [Column("ID_CONTINENTE")]
        public int IdContinente { get; set; }
        [Column("NOMBRE")]
        public string Nombre { get; set; }
    }
}
