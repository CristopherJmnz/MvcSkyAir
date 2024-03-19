namespace MvcSkyAir.Models
{
    public class ModelPaginacionVuelosView
    {
        public int NumeroRegistros { get; set; }
        public List<VueloView> Vuelos { get; set;}
        public ModelPaginacionVuelosView()
        {
            this.Vuelos = new List<VueloView>();
        }
    }
}
