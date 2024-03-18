namespace MvcSkyAir.Models
{
    public class ModelVueloAsientos
    {
        public VueloView Vuelo {  get; set; }
        public List<string> Asientos { get; set; }
        public ModelVueloAsientos()
        {
            this.Asientos = new List<string>();
        }
    }
}
