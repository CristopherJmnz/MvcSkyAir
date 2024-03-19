using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MvcSkyAir.Models
{
    [Table("AVIONES")]
    public class Avion
    {
        [Key]
        [Column("ID_AVION")]
        public int IdAvion {  get; set; }
        [Column("MODELO")]
        public string Modelo { get; set; }
        [Column("CAPACIDADASIENTOS")]
        public int Capacidad { get; set; }
        [Column("VELOCIDAD")]
        public int Velocidad {  get; set; }
    }
}
