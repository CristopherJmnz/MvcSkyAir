using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MvcSkyAir.Models
{
    [Table("Vuelos")]
    public class Vuelo
    {
        [Key]
        [Column("ID_VUELO")]
        public int IdVuelo { get; set; }
        [Column("ID_AVION")]
        public int IdAvion { get; set; }
        [Column("ID_ORIGEN")]
        public int IdOrigen { get; set; }
        [Column("ID_DESTINO")]
        public int IdDestino { get; set; }
        [Column("FECHASALIDA")]
        public DateTime FechaSalida { get; set; }
        [Column("FECHALLEGADA")]
        public DateTime FechaLlegada { get; set; }
        [Column("CUPOTOTAL")]
        public int CupoTotal { get; set; }
        [Column("CUPODISPONIBLE")]
        public int CupoDisponible { get; set; }
        [Column("PrecioEstandar")]
        public decimal PrecioEstandar { get; set; }
        [Column("ID_ESTADO")]
        public int IdEstado { get; set; }
    }
}
