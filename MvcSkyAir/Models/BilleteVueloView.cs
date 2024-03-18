using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MvcSkyAir.Models
{
    [Table("V_BILLETEVUELO")]
    public class BilleteVueloView
    {
        [Key]
        [Column("ID_BILLETE")]
        public int IdBillete { get; set; }
        [Column("ID_VUELO")]
        public int IdVuelo { get; set; }
        [Column("EQUIPAJECABINA")]
        public int EquipajeCabina { get; set; }
        [Column("EQUIPAJEMANO")]
        public int EquipajeMano { get; set; }
        [Column("ASIENTO")]
        public string Asiento { get; set; }
        [Column("DOCUMENTOIDENTIDAD")]
        public string Documento { get; set; }
        [Column("APELLIDO")]
        public string Apellido { get; set; }
        [Column("FECHACOMPRA")]
        public DateTime FechaCompra { get; set; }
        [Column("FECHASALIDA")]
        public DateTime FechaSalida { get; set; }
        [Column("FECHALLEGADA")]
        public DateTime FechaLlegada { get; set; }
        [Column("PRECIO")]
        public decimal Precio { get; set; }
        [Column("CIUDADORIGEN")]
        public string CiudadOrigen { get; set; }
        [Column("CIUDADDESTINO")]
        public string CiudadDestino { get; set; }
        [Column("CLASE")]
        public string Clase { get; set; }
        [Column("AVION")]
        public string Avion { get; set; }
        [Column("ESTADO")]
        public string Estado{ get; set; }
    }
}
