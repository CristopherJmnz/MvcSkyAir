using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MvcSkyAir.Models
{
    [Table("V_VUELOS")]
    public class VueloView
    {
        [Key]
        [Column("ID_VUELO")]
        public int IdVuelo { get; set; }
        [Column("ID_AVION")]
        public int IdAvion { get; set; }
        [Column("ID_Ciudad_ORIGEN")]
        public int IdOrigen { get; set; }
        [Column("CiudadOrigen")]
        public string CiudadOrigen { get; set; }
        [Column("ID_Ciudad_DESTINO")]
        public int IdDestino { get; set; }
        [Column("CiudadDestino")]
        public string CiudadDestino { get; set; }
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
        [Column("ESTADO")]
        public string Estado { get; set; }
    }
}
