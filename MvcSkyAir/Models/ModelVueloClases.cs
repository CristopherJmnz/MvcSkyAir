namespace MvcSkyAir.Models
{
    public class ModelVueloClases
    {
        public List<TipoClase> Clases { get; set; }
        public VueloView VueloView { get; set; }
        public ModelVueloClases()
        {
            this.Clases = new List<TipoClase>();
        }
    }
}
