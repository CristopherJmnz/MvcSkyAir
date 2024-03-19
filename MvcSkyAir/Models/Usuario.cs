using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MvcSkyAir.Models
{
    [Table("USUARIOS")]
    public class Usuario
    {
        [Key]
        [Column("ID_USUARIO")]
        public int IdUsuario { get; set; }
        [Column("Nombre")]
        public string Nombre { get; set; }
        [Column("Apellido")]
        public string Apellido { get; set; }
        [Column("Email")]
        public string Email { get; set; }
        [Column("Password")]
        public string Password { get; set; }
        [Column("FECHAREGISTRO")]
        public DateTime FechaRegistro { get; set; }

    }
}
