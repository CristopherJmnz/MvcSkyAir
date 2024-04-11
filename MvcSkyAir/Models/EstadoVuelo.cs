using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MvcSkyAir.Models
{
    [Table("ESTADOS")]
    public class EstadoVuelo
    {
        [Key]
        [Column("ID_ESTADO")]
        public int IdEstado { get; set; }
        [Column("ESTADO")]
        public string NombreEstado { get; set; }
    }
}
