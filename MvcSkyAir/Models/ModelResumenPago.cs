namespace MvcSkyAir.Models
{
    public class ModelResumenPago
    {
        public int Pasajeros {  get; set; }
        public List<string> Asientos {  get; set; }
        public string Clase  { get; set; }
        public int Precio { get; set; }
        public ModelResumenPago()
        {
            Asientos = new List<string>();
        }
    }
}
