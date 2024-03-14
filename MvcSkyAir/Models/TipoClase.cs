using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MvcSkyAir.Models
{
    [Table("TIPOS_CLASES")]
    public class TipoClase
    {
        [Key]
        [Column("ID_TIPO_CLASE")]
        public int IdTipoClase { get; set; }
        [Column("Nombre")]
        public string Nombre { get; set; }
        [Column("EquipajeMano")]
        public int EquipajeMano { get; set; }
        [Column("EquipajeCabina")]
        public int EquipajeCabina { get; set; }

    }
}
