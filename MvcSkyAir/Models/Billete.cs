using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MvcSkyAir.Models
{
    [Table("Billetes")]
    public class Billete
    {
        [Key]
        [Column("ID_BILLETE")]
        public int IdBillete { get; set; }
        [Column("ID_VUELO")]
        public int IdVuelo { get; set; }
        [Column("ASIENTO")]
        public string Asiento { get; set; }
        [Column("EquipajeMano")]
        public int EquipajeMano { get; set; }
        [Column("EquioajeCabina")]
        public int EquipajeCabina { get; set; }
        [Column("Precio")]
        public decimal Precio { get; set; }
        [Column("Nombre")]
        public string Nombre { get; set; }
        [Column("DocumentoIdentidad")]
        public string DocumentoIdentidad { get; set; }
        [Column("Apellido")]
        public string Apellido { get; set; }
        [Column("Email")]
        public string Email { get; set; }
        [Column("TelefonoContacto")]
        public string TelefonoContacto { get; set; }
        [Column("FechaCompra")]
        public DateTime FechaCompra { get; set; }
        [Column("ID_CLASE")]
        public int IdClase { get; set; }
    }
}
