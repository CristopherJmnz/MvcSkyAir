﻿USE [SkyAir]
GO
/****** Object:  Table [dbo].[Billetes]    Script Date: 19/03/2024 5:58:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Billetes](
	[ID_Billete] [int] NOT NULL,
	[ID_VUELO] [int] NOT NULL,
	[EquipajeCabina] [int] NOT NULL,
	[EquipajeMano] [int] NOT NULL,
	[Asiento] [nvarchar](50) NOT NULL,
	[Precio] [decimal](10, 2) NOT NULL,
	[Nombre] [nvarchar](150) NOT NULL,
	[DocumentoIdentidad] [nvarchar](100) NOT NULL,
	[Apellido] [nvarchar](150) NOT NULL,
	[FechaCompra] [datetime] NOT NULL,
	[Email] [nvarchar](200) NOT NULL,
	[TelefonoContacto] [nvarchar](50) NOT NULL,
	[ID_TIPO_CLASE] [int] NOT NULL,
 CONSTRAINT [PK__Billetes__4FC117A576F8CBDC] PRIMARY KEY CLUSTERED 
(
	[ID_Billete] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Estados]    Script Date: 19/03/2024 5:58:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estados](
	[ID_ESTADO] [int] NOT NULL,
	[ESTADO] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_ESTADO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Aviones]    Script Date: 19/03/2024 5:58:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aviones](
	[ID_AVION] [int] NOT NULL,
	[MODELO] [nvarchar](100) NULL,
	[CapacidadAsientos] [int] NOT NULL,
	[Velocidad] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_AVION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TIPOS_CLASES]    Script Date: 19/03/2024 5:58:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPOS_CLASES](
	[ID_TIPO_CLASE] [int] NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[EquipajeMano] [int] NULL,
	[EquipajeCabina] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_TIPO_CLASE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ciudades]    Script Date: 19/03/2024 5:58:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ciudades](
	[ID_CIUDAD] [int] NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Latitud] [decimal](9, 6) NULL,
	[Longitud] [decimal](9, 6) NULL,
	[ID_PAIS] [int] NULL,
	[ID_ZonaHoraria] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_CIUDAD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vuelos]    Script Date: 19/03/2024 5:58:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vuelos](
	[ID_VUELO] [int] NOT NULL,
	[ID_AVION] [int] NULL,
	[ID_ORIGEN] [int] NULL,
	[ID_DESTINO] [int] NULL,
	[FechaSalida] [datetime] NOT NULL,
	[FechaLlegada] [datetime] NOT NULL,
	[CupoTotal] [int] NOT NULL,
	[CupoDisponible] [int] NOT NULL,
	[PrecioEstandar] [decimal](10, 2) NULL,
	[ID_ESTADO] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_VUELO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_Vuelos]    Script Date: 19/03/2024 5:58:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[V_Vuelos]
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
GO
/****** Object:  View [dbo].[V_BILLETEVUELO]    Script Date: 19/03/2024 5:58:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[V_BILLETEVUELO]
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
/****** Object:  Table [dbo].[Continentes]    Script Date: 19/03/2024 5:58:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Continentes](
	[ID_CONTINENTE] [int] NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_CONTINENTE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Paises]    Script Date: 19/03/2024 5:58:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Paises](
	[ID_PAIS] [int] NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Latitud] [decimal](9, 6) NULL,
	[Longitud] [decimal](9, 6) NULL,
	[ID_CONTINENTE] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_PAIS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_CIUDADES]    Script Date: 19/03/2024 5:58:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE View [dbo].[V_CIUDADES]
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
GO
/****** Object:  Table [dbo].[Aeropuertos]    Script Date: 19/03/2024 5:58:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aeropuertos](
	[ID_AEROPUERTO] [int] NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[ID_CIUDAD] [int] NULL,
	[CapacidadTerminal] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_AEROPUERTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 19/03/2024 5:58:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[ID_USUARIO] [int] NOT NULL,
	[Nombre] [nvarchar](150) NOT NULL,
	[Apellido] [nvarchar](150) NOT NULL,
	[Email] [nvarchar](200) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[FechaRegistro] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_USUARIO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ZonasHorarias]    Script Date: 19/03/2024 5:58:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZonasHorarias](
	[ID_ZonaHoraria] [int] NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Desplazamiento] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_ZonaHoraria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Aviones] ([ID_AVION], [MODELO], [CapacidadAsientos], [Velocidad]) VALUES (1, N'Boeing 777', 300, 900)
INSERT [dbo].[Aviones] ([ID_AVION], [MODELO], [CapacidadAsientos], [Velocidad]) VALUES (2, N'Airbus A380', 550, 950)
INSERT [dbo].[Aviones] ([ID_AVION], [MODELO], [CapacidadAsientos], [Velocidad]) VALUES (3, N'Boeing 787', 250, 910)
INSERT [dbo].[Aviones] ([ID_AVION], [MODELO], [CapacidadAsientos], [Velocidad]) VALUES (4, N'Airbus A350', 300, 920)
INSERT [dbo].[Aviones] ([ID_AVION], [MODELO], [CapacidadAsientos], [Velocidad]) VALUES (5, N'Boeing 737', 180, 800)
GO
INSERT [dbo].[Billetes] ([ID_Billete], [ID_VUELO], [EquipajeCabina], [EquipajeMano], [Asiento], [Precio], [Nombre], [DocumentoIdentidad], [Apellido], [FechaCompra], [Email], [TelefonoContacto], [ID_TIPO_CLASE]) VALUES (1, 1, 1, 1, N'1A', CAST(77.00 AS Decimal(10, 2)), N'C', N'54656J', N'JIM', CAST(N'2024-03-17T00:00:00.000' AS DateTime), N'C@U.COM', N'765643534', 1)
INSERT [dbo].[Billetes] ([ID_Billete], [ID_VUELO], [EquipajeCabina], [EquipajeMano], [Asiento], [Precio], [Nombre], [DocumentoIdentidad], [Apellido], [FechaCompra], [Email], [TelefonoContacto], [ID_TIPO_CLASE]) VALUES (2, 1, 2, 1, N'7F', CAST(77.00 AS Decimal(10, 2)), N'A', N'34545H', N'DFG', CAST(N'2024-03-17T00:00:00.000' AS DateTime), N'C@SJHDS', N'345345', 2)
INSERT [dbo].[Billetes] ([ID_Billete], [ID_VUELO], [EquipajeCabina], [EquipajeMano], [Asiento], [Precio], [Nombre], [DocumentoIdentidad], [Apellido], [FechaCompra], [Email], [TelefonoContacto], [ID_TIPO_CLASE]) VALUES (3, 1, 0, 0, N'1D', CAST(70.00 AS Decimal(10, 2)), N'cj', N'34534G', N'jm', CAST(N'2024-03-18T09:58:13.107' AS DateTime), N'cj@gmail.com', N'90382342', 1)
INSERT [dbo].[Billetes] ([ID_Billete], [ID_VUELO], [EquipajeCabina], [EquipajeMano], [Asiento], [Precio], [Nombre], [DocumentoIdentidad], [Apellido], [FechaCompra], [Email], [TelefonoContacto], [ID_TIPO_CLASE]) VALUES (4, 1, 0, 0, N'2E', CAST(70.00 AS Decimal(10, 2)), N'Cris', N'4353443J', N'Perez', CAST(N'2024-03-18T09:58:13.343' AS DateTime), N'cj@gmail.com', N'6456456', 1)
INSERT [dbo].[Billetes] ([ID_Billete], [ID_VUELO], [EquipajeCabina], [EquipajeMano], [Asiento], [Precio], [Nombre], [DocumentoIdentidad], [Apellido], [FechaCompra], [Email], [TelefonoContacto], [ID_TIPO_CLASE]) VALUES (5, 1, 2, 2, N'2G', CAST(77.00 AS Decimal(10, 2)), N'cj', N'34534G', N'jm', CAST(N'2024-03-18T12:59:53.743' AS DateTime), N'cj@gmail.com', N'90382342', 2)
INSERT [dbo].[Billetes] ([ID_Billete], [ID_VUELO], [EquipajeCabina], [EquipajeMano], [Asiento], [Precio], [Nombre], [DocumentoIdentidad], [Apellido], [FechaCompra], [Email], [TelefonoContacto], [ID_TIPO_CLASE]) VALUES (6, 1, 2, 2, N'2H', CAST(77.00 AS Decimal(10, 2)), N'Cris', N'4353443J', N'Perez', CAST(N'2024-03-18T12:59:53.950' AS DateTime), N'cj@gmail.com', N'6456456', 2)
INSERT [dbo].[Billetes] ([ID_Billete], [ID_VUELO], [EquipajeCabina], [EquipajeMano], [Asiento], [Precio], [Nombre], [DocumentoIdentidad], [Apellido], [FechaCompra], [Email], [TelefonoContacto], [ID_TIPO_CLASE]) VALUES (7, 2, 1, 1, N'2G', CAST(68.00 AS Decimal(10, 2)), N'cj', N'34534G', N'jm', CAST(N'2024-03-18T13:31:58.397' AS DateTime), N'cj@gmail.com', N'90382342', 1)
INSERT [dbo].[Billetes] ([ID_Billete], [ID_VUELO], [EquipajeCabina], [EquipajeMano], [Asiento], [Precio], [Nombre], [DocumentoIdentidad], [Apellido], [FechaCompra], [Email], [TelefonoContacto], [ID_TIPO_CLASE]) VALUES (8, 1, 2, 2, N'6D', CAST(77.00 AS Decimal(10, 2)), N'cj', N'34534G', N'jm', CAST(N'2024-03-18T19:25:46.797' AS DateTime), N'cj@gmail.com', N'90382342', 2)
INSERT [dbo].[Billetes] ([ID_Billete], [ID_VUELO], [EquipajeCabina], [EquipajeMano], [Asiento], [Precio], [Nombre], [DocumentoIdentidad], [Apellido], [FechaCompra], [Email], [TelefonoContacto], [ID_TIPO_CLASE]) VALUES (9, 1, 1, 1, N'5E', CAST(70.00 AS Decimal(10, 2)), N'cj', N'34534G', N'jm', CAST(N'2024-03-19T05:46:31.290' AS DateTime), N'cj@gmail.com', N'90382342', 1)
INSERT [dbo].[Billetes] ([ID_Billete], [ID_VUELO], [EquipajeCabina], [EquipajeMano], [Asiento], [Precio], [Nombre], [DocumentoIdentidad], [Apellido], [FechaCompra], [Email], [TelefonoContacto], [ID_TIPO_CLASE]) VALUES (10, 1, 1, 1, N'5F', CAST(70.00 AS Decimal(10, 2)), N'Cris', N'4353443J', N'Perez', CAST(N'2024-03-19T05:46:31.540' AS DateTime), N'cj@gmail.com', N'6456456', 1)
INSERT [dbo].[Billetes] ([ID_Billete], [ID_VUELO], [EquipajeCabina], [EquipajeMano], [Asiento], [Precio], [Nombre], [DocumentoIdentidad], [Apellido], [FechaCompra], [Email], [TelefonoContacto], [ID_TIPO_CLASE]) VALUES (11, 1, 2, 2, N'1H', CAST(77.00 AS Decimal(10, 2)), N'cj', N'34534G', N'jm', CAST(N'2024-03-19T05:49:27.543' AS DateTime), N'cj@gmail.com', N'90382342', 2)
INSERT [dbo].[Billetes] ([ID_Billete], [ID_VUELO], [EquipajeCabina], [EquipajeMano], [Asiento], [Precio], [Nombre], [DocumentoIdentidad], [Apellido], [FechaCompra], [Email], [TelefonoContacto], [ID_TIPO_CLASE]) VALUES (12, 1, 1, 1, N'1I', CAST(70.00 AS Decimal(10, 2)), N'cj', N'34534G', N'jm', CAST(N'2024-03-19T05:50:14.643' AS DateTime), N'cj@gmail.com', N'90382342', 1)
GO
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (1, N'Nicosia', CAST(35.170000 AS Decimal(9, 6)), CAST(33.370000 AS Decimal(9, 6)), 1, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (2, N'Bratislava', CAST(48.150000 AS Decimal(9, 6)), CAST(17.120000 AS Decimal(9, 6)), 2, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (3, N'Vatican City', CAST(41.900000 AS Decimal(9, 6)), CAST(12.450000 AS Decimal(9, 6)), 3, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (4, N'Belgrade', CAST(44.830000 AS Decimal(9, 6)), CAST(20.500000 AS Decimal(9, 6)), 4, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (5, N'Tórshavn', CAST(62.010000 AS Decimal(9, 6)), CAST(-6.770000 AS Decimal(9, 6)), 5, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (6, N'Tirana', CAST(41.320000 AS Decimal(9, 6)), CAST(19.820000 AS Decimal(9, 6)), 6, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (7, N'Rome', CAST(41.900000 AS Decimal(9, 6)), CAST(12.480000 AS Decimal(9, 6)), 7, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (8, N'Madrid', CAST(40.400000 AS Decimal(9, 6)), CAST(-3.680000 AS Decimal(9, 6)), 8, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (9, N'Dublin', CAST(53.320000 AS Decimal(9, 6)), CAST(-6.230000 AS Decimal(9, 6)), 9, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (10, N'Zagreb', CAST(45.800000 AS Decimal(9, 6)), CAST(16.000000 AS Decimal(9, 6)), 10, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (11, N'Tallinn', CAST(59.430000 AS Decimal(9, 6)), CAST(24.720000 AS Decimal(9, 6)), 11, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (12, N'London', CAST(51.500000 AS Decimal(9, 6)), CAST(-0.080000 AS Decimal(9, 6)), 12, 5)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (13, N'Gibraltar', CAST(36.130000 AS Decimal(9, 6)), CAST(-5.350000 AS Decimal(9, 6)), 13, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (14, N'Helsinki', CAST(60.170000 AS Decimal(9, 6)), CAST(24.930000 AS Decimal(9, 6)), 14, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (15, N'Stockholm', CAST(59.330000 AS Decimal(9, 6)), CAST(18.050000 AS Decimal(9, 6)), 15, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (16, N'Reykjavik', CAST(64.150000 AS Decimal(9, 6)), CAST(-21.950000 AS Decimal(9, 6)), 16, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (17, N'Bern', CAST(46.920000 AS Decimal(9, 6)), CAST(7.470000 AS Decimal(9, 6)), 17, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (18, N'Riga', CAST(56.950000 AS Decimal(9, 6)), CAST(24.100000 AS Decimal(9, 6)), 18, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (19, N'Warsaw', CAST(52.250000 AS Decimal(9, 6)), CAST(21.000000 AS Decimal(9, 6)), 19, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (20, N'Vilnius', CAST(54.680000 AS Decimal(9, 6)), CAST(25.320000 AS Decimal(9, 6)), 20, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (21, N'Andorra la Vella', CAST(42.500000 AS Decimal(9, 6)), CAST(1.520000 AS Decimal(9, 6)), 21, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (22, N'Saint Helier', CAST(49.180000 AS Decimal(9, 6)), CAST(-2.100000 AS Decimal(9, 6)), 22, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (23, N'Valletta', CAST(35.880000 AS Decimal(9, 6)), CAST(14.500000 AS Decimal(9, 6)), 23, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (24, N'Berlin', CAST(52.520000 AS Decimal(9, 6)), CAST(13.400000 AS Decimal(9, 6)), 24, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (25, N'City of San Marino', CAST(43.940000 AS Decimal(9, 6)), CAST(12.450000 AS Decimal(9, 6)), 25, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (26, N'Luxembourg', CAST(49.600000 AS Decimal(9, 6)), CAST(6.120000 AS Decimal(9, 6)), 26, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (27, N'Bucharest', CAST(44.430000 AS Decimal(9, 6)), CAST(26.100000 AS Decimal(9, 6)), 27, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (28, N'Longyearbyen', CAST(78.220000 AS Decimal(9, 6)), CAST(15.630000 AS Decimal(9, 6)), 28, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (29, N'Minsk', CAST(53.900000 AS Decimal(9, 6)), CAST(27.570000 AS Decimal(9, 6)), 29, 16)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (30, N'Mariehamn', CAST(60.120000 AS Decimal(9, 6)), CAST(19.900000 AS Decimal(9, 6)), 30, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (31, N'St. Peter Port', CAST(49.450000 AS Decimal(9, 6)), CAST(-2.540000 AS Decimal(9, 6)), 31, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (32, N'Oslo', CAST(59.920000 AS Decimal(9, 6)), CAST(10.750000 AS Decimal(9, 6)), 32, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (33, N'Brussels', CAST(50.830000 AS Decimal(9, 6)), CAST(4.330000 AS Decimal(9, 6)), 33, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (34, N'Lisbon', CAST(38.720000 AS Decimal(9, 6)), CAST(-9.130000 AS Decimal(9, 6)), 34, 12)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (35, N'Copenhagen', CAST(55.670000 AS Decimal(9, 6)), CAST(12.580000 AS Decimal(9, 6)), 35, 9)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (36, N'Prague', CAST(50.080000 AS Decimal(9, 6)), CAST(14.470000 AS Decimal(9, 6)), 36, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (37, N'Athens', CAST(37.980000 AS Decimal(9, 6)), CAST(23.730000 AS Decimal(9, 6)), 37, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (38, N'Vienna', CAST(48.200000 AS Decimal(9, 6)), CAST(16.370000 AS Decimal(9, 6)), 38, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (39, N'Monaco', CAST(43.730000 AS Decimal(9, 6)), CAST(7.420000 AS Decimal(9, 6)), 39, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (40, N'Ljubljana', CAST(46.050000 AS Decimal(9, 6)), CAST(14.520000 AS Decimal(9, 6)), 40, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (41, N'Sarajevo', CAST(43.870000 AS Decimal(9, 6)), CAST(18.420000 AS Decimal(9, 6)), 41, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (42, N'Paris', CAST(48.870000 AS Decimal(9, 6)), CAST(2.330000 AS Decimal(9, 6)), 42, 3)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (43, N'Sofia', CAST(42.680000 AS Decimal(9, 6)), CAST(23.320000 AS Decimal(9, 6)), 43, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (44, N'Chi?inau', CAST(47.010000 AS Decimal(9, 6)), CAST(28.900000 AS Decimal(9, 6)), 44, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (45, N'Douglas', CAST(54.150000 AS Decimal(9, 6)), CAST(-4.480000 AS Decimal(9, 6)), 45, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (46, N'Podgorica', CAST(42.430000 AS Decimal(9, 6)), CAST(19.270000 AS Decimal(9, 6)), 46, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (47, N'Budapest', CAST(47.500000 AS Decimal(9, 6)), CAST(19.080000 AS Decimal(9, 6)), 47, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (48, N'Skopje', CAST(42.000000 AS Decimal(9, 6)), CAST(21.430000 AS Decimal(9, 6)), 48, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (49, N'Pristina', CAST(42.670000 AS Decimal(9, 6)), CAST(21.170000 AS Decimal(9, 6)), 49, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (50, N'Amsterdam', CAST(52.350000 AS Decimal(9, 6)), CAST(4.920000 AS Decimal(9, 6)), 50, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (51, N'Kyiv', CAST(50.430000 AS Decimal(9, 6)), CAST(30.520000 AS Decimal(9, 6)), 51, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (52, N'Vaduz', CAST(47.130000 AS Decimal(9, 6)), CAST(9.520000 AS Decimal(9, 6)), 52, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (53, N'Moscow', CAST(55.750000 AS Decimal(9, 6)), CAST(37.600000 AS Decimal(9, 6)), 53, 16)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (54, N'Nuuk', CAST(64.180000 AS Decimal(9, 6)), CAST(-51.750000 AS Decimal(9, 6)), 54, 9)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (55, N'Saint-Pierre', CAST(46.770000 AS Decimal(9, 6)), CAST(-56.180000 AS Decimal(9, 6)), 55, 10)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (56, N'Ottawa', CAST(45.420000 AS Decimal(9, 6)), CAST(-75.700000 AS Decimal(9, 6)), 56, 5)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (58, N'Hamilton', CAST(32.280000 AS Decimal(9, 6)), CAST(-64.780000 AS Decimal(9, 6)), 58, 9)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (59, N'Mexico City', CAST(19.430000 AS Decimal(9, 6)), CAST(-99.130000 AS Decimal(9, 6)), 59, 5)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (60, N'Washington, D.C.', CAST(38.890000 AS Decimal(9, 6)), CAST(-77.050000 AS Decimal(9, 6)), 60, 1)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (61, N'Brasília', CAST(-15.790000 AS Decimal(9, 6)), CAST(-47.880000 AS Decimal(9, 6)), 61, 8)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (62, N'Lima', CAST(-12.050000 AS Decimal(9, 6)), CAST(-77.050000 AS Decimal(9, 6)), 62, 8)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (63, N'Bogotá', CAST(4.710000 AS Decimal(9, 6)), CAST(-74.070000 AS Decimal(9, 6)), 63, 8)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (64, N'Paramaribo', CAST(5.830000 AS Decimal(9, 6)), CAST(-55.170000 AS Decimal(9, 6)), 64, 10)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (65, N'Quito', CAST(-0.220000 AS Decimal(9, 6)), CAST(-78.500000 AS Decimal(9, 6)), 65, 7)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (66, N'Caracas', CAST(10.480000 AS Decimal(9, 6)), CAST(-66.870000 AS Decimal(9, 6)), 66, 9)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (67, N'Stanley', CAST(-51.700000 AS Decimal(9, 6)), CAST(-57.850000 AS Decimal(9, 6)), 67, 9)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (68, N'Sucre', CAST(-19.020000 AS Decimal(9, 6)), CAST(-65.260000 AS Decimal(9, 6)), 68, 9)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (69, N'Cayenne', CAST(4.940000 AS Decimal(9, 6)), CAST(-52.330000 AS Decimal(9, 6)), 69, 10)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (70, N'Asunción', CAST(-25.280000 AS Decimal(9, 6)), CAST(-57.570000 AS Decimal(9, 6)), 70, 9)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (71, N'Montevideo', CAST(-34.850000 AS Decimal(9, 6)), CAST(-56.170000 AS Decimal(9, 6)), 71, 10)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (72, N'Georgetown', CAST(6.800000 AS Decimal(9, 6)), CAST(-58.150000 AS Decimal(9, 6)), 72, 9)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (73, N'Santiago', CAST(-33.450000 AS Decimal(9, 6)), CAST(-70.670000 AS Decimal(9, 6)), 73, 7)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (74, N'Buenos Aires', CAST(-34.580000 AS Decimal(9, 6)), CAST(-58.670000 AS Decimal(9, 6)), 74, 10)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (75, N'Asmara', CAST(15.330000 AS Decimal(9, 6)), CAST(38.930000 AS Decimal(9, 6)), 75, 16)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (76, N'Monrovia', CAST(6.300000 AS Decimal(9, 6)), CAST(-10.800000 AS Decimal(9, 6)), 76, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (77, N'Kampala', CAST(0.320000 AS Decimal(9, 6)), CAST(32.550000 AS Decimal(9, 6)), 77, 16)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (78, N'Mamoudzou', CAST(-12.780000 AS Decimal(9, 6)), CAST(45.220000 AS Decimal(9, 6)), 78, 16)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (79, N'Mogadishu', CAST(2.070000 AS Decimal(9, 6)), CAST(45.330000 AS Decimal(9, 6)), 79, 16)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (80, N'Lusaka', CAST(-15.420000 AS Decimal(9, 6)), CAST(28.280000 AS Decimal(9, 6)), 80, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (81, N'Algiers', CAST(36.750000 AS Decimal(9, 6)), CAST(3.050000 AS Decimal(9, 6)), 81, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (82, N'Cairo', CAST(30.050000 AS Decimal(9, 6)), CAST(31.250000 AS Decimal(9, 6)), 82, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (83, N'Antananarivo', CAST(-18.920000 AS Decimal(9, 6)), CAST(47.520000 AS Decimal(9, 6)), 83, 16)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (84, N'Khartoum', CAST(15.600000 AS Decimal(9, 6)), CAST(32.530000 AS Decimal(9, 6)), 84, 16)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (85, N'Pretoria', CAST(-25.700000 AS Decimal(9, 6)), CAST(28.220000 AS Decimal(9, 6)), 85, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (86, N'Brazzaville', CAST(-4.250000 AS Decimal(9, 6)), CAST(15.280000 AS Decimal(9, 6)), 86, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (87, N'Nairobi', CAST(-1.280000 AS Decimal(9, 6)), CAST(36.820000 AS Decimal(9, 6)), 87, 16)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (88, N'Diego Garcia', CAST(-7.300000 AS Decimal(9, 6)), CAST(72.400000 AS Decimal(9, 6)), 88, 19)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (89, N'Yamoussoukro', CAST(6.820000 AS Decimal(9, 6)), CAST(-5.270000 AS Decimal(9, 6)), 89, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (90, N'Dakar', CAST(14.730000 AS Decimal(9, 6)), CAST(-17.630000 AS Decimal(9, 6)), 90, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (91, N'Nouakchott', CAST(18.070000 AS Decimal(9, 6)), CAST(-15.970000 AS Decimal(9, 6)), 91, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (92, N'Banjul', CAST(13.450000 AS Decimal(9, 6)), CAST(-16.570000 AS Decimal(9, 6)), 92, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (93, N'Victoria', CAST(-4.620000 AS Decimal(9, 6)), CAST(55.450000 AS Decimal(9, 6)), 93, 17)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (94, N'Jamestown', CAST(-15.930000 AS Decimal(9, 6)), CAST(-5.720000 AS Decimal(9, 6)), 94, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (95, N'São Tomé', CAST(0.340000 AS Decimal(9, 6)), CAST(6.730000 AS Decimal(9, 6)), 95, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (96, N'Accra', CAST(5.550000 AS Decimal(9, 6)), CAST(-0.220000 AS Decimal(9, 6)), 96, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (97, N'Dodoma', CAST(-6.160000 AS Decimal(9, 6)), CAST(35.750000 AS Decimal(9, 6)), 97, 16)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (98, N'Abuja', CAST(9.080000 AS Decimal(9, 6)), CAST(7.530000 AS Decimal(9, 6)), 98, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (99, N'Lomé', CAST(6.140000 AS Decimal(9, 6)), CAST(1.210000 AS Decimal(9, 6)), 99, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (100, N'Djibouti', CAST(11.580000 AS Decimal(9, 6)), CAST(43.150000 AS Decimal(9, 6)), 100, 16)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (101, N'Niamey', CAST(13.520000 AS Decimal(9, 6)), CAST(2.120000 AS Decimal(9, 6)), 101, 14)
GO
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (102, N'Addis Ababa', CAST(9.030000 AS Decimal(9, 6)), CAST(38.700000 AS Decimal(9, 6)), 102, 16)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (103, N'El Aaiún', CAST(-13.280000 AS Decimal(9, 6)), CAST(27.140000 AS Decimal(9, 6)), 103, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (104, N'Rabat', CAST(34.020000 AS Decimal(9, 6)), CAST(-6.820000 AS Decimal(9, 6)), 104, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (105, N'Malabo', CAST(3.750000 AS Decimal(9, 6)), CAST(8.780000 AS Decimal(9, 6)), 105, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (106, N'Bangui', CAST(4.370000 AS Decimal(9, 6)), CAST(18.580000 AS Decimal(9, 6)), 106, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (107, N'Conakry', CAST(9.500000 AS Decimal(9, 6)), CAST(-13.700000 AS Decimal(9, 6)), 107, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (108, N'Gaborone', CAST(-24.630000 AS Decimal(9, 6)), CAST(25.900000 AS Decimal(9, 6)), 108, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (109, N'Yaoundé', CAST(3.850000 AS Decimal(9, 6)), CAST(11.500000 AS Decimal(9, 6)), 109, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (110, N'Libreville', CAST(0.380000 AS Decimal(9, 6)), CAST(9.450000 AS Decimal(9, 6)), 110, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (111, N'Bissau', CAST(11.850000 AS Decimal(9, 6)), CAST(-15.580000 AS Decimal(9, 6)), 111, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (112, N'Harare', CAST(-17.820000 AS Decimal(9, 6)), CAST(31.030000 AS Decimal(9, 6)), 112, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (113, N'Maseru', CAST(-29.320000 AS Decimal(9, 6)), CAST(27.480000 AS Decimal(9, 6)), 113, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (114, N'Windhoek', CAST(-22.570000 AS Decimal(9, 6)), CAST(17.080000 AS Decimal(9, 6)), 114, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (115, N'Ouagadougou', CAST(12.370000 AS Decimal(9, 6)), CAST(-1.520000 AS Decimal(9, 6)), 115, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (116, N'Bamako', CAST(12.650000 AS Decimal(9, 6)), CAST(-8.000000 AS Decimal(9, 6)), 116, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (117, N'Porto-Novo', CAST(6.480000 AS Decimal(9, 6)), CAST(2.620000 AS Decimal(9, 6)), 117, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (118, N'Maputo', CAST(-25.950000 AS Decimal(9, 6)), CAST(32.580000 AS Decimal(9, 6)), 118, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (119, N'Saint-Denis', CAST(-20.880000 AS Decimal(9, 6)), CAST(55.450000 AS Decimal(9, 6)), 119, 17)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (120, N'Kinshasa', CAST(-4.320000 AS Decimal(9, 6)), CAST(15.300000 AS Decimal(9, 6)), 120, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (121, N'NDjamena', CAST(12.100000 AS Decimal(9, 6)), CAST(15.030000 AS Decimal(9, 6)), 121, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (122, N'Praia', CAST(14.920000 AS Decimal(9, 6)), CAST(-23.520000 AS Decimal(9, 6)), 122, 12)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (123, N'Gitega', CAST(-3.430000 AS Decimal(9, 6)), CAST(29.930000 AS Decimal(9, 6)), 123, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (124, N'Kigali', CAST(-1.950000 AS Decimal(9, 6)), CAST(30.050000 AS Decimal(9, 6)), 124, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (125, N'Port Louis', CAST(-20.150000 AS Decimal(9, 6)), CAST(57.480000 AS Decimal(9, 6)), 125, 17)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (126, N'Tripoli', CAST(32.880000 AS Decimal(9, 6)), CAST(13.170000 AS Decimal(9, 6)), 126, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (127, N'Lilongwe', CAST(-13.970000 AS Decimal(9, 6)), CAST(33.780000 AS Decimal(9, 6)), 127, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (128, N'Tunis', CAST(36.800000 AS Decimal(9, 6)), CAST(10.180000 AS Decimal(9, 6)), 128, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (129, N'Moroni', CAST(-11.700000 AS Decimal(9, 6)), CAST(43.230000 AS Decimal(9, 6)), 129, 16)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (130, N'Mbabane', CAST(-26.320000 AS Decimal(9, 6)), CAST(31.130000 AS Decimal(9, 6)), 130, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (131, N'Juba', CAST(4.850000 AS Decimal(9, 6)), CAST(31.620000 AS Decimal(9, 6)), 131, 16)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (132, N'Luanda', CAST(-8.830000 AS Decimal(9, 6)), CAST(13.220000 AS Decimal(9, 6)), 132, 14)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (133, N'Freetown', CAST(8.480000 AS Decimal(9, 6)), CAST(-13.230000 AS Decimal(9, 6)), 133, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (134, N'Jerusalem', CAST(31.770000 AS Decimal(9, 6)), CAST(35.230000 AS Decimal(9, 6)), 134, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (135, N'Singapore', CAST(1.280000 AS Decimal(9, 6)), CAST(103.850000 AS Decimal(9, 6)), 135, 21)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (136, N'Abu Dhabi', CAST(24.470000 AS Decimal(9, 6)), CAST(54.370000 AS Decimal(9, 6)), 136, 17)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (137, N'Beijing', CAST(39.920000 AS Decimal(9, 6)), CAST(116.380000 AS Decimal(9, 6)), 137, 21)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (138, N'Tashkent', CAST(41.320000 AS Decimal(9, 6)), CAST(69.250000 AS Decimal(9, 6)), 138, 18)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (139, N'Ashgabat', CAST(37.950000 AS Decimal(9, 6)), CAST(58.380000 AS Decimal(9, 6)), 139, 18)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (140, N'Malé', CAST(4.170000 AS Decimal(9, 6)), CAST(73.510000 AS Decimal(9, 6)), 140, 18)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (141, N'Ramallah,Jerusalem', CAST(31.900000 AS Decimal(9, 6)), CAST(35.200000 AS Decimal(9, 6)), 141, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (142, N'Riyadh', CAST(24.650000 AS Decimal(9, 6)), CAST(46.700000 AS Decimal(9, 6)), 142, 16)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (143, N'Ankara', CAST(39.930000 AS Decimal(9, 6)), CAST(32.870000 AS Decimal(9, 6)), 143, 16)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (144, N'Kuala Lumpur', CAST(3.170000 AS Decimal(9, 6)), CAST(101.700000 AS Decimal(9, 6)), 144, 21)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (145, N'Dili', CAST(-8.580000 AS Decimal(9, 6)), CAST(125.600000 AS Decimal(9, 6)), 145, 22)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (146, N'Nur-Sultan', CAST(51.160000 AS Decimal(9, 6)), CAST(71.450000 AS Decimal(9, 6)), 146, 18)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (147, N'Baku', CAST(40.380000 AS Decimal(9, 6)), CAST(49.870000 AS Decimal(9, 6)), 147, 17)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (148, N'Beirut', CAST(33.870000 AS Decimal(9, 6)), CAST(35.500000 AS Decimal(9, 6)), 148, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (149, N'Doha', CAST(25.280000 AS Decimal(9, 6)), CAST(51.530000 AS Decimal(9, 6)), 149, 16)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (150, N'Hanoi', CAST(21.030000 AS Decimal(9, 6)), CAST(105.850000 AS Decimal(9, 6)), 150, 20)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (151, N'Kabul', CAST(34.520000 AS Decimal(9, 6)), CAST(69.180000 AS Decimal(9, 6)), 151, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (152, N'Tokyo', CAST(35.680000 AS Decimal(9, 6)), CAST(139.750000 AS Decimal(9, 6)), 152, 22)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (153, N'Damascus', CAST(33.500000 AS Decimal(9, 6)), CAST(36.300000 AS Decimal(9, 6)), 153, 15)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (154, N'Amman', CAST(31.950000 AS Decimal(9, 6)), CAST(35.930000 AS Decimal(9, 6)), 154, 16)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (155, N'Kuwait City', CAST(29.370000 AS Decimal(9, 6)), CAST(47.970000 AS Decimal(9, 6)), 155, 16)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (156, N'Naypyidaw', CAST(19.760000 AS Decimal(9, 6)), CAST(96.070000 AS Decimal(9, 6)), 156, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (157, N'Bishkek', CAST(42.870000 AS Decimal(9, 6)), CAST(74.600000 AS Decimal(9, 6)), 157, 19)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (158, N'Bangkok', CAST(13.750000 AS Decimal(9, 6)), CAST(100.520000 AS Decimal(9, 6)), 158, 20)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (159, N'Yerevan', CAST(40.170000 AS Decimal(9, 6)), CAST(44.500000 AS Decimal(9, 6)), 159, 17)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (160, N'Tehran', CAST(35.700000 AS Decimal(9, 6)), CAST(51.420000 AS Decimal(9, 6)), 160, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (161, N'Manama', CAST(26.230000 AS Decimal(9, 6)), CAST(50.570000 AS Decimal(9, 6)), 161, 16)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (162, N'Vientiane', CAST(17.970000 AS Decimal(9, 6)), CAST(102.600000 AS Decimal(9, 6)), 162, 20)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (163, N'Seoul', CAST(37.550000 AS Decimal(9, 6)), CAST(126.980000 AS Decimal(9, 6)), 163, 22)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (164, N'Ulan Bator', CAST(47.920000 AS Decimal(9, 6)), CAST(106.910000 AS Decimal(9, 6)), 164, 20)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (165, N'New Delhi', CAST(28.600000 AS Decimal(9, 6)), CAST(77.200000 AS Decimal(9, 6)), 165, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (166, N'Dushanbe', CAST(38.550000 AS Decimal(9, 6)), CAST(68.770000 AS Decimal(9, 6)), 166, 18)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (167, N'Bandar Seri Begawan', CAST(4.880000 AS Decimal(9, 6)), CAST(114.930000 AS Decimal(9, 6)), 167, 21)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (168, N'Kathmandu', CAST(27.720000 AS Decimal(9, 6)), CAST(85.320000 AS Decimal(9, 6)), 168, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (169, N'Manila', CAST(14.600000 AS Decimal(9, 6)), CAST(120.970000 AS Decimal(9, 6)), 169, 21)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (170, N'Taipei', CAST(25.030000 AS Decimal(9, 6)), CAST(121.520000 AS Decimal(9, 6)), 170, 21)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (172, N'Sanaa', CAST(15.370000 AS Decimal(9, 6)), CAST(44.190000 AS Decimal(9, 6)), 172, 16)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (173, N'Islamabad', CAST(33.680000 AS Decimal(9, 6)), CAST(73.050000 AS Decimal(9, 6)), 173, 18)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (174, N'Thimphu', CAST(27.470000 AS Decimal(9, 6)), CAST(89.630000 AS Decimal(9, 6)), 174, 19)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (175, N'Phnom Penh', CAST(11.550000 AS Decimal(9, 6)), CAST(104.920000 AS Decimal(9, 6)), 175, 20)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (176, N'Muscat', CAST(23.620000 AS Decimal(9, 6)), CAST(58.580000 AS Decimal(9, 6)), 176, 17)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (177, N'Tbilisi', CAST(41.680000 AS Decimal(9, 6)), CAST(44.830000 AS Decimal(9, 6)), 177, 17)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (178, N'Pyongyang', CAST(39.020000 AS Decimal(9, 6)), CAST(125.750000 AS Decimal(9, 6)), 178, 22)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (179, N'Jakarta', CAST(-6.170000 AS Decimal(9, 6)), CAST(106.820000 AS Decimal(9, 6)), 179, 20)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (180, N'Dhaka', CAST(23.720000 AS Decimal(9, 6)), CAST(90.400000 AS Decimal(9, 6)), 180, 19)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (181, N'Baghdad', CAST(33.330000 AS Decimal(9, 6)), CAST(44.400000 AS Decimal(9, 6)), 181, 16)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (182, N'Sri Jayawardenepura Kotte', CAST(6.890000 AS Decimal(9, 6)), CAST(79.900000 AS Decimal(9, 6)), 182, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (183, N'City of Victoria', CAST(22.267000 AS Decimal(9, 6)), CAST(114.188000 AS Decimal(9, 6)), 183, 21)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (184, N'Fakaofo', CAST(-9.380000 AS Decimal(9, 6)), CAST(-171.220000 AS Decimal(9, 6)), 184, 26)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (185, N'Nuku alofa', CAST(-21.130000 AS Decimal(9, 6)), CAST(-175.200000 AS Decimal(9, 6)), 185, 26)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (186, N'Suva', CAST(-18.130000 AS Decimal(9, 6)), CAST(178.420000 AS Decimal(9, 6)), 186, 25)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (187, N'Flying Fish Cove', CAST(-10.420000 AS Decimal(9, 6)), CAST(105.680000 AS Decimal(9, 6)), 187, 20)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (188, N'Wellington', CAST(-41.300000 AS Decimal(9, 6)), CAST(174.780000 AS Decimal(9, 6)), 188, 2)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (189, N'Avarua', CAST(-21.200000 AS Decimal(9, 6)), CAST(-159.770000 AS Decimal(9, 6)), 189, 3)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (190, N'Nouméa', CAST(-22.270000 AS Decimal(9, 6)), CAST(166.450000 AS Decimal(9, 6)), 190, 24)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (191, N'Alofi', CAST(-19.020000 AS Decimal(9, 6)), CAST(-169.920000 AS Decimal(9, 6)), 191, 2)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (192, N'South Tarawa', CAST(1.330000 AS Decimal(9, 6)), CAST(172.980000 AS Decimal(9, 6)), 192, 25)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (193, N'Port Vila', CAST(-17.730000 AS Decimal(9, 6)), CAST(168.320000 AS Decimal(9, 6)), 193, 24)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (194, N'Majuro', CAST(7.100000 AS Decimal(9, 6)), CAST(171.380000 AS Decimal(9, 6)), 194, 25)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (195, N'Pago Pago', CAST(-14.270000 AS Decimal(9, 6)), CAST(-170.700000 AS Decimal(9, 6)), 195, 2)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (196, N'Ngerulmud', CAST(7.500000 AS Decimal(9, 6)), CAST(134.620000 AS Decimal(9, 6)), 196, 22)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (197, N'Mata-Utu', CAST(-13.950000 AS Decimal(9, 6)), CAST(-171.930000 AS Decimal(9, 6)), 197, 25)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (198, N'Kingston', CAST(-29.050000 AS Decimal(9, 6)), CAST(167.970000 AS Decimal(9, 6)), 198, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (199, N'Papeete', CAST(-17.530000 AS Decimal(9, 6)), CAST(-149.560000 AS Decimal(9, 6)), 199, 3)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (200, N'Adamstown', CAST(-25.070000 AS Decimal(9, 6)), CAST(-130.080000 AS Decimal(9, 6)), 200, 5)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (201, N'Canberra', CAST(-35.270000 AS Decimal(9, 6)), CAST(149.130000 AS Decimal(9, 6)), 201, 18)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (202, N'Hagåtña', CAST(13.480000 AS Decimal(9, 6)), CAST(144.750000 AS Decimal(9, 6)), 202, 23)
GO
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (203, N'Yaren', CAST(-0.550000 AS Decimal(9, 6)), CAST(166.920000 AS Decimal(9, 6)), 203, 25)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (204, N'West Island', CAST(-12.170000 AS Decimal(9, 6)), CAST(96.830000 AS Decimal(9, 6)), 204, 13)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (205, N'Honiara', CAST(-9.430000 AS Decimal(9, 6)), CAST(159.950000 AS Decimal(9, 6)), 205, 24)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (206, N'Saipan', CAST(15.200000 AS Decimal(9, 6)), CAST(145.750000 AS Decimal(9, 6)), 206, 23)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (207, N'Apia', CAST(-13.820000 AS Decimal(9, 6)), CAST(-171.770000 AS Decimal(9, 6)), 207, 26)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (208, N'Funafuti', CAST(-8.520000 AS Decimal(9, 6)), CAST(179.220000 AS Decimal(9, 6)), 208, 25)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (209, N'Port Moresby', CAST(-9.450000 AS Decimal(9, 6)), CAST(147.180000 AS Decimal(9, 6)), 209, 23)
INSERT [dbo].[Ciudades] ([ID_CIUDAD], [Nombre], [Latitud], [Longitud], [ID_PAIS], [ID_ZonaHoraria]) VALUES (210, N'Palikir', CAST(6.920000 AS Decimal(9, 6)), CAST(158.150000 AS Decimal(9, 6)), 210, 23)
GO
INSERT [dbo].[Continentes] ([ID_CONTINENTE], [Nombre]) VALUES (1, N'Europa')
INSERT [dbo].[Continentes] ([ID_CONTINENTE], [Nombre]) VALUES (2, N'América del Norte')
INSERT [dbo].[Continentes] ([ID_CONTINENTE], [Nombre]) VALUES (3, N'América del Sur')
INSERT [dbo].[Continentes] ([ID_CONTINENTE], [Nombre]) VALUES (4, N'África')
INSERT [dbo].[Continentes] ([ID_CONTINENTE], [Nombre]) VALUES (5, N'Asia')
INSERT [dbo].[Continentes] ([ID_CONTINENTE], [Nombre]) VALUES (6, N'Oceanía')
GO
INSERT [dbo].[Estados] ([ID_ESTADO], [ESTADO]) VALUES (1, N'PENDIENTE')
INSERT [dbo].[Estados] ([ID_ESTADO], [ESTADO]) VALUES (2, N'VOLANDO')
INSERT [dbo].[Estados] ([ID_ESTADO], [ESTADO]) VALUES (3, N'CANCELADO')
INSERT [dbo].[Estados] ([ID_ESTADO], [ESTADO]) VALUES (4, N'APLAZADO')
GO
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (1, N'Chipre', CAST(35.000000 AS Decimal(9, 6)), CAST(33.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (2, N'República Eslovaca', CAST(48.666667 AS Decimal(9, 6)), CAST(19.500000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (3, N'Ciudad del Vaticano', CAST(41.900000 AS Decimal(9, 6)), CAST(12.450000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (4, N'Serbia', CAST(44.000000 AS Decimal(9, 6)), CAST(21.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (5, N'Islas Faroe', CAST(62.000000 AS Decimal(9, 6)), CAST(-7.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (6, N'Albania', CAST(41.000000 AS Decimal(9, 6)), CAST(20.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (7, N'Italia', CAST(42.833333 AS Decimal(9, 6)), CAST(12.833333 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (8, N'España', CAST(40.000000 AS Decimal(9, 6)), CAST(-4.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (9, N'Irlanda', CAST(53.000000 AS Decimal(9, 6)), CAST(-8.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (10, N'Croacia', CAST(45.166667 AS Decimal(9, 6)), CAST(15.500000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (11, N'Estonia', CAST(59.000000 AS Decimal(9, 6)), CAST(26.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (12, N'Reino Unido', CAST(54.000000 AS Decimal(9, 6)), CAST(-2.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (13, N'Gibraltar', CAST(36.133333 AS Decimal(9, 6)), CAST(-5.350000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (14, N'Finlandia', CAST(64.000000 AS Decimal(9, 6)), CAST(26.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (15, N'Suecia', CAST(62.000000 AS Decimal(9, 6)), CAST(15.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (16, N'Islandia', CAST(65.000000 AS Decimal(9, 6)), CAST(-18.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (17, N'Suiza', CAST(47.000000 AS Decimal(9, 6)), CAST(8.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (18, N'Letonia', CAST(57.000000 AS Decimal(9, 6)), CAST(25.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (19, N'Polonia', CAST(52.000000 AS Decimal(9, 6)), CAST(20.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (20, N'Lituania', CAST(56.000000 AS Decimal(9, 6)), CAST(24.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (21, N'Andorra', CAST(42.500000 AS Decimal(9, 6)), CAST(1.500000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (22, N'Jersey', CAST(49.250000 AS Decimal(9, 6)), CAST(-2.166667 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (23, N'Malta', CAST(35.937500 AS Decimal(9, 6)), CAST(14.375400 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (24, N'Alemania', CAST(51.000000 AS Decimal(9, 6)), CAST(9.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (25, N'San Marino', CAST(43.766667 AS Decimal(9, 6)), CAST(12.416667 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (26, N'Luxemburgo', CAST(49.750000 AS Decimal(9, 6)), CAST(6.166667 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (27, N'Rumania', CAST(46.000000 AS Decimal(9, 6)), CAST(25.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (28, N'Islas Svalbard y Jan Mayen', CAST(78.000000 AS Decimal(9, 6)), CAST(20.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (29, N'Bielorrusia', CAST(53.000000 AS Decimal(9, 6)), CAST(28.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (30, N'Alandia', CAST(60.116667 AS Decimal(9, 6)), CAST(19.900000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (31, N'Guernsey', CAST(49.466667 AS Decimal(9, 6)), CAST(-2.583333 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (32, N'Noruega', CAST(62.000000 AS Decimal(9, 6)), CAST(10.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (33, N'Bélgica', CAST(50.833333 AS Decimal(9, 6)), CAST(4.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (34, N'Portugal', CAST(39.500000 AS Decimal(9, 6)), CAST(-8.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (35, N'Dinamarca', CAST(56.000000 AS Decimal(9, 6)), CAST(10.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (36, N'Chequia', CAST(49.750000 AS Decimal(9, 6)), CAST(15.500000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (37, N'Grecia', CAST(39.000000 AS Decimal(9, 6)), CAST(22.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (38, N'Austria', CAST(47.333333 AS Decimal(9, 6)), CAST(13.333333 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (39, N'Mónaco', CAST(43.733333 AS Decimal(9, 6)), CAST(7.400000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (40, N'Eslovenia', CAST(46.116667 AS Decimal(9, 6)), CAST(14.816667 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (41, N'Bosnia y Herzegovina', CAST(44.000000 AS Decimal(9, 6)), CAST(18.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (42, N'Francia', CAST(46.000000 AS Decimal(9, 6)), CAST(2.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (43, N'Bulgaria', CAST(43.000000 AS Decimal(9, 6)), CAST(25.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (44, N'Moldavia', CAST(47.000000 AS Decimal(9, 6)), CAST(29.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (45, N'Isla de Man', CAST(54.250000 AS Decimal(9, 6)), CAST(-4.500000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (46, N'Montenegro', CAST(42.500000 AS Decimal(9, 6)), CAST(19.300000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (47, N'Hungría', CAST(47.000000 AS Decimal(9, 6)), CAST(20.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (48, N'Macedonia del Norte', CAST(41.833333 AS Decimal(9, 6)), CAST(22.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (49, N'Kosovo', CAST(42.666667 AS Decimal(9, 6)), CAST(21.166667 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (50, N'Países Bajos', CAST(52.500000 AS Decimal(9, 6)), CAST(5.750000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (51, N'Ucrania', CAST(49.000000 AS Decimal(9, 6)), CAST(32.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (52, N'Liechtenstein', CAST(47.266667 AS Decimal(9, 6)), CAST(9.533333 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (53, N'Rusia', CAST(60.000000 AS Decimal(9, 6)), CAST(100.000000 AS Decimal(9, 6)), 1)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (54, N'Groenlandia', CAST(72.000000 AS Decimal(9, 6)), CAST(-40.000000 AS Decimal(9, 6)), 2)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (55, N'San Pedro y Miquelón', CAST(46.833333 AS Decimal(9, 6)), CAST(-56.333333 AS Decimal(9, 6)), 2)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (56, N'Canadá', CAST(60.000000 AS Decimal(9, 6)), CAST(-95.000000 AS Decimal(9, 6)), 2)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (57, N'Islas Ultramarinas Menores de Estados Unidos', CAST(19.300000 AS Decimal(9, 6)), CAST(166.633333 AS Decimal(9, 6)), 2)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (58, N'Bermudas', CAST(32.333333 AS Decimal(9, 6)), CAST(-64.750000 AS Decimal(9, 6)), 2)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (59, N'México', CAST(23.000000 AS Decimal(9, 6)), CAST(-102.000000 AS Decimal(9, 6)), 2)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (60, N'Estados Unidos', CAST(38.000000 AS Decimal(9, 6)), CAST(-97.000000 AS Decimal(9, 6)), 2)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (61, N'Brasil', CAST(-10.000000 AS Decimal(9, 6)), CAST(-55.000000 AS Decimal(9, 6)), 3)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (62, N'Perú', CAST(-10.000000 AS Decimal(9, 6)), CAST(-76.000000 AS Decimal(9, 6)), 3)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (63, N'Colombia', CAST(4.000000 AS Decimal(9, 6)), CAST(-72.000000 AS Decimal(9, 6)), 3)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (64, N'Surinam', CAST(4.000000 AS Decimal(9, 6)), CAST(-56.000000 AS Decimal(9, 6)), 3)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (65, N'Ecuador', CAST(-2.000000 AS Decimal(9, 6)), CAST(-77.500000 AS Decimal(9, 6)), 3)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (66, N'Venezuela', CAST(8.000000 AS Decimal(9, 6)), CAST(-66.000000 AS Decimal(9, 6)), 3)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (67, N'Islas Malvinas', CAST(-51.750000 AS Decimal(9, 6)), CAST(-59.000000 AS Decimal(9, 6)), 3)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (68, N'Bolivia', CAST(-17.000000 AS Decimal(9, 6)), CAST(-65.000000 AS Decimal(9, 6)), 3)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (69, N'Guayana Francesa', CAST(4.000000 AS Decimal(9, 6)), CAST(-53.000000 AS Decimal(9, 6)), 3)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (70, N'Paraguay', CAST(-23.000000 AS Decimal(9, 6)), CAST(-58.000000 AS Decimal(9, 6)), 3)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (71, N'Uruguay', CAST(-33.000000 AS Decimal(9, 6)), CAST(-56.000000 AS Decimal(9, 6)), 3)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (72, N'Guyana', CAST(5.000000 AS Decimal(9, 6)), CAST(-59.000000 AS Decimal(9, 6)), 3)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (73, N'Chile', CAST(-30.000000 AS Decimal(9, 6)), CAST(-71.000000 AS Decimal(9, 6)), 3)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (74, N'Argentina', CAST(-34.000000 AS Decimal(9, 6)), CAST(-64.000000 AS Decimal(9, 6)), 3)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (75, N'Eritrea', CAST(15.000000 AS Decimal(9, 6)), CAST(39.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (76, N'Liberia', CAST(6.500000 AS Decimal(9, 6)), CAST(-9.500000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (77, N'Uganda', CAST(1.000000 AS Decimal(9, 6)), CAST(32.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (78, N'Mayotte', CAST(-12.833333 AS Decimal(9, 6)), CAST(45.166667 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (79, N'Somalia', CAST(10.000000 AS Decimal(9, 6)), CAST(49.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (80, N'Zambia', CAST(-15.000000 AS Decimal(9, 6)), CAST(30.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (81, N'Argelia', CAST(28.000000 AS Decimal(9, 6)), CAST(3.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (82, N'Egipto', CAST(27.000000 AS Decimal(9, 6)), CAST(30.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (83, N'Madagascar', CAST(-20.000000 AS Decimal(9, 6)), CAST(47.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (84, N'Sudán', CAST(15.000000 AS Decimal(9, 6)), CAST(30.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (85, N'Sudáfrica', CAST(-29.000000 AS Decimal(9, 6)), CAST(24.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (86, N'Congo', CAST(-1.000000 AS Decimal(9, 6)), CAST(15.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (87, N'Kenia', CAST(1.000000 AS Decimal(9, 6)), CAST(38.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (88, N'Territorio Británico del Océano Índico', CAST(-6.000000 AS Decimal(9, 6)), CAST(71.500000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (89, N'Costa de Marfil', CAST(8.000000 AS Decimal(9, 6)), CAST(-5.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (90, N'Senegal', CAST(14.000000 AS Decimal(9, 6)), CAST(-14.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (91, N'Mauritania', CAST(20.000000 AS Decimal(9, 6)), CAST(-12.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (92, N'Gambia', CAST(13.466667 AS Decimal(9, 6)), CAST(-16.566667 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (93, N'Seychelles', CAST(-4.583333 AS Decimal(9, 6)), CAST(55.666667 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (94, N'Santa Elena, Ascensión y Tristán de Acuña', CAST(-15.950000 AS Decimal(9, 6)), CAST(-5.720000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (95, N'Santo Tomé y Príncipe', CAST(1.000000 AS Decimal(9, 6)), CAST(7.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (96, N'Ghana', CAST(8.000000 AS Decimal(9, 6)), CAST(-2.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (97, N'Tanzania', CAST(-6.000000 AS Decimal(9, 6)), CAST(35.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (98, N'Nigeria', CAST(10.000000 AS Decimal(9, 6)), CAST(8.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (99, N'Togo', CAST(8.000000 AS Decimal(9, 6)), CAST(1.166667 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (100, N'Djibouti', CAST(11.500000 AS Decimal(9, 6)), CAST(43.000000 AS Decimal(9, 6)), 4)
GO
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (101, N'Níger', CAST(16.000000 AS Decimal(9, 6)), CAST(8.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (102, N'Etiopía', CAST(8.000000 AS Decimal(9, 6)), CAST(38.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (103, N'Sahara Occidental', CAST(24.500000 AS Decimal(9, 6)), CAST(-13.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (104, N'Marruecos', CAST(32.000000 AS Decimal(9, 6)), CAST(-5.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (105, N'Guinea Ecuatorial', CAST(2.000000 AS Decimal(9, 6)), CAST(10.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (106, N'República Centroafricana', CAST(7.000000 AS Decimal(9, 6)), CAST(21.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (107, N'Guinea', CAST(11.000000 AS Decimal(9, 6)), CAST(-10.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (108, N'Botswana', CAST(-22.000000 AS Decimal(9, 6)), CAST(24.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (109, N'Camerún', CAST(6.000000 AS Decimal(9, 6)), CAST(12.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (110, N'Gabón', CAST(-1.000000 AS Decimal(9, 6)), CAST(11.750000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (111, N'Guinea-Bisáu', CAST(12.000000 AS Decimal(9, 6)), CAST(-15.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (112, N'Zimbabue', CAST(-20.000000 AS Decimal(9, 6)), CAST(30.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (113, N'Lesotho', CAST(-29.500000 AS Decimal(9, 6)), CAST(28.500000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (114, N'Namibia', CAST(-22.000000 AS Decimal(9, 6)), CAST(17.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (115, N'Burkina Faso', CAST(13.000000 AS Decimal(9, 6)), CAST(-2.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (116, N'Mali', CAST(17.000000 AS Decimal(9, 6)), CAST(-4.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (117, N'Benín', CAST(9.500000 AS Decimal(9, 6)), CAST(2.250000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (118, N'Mozambique', CAST(-18.250000 AS Decimal(9, 6)), CAST(35.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (119, N'Reunión', CAST(-21.150000 AS Decimal(9, 6)), CAST(55.500000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (120, N'Congo (Rep. Dem.)', CAST(0.000000 AS Decimal(9, 6)), CAST(25.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (121, N'Chad', CAST(15.000000 AS Decimal(9, 6)), CAST(19.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (122, N'Cabo Verde', CAST(16.538800 AS Decimal(9, 6)), CAST(23.041800 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (123, N'Burundi', CAST(-3.500000 AS Decimal(9, 6)), CAST(30.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (124, N'Ruanda', CAST(-2.000000 AS Decimal(9, 6)), CAST(30.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (125, N'Mauricio', CAST(-20.283333 AS Decimal(9, 6)), CAST(57.550000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (126, N'Libia', CAST(25.000000 AS Decimal(9, 6)), CAST(17.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (127, N'Malawi', CAST(-13.500000 AS Decimal(9, 6)), CAST(34.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (128, N'Túnez', CAST(34.000000 AS Decimal(9, 6)), CAST(9.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (129, N'Comoras', CAST(-12.166667 AS Decimal(9, 6)), CAST(44.250000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (130, N'Suazilandia', CAST(-26.500000 AS Decimal(9, 6)), CAST(31.500000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (131, N'Sudán del Sur', CAST(7.000000 AS Decimal(9, 6)), CAST(30.000000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (132, N'Angola', CAST(-12.500000 AS Decimal(9, 6)), CAST(18.500000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (133, N'Sierra Leone', CAST(8.500000 AS Decimal(9, 6)), CAST(-11.500000 AS Decimal(9, 6)), 4)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (134, N'Israel', CAST(31.470000 AS Decimal(9, 6)), CAST(35.130000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (135, N'Singapur', CAST(1.366667 AS Decimal(9, 6)), CAST(103.800000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (136, N'Emiratos Árabes Unidos', CAST(24.000000 AS Decimal(9, 6)), CAST(54.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (137, N'China', CAST(35.000000 AS Decimal(9, 6)), CAST(105.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (138, N'Uzbekistán', CAST(41.000000 AS Decimal(9, 6)), CAST(64.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (139, N'Turkmenistán', CAST(40.000000 AS Decimal(9, 6)), CAST(60.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (140, N'Maldivas', CAST(3.250000 AS Decimal(9, 6)), CAST(73.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (141, N'Palestina', CAST(31.900000 AS Decimal(9, 6)), CAST(35.200000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (142, N'Arabia Saudí', CAST(25.000000 AS Decimal(9, 6)), CAST(45.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (143, N'Turquía', CAST(39.000000 AS Decimal(9, 6)), CAST(35.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (144, N'Malasia', CAST(2.500000 AS Decimal(9, 6)), CAST(112.500000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (145, N'Timor Oriental', CAST(-8.833333 AS Decimal(9, 6)), CAST(125.916667 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (146, N'Kazajistán', CAST(48.019600 AS Decimal(9, 6)), CAST(66.923700 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (147, N'Azerbaiyán', CAST(40.500000 AS Decimal(9, 6)), CAST(47.500000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (148, N'Líbano', CAST(33.833333 AS Decimal(9, 6)), CAST(35.833333 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (149, N'Catar', CAST(25.500000 AS Decimal(9, 6)), CAST(51.250000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (150, N'Vietnam', CAST(16.166667 AS Decimal(9, 6)), CAST(107.833333 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (151, N'Afganistán', CAST(33.000000 AS Decimal(9, 6)), CAST(65.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (152, N'Japón', CAST(36.000000 AS Decimal(9, 6)), CAST(138.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (153, N'Siria', CAST(35.000000 AS Decimal(9, 6)), CAST(38.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (154, N'Jordania', CAST(31.000000 AS Decimal(9, 6)), CAST(36.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (155, N'Kuwait', CAST(29.500000 AS Decimal(9, 6)), CAST(45.750000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (156, N'Myanmar', CAST(22.000000 AS Decimal(9, 6)), CAST(98.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (157, N'Kirguizistán', CAST(41.000000 AS Decimal(9, 6)), CAST(75.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (158, N'Tailandia', CAST(15.000000 AS Decimal(9, 6)), CAST(100.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (159, N'Armenia', CAST(40.000000 AS Decimal(9, 6)), CAST(45.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (160, N'Iran', CAST(32.000000 AS Decimal(9, 6)), CAST(53.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (161, N'Bahrein', CAST(26.000000 AS Decimal(9, 6)), CAST(50.550000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (162, N'Laos', CAST(18.000000 AS Decimal(9, 6)), CAST(105.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (163, N'Corea del Sur', CAST(37.000000 AS Decimal(9, 6)), CAST(127.500000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (164, N'Mongolia', CAST(46.000000 AS Decimal(9, 6)), CAST(105.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (165, N'India', CAST(20.000000 AS Decimal(9, 6)), CAST(77.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (166, N'Tayikistán', CAST(39.000000 AS Decimal(9, 6)), CAST(71.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (167, N'Brunei', CAST(4.500000 AS Decimal(9, 6)), CAST(114.666667 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (168, N'Nepal', CAST(28.000000 AS Decimal(9, 6)), CAST(84.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (169, N'Filipinas', CAST(13.000000 AS Decimal(9, 6)), CAST(122.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (170, N'Taiwán', CAST(23.500000 AS Decimal(9, 6)), CAST(121.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (171, N'Macao', CAST(22.166667 AS Decimal(9, 6)), CAST(113.550000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (172, N'Yemen', CAST(15.000000 AS Decimal(9, 6)), CAST(48.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (173, N'Pakistán', CAST(30.000000 AS Decimal(9, 6)), CAST(70.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (174, N'Bután', CAST(27.500000 AS Decimal(9, 6)), CAST(90.500000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (175, N'Camboya', CAST(13.000000 AS Decimal(9, 6)), CAST(105.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (176, N'Omán', CAST(21.000000 AS Decimal(9, 6)), CAST(57.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (177, N'Georgia', CAST(42.000000 AS Decimal(9, 6)), CAST(43.500000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (178, N'Corea del Norte', CAST(40.000000 AS Decimal(9, 6)), CAST(127.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (179, N'Indonesia', CAST(-5.000000 AS Decimal(9, 6)), CAST(120.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (180, N'Bangladesh', CAST(24.000000 AS Decimal(9, 6)), CAST(90.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (181, N'Irak', CAST(33.000000 AS Decimal(9, 6)), CAST(44.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (182, N'Sri Lanka', CAST(7.000000 AS Decimal(9, 6)), CAST(81.000000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (183, N'Hong Kong', CAST(22.267000 AS Decimal(9, 6)), CAST(114.188000 AS Decimal(9, 6)), 5)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (184, N'Islas Tokelau', CAST(-9.000000 AS Decimal(9, 6)), CAST(-172.000000 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (185, N'Tonga', CAST(-20.000000 AS Decimal(9, 6)), CAST(-175.000000 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (186, N'Fiyi', CAST(17.713400 AS Decimal(9, 6)), CAST(178.065000 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (187, N'Isla de Navidad', CAST(-10.500000 AS Decimal(9, 6)), CAST(105.666667 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (188, N'Nueva Zelanda', CAST(-41.000000 AS Decimal(9, 6)), CAST(174.000000 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (189, N'Islas Cook', CAST(-21.233333 AS Decimal(9, 6)), CAST(-159.766667 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (190, N'Nueva Caledonia', CAST(-21.500000 AS Decimal(9, 6)), CAST(165.500000 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (191, N'Niue', CAST(-19.033333 AS Decimal(9, 6)), CAST(-169.866667 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (192, N'Kiribati', CAST(1.416667 AS Decimal(9, 6)), CAST(173.000000 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (193, N'Vanuatu', CAST(-16.000000 AS Decimal(9, 6)), CAST(167.000000 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (194, N'Islas Marshall', CAST(9.000000 AS Decimal(9, 6)), CAST(168.000000 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (195, N'Samoa Americana', CAST(-14.333333 AS Decimal(9, 6)), CAST(-170.000000 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (196, N'Palau', CAST(7.500000 AS Decimal(9, 6)), CAST(134.500000 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (197, N'Wallis y Futuna', CAST(-13.300000 AS Decimal(9, 6)), CAST(-176.200000 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (198, N'Isla de Norfolk', CAST(-29.033333 AS Decimal(9, 6)), CAST(167.950000 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (199, N'Polinesia Francesa', CAST(17.679700 AS Decimal(9, 6)), CAST(149.406800 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (200, N'Islas Pitcairn', CAST(-25.066667 AS Decimal(9, 6)), CAST(-130.100000 AS Decimal(9, 6)), 6)
GO
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (201, N'Australia', CAST(-27.000000 AS Decimal(9, 6)), CAST(133.000000 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (202, N'Guam', CAST(13.466667 AS Decimal(9, 6)), CAST(144.783333 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (203, N'Nauru', CAST(-0.533333 AS Decimal(9, 6)), CAST(166.916667 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (204, N'Islas Cocos o Islas Keeling', CAST(12.164200 AS Decimal(9, 6)), CAST(96.871000 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (205, N'Islas Salomón', CAST(-8.000000 AS Decimal(9, 6)), CAST(159.000000 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (206, N'Islas Marianas del Norte', CAST(15.200000 AS Decimal(9, 6)), CAST(145.750000 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (207, N'Samoa', CAST(-13.583333 AS Decimal(9, 6)), CAST(-172.333333 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (208, N'Tuvalu', CAST(-8.000000 AS Decimal(9, 6)), CAST(178.000000 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (209, N'Papúa Nueva Guinea', CAST(-6.000000 AS Decimal(9, 6)), CAST(147.000000 AS Decimal(9, 6)), 6)
INSERT [dbo].[Paises] ([ID_PAIS], [Nombre], [Latitud], [Longitud], [ID_CONTINENTE]) VALUES (210, N'Micronesia', CAST(6.916667 AS Decimal(9, 6)), CAST(158.250000 AS Decimal(9, 6)), 6)
GO
INSERT [dbo].[TIPOS_CLASES] ([ID_TIPO_CLASE], [Nombre], [EquipajeMano], [EquipajeCabina]) VALUES (1, N'Turista', 1, 1)
INSERT [dbo].[TIPOS_CLASES] ([ID_TIPO_CLASE], [Nombre], [EquipajeMano], [EquipajeCabina]) VALUES (2, N'Bussiness', 2, 2)
GO
INSERT [dbo].[Usuarios] ([ID_USUARIO], [Nombre], [Apellido], [Email], [Password], [FechaRegistro]) VALUES (1, N'Cristopher', N'Jiménez', N'cj@gmail.com', N'123', CAST(N'2002-03-18T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Vuelos] ([ID_VUELO], [ID_AVION], [ID_ORIGEN], [ID_DESTINO], [FechaSalida], [FechaLlegada], [CupoTotal], [CupoDisponible], [PrecioEstandar], [ID_ESTADO]) VALUES (1, 1, 1, 2, CAST(N'2024-03-18T12:26:00.000' AS DateTime), CAST(N'2024-03-18T14:30:00.000' AS DateTime), 70, 56, CAST(70.20 AS Decimal(10, 2)), 3)
INSERT [dbo].[Vuelos] ([ID_VUELO], [ID_AVION], [ID_ORIGEN], [ID_DESTINO], [FechaSalida], [FechaLlegada], [CupoTotal], [CupoDisponible], [PrecioEstandar], [ID_ESTADO]) VALUES (2, 1, 1, 2, CAST(N'2024-03-18T10:00:00.000' AS DateTime), CAST(N'2024-03-18T12:56:00.000' AS DateTime), 70, 50, CAST(68.75 AS Decimal(10, 2)), 1)
INSERT [dbo].[Vuelos] ([ID_VUELO], [ID_AVION], [ID_ORIGEN], [ID_DESTINO], [FechaSalida], [FechaLlegada], [CupoTotal], [CupoDisponible], [PrecioEstandar], [ID_ESTADO]) VALUES (3, 1, 5, 7, CAST(N'2024-03-22T00:00:00.000' AS DateTime), CAST(N'2024-03-22T02:00:00.000' AS DateTime), 60, 34, CAST(56.00 AS Decimal(10, 2)), 1)
INSERT [dbo].[Vuelos] ([ID_VUELO], [ID_AVION], [ID_ORIGEN], [ID_DESTINO], [FechaSalida], [FechaLlegada], [CupoTotal], [CupoDisponible], [PrecioEstandar], [ID_ESTADO]) VALUES (4, 1, 13, 56, CAST(N'2024-03-22T00:00:00.000' AS DateTime), CAST(N'2024-03-22T00:00:00.000' AS DateTime), 98, 23, CAST(90.00 AS Decimal(10, 2)), 3)
INSERT [dbo].[Vuelos] ([ID_VUELO], [ID_AVION], [ID_ORIGEN], [ID_DESTINO], [FechaSalida], [FechaLlegada], [CupoTotal], [CupoDisponible], [PrecioEstandar], [ID_ESTADO]) VALUES (5, 1, 76, 34, CAST(N'2024-03-22T00:00:00.000' AS DateTime), CAST(N'2024-03-22T00:00:00.000' AS DateTime), 123, 56, CAST(120.00 AS Decimal(10, 2)), 1)
INSERT [dbo].[Vuelos] ([ID_VUELO], [ID_AVION], [ID_ORIGEN], [ID_DESTINO], [FechaSalida], [FechaLlegada], [CupoTotal], [CupoDisponible], [PrecioEstandar], [ID_ESTADO]) VALUES (6, 1, 1, 2, CAST(N'2024-03-18T12:26:00.000' AS DateTime), CAST(N'1900-01-01T15:26:00.000' AS DateTime), 300, 300, CAST(600.00 AS Decimal(10, 2)), 1)
INSERT [dbo].[Vuelos] ([ID_VUELO], [ID_AVION], [ID_ORIGEN], [ID_DESTINO], [FechaSalida], [FechaLlegada], [CupoTotal], [CupoDisponible], [PrecioEstandar], [ID_ESTADO]) VALUES (7, 1, 1, 2, CAST(N'2024-03-18T12:26:00.000' AS DateTime), CAST(N'2024-03-18T15:26:00.000' AS DateTime), 300, 300, CAST(600.00 AS Decimal(10, 2)), 1)
INSERT [dbo].[Vuelos] ([ID_VUELO], [ID_AVION], [ID_ORIGEN], [ID_DESTINO], [FechaSalida], [FechaLlegada], [CupoTotal], [CupoDisponible], [PrecioEstandar], [ID_ESTADO]) VALUES (8, 2, 13, 15, CAST(N'2024-03-22T04:57:00.000' AS DateTime), CAST(N'2024-03-22T08:57:00.000' AS DateTime), 550, 550, CAST(23.00 AS Decimal(10, 2)), 1)
GO
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (1, N'UTC-12:00', -12)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (2, N'UTC-11:00', -11)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (3, N'UTC-10:00', -10)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (4, N'UTC-09:00', -9)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (5, N'UTC-08:00', -8)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (6, N'UTC-07:00', -7)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (7, N'UTC-06:00', -6)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (8, N'UTC-05:00', -5)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (9, N'UTC-04:00', -4)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (10, N'UTC-03:00', -3)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (11, N'UTC-02:00', -2)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (12, N'UTC-01:00', -1)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (13, N'UTC+00:00', 0)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (14, N'UTC+01:00', 1)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (15, N'UTC+02:00', 2)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (16, N'UTC+03:00', 3)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (17, N'UTC+04:00', 4)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (18, N'UTC+05:00', 5)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (19, N'UTC+06:00', 6)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (20, N'UTC+07:00', 7)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (21, N'UTC+08:00', 8)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (22, N'UTC+09:00', 9)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (23, N'UTC+10:00', 10)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (24, N'UTC+11:00', 11)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (25, N'UTC+12:00', 12)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (26, N'UTC+13:00', 13)
INSERT [dbo].[ZonasHorarias] ([ID_ZonaHoraria], [Nombre], [Desplazamiento]) VALUES (27, N'UTC+14:00', 14)
GO
ALTER TABLE [dbo].[Aeropuertos]  WITH CHECK ADD FOREIGN KEY([ID_CIUDAD])
REFERENCES [dbo].[Ciudades] ([ID_CIUDAD])
GO
ALTER TABLE [dbo].[Billetes]  WITH CHECK ADD  CONSTRAINT [FK__Billetes__ID_TIP__4F7CD00D] FOREIGN KEY([ID_TIPO_CLASE])
REFERENCES [dbo].[TIPOS_CLASES] ([ID_TIPO_CLASE])
GO
ALTER TABLE [dbo].[Billetes] CHECK CONSTRAINT [FK__Billetes__ID_TIP__4F7CD00D]
GO
ALTER TABLE [dbo].[Billetes]  WITH CHECK ADD  CONSTRAINT [FK__Billetes__ID_VUE__4E88ABD4] FOREIGN KEY([ID_VUELO])
REFERENCES [dbo].[Vuelos] ([ID_VUELO])
GO
ALTER TABLE [dbo].[Billetes] CHECK CONSTRAINT [FK__Billetes__ID_VUE__4E88ABD4]
GO
ALTER TABLE [dbo].[Ciudades]  WITH CHECK ADD FOREIGN KEY([ID_PAIS])
REFERENCES [dbo].[Paises] ([ID_PAIS])
GO
ALTER TABLE [dbo].[Ciudades]  WITH CHECK ADD FOREIGN KEY([ID_ZonaHoraria])
REFERENCES [dbo].[ZonasHorarias] ([ID_ZonaHoraria])
GO
ALTER TABLE [dbo].[Paises]  WITH CHECK ADD FOREIGN KEY([ID_CONTINENTE])
REFERENCES [dbo].[Continentes] ([ID_CONTINENTE])
GO
ALTER TABLE [dbo].[Vuelos]  WITH CHECK ADD  CONSTRAINT [FK__Vuelos__ID_AVION__47DBAE45] FOREIGN KEY([ID_AVION])
REFERENCES [dbo].[Aviones] ([ID_AVION])
GO
ALTER TABLE [dbo].[Vuelos] CHECK CONSTRAINT [FK__Vuelos__ID_AVION__47DBAE45]
GO
ALTER TABLE [dbo].[Vuelos]  WITH CHECK ADD  CONSTRAINT [FK__Vuelos__ID_DESTI__49C3F6B7] FOREIGN KEY([ID_DESTINO])
REFERENCES [dbo].[Ciudades] ([ID_CIUDAD])
GO
ALTER TABLE [dbo].[Vuelos] CHECK CONSTRAINT [FK__Vuelos__ID_DESTI__49C3F6B7]
GO
ALTER TABLE [dbo].[Vuelos]  WITH CHECK ADD  CONSTRAINT [FK__Vuelos__ID_ORIGE__48CFD27E] FOREIGN KEY([ID_ORIGEN])
REFERENCES [dbo].[Ciudades] ([ID_CIUDAD])
GO
ALTER TABLE [dbo].[Vuelos] CHECK CONSTRAINT [FK__Vuelos__ID_ORIGE__48CFD27E]
GO
ALTER TABLE [dbo].[Vuelos]  WITH CHECK ADD  CONSTRAINT [FK_Vuelos_Estados] FOREIGN KEY([ID_ESTADO])
REFERENCES [dbo].[Estados] ([ID_ESTADO])
GO
ALTER TABLE [dbo].[Vuelos] CHECK CONSTRAINT [FK_Vuelos_Estados]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_VUELO]    Script Date: 19/03/2024 5:58:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INSERT_VUELO]
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
GO
/****** Object:  StoredProcedure [dbo].[SP_PAGINAR_VUELOS]    Script Date: 19/03/2024 5:58:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_PAGINAR_VUELOS]
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
