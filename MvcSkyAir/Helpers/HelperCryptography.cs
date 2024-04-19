using System.Security.Cryptography;
using System.Text;

namespace MvcSkyAir.Helpers
{
    public class HelperCryptography
    {
        //TENDREMOS UNA PROPIEDAD DONDE ALMACENAREMOS EL 
        //SALT DINAMICO QUE VAMOS A GENERAR
        public static string Salt { get; set; }

        //CADA VEZ QUE REALICEMOS UN CIFRADO, SE GENERARA 
        //UN SALT DISTINTO
        private static string GenerateSalt()
        {
            Random random = new Random();
            string salt = "";
            for (int i = 1; i <= 50; i++)
            {
                //UN NUMERO ENTRE LOS CARACTERES ASCII
                int aleat = random.Next(1, 255);
                char letra = Convert.ToChar(aleat);
                salt += letra;
            }
            return salt;
        }

        //CREAMOS UN METODO PARA CIFRAR CORRECTAMENTE
        public static string EncriptarContenido
            (string contenido, bool comparar)
        {
            // password123
            //password123~€#@##~#@#21U392
            if (comparar == false)
            {
                //EL USUARIO QUIERE CIFRAR, POR LO QUE 
                //GENERAMOS UN NUEVO SALT
                //Y LO GUARDAMOS EN LA PROPIEDAD
                Salt = GenerateSalt();
            }
            //EL SALT SE UTILIZA EN MULTIPLES LUGARES, ES DECIR, 
            //LO PODEMOS INCLUIR AL FINAL, AL INICIO, CON UN INSERT...
            string contenidoSalt = contenido + Salt;
            //CREAMOS EL OBJETO PARA CIFRAR EL CONTENIDO
            SHA256 sHA256 = SHA256.Create();
            byte[] salida;
            UnicodeEncoding encoding = new UnicodeEncoding();
            //CONVERTIMOS A BYTES NUESTRO CONTENIDO + SALT
            salida = encoding.GetBytes(contenidoSalt);
            //CIFRAMOS EL CONTENIDO N ITERACIONES
            for (int i = 1; i <= 25; i++)
            {
                //REALIZAMOS CIFRADO SOBRE CIFRADO
                salida = sHA256.ComputeHash(salida);
            }
            //DEBEMOS LIMPIAR EL OBJETO DEL CIFRADO
            sHA256.Clear();
            string resultado = encoding.GetString(salida);
            return resultado;
        }


        //VAMOS A CREAR UN METODO STATIC PARA CONVERTIR 
        //UN CONTENIDO Y CIFRARLO.  DEVOLVEMOS EL TEXTO CIFRADO
        public static string EncriptarTextoBasico(string contenido)
        {
            //NECESITAMOS UN ARRAY DE BYTES PARA CONVERTIR EL 
            //TEXTO A byte[]
            byte[] entrada;
            //AL CIFRAR, NOS DEVOLVERA UN ARRAY DE BYTES CON LA 
            //SALIDA CIFRADA
            byte[] salida;
            //NECESITAMOS UNA CLASE QUE NOS PERMITE CONVERTIR STRING A BYTE[]
            //Y VICEVERSA
            UnicodeEncoding encoding = new UnicodeEncoding();
            //NECESITAMOS EL OBJETO PARA CIFRAR EL CONTENIDO
            //SHA1Managed managed = new SHA1Managed();
            SHA1 managed = SHA1.Create();
            //CONVERTIMOS EL STRING DE CONTENIDO EN BYTE[]
            entrada = encoding.GetBytes(contenido);
            //EL OBJETO SHA1 RECIBE UN ARRAY DE BYTES E INTERNAMENTE
            //MODIFICA CADA ELEMENTO DEVOLVIENDO OTRO ARRAY DE BYTES
            salida = managed.ComputeHash(entrada);
            //CONVERTIMOS BYTES[] A STRING
            string resultado = encoding.GetString(salida);
            return resultado;
        }
    }
}
