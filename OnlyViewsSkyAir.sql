alter View V_CIUDADES
as
	select Ciudades.ID_CIUDAD,ciudades.nombre,
	ciudades.Latitud as latitud,ciudades.Longitud as longitud,
	paises.ID_PAIS as ID_PAIS, paises.Nombre as Pais,
	CONTINENTES.ID_CONTINENTE AS ID_CONTINENTE,continentes.Nombre as Continente
	from Ciudades
	inner join paises
	on ciudades.ID_PAIS=paises.ID_PAIS
	inner join Continentes
	on Continentes.ID_CONTINENTE=paises.ID_CONTINENTE;
go

alter view V_Vuelos
as
		SELECT v.*, e.ESTADO,
		o.ID_CIUDAD as ID_CIUDAD_ORIGEN, o.Nombre as CiudadOrigen,
		d.ID_CIUDAD as ID_CIUDAD_DESTINO, d.Nombre as CiudadDestino
		from vuelos v
		inner join CIUDADES o
		on o.ID_CIUDAD=v.ID_ORIGEN
		inner join Ciudades d
		on d.ID_CIUDAD=v.ID_DESTINO
		inner join ESTADOS e
		on v.id_estado=e.ID_ESTADO
go


alter view V_BILLETEVUELO
AS
	SELECT b.ID_Billete,b.ID_VUELO, b.EquipajeCabina,b.EquipajeMano,b.Asiento,b.DocumentoIdentidad,b.Apellido,b.FechaCompra,b.Precio,
	v.FechaSalida,v.FechaLlegada,v.CiudadOrigen,v.CiudadDestino,e.estado as estado,
	t.Nombre as Clase, a.modelo as Avion
	FROM Billetes b
	inner join V_Vuelos v
	on b.ID_VUELO=v.ID_VUELO
	inner join TIPOS_CLASES t
	on b.ID_TIPO_CLASE=t.ID_TIPO_CLASE
	inner join Aviones a
	on v.ID_AVION=a.ID_AVION
	inner join ESTADOS e
	on v.id_estado = e.id_estado
GO

ALTER procedure SP_PAGINAR_VUELOS
(@posicion int, @registros int out)
AS
	SELECT @registros=count(id_vuelo)
	from V_Vuelos;

	select ID_VUELO,CiudadDestino,CiudadOrigen,CupoDisponible,CupoTotal,ESTADO,
	FechaLlegada,FechaSalida,ID_AVION,ID_CIUDAD_DESTINO,ID_CIUDAD_ORIGEN,PrecioEstandar
	from(
	select cast(ROW_NUMBER() over (order by V.ID_VUELO) as int) as posicion,
	v.ID_VUELO,v.CiudadDestino,v.CiudadOrigen,v.CupoDisponible,v.CupoTotal,v.ESTADO,v.FechaLlegada,v.FechaSalida,
	V.ID_AVION,V.ID_CIUDAD_DESTINO,V.ID_CIUDAD_ORIGEN,V.PrecioEstandar
	from V_Vuelos v)
	as query
	where QUERY.posicion >= @posicion and QUERY.posicion<(@posicion + 4);
GO




--alter PROCEDURE SP_INSERT_VUELO
--    (@IDAvion INT,
--    @IDOrigen INT,
--    @IDDestino INT,
--    @FechaSalida DATETIME,
--    @PrecioEstandar INT,
--    @IDEstado INT)
--AS
--    DECLARE @IDVuelo INT, @FechaLlegada DATETIME, @CupoTotal INT, @VelocidadAvion DECIMAL(10, 2);

--    -- Calcular el ID del vuelo
--    SET @IDVuelo = (SELECT ISNULL(MAX(ID_VUELO), 0) + 1 FROM Vuelos);

--    -- Calcular la fecha de llegada
--    DECLARE @DistanciaKm DECIMAL(18, 2);
--    DECLARE @LatitudOrigen DECIMAL(9, 6), @LongitudOrigen DECIMAL(9, 6);
--    DECLARE @LatitudDestino DECIMAL(9, 6), @LongitudDestino DECIMAL(9, 6);

--    -- Obtener latitud y longitud del aeropuerto de origen
--    SELECT @LatitudOrigen = Latitud, @LongitudOrigen = Longitud
--    FROM Ciudades
--    WHERE ID_CIUDAD = @IDOrigen;

--    -- Obtener latitud y longitud del aeropuerto de destino
--    SELECT @LatitudDestino = Latitud, @LongitudDestino = Longitud
--    FROM Ciudades
--    WHERE ID_CIUDAD = @IDDestino;

--    -- Calcular la distancia utilizando la fórmula de Haversine
--    SET @DistanciaKm = 12742 * ASIN(SQRT(
--        POWER(SIN((@LatitudDestino - @LatitudOrigen) * PI() / 180 / 2), 2) +
--        COS(@LatitudOrigen * PI() / 180) * COS(@LatitudDestino * PI() / 180) *
--        POWER(SIN((@LongitudDestino - @LongitudOrigen) * PI() / 180 / 2), 2)
--    ));

--    -- Obtener la velocidad del avión
--    SELECT @VelocidadAvion = Velocidad
--    FROM Aviones
--    WHERE ID_AVION = @IDAvion;

--    -- Calcular la fecha de llegada
--    SET @FechaLlegada = DATEADD(HOUR, @DistanciaKm / @VelocidadAvion, @FechaSalida);

--    -- Obtener el cupo total de asientos del avión
--    SELECT @CupoTotal = CapacidadAsientos
--    FROM Aviones
--    WHERE ID_AVION = @IDAvion;

--    -- Insertar datos del vuelo
--    INSERT INTO Vuelos (ID_VUELO, ID_AVION, ID_ORIGEN, ID_DESTINO, FechaSalida, FechaLlegada, PrecioEstandar, CupoTotal, CupoDisponible, ID_ESTADO)
--    VALUES (@IDVuelo, @IDAvion, @IDOrigen, @IDDestino, @FechaSalida, @FechaLlegada, @PrecioEstandar, @CupoTotal, @CupoTotal, @IDEstado);

--    -- Devolver el ID del vuelo insertado
--    SELECT * from Vuelos where ID_VUELO=@IDVuelo;
--go





--alter PROCEDURE SP_INSERT_VUELO
--   ( @ID_AVION INT,
--    @ID_ORIGEN INT,
--    @ID_DESTINO INT,
--    @FechaSalida DATETIME,
--    @PrecioEstandar INT,
--    @IDEstado INT)
--AS
--    DECLARE @ID_VUELO INT, @FechaLlegada DATETIME, @CupoTotal INT, @VelocidadAvion DECIMAL(10, 2);
--    DECLARE @HoraLlegadaLocal TIME;

--    -- Obtener la velocidad del avión
--    SELECT @VelocidadAvion = Velocidad
--    FROM Aviones
--    WHERE ID_AVION = @ID_AVION;


--	-- maxid
--	select @id_vuelo=max(id_vuelo)+1 from vuelos;

--    -- Calcular la distancia entre el origen y el destino
--    DECLARE @LatitudOrigen DECIMAL(9, 6), @LongitudOrigen DECIMAL(9, 6), @LatitudDestino DECIMAL(9, 6), @LongitudDestino DECIMAL(9, 6);
--    SELECT @LatitudOrigen = Latitud, @LongitudOrigen = Longitud
--    FROM Ciudades
--    WHERE ID_CIUDAD = @ID_ORIGEN;

--    SELECT @LatitudDestino = Latitud, @LongitudDestino = Longitud
--    FROM Ciudades
--    WHERE ID_CIUDAD = @ID_DESTINO;

--    -- Calcular la distancia utilizando la fórmula de Haversine
--    DECLARE @DistanciaKm DECIMAL(18, 2);
--    SET @DistanciaKm = 12742 * ASIN(SQRT(
--        POWER(SIN((@LatitudDestino - @LatitudOrigen) * PI() / 180 / 2), 2) +
--        COS(@LatitudOrigen * PI() / 180) * COS(@LatitudDestino * PI() / 180) *
--        POWER(SIN((@LongitudDestino - @LongitudOrigen) * PI() / 180 / 2), 2)
--    ));

--    -- Calcular la hora de llegada local en el país de destino
--    DECLARE @ZonaHorariaDestino INT;
--    SELECT @ZonaHorariaDestino = ZH.Desplazamiento
--    FROM Ciudades AS C
--    JOIN ZonasHorarias AS ZH ON C.ID_ZonaHoraria = ZH.ID_ZonaHoraria
--    WHERE C.ID_CIUDAD = @ID_DESTINO;

--    -- Calcular la hora de llegada en función de la zona horaria del país de destino
--    SET @HoraLlegadaLocal = DATEADD(HOUR, @DistanciaKm / @VelocidadAvion, DATEADD(HOUR, @ZonaHorariaDestino, @FechaSalida));

--    -- Obtener el cupo total del avión
--    SELECT @CupoTotal = CapacidadAsientos
--    FROM Aviones
--    WHERE ID_AVION = @ID_AVION;

--    -- Insertar el vuelo con los datos calculados
--    INSERT INTO Vuelos (id_vuelo,ID_AVION, ID_ORIGEN, ID_DESTINO, FechaSalida, FechaLlegada, PrecioEstandar,CupoDisponible, CupoTotal, ID_ESTADO)
--    VALUES (@id_vuelo,@ID_AVION, @ID_ORIGEN, @ID_DESTINO, @FechaSalida, @HoraLlegadaLocal, @PrecioEstandar,@cupoTotal, @CupoTotal, @IDEstado);
--go

--EXEC SP_INSERT_VUELO 1, 1, 2, '20240318 12:26:00.000', 600, 1;





--test

ALTER PROCEDURE SP_INSERT_VUELO
   @ID_AVION INT,
   @ID_ORIGEN INT,
   @ID_DESTINO INT,
   @FechaSalida DATETIME,
   @PrecioEstandar INT,
   @IDEstado INT
AS
BEGIN
    DECLARE @ID_VUELO INT, @FechaLlegada DATETIME, @CupoTotal INT, @VelocidadAvion DECIMAL(10, 2);
    DECLARE @HoraLlegadaLocal DATETIME; -- Cambiado de TIME a DATETIME
	-- maxid
	select @id_vuelo=max(id_vuelo)+1 from vuelos;
    -- Obtener la velocidad del avión
    SELECT @VelocidadAvion = Velocidad
    FROM Aviones
    WHERE ID_AVION = @ID_AVION;

    -- Calcular la distancia entre el origen y el destino
    DECLARE @LatitudOrigen DECIMAL(9, 6), @LongitudOrigen DECIMAL(9, 6), @LatitudDestino DECIMAL(9, 6), @LongitudDestino DECIMAL(9, 6);
    SELECT @LatitudOrigen = Latitud, @LongitudOrigen = Longitud
    FROM Ciudades
    WHERE ID_CIUDAD = @ID_ORIGEN;

    SELECT @LatitudDestino = Latitud, @LongitudDestino = Longitud
    FROM Ciudades
    WHERE ID_CIUDAD = @ID_DESTINO;

    -- Calcular la distancia utilizando la fórmula de Haversine
    DECLARE @DistanciaKm DECIMAL(18, 2);
    SET @DistanciaKm = 12742 * ASIN(SQRT(
        POWER(SIN((@LatitudDestino - @LatitudOrigen) * PI() / 180 / 2), 2) +
        COS(@LatitudOrigen * PI() / 180) * COS(@LatitudDestino * PI() / 180) *
        POWER(SIN((@LongitudDestino - @LongitudOrigen) * PI() / 180 / 2), 2)
    ));

    -- Calcular la hora de llegada local en el país de destino
    DECLARE @ZonaHorariaDestino INT;
    SELECT @ZonaHorariaDestino = ZH.Desplazamiento
    FROM Ciudades AS C
    JOIN ZonasHorarias AS ZH ON C.ID_ZonaHoraria = ZH.ID_ZonaHoraria
    WHERE C.ID_CIUDAD = @ID_DESTINO;

    -- Calcular la hora de llegada en función de la zona horaria del país de destino
    SET @HoraLlegadaLocal = DATEADD(HOUR, @DistanciaKm / @VelocidadAvion, DATEADD(HOUR, @ZonaHorariaDestino, @FechaSalida));

    -- Obtener el cupo total del avión
    SELECT @CupoTotal = CapacidadAsientos
    FROM Aviones
    WHERE ID_AVION = @ID_AVION;

    -- Insertar el vuelo con los datos calculados
    INSERT INTO Vuelos (id_vuelo, ID_AVION, ID_ORIGEN, ID_DESTINO, FechaSalida, FechaLlegada, PrecioEstandar, CupoDisponible, CupoTotal, ID_ESTADO)
    VALUES (@ID_VUELO, @ID_AVION, @ID_ORIGEN, @ID_DESTINO, @FechaSalida, @HoraLlegadaLocal, @PrecioEstandar, @CupoTotal, @CupoTotal, @IDEstado);
END;
