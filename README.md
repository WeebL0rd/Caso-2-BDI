# Documentación del Caso #2
Profesor Rodrigo Núñez Núñez

Curso: Bases de Datos I

## Integrantes
Efraim Cuevas Aguilar
Carné: 2024109746
Github user: weebL0rd

Carlos Andrés García Molina
Carné: 2024181023
Github user: CGarcia1411

Beatriz Rebeca Díaz Gómez
Carné: 2024090972
Github user: pinkcrate

Rachel Leiva Abarca
Carné: 2024220640
Github user:RachellLeiva

---
# Diseño de la base de datos
## Script de Creación

## Mongo
```python
# ─── IMPORTS ───────────────────────────────────────────────────────────────
from pymongo import MongoClient
from datetime import datetime
from bson import ObjectId

# ─── CONEXIÓN A MONGO ──────────────────────────────────────────────────────
client = MongoClient("mongodb://localhost:27017/")
db = client["soltura"]

# ─── FUNCIÓN: Insertar usuarios ─────────────────────────────────────────────
def insertarUsuarios():
    usuarios = [
        {
            "nombreCompleto": "Juan Pérez",
            "nombreUsuario": "juanp",
            "email": "juan@example.com",
            "telefono": "+50688888888",
            "lenguaje": "es-CR",
            "fechaRegistro": datetime.now(),
            "activo": True,
            "metodoRegistro": "Email",
            "foto": "https://ejemplo.com/fotos/juan.jpg",
            "direccion": {
                "provincia": "San José",
                "canton": "Central",
                "distrito": "Carmen",
                "direccionExacta": "Av. 10, Calle 3",
                "coordenadas": {
                    "lat": 9.933,
                    "lng": -84.08
                }
            }
        },
        {
            "nombreCompleto": "Ana Rodríguez",
            "nombreUsuario": "anar",
            "email": "ana@example.com",
            "telefono": "+50687777777",
            "lenguaje": "es-CR",
            "fechaRegistro": datetime.now(),
            "activo": False,
            "metodoRegistro": "Google",
            "foto": "https://ejemplo.com/fotos/ana.jpg",
            "direccion": {
                "provincia": "Alajuela",
                "canton": "Alajuela",
                "distrito": "San José",
                "direccionExacta": "Calle 5",
                "coordenadas": {
                    "lat": 10.02,
                    "lng": -84.21
                }
            }
        }
    ]
    db.usuarios.insert_many(usuarios)
    return [usuario["nombreUsuario"] for usuario in usuarios]

# ─── FUNCIÓN: Insertar departamentos ────────────────────────────────────────
def insertarDepartamentos():
    departamentos = [
        {
            "nombreDepartamento": "Atención al Cliente",
            "mediosContacto": ["telefono", "email", "whatsapp"],
            "horario": {
                "lunesAViernes": "08:00-17:00",
                "sabados": "09:00-13:00",
                "domingos": "cerrado"
            }
        },
        {
            "nombreDepartamento": "Soporte Técnico",
            "mediosContacto": ["email"],
            "horario": {
                "lunesAViernes": "08:00-18:00",
                "sabados": "cerrado",
                "domingos": "cerrado"
            }
        }
    ]
    db.departamentos.insert_many(departamentos)
    return departamentos

# ─── FUNCIÓN: Insertar agentes ──────────────────────────────────────────────
def insertarAgentes(departamentos):
    agentes = [
        {
            "IDAgente": "AGT001",
            "nombre": "Carlos Ramírez",
            "email": "carlos@soltura.com",
            "lenguajes": ["es-CR", "en-US"],
            "horario": {
                "lunesAViernes": "08:00-17:00",
                "sabados": "09:00-12:00",
                "domingos": "cerrado"
            },
            "departamento": "Atención al Cliente",
            "nivelAutoridad": "senior",
            "maxCasosSimultaneos": 5
        },
        {
            "IDAgente": "AGT002",
            "nombre": "Lucía Vega",
            "email": "lucia@soltura.com",
            "lenguajes": ["es-CR"],
            "horario": {
                "lunesAViernes": "10:00-18:00",
                "sabados": "cerrado",
                "domingos": "cerrado"
            },
            "departamento": "Soporte Técnico",
            "nivelAutoridad": "junior",
            "maxCasosSimultaneos": 3
        }
    ]
    db.agentes.insert_many(agentes)
    return agentes

def insertarCasos(usuarios, agentes):
    casos = [
        {
            "CasoID": "C-1001",
            "categoria": "consulta",
            "estado": "en espera",
            "ClienteUsername": "juanp",
            "agentesAsignados": ["AGT001"],
            "asunto": "¿Cómo cambio mi contraseña?",
            "descripcion": "Necesito ayuda para restablecer mi clave.",
            "fechaCreacion": datetime.now(),
            "lastUpdated": datetime.now(),
            "prioridad": "media",
            "satisfaccionCliente": None,
            "historial": [
                {
                    "autor": "juanp",
                    "fecha": datetime.now(),
                    "mensaje": "Hola, necesito cambiar mi contraseña",
                    "lenguaje": "es-CR"
                },
                {
                    "autor": "AGT001",
                    "fecha": datetime.now(),
                    "mensaje": "Claro, puede hacerlo desde el menú de configuración.",
                    "lenguaje": "es-CR"
                }
            ]
        },
        {
            "CasoID": "C-1002",
            "categoria": "queja",
            "estado": "en proceso",
            "ClienteUsername": "anar",
            "agentesAsignados": ["AGT002"],
            "asunto": "Problemas con la facturación",
            "descripcion": "Me cobraron un monto incorrecto en mi factura.",
            "fechaCreacion": datetime.now(),
            "lastUpdated": datetime.now(),
            "prioridad": "alta",
            "satisfaccionCliente": None,
            "historial": [
                {
                    "autor": "anar",
                    "fecha": datetime.now(),
                    "mensaje": "Mi factura tiene un cobro que no reconozco.",
                    "lenguaje": "es-CR"
                },
                {
                    "autor": "AGT002",
                    "fecha": datetime.now(),
                    "mensaje": "Vamos a revisar los detalles de su cuenta.",
                    "lenguaje": "es-CR"
                }
            ]
        }
    ]
    db.casos.insert_many(casos)


# ─── FUNCIÓN: Insertar beneficios ──────────────────────────────────────────
def insertarBeneficios():
    beneficios = [
        {
            "beneficioID": "BEN01",
            "nombre": "Gimnasio SmartFit",
            "tipo": "salud",
            "descripcion": "Acceso a SmartFit en horarios regulares",
            "unidad": "horas",
            "cantidad": 6,
            "frecuencia": "semanal",
            "activo": True
        },
        {
            "beneficioID": "BEN02",
            "nombre": "Lavandería y aplanchado",
            "tipo": "hogar",
            "descripcion": "Servicio completo de lavandería y planchado",
            "unidad": "servicios",
            "cantidad": 1,
            "frecuencia": "mensual",
            "activo": True
        },
        {
            "beneficioID": "BEN03",
            "nombre": "Limpieza básica de hogar",
            "tipo": "hogar",
            "descripcion": "Limpieza básica con personal capacitado",
            "unidad": "días",
            "cantidad": 2,
            "frecuencia": "mensual",
            "activo": True
        },
        {
            "beneficioID": "BEN04",
            "nombre": "Combustible",
            "tipo": "movilidad",
            "descripcion": "Monto mensual para combustible gas o diésel",
            "unidad": "CRC",
            "cantidad": 50000,
            "frecuencia": "mensual",
            "activo": True
        },
        {
            "beneficioID": "BEN05",
            "nombre": "Corte de pelo (Tito Barbers)",
            "tipo": "estética",
            "descripcion": "Corte profesional en Tito Barbers",
            "unidad": "cortes",
            "cantidad": 1,
            "frecuencia": "mensual",
            "activo": True
        },
        {
            "beneficioID": "BEN06",
            "nombre": "Cenas seleccionadas",
            "tipo": "alimentación",
            "descripcion": "Cenas de restaurantes aliados",
            "unidad": "cenas",
            "cantidad": 2,
            "frecuencia": "mensual",
            "activo": True
        },
        {
            "beneficioID": "BEN07",
            "nombre": "Almuerzos seleccionados",
            "tipo": "alimentación",
            "descripcion": "Almuerzos de restaurantes aliados",
            "unidad": "almuerzos",
            "cantidad": 4,
            "frecuencia": "mensual",
            "activo": True
        },
        {
            "beneficioID": "BEN08",
            "nombre": "Plan móvil (Kolbi)",
            "tipo": "tecnología",
            "descripcion": "Plan de datos y llamadas ilimitadas",
            "unidad": "servicio",
            "cantidad": 1,
            "frecuencia": "mensual",
            "activo": True
        },
        {
            "beneficioID": "BEN09",
            "nombre": "Parqueo",
            "tipo": "movilidad",
            "descripcion": "Horas de parqueo en puntos seleccionados",
            "unidad": "horas",
            "cantidad": 10,
            "frecuencia": "mensual",
            "activo": True
        },
        {
            "beneficioID": "BEN10",
            "nombre": "Grooming para mascota",
            "tipo": "mascotas",
            "descripcion": "Servicio de grooming para una mascota",
            "unidad": "servicio",
            "cantidad": 1,
            "frecuencia": "mensual",
            "activo": True
        },
        {
            "beneficioID": "BEN11",
            "nombre": "Revisión veterinaria",
            "tipo": "mascotas",
            "descripcion": "Consulta veterinaria básica",
            "unidad": "consulta",
            "cantidad": 1,
            "frecuencia": "mensual",
            "activo": True
        },
        {
            "beneficioID": "BEN12",
            "nombre": "Clases de natación o fútbol (niños)",
            "tipo": "educación",
            "descripcion": "Clases recreativas para niños",
            "unidad": "clases",
            "cantidad": 3,
            "frecuencia": "mensual",
            "activo": True
        },
        {
            "beneficioID": "BEN13",
            "nombre": "Uber Eats",
            "tipo": "alimentación",
            "descripcion": "Pedidos con envío gratis y 20% descuento",
            "unidad": "pedidos",
            "cantidad": 10,
            "frecuencia": "mensual",
            "activo": True
        },
        {
            "beneficioID": "BEN14",
            "nombre": "Uber Rides",
            "tipo": "movilidad",
            "descripcion": "Saldo para viajes en Uber",
            "unidad": "CRC",
            "cantidad": 7000,
            "frecuencia": "mensual",
            "activo": True
        }
    ]
    db.beneficios.insert_many(beneficios)
    return [b["beneficioID"] for b in beneficios]


# ─── FUNCIÓN: Insertar paquetes ────────────────────────────────────────────
def insertarPaquetes(beneficioIDs):
    paquetes = [
        {
            "paqueteID": "PAX1",
            "titulo": "Paquete Profesional Joven",
            "descripcion": "Ideal para profesionales activos que buscan conveniencia",
            "beneficios": beneficioIDs[0:9],
            "precioMensual": 25000,
            "moneda": "CRC",
            "maxPersonas": 1,
            "disponible": True,
            "fechaCreacion": datetime.utcnow(),
            "fechaUltimaActualizacion": datetime.utcnow()
        },
        {
            "paqueteID": "PAX2",
            "titulo": "Paquete Full Modern Family",
            "descripcion": "Pensado para familias modernas que buscan bienestar integral",
            "beneficios": beneficioIDs[8:] + beneficioIDs[9:],
            "precioMensual": 45000,
            "moneda": "CRC",
            "maxPersonas": 4,
            "disponible": True,
            "fechaCreacion": datetime.utcnow(),
            "fechaUltimaActualizacion": datetime.utcnow()
        }
    ]
    db.paquetesInformativos.insert_many(paquetes)
    return [paquete["paqueteID"] for paquete in paquetes]


# ─── FUNCIÓN: Insertar Reviews con Respuestas ────────────────────────────────
def insertarReviews(usuarios, paquetes):
    reviews = [
        {
            "ClienteUsername": usuarios[0],
            "paqueteID": paquetes[0],
            "calificacion": 4,
            "comentario": "Buen paquete, pero me gustaría más soporte técnico.",
            "fecha": datetime.now(),
            "respuestas": [
                {
                    "ClienteUsername": usuarios[1],
                    "comentario": "Entiendo lo que dices, el soporte técnico podría mejorar.",
                    "fecha": datetime.now()
                },
                {
                    "ClienteUsername": usuarios[0],
                    "comentario": "¿Qué tipo de soporte crees que falta? Podría ayudar.",
                    "fecha": datetime.now()
                }
            ]
        },
        {
            "ClienteUsername": usuarios[1],
            "paqueteID": paquetes[1],
            "calificacion": 5,
            "comentario": "Excelente servicio, totalmente recomendado.",
            "fecha": datetime.now(),
            "respuestas": []
        }
    ]
    db.reviews.insert_many(reviews)
    return reviews


# ─── FUNCIÓN: Insertar anuncios web ──────────────────────────────────────────
def insertarAnuncios():
    anuncios = [
        {
            "nombreAnuncio": "BannerPrincipalMigracion",
            "activo": True,
            "fechaInicioPublicacion": datetime(2025, 5, 15, 0, 0, 0),
            "fechaFinPublicacion": datetime(2025, 6, 30, 23, 59, 59),
            "banners": [
                {
                    "imagenUrl": "url_del_banner_migracion.png",
                    "texto": "¡Payment Assistant ahora es Soltura! Sigue los pasos en la guía para la fecha en que ocurrirá la migración.",
                    "fecha": datetime(2025, 5, 15, 0, 0, 0),
                    "link": "/guia-migracion"
                }
            ],
            "fechaCreacion": datetime.now()
        },
        {
            "nombreAnuncio": "PromocionVeranoHome",
            "activo": True,
            "fechaInicioPublicacion": datetime(2025, 6, 1, 0, 0, 0),
            "fechaFinPublicacion": datetime(2025, 7, 31, 23, 59, 59),
            "banners": [
                {
                    "imagenUrl": "url_promocion_verano_home.jpg",
                    "texto": "¡Disfruta el verano con Soltura! Descubre nuestras ofertas.",
                    "link": "/promociones/verano"
                }
            ],
            "fechaCreacion": datetime.now()
        },
        {
            "nombreAnuncio": "NuevoPaqueteFamiliar",
            "activo": True,
            "fechaInicioPublicacion": datetime(2025, 5, 20, 0, 0, 0),
            "banners": [
                {
                    "imagenUrl": "url_tarjeta_familiar.png",
                    "texto": "Conoce el nuevo Paquete Familiar Plus. ¡Más beneficios para toda la familia!",
                    "link": "/paquetes/familiar-plus"
                }
            ],
            "fechaCreacion": datetime.now()
        },
        {
            "nombreAnuncio": "AnuncioAppMobile",
            "activo": True,
            "fechaInicioPublicacion": datetime(2025, 5, 10, 0, 0, 0),
            "fechaFinPublicacion": datetime(2025, 5, 25, 23, 59, 59),
            "banners": [
                {
                    "imagenUrl": "url_modal_app.png",
                    "texto": "Descarga nuestra nueva app y gestiona todo más fácil.",
                    "link": "/descarga-app"
                }
            ],
            "fechaCreacion": datetime.now()
        },
        {
            "nombreAnuncio": "BannerDescuentoJoven",
            "activo": True,
            "fechaInicioPublicacion": datetime(2025, 6, 15, 0, 0, 0),
            "fechaFinPublicacion": datetime(2025, 7, 15, 23, 59, 59),
            "banners": [
                {
                    "imagenUrl": "url_banner_joven.jpg",
                    "texto": "¡Paquete Joven, listo para cumplir todas sus necesidades básicas!",
                    "link": "/paquetes/joven"
                }
            ],
            "fechaCreacion": datetime.now()
        }
    ]
    db.anunciosWeb.insert_many(anuncios)
    return anuncios


# ─── EJECUCIÓN DEL SCRIPT COMPLETO ─────────────────────────────────────────
if __name__ == "__main__":
    usuarios = insertarUsuarios()
    departamentos = insertarDepartamentos()
    agentes = insertarAgentes(departamentos)
    insertarCasos(usuarios, agentes)
    beneficio_ids = insertarBeneficios()
    paquetes = insertarPaquetes(beneficio_ids)
    insertarReviews(usuarios, paquetes)
    anuncios = insertarAnuncios() 
    print("Datos insertados correctamente.")

```

## SQL Server
```sql
USE [solturaDB]
GO
/****** Object:  Schema [solturaDB]    Script Date: 5/6/2025 5:15:49 PM ******/
CREATE SCHEMA [solturaDB]
GO
/****** Object:  Table [dbo].[sol_migratedUsers]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sol_migratedUsers](
	[migratedUserID] [int] IDENTITY(1,1) NOT NULL,
	[userID] [int] NOT NULL,
	[changedPassword] [binary](1) NULL,
	[platform] [varchar](60) NULL,
 CONSTRAINT [PK_sol_migratedUsers] PRIMARY KEY CLUSTERED 
(
	[migratedUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_addresses]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_addresses](
	[addressid] [int] IDENTITY(1,1) NOT NULL,
	[line1] [nvarchar](200) NOT NULL,
	[line2] [nvarchar](200) NULL,
	[zipcode] [nvarchar](9) NOT NULL,
	[geoposition] [geometry] NOT NULL,
	[cityID] [int] NOT NULL,
 CONSTRAINT [PK_sol_addresses_addressid] PRIMARY KEY CLUSTERED 
(
	[addressid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_associateIdentificationTypes]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_associateIdentificationTypes](
	[identificationTypeID] [int] IDENTITY(1,1) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
	[datatype] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_sol_associateIdentificationTypes_identificationTypeID] PRIMARY KEY CLUSTERED 
(
	[identificationTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_associatePlans]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_associatePlans](
	[associatePlanID] [int] IDENTITY(1,1) NOT NULL,
	[associateID] [int] NOT NULL,
	[userPlanID] [int] NOT NULL,
 CONSTRAINT [PK_sol_associatePlans_associatePlanID] PRIMARY KEY CLUSTERED 
(
	[associatePlanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_availablePayMethods]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_availablePayMethods](
	[available_method_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[userID] [int] NOT NULL,
	[token] [nvarchar](255) NOT NULL,
	[expToken] [date] NOT NULL,
	[maskAccount] [nvarchar](50) NOT NULL,
	[methodID] [int] NOT NULL,
 CONSTRAINT [PK_sol_availablePayMethods_available_method_id] PRIMARY KEY CLUSTERED 
(
	[available_method_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_balances]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_balances](
	[balanceID] [int] IDENTITY(1,1) NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[expirationDate] [datetime2](0) NOT NULL,
	[lastUpdate] [datetime2](0) NOT NULL,
	[balanceTypeID] [int] NOT NULL,
	[planFeatureID] [int] NOT NULL,
	[userID] [int] NOT NULL,
 CONSTRAINT [PK_sol_balances_balanceID] PRIMARY KEY CLUSTERED 
(
	[balanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_city]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_city](
	[cityID] [int] IDENTITY(1,1) NOT NULL,
	[stateID] [int] NOT NULL,
	[name] [nvarchar](60) NOT NULL,
 CONSTRAINT [PK_sol_city_cityID] PRIMARY KEY CLUSTERED 
(
	[cityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_communicationChannels]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_communicationChannels](
	[communicationChannelID] [int] NOT NULL,
	[channel] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_sol_communicationChannels_communicationChannelID] PRIMARY KEY CLUSTERED 
(
	[communicationChannelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_contact_departments]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_contact_departments](
	[contactDepartmentId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_sol_contact_departments_contactDepartmentId] PRIMARY KEY CLUSTERED 
(
	[contactDepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_contact_info]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_contact_info](
	[contactInfoID] [int] IDENTITY(1,1) NOT NULL,
	[value] [nvarchar](100) NOT NULL,
	[enable] [binary](1) NOT NULL,
	[lastUpdate] [datetime2](0) NOT NULL,
	[contactTypeID] [int] NOT NULL,
	[contactDepartmentId] [int] NOT NULL,
	[partnerId] [int] NOT NULL,
 CONSTRAINT [PK_sol_contact_info_contactInfoID] PRIMARY KEY CLUSTERED 
(
	[contactInfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_contactType]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_contactType](
	[contactTypeID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_sol_contactType_contactTypeID] PRIMARY KEY CLUSTERED 
(
	[contactTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_countries]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_countries](
	[countryID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](60) NOT NULL,
 CONSTRAINT [PK_sol_countries_countryID] PRIMARY KEY CLUSTERED 
(
	[countryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_currencies]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_currencies](
	[currency_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[acronym] [nvarchar](5) NOT NULL,
	[symbol] [nvarchar](5) NOT NULL,
	[countryID] [int] NOT NULL,
 CONSTRAINT [PK_sol_currencies_currency_id] PRIMARY KEY CLUSTERED 
(
	[currency_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_deals]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_deals](
	[dealId] [int] IDENTITY(1,1) NOT NULL,
	[partnerId] [int] NOT NULL,
	[dealDescription] [nvarchar](250) NOT NULL,
	[sealDate] [datetime2](0) NOT NULL,
	[endDate] [datetime2](0) NOT NULL,
	[solturaComission] [decimal](5, 2) NOT NULL,
	[discount] [decimal](5, 2) NOT NULL,
	[isActive] [binary](1) NOT NULL,
 CONSTRAINT [PK_sol_deals_dealId] PRIMARY KEY CLUSTERED 
(
	[dealId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_enterprise_size]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_enterprise_size](
	[enterpriseSizeId] [int] IDENTITY(1,1) NOT NULL,
	[size] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_sol_enterprise_size_enterpriseSizeId] PRIMARY KEY CLUSTERED 
(
	[enterpriseSizeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_exchangeCurrencies]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_exchangeCurrencies](
	[exchangeCurrencyID] [int] IDENTITY(1,1) NOT NULL,
	[sourceID] [int] NOT NULL,
	[destinyID] [int] NOT NULL,
	[startDate] [date] NOT NULL,
	[endDate] [date] NULL,
	[exchange_rate] [decimal](12, 3) NOT NULL,
	[enabled] [binary](1) NOT NULL,
	[currentExchange] [binary](1) NOT NULL,
 CONSTRAINT [PK_sol_exchangeCurrencies_exchangeCurrencyID] PRIMARY KEY CLUSTERED 
(
	[exchangeCurrencyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_featureAvailableLocations]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_featureAvailableLocations](
	[locationID] [int] IDENTITY(1,1) NOT NULL,
	[featurePerPlanID] [int] NOT NULL,
	[partnerAddressId] [int] NOT NULL,
	[available] [binary](1) NOT NULL,
 CONSTRAINT [PK_sol_featureAvailableLocations_locationID] PRIMARY KEY CLUSTERED 
(
	[locationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_featurePrices]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_featurePrices](
	[featurePriceID] [int] IDENTITY(1,1) NOT NULL,
	[originalPrice] [decimal](10, 2) NULL,
	[discountedPrice] [decimal](10, 2) NULL,
	[finalPrice] [decimal](10, 2) NULL,
	[currency_id] [int] NOT NULL,
	[current] [binary](1) NOT NULL,
	[variable] [binary](1) NOT NULL,
	[planFeatureID] [int] NOT NULL,
 CONSTRAINT [PK_sol_featurePrices_featurePriceID] PRIMARY KEY CLUSTERED 
(
	[featurePriceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_featuresPerPlans]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_featuresPerPlans](
	[featurePerPlansID] [int] IDENTITY(1,1) NOT NULL,
	[planFeatureID] [int] NOT NULL,
	[planID] [int] NOT NULL,
	[enabled] [binary](1) NOT NULL,
 CONSTRAINT [PK_sol_featuresPerPlans_featurePerPlansID] PRIMARY KEY CLUSTERED 
(
	[featurePerPlansID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_featureTypes]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_featureTypes](
	[featureTypeID] [int] IDENTITY(1,1) NOT NULL,
	[type] [nvarchar](75) NOT NULL,
 CONSTRAINT [PK_sol_featureTypes_featureTypeID] PRIMARY KEY CLUSTERED 
(
	[featureTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_languages]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_languages](
	[languageID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](45) NOT NULL,
	[culture] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_sol_languages_languageID] PRIMARY KEY CLUSTERED 
(
	[languageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_logs]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_logs](
	[log_id] [int] IDENTITY(1,1) NOT NULL,
	[description] [nvarchar](200) NOT NULL,
	[postTime] [datetime2](0) NOT NULL,
	[computer] [nvarchar](75) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[trace] [nvarchar](100) NOT NULL,
	[referenceId1] [bigint] NULL,
	[referenceId2] [bigint] NULL,
	[value1] [nvarchar](180) NULL,
	[value2] [nvarchar](180) NULL,
	[checksum] [varbinary](250) NOT NULL,
	[logSeverityID] [int] NOT NULL,
	[logTypesID] [int] NOT NULL,
	[logSourcesID] [int] NOT NULL,
 CONSTRAINT [PK_sol_logs_log_id] PRIMARY KEY CLUSTERED 
(
	[log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_logSources]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_logSources](
	[logSourcesID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_sol_logSources_logSourcesID] PRIMARY KEY CLUSTERED 
(
	[logSourcesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_logsSererity]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_logsSererity](
	[logSererityID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_sol_logsSererity_logSererityID] PRIMARY KEY CLUSTERED 
(
	[logSererityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_logTypes]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_logTypes](
	[logTypesID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](45) NOT NULL,
	[reference1Description] [nvarchar](75) NULL,
	[reference2Description] [nvarchar](75) NULL,
	[value1Description] [nvarchar](75) NULL,
	[value2Description] [nvarchar](75) NULL,
 CONSTRAINT [PK_sol_logTypes_logTypesID] PRIMARY KEY CLUSTERED 
(
	[logTypesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_mediaFile]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_mediaFile](
	[mediaFileID] [int] IDENTITY(1,1) NOT NULL,
	[URL] [nvarchar](200) NOT NULL,
	[deleted] [binary](1) NOT NULL,
	[media_type_id] [smallint] NOT NULL,
	[userID] [int] NOT NULL,
 CONSTRAINT [PK_sol_mediaFile_mediaFileID] PRIMARY KEY CLUSTERED 
(
	[mediaFileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_mediaTypes]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_mediaTypes](
	[mediaTypeID] [smallint] IDENTITY(1,1) NOT NULL,
	[type] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_sol_mediaTypes_mediaTypeID] PRIMARY KEY CLUSTERED 
(
	[mediaTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_modules]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_modules](
	[moduleID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_sol_modules_moduleID] PRIMARY KEY CLUSTERED 
(
	[moduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_notificationConfigurations]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_notificationConfigurations](
	[configurationID] [int] IDENTITY(1,1) NOT NULL,
	[userID] [int] NOT NULL,
	[notificationTypeID] [smallint] NOT NULL,
	[communicationChannelID] [int] NOT NULL,
	[settings] [nvarchar](max) NOT NULL,
	[enabled] [binary](1) NOT NULL,
 CONSTRAINT [PK_sol_notificationConfigurations_configurationID] PRIMARY KEY CLUSTERED 
(
	[configurationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_notifications]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_notifications](
	[notificationID] [int] IDENTITY(1,1) NOT NULL,
	[userID] [int] NOT NULL,
	[notification_type_id] [smallint] NOT NULL,
	[message] [nvarchar](300) NOT NULL,
	[sentTime] [datetime2](0) NOT NULL,
	[status] [smallint] NOT NULL,
	[communicationChannelID] [int] NOT NULL,
 CONSTRAINT [PK_sol_notifications_notificationID] PRIMARY KEY CLUSTERED 
(
	[notificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_notificationTypes]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_notificationTypes](
	[notificationTypeID] [smallint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](70) NOT NULL,
 CONSTRAINT [PK_sol_notificationTypes_notificationTypeID] PRIMARY KEY CLUSTERED 
(
	[notificationTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_partner_addresses]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_partner_addresses](
	[partnerAddressId] [int] IDENTITY(1,1) NOT NULL,
	[partnerId] [int] NOT NULL,
	[addressid] [int] NOT NULL,
 CONSTRAINT [PK_sol_partner_addresses_partnerAddressId] PRIMARY KEY CLUSTERED 
(
	[partnerAddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_partners]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_partners](
	[partnerId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](60) NOT NULL,
	[registerDate] [datetime2](0) NOT NULL,
	[state] [smallint] NOT NULL,
	[identificationtypeId] [int] NOT NULL,
	[enterpriseSizeId] [int] NOT NULL,
	[identification] [nvarchar](90) NOT NULL,
 CONSTRAINT [PK_sol_partners_partnerId] PRIMARY KEY CLUSTERED 
(
	[partnerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_partners_identifications_types]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_partners_identifications_types](
	[identificationtypeId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_sol_partners_identifications_types_identificationtypeId] PRIMARY KEY CLUSTERED 
(
	[identificationtypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_payments]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_payments](
	[paymentID] [int] IDENTITY(1,1) NOT NULL,
	[availableMethodID] [int] NOT NULL,
	[currency_id] [int] NOT NULL,
	[amount] [decimal](9, 2) NOT NULL,
	[date_pay] [date] NOT NULL,
	[confirmed] [binary](1) NOT NULL,
	[result] [nvarchar](200) NOT NULL,
	[auth] [nvarchar](60) NOT NULL,
	[reference] [nvarchar](100) NOT NULL,
	[charge_token] [varbinary](255) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
	[error] [nvarchar](200) NULL,
	[checksum] [varbinary](250) NOT NULL,
	[methodID] [int] NOT NULL,
 CONSTRAINT [PK_sol_payments_paymentID] PRIMARY KEY CLUSTERED 
(
	[paymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_payMethod]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_payMethod](
	[payMethodID] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[apiURL] [nvarchar](200) NOT NULL,
	[secretKey] [varbinary](255) NOT NULL,
	[key] [nvarchar](255) NOT NULL,
	[logoIconURL] [nvarchar](200) NOT NULL,
	[enabled] [binary](1) NOT NULL,
 CONSTRAINT [PK_sol_payMethod_payMethodID] PRIMARY KEY CLUSTERED 
(
	[payMethodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_permissions]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_permissions](
	[permissionID] [int] IDENTITY(1,1) NOT NULL,
	[description] [nvarchar](200) NOT NULL,
	[code] [nvarchar](10) NOT NULL,
	[moduleID] [int] NOT NULL,
 CONSTRAINT [PK_sol_permissions_permissionID] PRIMARY KEY CLUSTERED 
(
	[permissionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [sol_permissions$code_UNIQUE] UNIQUE NONCLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_planFeatures]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_planFeatures](
	[planFeatureID] [int] IDENTITY(1,1) NOT NULL,
	[dealId] [int] NOT NULL,
	[description] [nvarchar](100) NOT NULL,
	[unit] [nvarchar](50) NOT NULL,
	[consumableQuantity] [int] NOT NULL,
	[enabled] [binary](1) NOT NULL,
	[isRecurrent] [binary](1) NOT NULL,
	[scheduleID] [int] NOT NULL,
	[featureTypeID] [int] NOT NULL,
 CONSTRAINT [PK_sol_planFeatures_planFeatureID] PRIMARY KEY CLUSTERED 
(
	[planFeatureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_planPrices]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_planPrices](
	[planPriceID] [int] IDENTITY(1,1) NOT NULL,
	[planID] [int] NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[currency_id] [int] NOT NULL,
	[postTime] [datetime2](0) NOT NULL,
	[endDate] [nvarchar](45) NOT NULL,
	[current] [binary](1) NOT NULL,
 CONSTRAINT [PK_sol_planPrices_planPriceID] PRIMARY KEY CLUSTERED 
(
	[planPriceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_plans]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_plans](
	[planID] [int] IDENTITY(1,1) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
	[planTypeID] [int] NOT NULL,
 CONSTRAINT [PK_sol_plans_planID] PRIMARY KEY CLUSTERED 
(
	[planID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_planTransactions]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_planTransactions](
	[planTransactionID] [int] IDENTITY(1,1) NOT NULL,
	[planTransactionTypeID] [int] NOT NULL,
	[date] [datetime2](0) NOT NULL,
	[postTime] [datetime2](0) NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[checksum] [varbinary](250) NOT NULL,
	[userID] [int] NOT NULL,
	[associateID] [int] NOT NULL,
	[partnerAddressId] [int] NULL,
 CONSTRAINT [PK_sol_planTransactions_planTransactionID] PRIMARY KEY CLUSTERED 
(
	[planTransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_planTransactionTypes]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_planTransactionTypes](
	[planTransactionTypeID] [int] IDENTITY(1,1) NOT NULL,
	[type] [nvarchar](60) NOT NULL,
 CONSTRAINT [PK_sol_planTransactionTypes_planTransactionTypeID] PRIMARY KEY CLUSTERED 
(
	[planTransactionTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_planTypes]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_planTypes](
	[planTypeID] [int] IDENTITY(1,1) NOT NULL,
	[type] [nvarchar](50) NOT NULL,
	[userID] [int] NULL,
 CONSTRAINT [PK_sol_planTypes_planTypeID] PRIMARY KEY CLUSTERED 
(
	[planTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_rolePermissions]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_rolePermissions](
	[rolePermissionID] [int] IDENTITY(1,1) NOT NULL,
	[roleID] [smallint] NOT NULL,
	[permissionID] [int] NOT NULL,
	[enabled] [binary](1) NOT NULL,
	[deleted] [binary](1) NOT NULL,
	[lastPermUpdate] [datetime2](0) NOT NULL,
	[username] [nvarchar](45) NOT NULL,
	[checksum] [varbinary](250) NOT NULL,
 CONSTRAINT [PK_sol_rolePermissions_rolePermissionID] PRIMARY KEY CLUSTERED 
(
	[rolePermissionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_roles]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_roles](
	[roleID] [smallint] IDENTITY(1,1) NOT NULL,
	[roleName] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_sol_roles_roleID] PRIMARY KEY CLUSTERED 
(
	[roleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_schedules]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_schedules](
	[scheduleID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](70) NOT NULL,
	[repit] [binary](1) NOT NULL,
	[repetitions] [smallint] NOT NULL,
	[recurrencyType] [smallint] NOT NULL,
	[endDate] [datetime2](0) NULL,
	[startDate] [datetime2](0) NOT NULL,
 CONSTRAINT [PK_sol_schedules_scheduleID] PRIMARY KEY CLUSTERED 
(
	[scheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_schedulesDetails]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_schedulesDetails](
	[schedulesDetailsID] [int] IDENTITY(1,1) NOT NULL,
	[deleted] [binary](1) NOT NULL,
	[schedule_id] [int] NOT NULL,
	[baseDate] [datetime2](0) NOT NULL,
	[datePart] [date] NOT NULL,
	[lastExecute] [datetime2](0) NULL,
	[nextExecute] [datetime2](0) NOT NULL,
	[description] [varchar](100) NOT NULL,
	[detail] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_sol_schedulesDetails_schedulesDetailsID] PRIMARY KEY CLUSTERED 
(
	[schedulesDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_states]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_states](
	[stateID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](40) NOT NULL,
	[countryID] [int] NOT NULL,
 CONSTRAINT [PK_sol_states_stateID] PRIMARY KEY CLUSTERED 
(
	[stateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_transactions]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_transactions](
	[transactionsID] [int] IDENTITY(1,1) NOT NULL,
	[payment_id] [int] NULL,
	[date] [datetime2](0) NOT NULL,
	[postTime] [datetime2](0) NOT NULL,
	[refNumber] [nvarchar](50) NOT NULL,
	[user_id] [int] NOT NULL,
	[checksum] [varbinary](250) NOT NULL,
	[exchangeRate] [decimal](12, 3) NOT NULL,
	[convertedAmount] [decimal](12, 2) NOT NULL,
	[transactionTypesID] [int] NOT NULL,
	[transactionSubtypesID] [int] NOT NULL,
	[amount] [decimal](12, 2) NULL,
	[exchangeCurrencyID] [int] NULL,
 CONSTRAINT [PK_sol_transactions_transactionsID] PRIMARY KEY CLUSTERED 
(
	[transactionsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_transactionSubtypes]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_transactionSubtypes](
	[transactionSubtypeID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_sol_transactionSubtypes_transactionSubtypeID] PRIMARY KEY CLUSTERED 
(
	[transactionSubtypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_transactionTypes]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_transactionTypes](
	[transactionTypeID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_sol_transactionTypes_transactionTypeID] PRIMARY KEY CLUSTERED 
(
	[transactionTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_translations]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_translations](
	[translationsID] [int] IDENTITY(1,1) NOT NULL,
	[moduleID] [int] NOT NULL,
	[code] [nvarchar](100) NOT NULL,
	[caption] [nvarchar](100) NOT NULL,
	[enabled] [binary](1) NOT NULL,
	[languageID] [int] NOT NULL,
 CONSTRAINT [PK_sol_translations_translationsID] PRIMARY KEY CLUSTERED 
(
	[translationsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_userAssociateIdentifications]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_userAssociateIdentifications](
	[associateID] [int] NOT NULL,
	[token] [varbinary](max) NOT NULL,
	[userID] [int] NOT NULL,
	[identificationTypeID] [int] NOT NULL,
 CONSTRAINT [PK_sol_userAssociateIdentifications_associateID] PRIMARY KEY CLUSTERED 
(
	[associateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_userPermissions]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_userPermissions](
	[userPermissionID] [int] IDENTITY(1,1) NOT NULL,
	[permissionID] [int] NOT NULL,
	[enabled] [binary](1) NOT NULL,
	[deleted] [binary](1) NOT NULL,
	[lastPermUpdate] [datetime2](0) NOT NULL,
	[username] [nvarchar](45) NOT NULL,
	[checksum] [varbinary](250) NOT NULL,
	[userID] [int] NOT NULL,
 CONSTRAINT [PK_sol_userPermissions_userPermissionID] PRIMARY KEY CLUSTERED 
(
	[userPermissionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_userPlans]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_userPlans](
	[userPlanID] [int] IDENTITY(1,1) NOT NULL,
	[userID] [int] NOT NULL,
	[planPriceID] [int] NOT NULL,
	[scheduleID] [int] NOT NULL,
	[adquisition] [date] NOT NULL,
	[enabled] [binary](1) NOT NULL,
 CONSTRAINT [PK_sol_userPlans_userPlanID] PRIMARY KEY CLUSTERED 
(
	[userPlanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_userRoles]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_userRoles](
	[userID] [int] IDENTITY(1,1) NOT NULL,
	[role_id] [smallint] NOT NULL,
	[enabled] [binary](1) NOT NULL,
	[deleted] [binary](1) NOT NULL,
	[lastUpdate] [datetime2](0) NOT NULL,
	[username] [nvarchar](45) NOT NULL,
	[checksum] [varbinary](250) NOT NULL,
 CONSTRAINT [PK_sol_userRoles_userID] PRIMARY KEY CLUSTERED 
(
	[userID] ASC,
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_users]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_users](
	[userID] [int] IDENTITY(1,1) NOT NULL,
	[email] [nvarchar](80) NOT NULL,
	[firstName] [nvarchar](50) NOT NULL,
	[lastName] [nvarchar](50) NOT NULL,
	[password] [varbinary](250) NOT NULL,
	[enabled] [binary](1) NOT NULL,
 CONSTRAINT [PK_sol_users_userID] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [sol_users$email_UNIQUE] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [solturaDB].[sol_usersAdresses]    Script Date: 5/6/2025 5:15:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [solturaDB].[sol_usersAdresses](
	[userAddressID] [int] IDENTITY(1,1) NOT NULL,
	[userID] [int] NOT NULL,
	[addressID] [int] NOT NULL,
	[enabled] [binary](1) NOT NULL,
 CONSTRAINT [PK_sol_usersAdresses_userAddressID] PRIMARY KEY CLUSTERED 
(
	[userAddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[sol_migratedUsers] ADD  CONSTRAINT [DF_sol_migratedUsers_changedPassword]  DEFAULT (0x00) FOR [changedPassword]
GO
ALTER TABLE [solturaDB].[sol_addresses] ADD  DEFAULT (NULL) FOR [line2]
GO
ALTER TABLE [solturaDB].[sol_contact_info] ADD  DEFAULT (0x01) FOR [enable]
GO
ALTER TABLE [solturaDB].[sol_contact_info] ADD  DEFAULT (getdate()) FOR [lastUpdate]
GO
ALTER TABLE [solturaDB].[sol_deals] ADD  DEFAULT (0x01) FOR [isActive]
GO
ALTER TABLE [solturaDB].[sol_exchangeCurrencies] ADD  DEFAULT (NULL) FOR [endDate]
GO
ALTER TABLE [solturaDB].[sol_exchangeCurrencies] ADD  DEFAULT (0x01) FOR [enabled]
GO
ALTER TABLE [solturaDB].[sol_exchangeCurrencies] ADD  DEFAULT (0x01) FOR [currentExchange]
GO
ALTER TABLE [solturaDB].[sol_featureAvailableLocations] ADD  DEFAULT (0x01) FOR [available]
GO
ALTER TABLE [solturaDB].[sol_featurePrices] ADD  DEFAULT (NULL) FOR [originalPrice]
GO
ALTER TABLE [solturaDB].[sol_featurePrices] ADD  DEFAULT (NULL) FOR [discountedPrice]
GO
ALTER TABLE [solturaDB].[sol_featurePrices] ADD  DEFAULT (NULL) FOR [finalPrice]
GO
ALTER TABLE [solturaDB].[sol_featurePrices] ADD  DEFAULT (0x01) FOR [current]
GO
ALTER TABLE [solturaDB].[sol_featurePrices] ADD  DEFAULT (0x00) FOR [variable]
GO
ALTER TABLE [solturaDB].[sol_featuresPerPlans] ADD  DEFAULT (0x01) FOR [enabled]
GO
ALTER TABLE [solturaDB].[sol_logs] ADD  DEFAULT (NULL) FOR [referenceId1]
GO
ALTER TABLE [solturaDB].[sol_logs] ADD  DEFAULT (NULL) FOR [referenceId2]
GO
ALTER TABLE [solturaDB].[sol_logs] ADD  DEFAULT (NULL) FOR [value1]
GO
ALTER TABLE [solturaDB].[sol_logs] ADD  DEFAULT (NULL) FOR [value2]
GO
ALTER TABLE [solturaDB].[sol_logTypes] ADD  DEFAULT (NULL) FOR [reference1Description]
GO
ALTER TABLE [solturaDB].[sol_logTypes] ADD  DEFAULT (NULL) FOR [reference2Description]
GO
ALTER TABLE [solturaDB].[sol_logTypes] ADD  DEFAULT (NULL) FOR [value1Description]
GO
ALTER TABLE [solturaDB].[sol_logTypes] ADD  DEFAULT (NULL) FOR [value2Description]
GO
ALTER TABLE [solturaDB].[sol_mediaFile] ADD  DEFAULT (0x00) FOR [deleted]
GO
ALTER TABLE [solturaDB].[sol_notificationConfigurations] ADD  DEFAULT (0x01) FOR [enabled]
GO
ALTER TABLE [solturaDB].[sol_partners] ADD  DEFAULT ((1)) FOR [state]
GO
ALTER TABLE [solturaDB].[sol_payments] ADD  DEFAULT (0x00) FOR [confirmed]
GO
ALTER TABLE [solturaDB].[sol_payments] ADD  DEFAULT (N'En proceso') FOR [result]
GO
ALTER TABLE [solturaDB].[sol_payments] ADD  DEFAULT (NULL) FOR [error]
GO
ALTER TABLE [solturaDB].[sol_payMethod] ADD  DEFAULT (0x01) FOR [enabled]
GO
ALTER TABLE [solturaDB].[sol_planFeatures] ADD  DEFAULT (0x01) FOR [enabled]
GO
ALTER TABLE [solturaDB].[sol_planPrices] ADD  DEFAULT (0x01) FOR [current]
GO
ALTER TABLE [solturaDB].[sol_planTransactions] ADD  DEFAULT (NULL) FOR [partnerAddressId]
GO
ALTER TABLE [solturaDB].[sol_planTypes] ADD  DEFAULT (NULL) FOR [userID]
GO
ALTER TABLE [solturaDB].[sol_rolePermissions] ADD  DEFAULT (0x01) FOR [enabled]
GO
ALTER TABLE [solturaDB].[sol_rolePermissions] ADD  DEFAULT (0x00) FOR [deleted]
GO
ALTER TABLE [solturaDB].[sol_rolePermissions] ADD  DEFAULT (getdate()) FOR [lastPermUpdate]
GO
ALTER TABLE [solturaDB].[sol_schedules] ADD  DEFAULT (NULL) FOR [endDate]
GO
ALTER TABLE [solturaDB].[sol_schedulesDetails] ADD  DEFAULT (0x00) FOR [deleted]
GO
ALTER TABLE [solturaDB].[sol_schedulesDetails] ADD  DEFAULT (NULL) FOR [lastExecute]
GO
ALTER TABLE [solturaDB].[sol_transactions] ADD  DEFAULT (NULL) FOR [payment_id]
GO
ALTER TABLE [solturaDB].[sol_transactions] ADD  DEFAULT (NULL) FOR [amount]
GO
ALTER TABLE [solturaDB].[sol_transactions] ADD  DEFAULT (NULL) FOR [exchangeCurrencyID]
GO
ALTER TABLE [solturaDB].[sol_userPermissions] ADD  DEFAULT (0x01) FOR [enabled]
GO
ALTER TABLE [solturaDB].[sol_userPermissions] ADD  DEFAULT (0x00) FOR [deleted]
GO
ALTER TABLE [solturaDB].[sol_userPermissions] ADD  DEFAULT (getdate()) FOR [lastPermUpdate]
GO
ALTER TABLE [solturaDB].[sol_userPlans] ADD  DEFAULT (0x01) FOR [enabled]
GO
ALTER TABLE [solturaDB].[sol_userRoles] ADD  DEFAULT (0x01) FOR [enabled]
GO
ALTER TABLE [solturaDB].[sol_userRoles] ADD  DEFAULT (0x00) FOR [deleted]
GO
ALTER TABLE [solturaDB].[sol_userRoles] ADD  DEFAULT (getdate()) FOR [lastUpdate]
GO
ALTER TABLE [solturaDB].[sol_users] ADD  DEFAULT (0x01) FOR [enabled]
GO
ALTER TABLE [solturaDB].[sol_usersAdresses] ADD  DEFAULT (0x01) FOR [enabled]
GO
ALTER TABLE [dbo].[sol_migratedUsers]  WITH NOCHECK ADD  CONSTRAINT [FK_sol_migratedUsers_sol_users] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [dbo].[sol_migratedUsers] NOCHECK CONSTRAINT [FK_sol_migratedUsers_sol_users]
GO
ALTER TABLE [solturaDB].[sol_addresses]  WITH NOCHECK ADD  CONSTRAINT [sol_addresses$fk_pay_Addresses_pay_city1] FOREIGN KEY([cityID])
REFERENCES [solturaDB].[sol_city] ([cityID])
GO
ALTER TABLE [solturaDB].[sol_addresses] NOCHECK CONSTRAINT [sol_addresses$fk_pay_Addresses_pay_city1]
GO
ALTER TABLE [solturaDB].[sol_associatePlans]  WITH NOCHECK ADD  CONSTRAINT [sol_associatePlans$fk_sol_associatePlans_sol_userAssociateIdentifications1] FOREIGN KEY([associateID])
REFERENCES [solturaDB].[sol_userAssociateIdentifications] ([associateID])
GO
ALTER TABLE [solturaDB].[sol_associatePlans] NOCHECK CONSTRAINT [sol_associatePlans$fk_sol_associatePlans_sol_userAssociateIdentifications1]
GO
ALTER TABLE [solturaDB].[sol_associatePlans]  WITH NOCHECK ADD  CONSTRAINT [sol_associatePlans$fk_sol_associatePlans_sol_userPlans1] FOREIGN KEY([userPlanID])
REFERENCES [solturaDB].[sol_userPlans] ([userPlanID])
GO
ALTER TABLE [solturaDB].[sol_associatePlans] NOCHECK CONSTRAINT [sol_associatePlans$fk_sol_associatePlans_sol_userPlans1]
GO
ALTER TABLE [solturaDB].[sol_availablePayMethods]  WITH NOCHECK ADD  CONSTRAINT [sol_availablePayMethods$fk_pay_available_media_pay_pay_method1] FOREIGN KEY([methodID])
REFERENCES [solturaDB].[sol_payMethod] ([payMethodID])
GO
ALTER TABLE [solturaDB].[sol_availablePayMethods] NOCHECK CONSTRAINT [sol_availablePayMethods$fk_pay_available_media_pay_pay_method1]
GO
ALTER TABLE [solturaDB].[sol_availablePayMethods]  WITH NOCHECK ADD  CONSTRAINT [sol_availablePayMethods$fk_pay_available_media_pay_users1] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_availablePayMethods] NOCHECK CONSTRAINT [sol_availablePayMethods$fk_pay_available_media_pay_users1]
GO
ALTER TABLE [solturaDB].[sol_balances]  WITH NOCHECK ADD  CONSTRAINT [sol_balances$fk_sol_balances_sol_planFeatures1] FOREIGN KEY([planFeatureID])
REFERENCES [solturaDB].[sol_planFeatures] ([planFeatureID])
GO
ALTER TABLE [solturaDB].[sol_balances] NOCHECK CONSTRAINT [sol_balances$fk_sol_balances_sol_planFeatures1]
GO
ALTER TABLE [solturaDB].[sol_balances]  WITH NOCHECK ADD  CONSTRAINT [sol_balances$fk_sol_balances_sol_users1] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_balances] NOCHECK CONSTRAINT [sol_balances$fk_sol_balances_sol_users1]
GO
ALTER TABLE [solturaDB].[sol_city]  WITH NOCHECK ADD  CONSTRAINT [sol_city$fk_pay_city_pay_states1] FOREIGN KEY([stateID])
REFERENCES [solturaDB].[sol_states] ([stateID])
GO
ALTER TABLE [solturaDB].[sol_city] NOCHECK CONSTRAINT [sol_city$fk_pay_city_pay_states1]
GO
ALTER TABLE [solturaDB].[sol_contact_info]  WITH NOCHECK ADD  CONSTRAINT [sol_contact_info$fk_pay_contact_info_pay_contact_type1] FOREIGN KEY([contactTypeID])
REFERENCES [solturaDB].[sol_contactType] ([contactTypeID])
GO
ALTER TABLE [solturaDB].[sol_contact_info] NOCHECK CONSTRAINT [sol_contact_info$fk_pay_contact_info_pay_contact_type1]
GO
ALTER TABLE [solturaDB].[sol_contact_info]  WITH NOCHECK ADD  CONSTRAINT [sol_contact_info$fk_sol_contact_info_sol_contact_departments1] FOREIGN KEY([contactDepartmentId])
REFERENCES [solturaDB].[sol_contact_departments] ([contactDepartmentId])
GO
ALTER TABLE [solturaDB].[sol_contact_info] NOCHECK CONSTRAINT [sol_contact_info$fk_sol_contact_info_sol_contact_departments1]
GO
ALTER TABLE [solturaDB].[sol_contact_info]  WITH NOCHECK ADD  CONSTRAINT [sol_contact_info$fk_sol_contact_info_sol_partners1] FOREIGN KEY([partnerId])
REFERENCES [solturaDB].[sol_partners] ([partnerId])
GO
ALTER TABLE [solturaDB].[sol_contact_info] NOCHECK CONSTRAINT [sol_contact_info$fk_sol_contact_info_sol_partners1]
GO
ALTER TABLE [solturaDB].[sol_currencies]  WITH NOCHECK ADD  CONSTRAINT [sol_currencies$fk_pay_currencies_pay_countries1] FOREIGN KEY([countryID])
REFERENCES [solturaDB].[sol_countries] ([countryID])
GO
ALTER TABLE [solturaDB].[sol_currencies] NOCHECK CONSTRAINT [sol_currencies$fk_pay_currencies_pay_countries1]
GO
ALTER TABLE [solturaDB].[sol_deals]  WITH NOCHECK ADD  CONSTRAINT [sol_deals$fk_sol_deals_sol_partners1] FOREIGN KEY([partnerId])
REFERENCES [solturaDB].[sol_partners] ([partnerId])
GO
ALTER TABLE [solturaDB].[sol_deals] NOCHECK CONSTRAINT [sol_deals$fk_sol_deals_sol_partners1]
GO
ALTER TABLE [solturaDB].[sol_exchangeCurrencies]  WITH NOCHECK ADD  CONSTRAINT [sol_exchangeCurrencies$fk_pay_exchange_currency_pay_currency1] FOREIGN KEY([sourceID])
REFERENCES [solturaDB].[sol_currencies] ([currency_id])
GO
ALTER TABLE [solturaDB].[sol_exchangeCurrencies] NOCHECK CONSTRAINT [sol_exchangeCurrencies$fk_pay_exchange_currency_pay_currency1]
GO
ALTER TABLE [solturaDB].[sol_exchangeCurrencies]  WITH NOCHECK ADD  CONSTRAINT [sol_exchangeCurrencies$fk_pay_exchange_currency_pay_currency2] FOREIGN KEY([destinyID])
REFERENCES [solturaDB].[sol_currencies] ([currency_id])
GO
ALTER TABLE [solturaDB].[sol_exchangeCurrencies] NOCHECK CONSTRAINT [sol_exchangeCurrencies$fk_pay_exchange_currency_pay_currency2]
GO
ALTER TABLE [solturaDB].[sol_featureAvailableLocations]  WITH NOCHECK ADD  CONSTRAINT [sol_featureAvailableLocations$fk_sol_featureLocations_sol_featuresPerPlans1] FOREIGN KEY([featurePerPlanID])
REFERENCES [solturaDB].[sol_featuresPerPlans] ([featurePerPlansID])
GO
ALTER TABLE [solturaDB].[sol_featureAvailableLocations] NOCHECK CONSTRAINT [sol_featureAvailableLocations$fk_sol_featureLocations_sol_featuresPerPlans1]
GO
ALTER TABLE [solturaDB].[sol_featureAvailableLocations]  WITH NOCHECK ADD  CONSTRAINT [sol_featureAvailableLocations$fk_sol_featureLocations_sol_partner_addresses1] FOREIGN KEY([partnerAddressId])
REFERENCES [solturaDB].[sol_partner_addresses] ([partnerAddressId])
GO
ALTER TABLE [solturaDB].[sol_featureAvailableLocations] NOCHECK CONSTRAINT [sol_featureAvailableLocations$fk_sol_featureLocations_sol_partner_addresses1]
GO
ALTER TABLE [solturaDB].[sol_featurePrices]  WITH NOCHECK ADD  CONSTRAINT [sol_featurePrices$fk_sol_featurePrices_sol_currencies1] FOREIGN KEY([currency_id])
REFERENCES [solturaDB].[sol_currencies] ([currency_id])
GO
ALTER TABLE [solturaDB].[sol_featurePrices] NOCHECK CONSTRAINT [sol_featurePrices$fk_sol_featurePrices_sol_currencies1]
GO
ALTER TABLE [solturaDB].[sol_featurePrices]  WITH NOCHECK ADD  CONSTRAINT [sol_featurePrices$fk_sol_featurePrices_sol_planFeatures1] FOREIGN KEY([planFeatureID])
REFERENCES [solturaDB].[sol_planFeatures] ([planFeatureID])
GO
ALTER TABLE [solturaDB].[sol_featurePrices] NOCHECK CONSTRAINT [sol_featurePrices$fk_sol_featurePrices_sol_planFeatures1]
GO
ALTER TABLE [solturaDB].[sol_featuresPerPlans]  WITH NOCHECK ADD  CONSTRAINT [sol_featuresPerPlans$fk_sol_featuresPerPlans_sol_planFeatures1] FOREIGN KEY([planFeatureID])
REFERENCES [solturaDB].[sol_planFeatures] ([planFeatureID])
GO
ALTER TABLE [solturaDB].[sol_featuresPerPlans] NOCHECK CONSTRAINT [sol_featuresPerPlans$fk_sol_featuresPerPlans_sol_planFeatures1]
GO
ALTER TABLE [solturaDB].[sol_featuresPerPlans]  WITH NOCHECK ADD  CONSTRAINT [sol_featuresPerPlans$fk_sol_featuresPerPlans_sol_plans1] FOREIGN KEY([planID])
REFERENCES [solturaDB].[sol_plans] ([planID])
GO
ALTER TABLE [solturaDB].[sol_featuresPerPlans] NOCHECK CONSTRAINT [sol_featuresPerPlans$fk_sol_featuresPerPlans_sol_plans1]
GO
ALTER TABLE [solturaDB].[sol_logs]  WITH NOCHECK ADD  CONSTRAINT [sol_logs$fk_pay_logs_pay_log_severity1] FOREIGN KEY([logSeverityID])
REFERENCES [solturaDB].[sol_logsSererity] ([logSererityID])
GO
ALTER TABLE [solturaDB].[sol_logs] NOCHECK CONSTRAINT [sol_logs$fk_pay_logs_pay_log_severity1]
GO
ALTER TABLE [solturaDB].[sol_logs]  WITH NOCHECK ADD  CONSTRAINT [sol_logs$fk_pay_logs_pay_log_sources1] FOREIGN KEY([logSourcesID])
REFERENCES [solturaDB].[sol_logSources] ([logSourcesID])
GO
ALTER TABLE [solturaDB].[sol_logs] NOCHECK CONSTRAINT [sol_logs$fk_pay_logs_pay_log_sources1]
GO
ALTER TABLE [solturaDB].[sol_logs]  WITH NOCHECK ADD  CONSTRAINT [sol_logs$fk_pay_logs_pay_log_types1] FOREIGN KEY([logTypesID])
REFERENCES [solturaDB].[sol_logTypes] ([logTypesID])
GO
ALTER TABLE [solturaDB].[sol_logs] NOCHECK CONSTRAINT [sol_logs$fk_pay_logs_pay_log_types1]
GO
ALTER TABLE [solturaDB].[sol_mediaFile]  WITH NOCHECK ADD  CONSTRAINT [sol_mediaFile$fk_pay_media_files_pay_media_types] FOREIGN KEY([media_type_id])
REFERENCES [solturaDB].[sol_mediaTypes] ([mediaTypeID])
GO
ALTER TABLE [solturaDB].[sol_mediaFile] NOCHECK CONSTRAINT [sol_mediaFile$fk_pay_media_files_pay_media_types]
GO
ALTER TABLE [solturaDB].[sol_mediaFile]  WITH NOCHECK ADD  CONSTRAINT [sol_mediaFile$fk_pay_media_files_pay_users1] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_mediaFile] NOCHECK CONSTRAINT [sol_mediaFile$fk_pay_media_files_pay_users1]
GO
ALTER TABLE [solturaDB].[sol_notificationConfigurations]  WITH NOCHECK ADD  CONSTRAINT [sol_notificationConfigurations$fk_notification_configurations_pay_communication_channels1] FOREIGN KEY([communicationChannelID])
REFERENCES [solturaDB].[sol_communicationChannels] ([communicationChannelID])
GO
ALTER TABLE [solturaDB].[sol_notificationConfigurations] NOCHECK CONSTRAINT [sol_notificationConfigurations$fk_notification_configurations_pay_communication_channels1]
GO
ALTER TABLE [solturaDB].[sol_notificationConfigurations]  WITH NOCHECK ADD  CONSTRAINT [sol_notificationConfigurations$fk_notification_configurations_pay_notification_types1] FOREIGN KEY([notificationTypeID])
REFERENCES [solturaDB].[sol_notificationTypes] ([notificationTypeID])
GO
ALTER TABLE [solturaDB].[sol_notificationConfigurations] NOCHECK CONSTRAINT [sol_notificationConfigurations$fk_notification_configurations_pay_notification_types1]
GO
ALTER TABLE [solturaDB].[sol_notificationConfigurations]  WITH NOCHECK ADD  CONSTRAINT [sol_notificationConfigurations$fk_notification_configurations_pay_users2] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_notificationConfigurations] NOCHECK CONSTRAINT [sol_notificationConfigurations$fk_notification_configurations_pay_users2]
GO
ALTER TABLE [solturaDB].[sol_notifications]  WITH NOCHECK ADD  CONSTRAINT [sol_notifications$fk_pay_notifications_pay_channel_types1] FOREIGN KEY([communicationChannelID])
REFERENCES [solturaDB].[sol_communicationChannels] ([communicationChannelID])
GO
ALTER TABLE [solturaDB].[sol_notifications] NOCHECK CONSTRAINT [sol_notifications$fk_pay_notifications_pay_channel_types1]
GO
ALTER TABLE [solturaDB].[sol_notifications]  WITH NOCHECK ADD  CONSTRAINT [sol_notifications$fk_pay_notifications_pay_notification_types1] FOREIGN KEY([notification_type_id])
REFERENCES [solturaDB].[sol_notificationTypes] ([notificationTypeID])
GO
ALTER TABLE [solturaDB].[sol_notifications] NOCHECK CONSTRAINT [sol_notifications$fk_pay_notifications_pay_notification_types1]
GO
ALTER TABLE [solturaDB].[sol_notifications]  WITH NOCHECK ADD  CONSTRAINT [sol_notifications$fk_pay_notifications_pay_users1] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_notifications] NOCHECK CONSTRAINT [sol_notifications$fk_pay_notifications_pay_users1]
GO
ALTER TABLE [solturaDB].[sol_partner_addresses]  WITH NOCHECK ADD  CONSTRAINT [sol_partner_addresses$fk_sol_partners_addresses_sol_addresses1] FOREIGN KEY([addressid])
REFERENCES [solturaDB].[sol_addresses] ([addressid])
GO
ALTER TABLE [solturaDB].[sol_partner_addresses] NOCHECK CONSTRAINT [sol_partner_addresses$fk_sol_partners_addresses_sol_addresses1]
GO
ALTER TABLE [solturaDB].[sol_partner_addresses]  WITH NOCHECK ADD  CONSTRAINT [sol_partner_addresses$fk_sol_partners_addresses_sol_partners1] FOREIGN KEY([partnerId])
REFERENCES [solturaDB].[sol_partners] ([partnerId])
GO
ALTER TABLE [solturaDB].[sol_partner_addresses] NOCHECK CONSTRAINT [sol_partner_addresses$fk_sol_partners_addresses_sol_partners1]
GO
ALTER TABLE [solturaDB].[sol_partners]  WITH NOCHECK ADD  CONSTRAINT [sol_partners$fk_sol_partners_sol_enterprise_size1] FOREIGN KEY([enterpriseSizeId])
REFERENCES [solturaDB].[sol_enterprise_size] ([enterpriseSizeId])
GO
ALTER TABLE [solturaDB].[sol_partners] NOCHECK CONSTRAINT [sol_partners$fk_sol_partners_sol_enterprise_size1]
GO
ALTER TABLE [solturaDB].[sol_partners]  WITH NOCHECK ADD  CONSTRAINT [sol_partners$fk_sol_partners_sol_partners_identifications_types1] FOREIGN KEY([identificationtypeId])
REFERENCES [solturaDB].[sol_partners_identifications_types] ([identificationtypeId])
GO
ALTER TABLE [solturaDB].[sol_partners] NOCHECK CONSTRAINT [sol_partners$fk_sol_partners_sol_partners_identifications_types1]
GO
ALTER TABLE [solturaDB].[sol_payments]  WITH NOCHECK ADD  CONSTRAINT [sol_payments$fk_pay_payments_pay_available_pay_methods1] FOREIGN KEY([availableMethodID])
REFERENCES [solturaDB].[sol_availablePayMethods] ([available_method_id])
GO
ALTER TABLE [solturaDB].[sol_payments] NOCHECK CONSTRAINT [sol_payments$fk_pay_payments_pay_available_pay_methods1]
GO
ALTER TABLE [solturaDB].[sol_payments]  WITH NOCHECK ADD  CONSTRAINT [sol_payments$fk_pay_payments_pay_currency1] FOREIGN KEY([currency_id])
REFERENCES [solturaDB].[sol_currencies] ([currency_id])
GO
ALTER TABLE [solturaDB].[sol_payments] NOCHECK CONSTRAINT [sol_payments$fk_pay_payments_pay_currency1]
GO
ALTER TABLE [solturaDB].[sol_payments]  WITH NOCHECK ADD  CONSTRAINT [sol_payments$fk_pay_pays_pay_pay_method1] FOREIGN KEY([methodID])
REFERENCES [solturaDB].[sol_payMethod] ([payMethodID])
GO
ALTER TABLE [solturaDB].[sol_payments] NOCHECK CONSTRAINT [sol_payments$fk_pay_pays_pay_pay_method1]
GO
ALTER TABLE [solturaDB].[sol_permissions]  WITH NOCHECK ADD  CONSTRAINT [sol_permissions$fk_pay_permissions_pay_modules1] FOREIGN KEY([moduleID])
REFERENCES [solturaDB].[sol_modules] ([moduleID])
GO
ALTER TABLE [solturaDB].[sol_permissions] NOCHECK CONSTRAINT [sol_permissions$fk_pay_permissions_pay_modules1]
GO
ALTER TABLE [solturaDB].[sol_planFeatures]  WITH NOCHECK ADD  CONSTRAINT [sol_planFeatures$fk_sol_planFeatures_sol_deals1] FOREIGN KEY([dealId])
REFERENCES [solturaDB].[sol_deals] ([dealId])
GO
ALTER TABLE [solturaDB].[sol_planFeatures] NOCHECK CONSTRAINT [sol_planFeatures$fk_sol_planFeatures_sol_deals1]
GO
ALTER TABLE [solturaDB].[sol_planFeatures]  WITH NOCHECK ADD  CONSTRAINT [sol_planFeatures$fk_sol_planFeatures_sol_featureTypes1] FOREIGN KEY([featureTypeID])
REFERENCES [solturaDB].[sol_featureTypes] ([featureTypeID])
GO
ALTER TABLE [solturaDB].[sol_planFeatures] NOCHECK CONSTRAINT [sol_planFeatures$fk_sol_planFeatures_sol_featureTypes1]
GO
ALTER TABLE [solturaDB].[sol_planFeatures]  WITH NOCHECK ADD  CONSTRAINT [sol_planFeatures$fk_sol_planFeatures_sol_schedules1] FOREIGN KEY([scheduleID])
REFERENCES [solturaDB].[sol_schedules] ([scheduleID])
GO
ALTER TABLE [solturaDB].[sol_planFeatures] NOCHECK CONSTRAINT [sol_planFeatures$fk_sol_planFeatures_sol_schedules1]
GO
ALTER TABLE [solturaDB].[sol_planPrices]  WITH NOCHECK ADD  CONSTRAINT [sol_planPrices$fk_sol_planPrices_sol_currencies1] FOREIGN KEY([currency_id])
REFERENCES [solturaDB].[sol_currencies] ([currency_id])
GO
ALTER TABLE [solturaDB].[sol_planPrices] NOCHECK CONSTRAINT [sol_planPrices$fk_sol_planPrices_sol_currencies1]
GO
ALTER TABLE [solturaDB].[sol_planPrices]  WITH NOCHECK ADD  CONSTRAINT [sol_planPrices$fk_sol_planPrices_sol_plans1] FOREIGN KEY([planID])
REFERENCES [solturaDB].[sol_plans] ([planID])
GO
ALTER TABLE [solturaDB].[sol_planPrices] NOCHECK CONSTRAINT [sol_planPrices$fk_sol_planPrices_sol_plans1]
GO
ALTER TABLE [solturaDB].[sol_plans]  WITH NOCHECK ADD  CONSTRAINT [sol_plans$fk_sol_plans_sol_planTypes1] FOREIGN KEY([planTypeID])
REFERENCES [solturaDB].[sol_planTypes] ([planTypeID])
GO
ALTER TABLE [solturaDB].[sol_plans] NOCHECK CONSTRAINT [sol_plans$fk_sol_plans_sol_planTypes1]
GO
ALTER TABLE [solturaDB].[sol_planTransactions]  WITH NOCHECK ADD  CONSTRAINT [sol_planTransactions$fk_sol_planTransactions_sol_partner_addresses1] FOREIGN KEY([partnerAddressId])
REFERENCES [solturaDB].[sol_partner_addresses] ([partnerAddressId])
GO
ALTER TABLE [solturaDB].[sol_planTransactions] NOCHECK CONSTRAINT [sol_planTransactions$fk_sol_planTransactions_sol_partner_addresses1]
GO
ALTER TABLE [solturaDB].[sol_planTransactions]  WITH NOCHECK ADD  CONSTRAINT [sol_planTransactions$fk_sol_planTransactions_sol_planTransactionTypes1] FOREIGN KEY([planTransactionTypeID])
REFERENCES [solturaDB].[sol_planTransactionTypes] ([planTransactionTypeID])
GO
ALTER TABLE [solturaDB].[sol_planTransactions] NOCHECK CONSTRAINT [sol_planTransactions$fk_sol_planTransactions_sol_planTransactionTypes1]
GO
ALTER TABLE [solturaDB].[sol_planTransactions]  WITH NOCHECK ADD  CONSTRAINT [sol_planTransactions$fk_sol_planTransactions_sol_userAssociateIdentifications1] FOREIGN KEY([associateID])
REFERENCES [solturaDB].[sol_userAssociateIdentifications] ([associateID])
GO
ALTER TABLE [solturaDB].[sol_planTransactions] NOCHECK CONSTRAINT [sol_planTransactions$fk_sol_planTransactions_sol_userAssociateIdentifications1]
GO
ALTER TABLE [solturaDB].[sol_planTransactions]  WITH NOCHECK ADD  CONSTRAINT [sol_planTransactions$fk_sol_planTransactions_sol_users1] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_planTransactions] NOCHECK CONSTRAINT [sol_planTransactions$fk_sol_planTransactions_sol_users1]
GO
ALTER TABLE [solturaDB].[sol_planTypes]  WITH NOCHECK ADD  CONSTRAINT [sol_planTypes$fk_sol_planTypes_sol_users1] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_planTypes] NOCHECK CONSTRAINT [sol_planTypes$fk_sol_planTypes_sol_users1]
GO
ALTER TABLE [solturaDB].[sol_rolePermissions]  WITH NOCHECK ADD  CONSTRAINT [sol_rolePermissions$fk_pay_role_permissions_pay_permissions1] FOREIGN KEY([permissionID])
REFERENCES [solturaDB].[sol_permissions] ([permissionID])
GO
ALTER TABLE [solturaDB].[sol_rolePermissions] NOCHECK CONSTRAINT [sol_rolePermissions$fk_pay_role_permissions_pay_permissions1]
GO
ALTER TABLE [solturaDB].[sol_rolePermissions]  WITH NOCHECK ADD  CONSTRAINT [sol_rolePermissions$fk_pay_role_permissions_pay_roles1] FOREIGN KEY([roleID])
REFERENCES [solturaDB].[sol_roles] ([roleID])
GO
ALTER TABLE [solturaDB].[sol_rolePermissions] NOCHECK CONSTRAINT [sol_rolePermissions$fk_pay_role_permissions_pay_roles1]
GO
ALTER TABLE [solturaDB].[sol_schedulesDetails]  WITH NOCHECK ADD  CONSTRAINT [sol_schedulesDetails$fk_pay_schedules_details_pay_schedules1] FOREIGN KEY([schedule_id])
REFERENCES [solturaDB].[sol_schedules] ([scheduleID])
GO
ALTER TABLE [solturaDB].[sol_schedulesDetails] NOCHECK CONSTRAINT [sol_schedulesDetails$fk_pay_schedules_details_pay_schedules1]
GO
ALTER TABLE [solturaDB].[sol_states]  WITH NOCHECK ADD  CONSTRAINT [sol_states$fk_pay_states_pay_countries1] FOREIGN KEY([countryID])
REFERENCES [solturaDB].[sol_countries] ([countryID])
GO
ALTER TABLE [solturaDB].[sol_states] NOCHECK CONSTRAINT [sol_states$fk_pay_states_pay_countries1]
GO
ALTER TABLE [solturaDB].[sol_transactions]  WITH NOCHECK ADD  CONSTRAINT [sol_transactions$fk_pay_transactions_pay_pays1] FOREIGN KEY([payment_id])
REFERENCES [solturaDB].[sol_payments] ([paymentID])
GO
ALTER TABLE [solturaDB].[sol_transactions] NOCHECK CONSTRAINT [sol_transactions$fk_pay_transactions_pay_pays1]
GO
ALTER TABLE [solturaDB].[sol_transactions]  WITH NOCHECK ADD  CONSTRAINT [sol_transactions$fk_pay_transactions_pay_transaction_subtypes1] FOREIGN KEY([transactionSubtypesID])
REFERENCES [solturaDB].[sol_transactionSubtypes] ([transactionSubtypeID])
GO
ALTER TABLE [solturaDB].[sol_transactions] NOCHECK CONSTRAINT [sol_transactions$fk_pay_transactions_pay_transaction_subtypes1]
GO
ALTER TABLE [solturaDB].[sol_transactions]  WITH NOCHECK ADD  CONSTRAINT [sol_transactions$fk_pay_transactions_pay_transaction_types1] FOREIGN KEY([transactionTypesID])
REFERENCES [solturaDB].[sol_transactionTypes] ([transactionTypeID])
GO
ALTER TABLE [solturaDB].[sol_transactions] NOCHECK CONSTRAINT [sol_transactions$fk_pay_transactions_pay_transaction_types1]
GO
ALTER TABLE [solturaDB].[sol_transactions]  WITH NOCHECK ADD  CONSTRAINT [sol_transactions$fk_pay_transactions_pay_users1] FOREIGN KEY([user_id])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_transactions] NOCHECK CONSTRAINT [sol_transactions$fk_pay_transactions_pay_users1]
GO
ALTER TABLE [solturaDB].[sol_transactions]  WITH NOCHECK ADD  CONSTRAINT [sol_transactions$fk_sol_transactions_sol_exchangeCurrencies1] FOREIGN KEY([exchangeCurrencyID])
REFERENCES [solturaDB].[sol_exchangeCurrencies] ([exchangeCurrencyID])
GO
ALTER TABLE [solturaDB].[sol_transactions] NOCHECK CONSTRAINT [sol_transactions$fk_sol_transactions_sol_exchangeCurrencies1]
GO
ALTER TABLE [solturaDB].[sol_translations]  WITH NOCHECK ADD  CONSTRAINT [sol_translations$fk_pay_translations_pay_languages1] FOREIGN KEY([languageID])
REFERENCES [solturaDB].[sol_languages] ([languageID])
GO
ALTER TABLE [solturaDB].[sol_translations] NOCHECK CONSTRAINT [sol_translations$fk_pay_translations_pay_languages1]
GO
ALTER TABLE [solturaDB].[sol_translations]  WITH NOCHECK ADD  CONSTRAINT [sol_translations$fk_pay_translations_pay_modules1] FOREIGN KEY([moduleID])
REFERENCES [solturaDB].[sol_modules] ([moduleID])
GO
ALTER TABLE [solturaDB].[sol_translations] NOCHECK CONSTRAINT [sol_translations$fk_pay_translations_pay_modules1]
GO
ALTER TABLE [solturaDB].[sol_userAssociateIdentifications]  WITH NOCHECK ADD  CONSTRAINT [sol_userAssociateIdentifications$fk_sol_userAssociateIdentifications_sol_associateIdentificati1] FOREIGN KEY([identificationTypeID])
REFERENCES [solturaDB].[sol_associateIdentificationTypes] ([identificationTypeID])
GO
ALTER TABLE [solturaDB].[sol_userAssociateIdentifications] NOCHECK CONSTRAINT [sol_userAssociateIdentifications$fk_sol_userAssociateIdentifications_sol_associateIdentificati1]
GO
ALTER TABLE [solturaDB].[sol_userAssociateIdentifications]  WITH NOCHECK ADD  CONSTRAINT [sol_userAssociateIdentifications$fk_sol_userAssociateIdentifications_sol_users1] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_userAssociateIdentifications] NOCHECK CONSTRAINT [sol_userAssociateIdentifications$fk_sol_userAssociateIdentifications_sol_users1]
GO
ALTER TABLE [solturaDB].[sol_userPermissions]  WITH NOCHECK ADD  CONSTRAINT [sol_userPermissions$fk_pay_role_permissions_pay_permissions10] FOREIGN KEY([permissionID])
REFERENCES [solturaDB].[sol_permissions] ([permissionID])
GO
ALTER TABLE [solturaDB].[sol_userPermissions] NOCHECK CONSTRAINT [sol_userPermissions$fk_pay_role_permissions_pay_permissions10]
GO
ALTER TABLE [solturaDB].[sol_userPermissions]  WITH NOCHECK ADD  CONSTRAINT [sol_userPermissions$fk_pay_user_permissions_pay_users1] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_userPermissions] NOCHECK CONSTRAINT [sol_userPermissions$fk_pay_user_permissions_pay_users1]
GO
ALTER TABLE [solturaDB].[sol_userPlans]  WITH NOCHECK ADD  CONSTRAINT [sol_userPlans$fk_sol_userPlans_sol_pay_schedules1] FOREIGN KEY([scheduleID])
REFERENCES [solturaDB].[sol_schedules] ([scheduleID])
GO
ALTER TABLE [solturaDB].[sol_userPlans] NOCHECK CONSTRAINT [sol_userPlans$fk_sol_userPlans_sol_pay_schedules1]
GO
ALTER TABLE [solturaDB].[sol_userPlans]  WITH NOCHECK ADD  CONSTRAINT [sol_userPlans$fk_sol_userPlans_sol_planPrices1] FOREIGN KEY([planPriceID])
REFERENCES [solturaDB].[sol_planPrices] ([planPriceID])
GO
ALTER TABLE [solturaDB].[sol_userPlans] NOCHECK CONSTRAINT [sol_userPlans$fk_sol_userPlans_sol_planPrices1]
GO
ALTER TABLE [solturaDB].[sol_userPlans]  WITH NOCHECK ADD  CONSTRAINT [sol_userPlans$fk_sol_userPlans_sol_users1] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_userPlans] NOCHECK CONSTRAINT [sol_userPlans$fk_sol_userPlans_sol_users1]
GO
ALTER TABLE [solturaDB].[sol_userRoles]  WITH NOCHECK ADD  CONSTRAINT [sol_userRoles$fk_pay_users_has_pay_roles_pay_roles1] FOREIGN KEY([role_id])
REFERENCES [solturaDB].[sol_roles] ([roleID])
GO
ALTER TABLE [solturaDB].[sol_userRoles] NOCHECK CONSTRAINT [sol_userRoles$fk_pay_users_has_pay_roles_pay_roles1]
GO
ALTER TABLE [solturaDB].[sol_userRoles]  WITH NOCHECK ADD  CONSTRAINT [sol_userRoles$fk_pay_users_has_pay_roles_pay_users1] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_userRoles] NOCHECK CONSTRAINT [sol_userRoles$fk_pay_users_has_pay_roles_pay_users1]
GO
ALTER TABLE [solturaDB].[sol_usersAdresses]  WITH NOCHECK ADD  CONSTRAINT [sol_usersAdresses$fk_pay_users_adresses_pay_addresses1] FOREIGN KEY([addressID])
REFERENCES [solturaDB].[sol_addresses] ([addressid])
GO
ALTER TABLE [solturaDB].[sol_usersAdresses] NOCHECK CONSTRAINT [sol_usersAdresses$fk_pay_users_adresses_pay_addresses1]
GO
ALTER TABLE [solturaDB].[sol_usersAdresses]  WITH NOCHECK ADD  CONSTRAINT [sol_usersAdresses$fk_pay_users_adresses_pay_users1] FOREIGN KEY([userID])
REFERENCES [solturaDB].[sol_users] ([userID])
GO
ALTER TABLE [solturaDB].[sol_usersAdresses] NOCHECK CONSTRAINT [sol_usersAdresses$fk_pay_users_adresses_pay_users1]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_addresses' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_addresses'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_associateIdentificationTypes' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_associateIdentificationTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_associatePlans' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_associatePlans'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_availablePayMethods' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_availablePayMethods'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_balances' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_balances'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_city' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_city'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_communicationChannels' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_communicationChannels'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_contact_departments' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_contact_departments'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_contact_info' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_contact_info'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_contactType' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_contactType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_countries' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_countries'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_currencies' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_currencies'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_deals' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_deals'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_enterprise_size' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_enterprise_size'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_exchangeCurrencies' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_exchangeCurrencies'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_featureAvailableLocations' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_featureAvailableLocations'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_featurePrices' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_featurePrices'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_featuresPerPlans' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_featuresPerPlans'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_featureTypes' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_featureTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_languages' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_languages'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_logs' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_logs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_logSources' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_logSources'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_logsSererity' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_logsSererity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_logTypes' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_logTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_mediaFile' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_mediaFile'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_mediaTypes' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_mediaTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_modules' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_modules'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_notificationConfigurations' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_notificationConfigurations'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_notifications' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_notifications'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_notificationTypes' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_notificationTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_partner_addresses' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_partner_addresses'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_partners' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_partners'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_partners_identifications_types' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_partners_identifications_types'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_payments' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_payments'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_payMethod' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_payMethod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_permissions' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_permissions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_planFeatures' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_planFeatures'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_planPrices' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_planPrices'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_plans' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_plans'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_planTransactions' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_planTransactions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_planTransactionTypes' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_planTransactionTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_planTypes' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_planTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_rolePermissions' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_rolePermissions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_roles' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_roles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_schedules' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_schedules'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_schedulesDetails' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_schedulesDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_states' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_states'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_transactions' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_transactions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_transactionSubtypes' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_transactionSubtypes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_transactionTypes' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_transactionTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_translations' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_translations'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_userAssociateIdentifications' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_userAssociateIdentifications'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_userPermissions' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_userPermissions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_userPlans' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_userPlans'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_userRoles' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_userRoles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_users' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_users'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'solturaDB.sol_usersAdresses' , @level0type=N'SCHEMA',@level0name=N'solturaDB', @level1type=N'TABLE',@level1name=N'sol_usersAdresses'
GO
```
---
# Test de la base de datos
## Población de datos
Script Llenado Paises
Inserta todos los datos referentes a países. 
```sql
USE solturaDB
INSERT INTO solturaDB.sol_countries (name)
VALUES
('Costa Rica'),
('Estados Unidos'),
('México'),
('España');
INSERT INTO solturaDB.sol_states (name, countryID)
VALUES
('San José', 1),
('Alajuela', 1),
('Cartago', 1),
('Heredia', 1),
('Guanacaste', 1),
('Puntarenas', 1),
('Limón', 1),
('California', 2),
('Texas', 2),
('Florida', 2),
('Nueva York', 2),
('Ciudad de México', 3),
('Jalisco', 3),
('Nuevo León', 3),
('Madrid', 4),
('Barcelona', 4),
('Valencia', 4);
SET IDENTITY_INSERT solturaDB.sol_city ON;
INSERT INTO solturaDB.sol_city (cityID, stateID, name)
VALUES
(1, 1, 'San José'),
(2, 1, 'Escazú'),
(3, 1, 'Santa Ana'),
(4, 2, 'Alajuela'),
(5, 2, 'Grecia'),
(6, 2, 'San Ramón'),
(7, 8, 'Los Ángeles'),
(8, 8, 'San Francisco'),
(9, 8, 'San Diego'),
(10, 12, 'Ciudad de México'),
(11, 12, 'Coyoacán'),
(12, 12, 'Polanco'),
(13, 15, 'Madrid'),
(14, 15, 'Alcobendas'),
(15, 15, 'Las Rozas');

SET IDENTITY_INSERT solturaDB.sol_city OFF;
SET IDENTITY_INSERT solturaDB.sol_addresses ON;
INSERT INTO solturaDB.sol_addresses (addressid, line1, line2, zipcode, geoposition, cityID)
VALUES
(1, 'Avenida Central', 'Calle 25', '10101', 
 geometry::Point(9.9281, -84.0907, 4326), 1),
(2, 'Centro Comercial Multiplaza', 'Local #45', '10203', 
 geometry::Point(9.9186, -84.1118, 4326), 2),
(3, 'Calle Vieja', 'Frente a la iglesia', '10901', 
 geometry::Point(9.9326, -84.1826, 4326), 3),
(4, 'Hollywood Boulevard 123', 'Sector 5', '90028', 
 geometry::Point(34.1016, -118.3389, 4326), 7),
(5, 'Gran Vía 78', 'Piso 3', '28013', 
 geometry::Point(40.4194, -3.7055, 4326), 13);
SET IDENTITY_INSERT solturaDB.sol_addresses OFF;
INSERT INTO solturaDB.sol_currencies (name, acronym, symbol, countryID)
VALUES
('Colón Costarricense', 'CRC', '₡', 1),
('Dólar Estadounidense', 'USD', '$', 2);
SET IDENTITY_INSERT solturaDB.sol_exchangeCurrencies ON;
INSERT INTO solturaDB.sol_exchangeCurrencies (exchangeCurrencyID, sourceID, destinyID, startDate, endDate, exchange_rate, enabled, currentExchange)
VALUES
(1, 1, 2, '2025-05-01', NULL, 0.0018, 1, 1),
(2, 2, 1, '2025-05-01', NULL, 555.556, 1, 1);
SET IDENTITY_INSERT solturaDB.sol_exchangeCurrencies OFF;
```
Script Llenado Partners
Inserts de los datos relacionado a Partners y a Empresas. 
```sql
USE solturaDB
GO
INSERT INTO solturaDB.sol_partners_identifications_types(name) 
VALUES 
('Jurídico'),
('Cédula'),
('Gobierno')
INSERT INTO solturaDB.sol_enterprise_size (size) 
VALUES 
('Pequeña'),
('Mediana'),
('Grande')
SET IDENTITY_INSERT solturaDB.sol_partners ON;
INSERT INTO solturaDB.sol_partners (partnerId, name, registerDate, state, identificationtypeId, enterpriseSizeid, identification) 
VALUES
(1, 'ElectroProveedores S.A.', GETDATE(), 1, 1, 3, '3-101-205045'),
(2, 'Tienda XYZ Descuentos', GETDATE(), 1, 1, 2, '3-102-456789'),
(3, 'SuperAhorro Limitado', GETDATE(), 1, 1, 2, '3-103-123456'),
(4, 'MegaTienda Cuponera', GETDATE(), 1, 1, 3, '3-104-789123'),
(5, 'Parqueo Seguro VIP', GETDATE(), 1, 1, 2, '3-105-456123'),
(6, 'Cinépolis', GETDATE(), 1, 1, 3, '3-106-321654'),
(7, 'McDonalds', GETDATE(), 1, 1, 2, '3-107-098324');
SET IDENTITY_INSERT solturaDB.sol_partners OFF;
INSERT INTO solturaDB.sol_partner_addresses (partnerId, addressid)
VALUES
(1, 1),  
(2, 2),  
(3, 2),  
(4, 5), 
(5, 3),
(7, 1),
(6, 4);
```
Script Llenado Usuarios
Inserta datos referentes a los usuarios.
```sql
USE solturaDB
GO

CREATE OR ALTER PROCEDURE sp_PopulateUserTables
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
		        SET IDENTITY_INSERT solturaDB.sol_users ON;
        INSERT INTO solturaDB.sol_users (userID, email, firstName, lastName, password, enabled)
        VALUES
        (1, 'admin@soltura.com', 'Admin', 'Sistema', HASHBYTES('SHA2_256', 'Admin123'), 1),
        (2, 'juan.perez@example.com', 'Juan', 'Pérez', HASHBYTES('SHA2_256', 'Clave123'), 1),
        (3, 'maria.gomez@example.com', 'María', 'Gómez', HASHBYTES('SHA2_256', 'Secure456'), 1),
        (4, 'carlos.rodriguez@example.com', 'Carlos', 'Rodríguez', HASHBYTES('SHA2_256', 'Pass789'), 1),
        (5, 'ana.martinez@example.com', 'Ana', 'Martínez', HASHBYTES('SHA2_256', 'Ana2023'), 1),
        (6, 'luis.hdez@example.com', 'Luis', 'Hernández', HASHBYTES('SHA2_256', 'Luis456'), 1),
        (7, 'sofia.castro@example.com', 'Sofía', 'Castro', HASHBYTES('SHA2_256', 'Sofia789'), 1),
        (8, 'pedro.mendoza@example.com', 'Pedro', 'Mendoza', HASHBYTES('SHA2_256', 'Pedro123'), 1),
        (9, 'laura.gutierrez@example.com', 'Laura', 'Gutiérrez', HASHBYTES('SHA2_256', 'Laura456'), 1),
        (10, 'diego.ramirez@example.com', 'Diego', 'Ramírez', HASHBYTES('SHA2_256', 'Diego789'), 1),
        (11, 'elena.sanchez@example.com', 'Elena', 'Sánchez', HASHBYTES('SHA2_256', 'Elena123'), 1),
        (12, 'javier.lopez@example.com', 'Javier', 'López', HASHBYTES('SHA2_256', 'Javier456'), 1),
        (13, 'isabel.garcia@example.com', 'Isabel', 'García', HASHBYTES('SHA2_256', 'Isabel789'), 1),
        (14, 'miguel.torres@example.com', 'Miguel', 'Torres', HASHBYTES('SHA2_256', 'Miguel123'), 1),
        (15, 'carmen.ortiz@example.com', 'Carmen', 'Ortiz', HASHBYTES('SHA2_256', 'Carmen456'), 1),
        (16, 'raul.morales@example.com', 'Raúl', 'Morales', HASHBYTES('SHA2_256', 'Raul789'), 1),
        (17, 'patricia.vargas@example.com', 'Patricia', 'Vargas', HASHBYTES('SHA2_256', 'Patricia123'), 1),
        (18, 'oscar.diaz@example.com', 'Oscar', 'Díaz', HASHBYTES('SHA2_256', 'Oscar456'), 1),
        (19, 'adriana.ruiz@example.com', 'Adriana', 'Ruiz', HASHBYTES('SHA2_256', 'Adriana789'), 1),
        (20, 'fernando.molina@example.com', 'Fernando', 'Molina', HASHBYTES('SHA2_256', 'Fernando123'), 1),
        (21, 'gabriela.silva@example.com', 'Gabriela', 'Silva', HASHBYTES('SHA2_256', 'Gabriela456'), 1),
        (22, 'arturo.cruz@example.com', 'Arturo', 'Cruz', HASHBYTES('SHA2_256', 'Arturo789'), 1),
        (23, 'claudia.reyes@example.com', 'Claudia', 'Reyes', HASHBYTES('SHA2_256', 'Claudia123'), 1),
        (24, 'manuel.aguilar@example.com', 'Manuel', 'Aguilar', HASHBYTES('SHA2_256', 'Manuel456'), 1),
        (25, 'diana.flores@example.com', 'Diana', 'Flores', HASHBYTES('SHA2_256', 'Diana789'), 1),
        (26, 'roberto.campos@example.com', 'Roberto', 'Campos', HASHBYTES('SHA2_256', 'Roberto123'), 1),
        (27, 'silvia.mendez@example.com', 'Silvia', 'Méndez', HASHBYTES('SHA2_256', 'Silvia456'), 1),
        (28, 'eduardo.guerra@example.com', 'Eduardo', 'Guerra', HASHBYTES('SHA2_256', 'Eduardo789'), 1),
        (29, 'lucia.sosa@example.com', 'Lucía', 'Sosa', HASHBYTES('SHA2_256', 'Lucia123'), 1),
        (30, 'hugo.rios@example.com', 'Hugo', 'Ríos', HASHBYTES('SHA2_256', 'Hugo456'), 1);
        SET IDENTITY_INSERT solturaDB.sol_users OFF;

		SET IDENTITY_INSERT solturaDB.sol_associateIdentificationTypes ON;
		INSERT INTO solturaDB.sol_associateIdentificationTypes (identificationTypeID, description, datatype) VALUES
		(1, 'NFC Tag - Formato estándar', 'Binario'),
		(2, 'NFC Tag - Formato personalizado', 'Binario'),
		(3, 'Código QR - Versión 1', 'Texto'),
		(4, 'Código QR - Versión 2 con logo', 'Texto'),
		(5, 'Código QR Dinámico', 'URL'),
		(6, 'NFC HCE (Host Card Emulation)', 'Binario'),
		(7, 'Código QR de un solo uso', 'Texto encriptado'),
		(8, 'NFC con autenticación biométrica', 'Binario seguro');
		SET IDENTITY_INSERT solturaDB.sol_associateIdentificationTypes OFF;


		SET IDENTITY_INSERT solturaDB.sol_planTypes ON;
		INSERT INTO solturaDB.sol_planTypes (planTypeID, type, userID) VALUES
		(1, 'Básico', NULL),
		(2, 'Premium', NULL),
		(3, 'Empresarial', NULL),
		(4, 'Familiar', NULL),
		(5, 'Estudiantil', NULL),
		(6, 'Personalizado', NULL),
		(7, 'Promocional', NULL),
		(8, 'Metales (Gold/Plata/Bronce)', NULL),
		(9, 'Prueba Gratis', NULL),
		(10, 'Corporativo', NULL),
		(11, 'Gobierno', NULL),
		(12, 'ONG', NULL),
		(13, 'Emergencia', NULL),
		(14, 'Temporada', NULL),
		(15, 'Personal Plus', NULL);
		SET IDENTITY_INSERT solturaDB.sol_planTypes OFF;
		

		SET IDENTITY_INSERT solturaDB.sol_plans ON;
		INSERT INTO solturaDB.sol_plans (planID, description, planTypeID) VALUES 
		(1, 'Plan Básico Mensual', 1),
		(2, 'Plan Básico Anual', 1),
		(3, 'Plan Premium Mensual', 2),
		(4, 'Plan Premium Anual', 2),
		(5, 'Plan Empresarial Básico', 3),
		(6, 'Plan Empresarial Avanzado', 3),
		(7, 'Plan Familiar', 4),
		(8, 'Plan Estudiantil', 5),
		(9, 'Plan Personalizado', 6),
		(10, 'Plan Promocional Temporada', 7),
		(11, 'Plan Gold - Acceso Total', 8),
		(12, 'Plan Plata - Funcionalidades Limitadas', 8),
		(13, 'Plan Bronce - Básico', 8),
		(14, 'Plan Prueba 15 días', 9),
		(15, 'Plan Corporativo Multisede', 10),
		(16, 'Plan Gobierno', 11),
		(17, 'Plan ONG', 12),
		(18, 'Plan Emergencia', 13),
		(19, 'Plan Temporada Baja', 14),
		(20, 'Plan Personal Plus', 15),
		(21, 'Joven Deportista', 5),  
		(22, 'Familia de Verano', 4), 
		(23, 'Viajero Frecuente', 6), 
		(24, 'Nómada Digital', 6);    
		SET IDENTITY_INSERT solturaDB.sol_plans OFF;

		SET IDENTITY_INSERT solturaDB.sol_planPrices ON;
		INSERT INTO solturaDB.sol_planPrices (planPriceID,planID,amount,currency_id,postTime,endDate,"current")
		VALUES
		(1, 1, 20000.00, 1, GETDATE(), '2023-12-31', 1),
		(2, 2, 35000.00, 1, GETDATE(), '2023-12-31', 1),
		(3, 3, 50.00, 2, GETDATE(), '2023-12-31', 1),
		(4, 4, 35.00, 2, GETDATE(), '2023-12-31', 0),
		(5, 5, 60.00, 2, GETDATE(), '2023-12-31', 0);
		SET IDENTITY_INSERT solturaDB.sol_planPrices OFF;

		SET IDENTITY_INSERT solturaDB.sol_schedules ON;
        INSERT INTO solturaDB.sol_schedules (scheduleID,name,repit,repetitions,recurrencyType,endDate,startDate)
        VALUES
        (1, 'Ejecución Diaria', 1, 0, 1, NULL, '2023-01-01'),
        (2, 'Ejecución Semanal', 1, 12, 2, DATEADD(MONTH, 3, GETDATE()), '2023-01-01'),
        (3, 'Ejecución Mensual', 1, 12, 3, DATEADD(YEAR, 1, GETDATE()), '2023-01-01'),
        (4, 'Ejecución Anual', 1, 0, 5, NULL, '2023-01-01');
        SET IDENTITY_INSERT solturaDB.sol_schedules OFF;

        SET IDENTITY_INSERT solturaDB.sol_schedulesDetails ON;
        INSERT INTO solturaDB.sol_schedulesDetails (schedulesDetailsID,deleted,schedule_id,baseDate,datePart,lastExecute,nextExecute,description,detail)
        VALUES
        (1, 0, 1, '2023-01-01', CONVERT(date, GETDATE()), 
            DATEADD(DAY, -1, GETDATE()), GETDATE(), 
            'Ejecución diaria del sistema', 'Procesamiento nocturno'),
        (2, 0, 2, '2023-01-01', CONVERT(date, DATEADD(DAY, 7-DATEPART(WEEKDAY, GETDATE()), GETDATE())), 
            DATEADD(WEEK, -1, GETDATE()), DATEADD(WEEK, 1, GETDATE()), 
            'Ejecución semanal de reportes', 'Generación de reportes semanales'),
        (3, 0, 3, '2023-01-01', CONVERT(date, DATEADD(DAY, -DAY(GETDATE())+1, GETDATE())), 
            DATEADD(MONTH, -1, GETDATE()), DATEADD(MONTH, 1, GETDATE()), 
            'Cierre mensual contable', 'Proceso de cierre contable'),
        (4, 0, 4, '2023-01-01', DATEFROMPARTS(YEAR(GETDATE()), 1, 1), 
            DATEADD(YEAR, -1, GETDATE()), DATEADD(YEAR, 1, GETDATE()), 
            'Mantenimiento anual', 'Actualización general del sistema');
        SET IDENTITY_INSERT solturaDB.sol_schedulesDetails OFF;


        SET IDENTITY_INSERT solturaDB.sol_roles ON;
        INSERT INTO solturaDB.sol_roles (roleID, roleName)
        VALUES
        (1, 'Administrador'),
        (2, 'Usuario Estándar'),
        (3, 'Usuario Premium'),
        (4, 'Soporte Técnico'),
        (5, 'Gestor de Contenidos');
        SET IDENTITY_INSERT solturaDB.sol_roles OFF;

        SET IDENTITY_INSERT solturaDB.sol_modules ON;
        INSERT INTO solturaDB.sol_modules (moduleID, name)
        VALUES
        (1, 'Dashboard'),
        (2, 'Usuarios'),
        (3, 'Planes'),
        (4, 'Reportes'),
        (5, 'Configuración');
        SET IDENTITY_INSERT solturaDB.sol_modules OFF;

        SET IDENTITY_INSERT solturaDB.sol_permissions ON;
        INSERT INTO solturaDB.sol_permissions (permissionID, description, code, moduleID)
        VALUES
        (1, 'Acceso completo', 'All', 1),
        (2, 'Ver dashboard', 'DashView', 1),
        (3, 'Crear usuarios', 'UserCreate', 2),
        (4, 'Editar usuarios', 'UserEdit', 2),
        (5, 'Eliminar usuarios', 'UserDelete', 2),
        (6, 'Administrar planes', 'PlanManage', 3),
        (7, 'Generar reportes', 'ReportGen', 4),
        (8, 'Configuración sistema', 'ConfigEdit', 5);
        SET IDENTITY_INSERT solturaDB.sol_permissions OFF;

        SET IDENTITY_INSERT solturaDB.sol_rolePermissions ON;
        INSERT INTO solturaDB.sol_rolePermissions (rolePermissionID, roleID, permissionID, enabled, deleted, lastPermUpdate, username, checksum)
        VALUES
        (1, 1, 1, 1, 0, GETDATE(), 'system', HASHBYTES('SHA2_256', 'roleperm1')),
        (2, 2, 2, 1, 0, GETDATE(), 'system', HASHBYTES('SHA2_256', 'roleperm2')),
        (3, 3, 2, 1, 0, GETDATE(), 'system', HASHBYTES('SHA2_256', 'roleperm3')),
        (4, 3, 6, 1, 0, GETDATE(), 'system', HASHBYTES('SHA2_256', 'roleperm4')),
        (5, 4, 2, 1, 0, GETDATE(), 'system', HASHBYTES('SHA2_256', 'roleperm5')), 
        (6, 4, 3, 1, 0, GETDATE(), 'system', HASHBYTES('SHA2_256', 'roleperm6')),
        (7, 4, 4, 1, 0, GETDATE(), 'system', HASHBYTES('SHA2_256', 'roleperm7')),
        (8, 5, 2, 1, 0, GETDATE(), 'system', HASHBYTES('SHA2_256', 'roleperm8')), 
        (9, 5, 7, 1, 0, GETDATE(), 'system', HASHBYTES('SHA2_256', 'roleperm9')); 
        SET IDENTITY_INSERT solturaDB.sol_rolePermissions OFF;

        SET IDENTITY_INSERT solturaDB.sol_userRoles ON;
        INSERT INTO solturaDB.sol_userRoles (userID, role_id, enabled, deleted, lastUpdate, username, checksum)
        VALUES
        (1, 1, 1, 0, GETDATE(), 'admin', HASHBYTES('SHA2_256', 'admin_role')),
        (2, 2, 1, 0, GETDATE(), 'juan.perez', HASHBYTES('SHA2_256', 'user_role')),
        (3, 3, 1, 0, GETDATE(), 'maria.gomez', HASHBYTES('SHA2_256', 'prem_role')),
        (4, 4, 1, 0, GETDATE(), 'carlos.rod', HASHBYTES('SHA2_256', 'support_role')),
        (5, 5, 1, 0, GETDATE(), 'ana.mtz', HASHBYTES('SHA2_256', 'content_role')),
        (6, 2, 1, 0, GETDATE(), 'luis.hdez', HASHBYTES('SHA2_256', 'user_role')),
        (7, 3, 1, 0, GETDATE(), 'sofia.castro', HASHBYTES('SHA2_256', 'prem_role')),
        (8, 2, 1, 0, GETDATE(), 'pedro.mendoza', HASHBYTES('SHA2_256', 'user_role')),
        (9, 3, 1, 0, GETDATE(), 'laura.gutierrez', HASHBYTES('SHA2_256', 'prem_role')),
        (10, 2, 1, 0, GETDATE(), 'diego.ramirez', HASHBYTES('SHA2_256', 'user_role')),
        (11, 3, 1, 0, GETDATE(), 'elena.sanchez', HASHBYTES('SHA2_256', 'prem_role')),
        (12, 2, 1, 0, GETDATE(), 'javier.lopez', HASHBYTES('SHA2_256', 'user_role')),
        (13, 3, 1, 0, GETDATE(), 'isabel.garcia', HASHBYTES('SHA2_256', 'prem_role')),
        (14, 2, 1, 0, GETDATE(), 'miguel.torres', HASHBYTES('SHA2_256', 'user_role')),
        (15, 3, 1, 0, GETDATE(), 'carmen.ortiz', HASHBYTES('SHA2_256', 'prem_role')),
        (16, 2, 1, 0, GETDATE(), 'raul.morales', HASHBYTES('SHA2_256', 'user_role')),
        (17, 3, 1, 0, GETDATE(), 'patricia.vargas', HASHBYTES('SHA2_256', 'prem_role')),
        (18, 2, 1, 0, GETDATE(), 'oscar.diaz', HASHBYTES('SHA2_256', 'user_role')),
        (19, 3, 1, 0, GETDATE(), 'adriana.ruiz', HASHBYTES('SHA2_256', 'prem_role')),
        (20, 2, 1, 0, GETDATE(), 'fernando.molina', HASHBYTES('SHA2_256', 'user_role')),
        (21, 3, 1, 0, GETDATE(), 'gabriela.silva', HASHBYTES('SHA2_256', 'prem_role')),
        (22, 2, 1, 0, GETDATE(), 'arturo.cruz', HASHBYTES('SHA2_256', 'user_role')),
        (23, 3, 1, 0, GETDATE(), 'claudia.reyes', HASHBYTES('SHA2_256', 'prem_role')),
        (24, 2, 1, 0, GETDATE(), 'manuel.aguilar', HASHBYTES('SHA2_256', 'user_role')),
        (25, 3, 1, 0, GETDATE(), 'diana.flores', HASHBYTES('SHA2_256', 'prem_role')),
        (26, 2, 1, 0, GETDATE(), 'roberto.campos', HASHBYTES('SHA2_256', 'user_role')),
        (27, 2, 1, 0, GETDATE(), 'silvia.mendez', HASHBYTES('SHA2_256', 'user_role')),
        (28, 2, 1, 0, GETDATE(), 'eduardo.guerra', HASHBYTES('SHA2_256', 'user_role')),
        (29, 2, 1, 0, GETDATE(), 'lucia.sosa', HASHBYTES('SHA2_256', 'user_role')),
        (30, 2, 1, 0, GETDATE(), 'hugo.rios', HASHBYTES('SHA2_256', 'user_role'));
        SET IDENTITY_INSERT solturaDB.sol_userRoles OFF;

        SET IDENTITY_INSERT solturaDB.sol_usersAdresses ON;
        INSERT INTO solturaDB.sol_usersAdresses(userAddressID, userID, addressID, enabled)
        VALUES
        (1, 1, 1, 1),
        (2, 2, 2, 1),
        (3, 3, 3, 1),
        (4, 4, 4, 1),
        (5, 5, 5, 1),
        (6, 6, 1, 1),
        (7, 7, 2, 1),
        (8, 8, 3, 1),
        (9, 9, 4, 1),
        (10, 10, 5, 1),
        (11, 11, 1, 1),
        (12, 12, 2, 1),
        (13, 13, 3, 1),
        (14, 14, 4, 1),
        (15, 15, 5, 1),
        (16, 16, 1, 1),
        (17, 17, 2, 1),
        (18, 18, 3, 1),
        (19, 19, 4, 1),
        (20, 20, 5, 1),
        (21, 21, 1, 1),
        (22, 22, 2, 1),
        (23, 23, 3, 1),
        (24, 24, 4, 1),
        (25, 25, 5, 1),
        (26, 26, 1, 1),
        (27, 27, 2, 1),
        (28, 28, 3, 1),
        (29, 29, 4, 1),
        (30, 30, 5, 1);
        SET IDENTITY_INSERT solturaDB.sol_usersAdresses OFF;

        SET IDENTITY_INSERT solturaDB.sol_userPlans ON;
        INSERT INTO solturaDB.sol_userPlans (userPlanID, userID, planPriceID, scheduleID, adquisition, enabled)
        VALUES
        (1, 1, 1, 1, '2023-01-01', 1),
        (2, 2, 2, 1, '2023-02-15', 1),
        (3, 3, 2, 2, '2023-03-10', 1),
        (4, 4, 3, 3, '2023-04-20', 1),
        (5, 5, 3, 3, '2023-05-05', 1),
        (6, 6, 1, 1, '2023-01-15', 1),
        (7, 7, 2, 1, '2023-02-20', 1),
        (8, 8, 2, 2, '2023-03-25', 1),
        (9, 9, 3, 3, '2023-04-10', 1),
        (10, 10, 3, 3, '2023-05-15', 1),
        (11, 11, 1, 1, '2023-01-20', 1),
        (12, 12, 2, 1, '2023-02-25', 1),
        (13, 13, 2, 2, '2023-03-30', 1),
        (14, 14, 3, 3, '2023-04-05', 1),
        (15, 15, 3, 3, '2023-05-10', 1),
        (16, 16, 1, 1, '2023-01-25', 1),
        (17, 17, 2, 1, '2023-02-28', 1),
        (18, 18, 2, 2, '2023-03-05', 1),
        (19, 19, 3, 3, '2023-04-15', 1),
        (20, 20, 3, 3, '2023-05-20', 1),
        (21, 21, 1, 1, '2023-01-30', 1),
        (22, 22, 2, 1, '2023-02-05', 1),
        (23, 23, 2, 2, '2023-03-15', 1),
        (24, 24, 3, 3, '2023-04-25', 1),
        (25, 25, 3, 3, '2023-05-30', 1),
		(26, 26, 1, 1, '2023-06-01', 1),
		(27, 27, 1, 1, '2023-06-05', 1),
		(28, 28, 1, 1, '2023-06-10', 1),
		(29, 29, 2, 2, '2023-06-15', 1),
		(30, 30, 2, 2, '2023-06-20', 1);
        SET IDENTITY_INSERT solturaDB.sol_userPlans OFF;

        SET IDENTITY_INSERT solturaDB.sol_userPermissions ON;
        INSERT INTO solturaDB.sol_userPermissions (userPermissionID, permissionID, enabled, deleted, lastPermUpdate, username, checksum, userID)
        VALUES
        (1, 1, 1, 0, GETDATE(), 'admin', HASHBYTES('SHA2_256', 'perm_admin'), 1),
        (2, 2, 1, 0, GETDATE(), 'juan.perez', HASHBYTES('SHA2_256', 'perm_user'), 2),
        (3, 2, 1, 0, GETDATE(), 'maria.gomez', HASHBYTES('SHA2_256', 'perm_user'), 3),
        (4, 3, 1, 0, GETDATE(), 'carlos.rod', HASHBYTES('SHA2_256', 'perm_prem'), 4),
        (5, 3, 1, 0, GETDATE(), 'ana.mtz', HASHBYTES('SHA2_256', 'perm_prem'), 5);
        SET IDENTITY_INSERT solturaDB.sol_userPermissions OFF;
		SET IDENTITY_INSERT solturaDB.sol_userPermissions ON;
        INSERT INTO solturaDB.sol_userPermissions (
            userPermissionID, permissionID, enabled, deleted, lastPermUpdate, username, checksum, userID
        )
        SELECT 
            ROW_NUMBER() OVER (ORDER BY u.userID) + 5 AS userPermissionID, -- Continuando desde el ID 6
            CASE 
                WHEN u.userID = 1 THEN 1 
                WHEN u.userID % 3 = 0 THEN 3
                ELSE 2 
            END AS permissionID,
            1 AS enabled,
            0 AS deleted,
            GETDATE() AS lastPermUpdate,
            LEFT(u.email, CHARINDEX('@', u.email) - 1) AS username,
            HASHBYTES('SHA2_256', 'perm_' + CAST(u.userID AS VARCHAR)) AS checksum,
            u.userID
        FROM solturaDB.sol_users u
        WHERE u.userID > 5; 
        SET IDENTITY_INSERT solturaDB.sol_userPermissions OFF;

		ALTER TABLE solturaDB.sol_userAssociateIdentifications
		ALTER COLUMN token VARBINARY(MAX) NOT NULL;

        OPEN SYMMETRIC KEY SolturaLlaveSimetrica  
		DECRYPTION BY CERTIFICATE CertificadoDeCifrado;

		INSERT INTO solturaDB.sol_userAssociateIdentifications(associateID, token, userID, identificationTypeID)
		VALUES
		(1, EncryptByKey(Key_GUID('SolturaLlaveSimetrica'), CONVERT(varchar, 'NFC_TAG_STD_001')), 1, 1),
		(2, EncryptByKey(Key_GUID('SolturaLlaveSimetrica'), CONVERT(varchar, 'NFC_TAG_CUSTOM_002')), 2, 2),
		(3, EncryptByKey(Key_GUID('SolturaLlaveSimetrica'), CONVERT(varchar, 'QR_V1_ABC123')), 3, 3),
		(4, EncryptByKey(Key_GUID('SolturaLlaveSimetrica'), CONVERT(varchar, 'QR_V2_LOGO_DEF456')), 4, 4),
		(5, EncryptByKey(Key_GUID('SolturaLlaveSimetrica'), CONVERT(varchar, 'DYN_QR_789URL')), 5, 5);

		INSERT INTO solturaDB.sol_userAssociateIdentifications (associateID, token, userID, identificationTypeID)
		SELECT 
			ROW_NUMBER() OVER (ORDER BY u.userID) + 5 AS associateID,
			EncryptByKey(Key_GUID('SolturaLlaveSimetrica'), 
				CONVERT(varchar,
					CASE 
						WHEN u.userID % 2 = 0 THEN 'NFC_STD_UID_' + CAST(u.userID AS varchar)
						ELSE 'QR_V1_TOKEN_' + CAST(u.userID AS varchar)
					END
				)
			) AS token,
			u.userID,
			CASE 
				WHEN u.userID % 2 = 0 THEN 1  -- NFC Tag - Formato estándar
				ELSE 3                        -- Código QR - Versión 1
			END AS identificationTypeID
		FROM solturaDB.sol_users u
		WHERE u.userID > 5;

CLOSE SYMMETRIC KEY SolturaLlaveSimetrica;
               COMMIT TRANSACTION;
        PRINT 'Tablas de usuarios pobladas exitosamente';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error al poblar tablas de usuarios: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
delete from solturaDB.sol_availablePayMethods 
EXEC sp_PopulateUserTables;
```
Script Llenado Logs
Insertar datos referentes a los logs, sobretodo preparando los logs para el trigger hecho más adelante.
```sql
USE solturaDB;
GO
INSERT INTO solturaDB.sol_logSources ( name)
VALUES 
    ('PaymentSystem'),
    ( 'UserManagement'), 
    ( 'Subscription'),
    ( 'API'),  
    ( 'Database'),  
    ( 'Scheduler'), 
    ( 'MobileApp'),   
    ( 'WebPortal'); 


INSERT INTO solturaDB.sol_logTypes (
    name, 
    reference1Description, 
    reference2Description, 
    value1Description, 
    value2Description
)
VALUES 
    ( 'Payment', 'PaymentID', 'UserID', 'Amount', 'PaymentMethod'), 
    ( 'User', 'UserID', 'RoleID', 'Action', 'Details'),   
    ( 'Subscription', 'PlanID', 'UserID', 'OldPlan', 'NewPlan'),  
    ( 'Error', 'ErrorCode', 'LineNumber', 'Message', 'Context'), 
    ( 'Audit', 'EntityID', 'ModifiedBy', 'FieldChanged', 'NewValue'),
    ( 'Security', 'UserID', 'IPAddress', 'Action', 'Status'), 
    ( 'APIRequest', 'Endpoint', 'Status', 'Parameters', 'Response'), 
    ( 'Maintenance', 'TaskID', 'Duration', 'Details', 'Result');  

INSERT INTO solturaDB.sol_logsSererity ( name)
VALUES 
    ( 'Info'),
    ( 'Warning'), 
    ( 'Error'), 
    ( 'Critical'), 
    ( 'Debug');  

ALTER TABLE solturaDB.sol_logs
ALTER COLUMN computer NVARCHAR(75) NULL;
ALTER TABLE solturaDB.sol_logs
ALTER COLUMN trace NVARCHAR(100) NULL;
ALTER TABLE solturaDB.sol_logs
ALTER COLUMN checksum varbinary(250) NULL;
GO
```

Script Llenado Payments
Inserts relacionados a los payments, y a los features
```sql
USE solturaDB
GO
BEGIN TRY
    BEGIN TRANSACTION;
    
    DECLARE @constraintName NVARCHAR(128);
    
    SELECT @constraintName = name
    FROM sys.key_constraints
    WHERE parent_object_id = OBJECT_ID('solturaDB.sol_payments')
    AND type = 'UQ';
    
    IF @constraintName IS NOT NULL
    BEGIN
        DECLARE @sql NVARCHAR(MAX) = N'ALTER TABLE solturaDB.sol_payments DROP CONSTRAINT [' + @constraintName + ']';
        EXEC sp_executesql @sql;
        
        PRINT 'Restricción UNIQUE eliminada: ' + @constraintName;
    END
    ELSE
    BEGIN
        PRINT 'No se encontró ninguna restricción UNIQUE en sol_payments.methodID';
    END
    
    COMMIT TRANSACTION;
    PRINT 'Operación completada exitosamente';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error al eliminar la restricción UNIQUE: ' + ERROR_MESSAGE();
END CATCH
GO

CREATE OR ALTER PROCEDURE sp_PopulateTables
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
	
		INSERT INTO solturaDB.sol_payMethod (payMethodID, name, apiURL, secretKey, [key], logoIconURL, enabled)
		VALUES
		(1, 'Tarjeta de Crédito', 'https://api.payments.com/creditcard', 
		 CAST('AES_Encrypted_Key_123' AS VARBINARY(255)), 
		 'pk_live_123456789', '/assets/icons/credit-card.png', 1),
    
		(2, 'Transferencia Bancaria', 'https://api.payments.com/banktransfer', 
		 CAST('AES_Encrypted_Key_456' AS VARBINARY(255)), 
		 'pk_live_987654321', '/assets/icons/bank-transfer.png', 1),
    
		(3, 'PayPal', 'https://api.payments.com/paypal', 
		 CAST('AES_Encrypted_Key_789' AS VARBINARY(255)), 
		 'pk_live_567891234', '/assets/icons/paypal.png', 1),
    
		(4, 'Sinpe Móvil', 'https://api.payments.com/sinpe', 
		 CAST('AES_Encrypted_Key_321' AS VARBINARY(255)), 
		 'pk_live_432187654', '/assets/icons/mobile-payment.png', 1),
    
		(5, 'Efectivo', 'https://api.payments.com/cash', 
		 CAST('AES_Encrypted_Key_654' AS VARBINARY(255)), 
		 'pk_live_876543219', '/assets/icons/cash.png', 1);


		SET IDENTITY_INSERT solturaDB.sol_availablePayMethods ON;
		INSERT INTO solturaDB.sol_availablePayMethods (available_method_id, name, userID, token, expToken, 
														maskAccount, methodID)
		VALUES
		(1, 'VISA Platinum ****1234', 1, 'tok_visa_1234', DATEADD(YEAR, 4, GETDATE()), '****-****-****-1234', 1),
		(2, 'Cuenta BAC Credomatic', 1, 'tok_bac_5678', DATEADD(YEAR, 6, GETDATE()), '****5678 (BAC)', 2),
		(3, 'PayPal Premium', 2, 'tok_paypal_9012', DATEADD(YEAR, 3, GETDATE()), 'pp_juan', 3),
		(4, 'Mastercard Gold ****4321', 3, 'tok_mc_4321', DATEADD(YEAR, 5, GETDATE()), '****-****-****-4321', 1),
		(5, 'Sinpe Móvil BAC', 3, 'tok_sinpe_8765', DATEADD(YEAR, 12, GETDATE()), '8888-8888 (SINPE)', 4),
		(6, 'Efectivo en Sucursal', 4, 'tok_cash_0000', DATEADD(YEAR, 50, GETDATE()), 'EFECTIVO-001', 5),
		(7, 'VISA Infinite ****1111', 5, 'tok_visa_1111', DATEADD(YEAR, 4, GETDATE()), '****-****-****-1111', 1),
		(8, 'Mastercard Black ****2222', 6, 'tok_mc_2222', DATEADD(YEAR, 5, GETDATE()), '****-****-****-2222', 1),
		(9, 'PayPal Business', 7, 'tok_paypal_biz', DATEADD(YEAR, 3, GETDATE()), 'pp_sofia', 3),
		(10, 'Cuenta BCR', 8, 'tok_bcr_3333', DATEADD(YEAR, 7, GETDATE()), '****3333 (BCR)', 2),
		(11, 'Sinpe Móvil BCR', 9, 'tok_sinpe_bcr', DATEADD(YEAR, 10, GETDATE()), '7777-7777', 4),
		(12, 'Efectivo Express', 10, 'tok_cash_exp', DATEADD(YEAR, 2, GETDATE()), 'EFECTIVO-002', 5),
		(13, 'VISA Signature ****4444', 11, 'tok_visa_4444', DATEADD(YEAR, 4, GETDATE()), '****-****-****-4444', 1),
		(14, 'Mastercard Platinum ****5555', 12, 'tok_mc_5555', DATEADD(YEAR, 5, GETDATE()), '****-****-****-5555', 1),
		(15, 'PayPal Personal', 13, 'tok_paypal_per', DATEADD(YEAR, 3, GETDATE()), 'pp_isabel', 3),
		(16, 'Cuenta Scotiabank', 14, 'tok_scotia_666', DATEADD(YEAR, 6, GETDATE()), '****6666 (Scotia)', 2),
		(17, 'Sinpe Móvil BN', 15, 'tok_sinpe_bn', DATEADD(YEAR, 8, GETDATE()), '6666-6666', 4),
		(18, 'Efectivo VIP', 16, 'tok_cash_vip', DATEADD(YEAR, 3, GETDATE()), 'EFECTIVO-VIP', 5),
		(19, 'VISA Classic ****7777', 17, 'tok_visa_7777', DATEADD(YEAR, 3, GETDATE()), '****-****-****-7777', 1),
		(20, 'Mastercard Standard ****8888', 18, 'tok_mc_8888', DATEADD(YEAR, 4, GETDATE()), '****-****-****-8888', 1),
		(21, 'PayPal Family', 19, 'tok_paypal_fam', DATEADD(YEAR, 2, GETDATE()), 'pp_adriana', 3),
		(22, 'Cuenta Popular', 20, 'tok_popular_999', DATEADD(YEAR, 5, GETDATE()), '****9999 (Popular)', 2),
		(23, 'Sinpe Móvil Popular', 21, 'tok_sinpe_pop', DATEADD(YEAR, 7, GETDATE()), '9999-9999', 4),
		(24, 'Efectivo Rápido', 22, 'tok_cash_fast', DATEADD(YEAR, 1, GETDATE()), 'EFECTIVO-FAST', 5),
		(25, 'VISA Oro ****0000', 23, 'tok_visa_0000', DATEADD(YEAR, 3, GETDATE()), '****-****-****-0000', 1),
		(26, 'Mastercard Oro ****1111', 24, 'tok_mc_1111', DATEADD(YEAR, 4, GETDATE()), '****-****-****-1111', 1),
		(27, 'PayPal Student', 25, 'tok_paypal_std', DATEADD(YEAR, 2, GETDATE()), 'pp_diana', 3),
		(28, 'Cuenta Nacional', 26, 'tok_nacional_222', DATEADD(YEAR, 5, GETDATE()), '****2222 (Nacional)', 2),
		(29, 'Sinpe Móvil Nacional', 27, 'tok_sinpe_nac', DATEADD(YEAR, 6, GETDATE()), '2222-2222', 4),
		(30, 'Efectivo Standard', 28, 'tok_cash_std', DATEADD(YEAR, 2, GETDATE()), 'EFECTIVO-STD', 5);
		SET IDENTITY_INSERT solturaDB.sol_availablePayMethods OFF;
    
		SET IDENTITY_INSERT solturaDB.sol_payments ON;
		INSERT INTO solturaDB.sol_payments (paymentID, availableMethodID, currency_id, amount, date_pay, confirmed, 
		result, auth, [reference], charge_token,[description], error, checksum, methodID)
		VALUES
		(1, 1, 1, 15000.00, GETDATE(), 1, 'Aprobado', 'AUTH123', 'REF-1001', 
		 CAST('charge_tok_123' AS VARBINARY(255)), 'Pago membresía básica', NULL, 
		 CAST('checksum_123' AS VARBINARY(250)), 1),
		(2, 3, 2, 50.00, DATEADD(DAY, -5, GETDATE()), 1, 'Completado', 'AUTH456', 'REF-1002', 
		 CAST('charge_tok_456' AS VARBINARY(255)), 'Pago membresía premium', NULL, 
		 CAST('checksum_456' AS VARBINARY(250)), 3),
		(3, 4, 1, 20000.00, DATEADD(DAY, -2, GETDATE()), 0, 'Procesando', 'AUTH789', 'REF-1003', 
		 CAST('charge_tok_789' AS VARBINARY(255)), 'Pago anual', NULL, 
		 CAST('checksum_789' AS VARBINARY(250)), 4),
		(4, 2, 1, 10000.00, DATEADD(DAY, -7, GETDATE()), 0, 'Rechazado', 'AUTH321', 'REF-1004', 
		 CAST('charge_tok_321' AS VARBINARY(255)), 'Pago servicios adicionales', 'Fondos insuficientes', 
		 CAST('checksum_321' AS VARBINARY(250)), 2),
		(5, 6, 1, 5000.00, DATEADD(DAY, -1, GETDATE()), 1, 'Completado', 'AUTH654', 'REF-1005', 
		 CAST('charge_tok_654' AS VARBINARY(255)), 'Pago en oficina', NULL, 
		 CAST('checksum_654' AS VARBINARY(250)), 5),
		 (6, 7, 2, 75.00, DATEADD(DAY, -10, GETDATE()), 1, 'Aprobado', 'AUTH202', 'REF-1006', 
		 CAST('charge_tok_202' AS VARBINARY(255)), 'Pago corporativo', NULL, 
		 CAST('checksum_202' AS VARBINARY(250)), 1),
    
		(7, 8, 1, 22000.00, DATEADD(DAY, -7, GETDATE()), 1, 'Completado', 'AUTH303', 'REF-1007', 
		 CAST('charge_tok_303' AS VARBINARY(255)), 'Pago anual premium', NULL, 
		 CAST('checksum_303' AS VARBINARY(250)), 1),
    
		(8, 9, 1, 12000.00, DATEADD(DAY, -4, GETDATE()), 1, 'Aprobado', 'AUTH404', 'REF-1008', 
		 CAST('charge_tok_404' AS VARBINARY(255)), 'Pago estudiantil', NULL, 
		 CAST('checksum_404' AS VARBINARY(250)), 3),
    
		(9, 10, 2, 60.00, DATEADD(DAY, -15, GETDATE()), 1, 'Completado', 'AUTH505', 'REF-1009', 
		 CAST('charge_tok_505' AS VARBINARY(255)), 'Pago promocional', NULL, 
		 CAST('checksum_505' AS VARBINARY(250)), 3),
    
		(10, 11, 1, 25000.00, DATEADD(DAY, -20, GETDATE()), 1, 'Aprobado', 'AUTH606', 'REF-1010', 
		 CAST('charge_tok_606' AS VARBINARY(255)), 'Pago gobierno', NULL, 
		 CAST('checksum_606' AS VARBINARY(250)), 2),
    
		(11, 12, 1, 17000.00, DATEADD(DAY, -1, GETDATE()), 0, 'Procesando', 'AUTH707', 'REF-1011', 
		 CAST('charge_tok_707' AS VARBINARY(255)), 'Pago semestral', NULL, 
		 CAST('checksum_707' AS VARBINARY(250)), 1),
    
		(12, 13, 2, 85.00, DATEADD(DAY, -2, GETDATE()), 0, 'Procesando', 'AUTH808', 'REF-1012', 
		 CAST('charge_tok_808' AS VARBINARY(255)), 'Pago internacional', NULL, 
		 CAST('checksum_808' AS VARBINARY(250)), 1),
    
		(13, 14, 1, 19000.00, DATEADD(DAY, -3, GETDATE()), 0, 'Procesando', 'AUTH909', 'REF-1013', 
		 CAST('charge_tok_909' AS VARBINARY(255)), 'Pago empresarial', NULL, 
		 CAST('checksum_909' AS VARBINARY(250)), 2),
    
		(14, 15, 1, 8000.00, DATEADD(DAY, -5, GETDATE()), 0, 'Procesando', 'AUTH010', 'REF-1014', 
		 CAST('charge_tok_010' AS VARBINARY(255)), 'Pago básico', NULL, 
		 CAST('checksum_010' AS VARBINARY(250)), 4),
    
		(15, 16, 2, 45.00, DATEADD(DAY, -8, GETDATE()), 0, 'Procesando', 'AUTH111', 'REF-1015', 
		 CAST('charge_tok_111' AS VARBINARY(255)), 'Pago prueba', NULL, 
		 CAST('checksum_111' AS VARBINARY(250)), 3),
		
		(16, 17, 1, 10000.00, DATEADD(DAY, -7, GETDATE()), 0, 'Rechazado', 'AUTH222', 'REF-1016', 
		 CAST('charge_tok_222' AS VARBINARY(255)), 'Pago servicios', 'Fondos insuficientes', 
		 CAST('checksum_222' AS VARBINARY(250)), 2),
    
		(17, 18, 1, 21000.00, DATEADD(DAY, -10, GETDATE()), 0, 'Rechazado', 'AUTH333', 'REF-1017', 
		 CAST('charge_tok_333' AS VARBINARY(255)), 'Pago anual plus', 'Tarjeta expirada', 
		 CAST('checksum_333' AS VARBINARY(250)), 1),
    
		(18, 19, 2, 55.00, DATEADD(DAY, -12, GETDATE()), 0, 'Rechazado', 'AUTH444', 'REF-1018', 
		 CAST('charge_tok_444' AS VARBINARY(255)), 'Pago membresía', 'Límite excedido', 
		 CAST('checksum_444' AS VARBINARY(250)), 3),
    
		(19, 20, 1, 13000.00, DATEADD(DAY, -15, GETDATE()), 0, 'Rechazado', 'AUTH555', 'REF-1019', 
		 CAST('charge_tok_555' AS VARBINARY(255)), 'Pago familiar', 'Cuenta suspendida', 
		 CAST('checksum_555' AS VARBINARY(250)), 4),
    
		(20, 21, 1, 9000.00, DATEADD(DAY, -18, GETDATE()), 0, 'Rechazado', 'AUTH666', 'REF-1020', 
		 CAST('charge_tok_666' AS VARBINARY(255)), 'Pago estudiantil', 'Autenticación fallida', 
		 CAST('checksum_666' AS VARBINARY(250)), 5),
    
		-- Pagos varios (21-25)
		(21, 22, 2, 65.00, DATEADD(DAY, -22, GETDATE()), 1, 'Completado', 'AUTH777', 'REF-1021', 
		 CAST('charge_tok_777' AS VARBINARY(255)), 'Pago promoción', NULL, 
		 CAST('checksum_777' AS VARBINARY(250)), 3),
    
		(22, 23, 1, 28000.00, DATEADD(DAY, -25, GETDATE()), 1, 'Aprobado', 'AUTH888', 'REF-1022', 
		 CAST('charge_tok_888' AS VARBINARY(255)), 'Pago corporativo plus', NULL, 
		 CAST('checksum_888' AS VARBINARY(250)), 1),
    
		(23, 24, 1, 7500.00, DATEADD(DAY, -30, GETDATE()), 0, 'Reembolsado', 'AUTH999', 'REF-1023', 
		 CAST('charge_tok_999' AS VARBINARY(255)), 'Pago especial', 'Reembolsado por solicitud', 
		 CAST('checksum_999' AS VARBINARY(250)), 2),
    
		(24, 25, 2, 95.00, DATEADD(DAY, -35, GETDATE()), 1, 'Completado', 'AUTH000', 'REF-1024', 
		 CAST('charge_tok_000' AS VARBINARY(255)), 'Pago internacional plus', NULL, 
		 CAST('checksum_000' AS VARBINARY(250)), 1),
    
		(25, 1, 1, 30000.00, DATEADD(DAY, -40, GETDATE()), 1, 'Aprobado', 'AUTH121', 'REF-1025', 
		 CAST('charge_tok_121' AS VARBINARY(255)), 'Pago anual gold', NULL, 
		 CAST('checksum_121' AS VARBINARY(250)), 1);
			SET IDENTITY_INSERT solturaDB.sol_payments OFF;

		SET IDENTITY_INSERT solturaDB.sol_deals ON;
		INSERT INTO solturaDB.sol_deals (dealId,partnerId,dealDescription,sealDate,endDate,solturaComission,discount,isActive)
		VALUES
		(1, 1, 'Promoción de verano: 15% descuento en membresías de gimnasio', 
		 '2023-06-01', '2023-08-31', 15.00, 15.00, 1),
		(2, 2, '2x1 en cines los miércoles', 
		 '2023-05-15', '2023-12-31', 10.00, 50.00, 1),
		(3, 3, '10% de descuento en compras mayores a ₡30,000', 
		 '2023-04-01', '2023-09-30', 12.50, 10.00, 1),
		(4, 4, 'Promoción Black Friday: 20% descuento en todos los servicios', 
		 '2023-11-01', '2023-11-30', 18.00, 20.00, 0), 
		(5, 5, 'Parqueo gratuito los fines de semana', 
		 '2023-07-01', '2024-01-31', 8.00, 100.00, 1),
		(6, 6, 'Combo familiar: 4 entradas + palomitas grandes + 4 bebidas', 
		 '2023-03-01', '2023-12-31', 12.00, 25.00, 1),
		(7, 7, 'Descuento del 15% en pedidos a través de la app', 
		 '2023-05-01', '2023-10-31', 10.00, 15.00, 1),
		(8, 1, 'Paquete deportivo: Gimnasio + Parqueo + Comida saludable', 
		 '2023-06-15', '2023-09-15', 20.00, 25.00, 1),
		(9, 1, 'Promoción de inicio de año: Matrícula gratis', 
		 '2023-01-01', '2023-01-31', 5.00, 100.00, 0),
		(10, 2, 'Descuentos para estudiantes los jueves', 
		 '2023-02-01', '2023-12-31', 7.50, 15.00, 1);
		SET IDENTITY_INSERT solturaDB.sol_deals OFF;
        
		SET IDENTITY_INSERT solturaDB.sol_featureTypes ON;
        INSERT INTO solturaDB.sol_featureTypes (featureTypeID, type)
		VALUES 
		(1, 'Gimnasios'),
		(2, 'Salud'),
		(3, 'Parqueos'),
		(4, 'Entretenimiento'),
		(5, 'Restaurantes'),
		(6, 'Viajes'),
		(7, 'Educación');
		SET IDENTITY_INSERT solturaDB.sol_featureTypes OFF;
		
		SET IDENTITY_INSERT solturaDB.sol_planFeatures ON;
		INSERT INTO solturaDB.sol_planFeatures (planFeatureID,dealId,description,unit,consumableQuantity,enabled,isRecurrent,scheduleID,featureTypeID)
		VALUES
		(1, 1, 'Acceso completo a instalaciones del gimnasio', 'visitas', 30, 1, 1, 1, 1),
		(2, 5, 'Acceso a áreas de parqueo exclusivas', 'horas', 60, 1, 1, 1, 2),
		(3, 1, 'Uso de instalaciones de spa y relajación', 'visitas', 4, 1, 1, 3, 3),
		(4, 1, 'Sesiones de masaje incluidas', 'sesiones', 2, 1, 1, 3, 4),
		(5, 8, 'Acceso a plataforma con entrenadores virtuales', 'sesiones', 12, 1, 1, 2, 5),
		(6, 6, 'Programas recreativos para niños', 'actividades', 8, 1, 1, 2, 6),
		(7, 5, 'Acceso a área de piscina familiar', 'visitas', 15, 1, 1, 1, 7);
		SET IDENTITY_INSERT solturaDB.sol_planFeatures OFF;

		SET IDENTITY_INSERT solturaDB.sol_featuresPerPlans ON;
		INSERT INTO solturaDB.sol_featuresPerPlans (featurePerPlansID,planFeatureID,planID,enabled)
		VALUES
		(1, 1, 1, 1),  
		(2, 2, 1, 1),  
		(3, 3, 1, 0),  
		(4, 1, 3, 1),
		(5, 2, 3, 1),
		(6, 3, 3, 1),  
		(7, 4, 3, 1), 
		(8, 1, 21, 1),
		(9, 5, 21, 1),
		(10, 6, 22, 1),
		(11, 7, 22, 1);
		SET IDENTITY_INSERT solturaDB.sol_featuresPerPlans OFF;
    
		SET IDENTITY_INSERT solturaDB.sol_featurePrices ON;
		INSERT INTO solturaDB.sol_featurePrices (featurePriceID,originalPrice,discountedPrice,finalPrice,currency_id,"current",variable,planFeatureID)
		VALUES
		(1, 15000.00, 13500.00, 13500.00, 1, 1, 0, 1),  
		(2, 5000.00, 5000.00, 5000.00, 1, 1, 0, 2), 
		(3, 20000.00, 18000.00, 18000.00, 1, 1, 0, 3), 
		(4, 10000.00, 10000.00, 10000.00, 1, 1, 1, 4), 
		(5, 30.00, 27.00, 27.00, 2, 1, 0, 1), 
		(6, 10.00, 9.00, 9.00, 2, 1, 0, 2),
		(7, 40.00, 36.00, 36.00, 2, 1, 0, 3), 
		(8, 8000.00, 7200.00, 7200.00, 1, 1, 0, 5), 
		(9, 12000.00, 10000.00, 10000.00, 1, 1, 0, 6), 
		(10, 15000.00, 12000.00, 12000.00, 1, 1, 0, 7);
		SET IDENTITY_INSERT solturaDB.sol_featurePrices OFF;

		SET IDENTITY_INSERT solturaDB.sol_featureAvailableLocations ON;
		INSERT INTO solturaDB.sol_featureAvailableLocations (locationID,featurePerPlanID,partnerAddressId,available)
		VALUES
		(1, 1, 1, 1),  
		(2, 1, 2, 1), 
		(3, 1, 5, 1),  
		(4, 2, 3, 1), 
		(5, 2, 5, 1), 
		(6, 3, 1, 1),
		(7, 10, 4, 1),
		(8, 11, 5, 1);
		SET IDENTITY_INSERT solturaDB.sol_featureAvailableLocations OFF;

        SET IDENTITY_INSERT solturaDB.sol_planTransactionTypes ON;
        INSERT INTO solturaDB.sol_planTransactionTypes (planTransactionTypeID, type)
        VALUES
        (1, 'Activación de plan'),
        (2, 'Renovación de plan'),
        (3, 'Upgrade de plan'),
        (4, 'Cancelación de plan'),
        (5, 'Pago de factura');
        SET IDENTITY_INSERT solturaDB.sol_planTransactionTypes OFF;

        SET IDENTITY_INSERT solturaDB.sol_transactionTypes ON;
        INSERT INTO solturaDB.sol_transactionTypes (transactionTypeID, name)
        VALUES
        (1, 'Pago'),
        (2, 'Reembolso'),
        (3, 'Ajuste'),
        (4, 'Transferencia'),
        (5, 'Cargo recurrente');
        SET IDENTITY_INSERT solturaDB.sol_transactionTypes OFF;

        SET IDENTITY_INSERT solturaDB.sol_transactionSubtypes ON;
        INSERT INTO solturaDB.sol_transactionSubtypes (transactionSubtypeID, name)
        VALUES
        (1, 'Tarjeta de crédito'),
        (2, 'Transferencia bancaria'),
        (3, 'Efectivo'),
        (4, 'Wallet digital'),
        (5, 'Pago móvil');
        SET IDENTITY_INSERT solturaDB.sol_transactionSubtypes OFF;

        SET IDENTITY_INSERT solturaDB.sol_planTransactions ON;
        INSERT INTO solturaDB.sol_planTransactions (planTransactionID,planTransactionTypeID,date,postTime,amount,checksum,userID,associateID,partnerAddressId)
        VALUES
        (1, 1, '2023-01-15', GETDATE(), 100.00, 0x123456, 1, 1, 1),
        (2, 2, '2023-02-20', GETDATE(), 120.00, 0x123457, 2, 2, 2),
        (3, 3, '2023-03-10', GETDATE(), 150.00, 0x123458, 3, 3, 3),
        (4, 4, '2023-04-05', GETDATE(), 0.00, 0x123459, 4, 4, NULL),
        (5, 5, '2023-05-12', GETDATE(), 80.00, 0x123460, 5, 5, 5);
        SET IDENTITY_INSERT solturaDB.sol_planTransactions OFF;

        SET IDENTITY_INSERT solturaDB.sol_transactions ON;
        INSERT INTO solturaDB.sol_transactions (transactionsID,payment_id,date,postTime,refNumber,user_id, checksum,exchangeRate,convertedAmount,
												transactionTypesID,transactionSubtypesID,amount,exchangeCurrencyID)
        VALUES
        (1, 1, '2023-01-15', GETDATE(), 'INV-001', 1, 0x654321, 1.0, 100.00, 1, 1, 100.00, 1),
        (2, 2, '2023-02-20', GETDATE(), 'INV-002', 2, 0x654322, 555.556, 55555.60, 1, 2, 100.00, 2),
        (3, 3, '2023-03-10', GETDATE(), 'INV-003', 3, 0x654323, 17.5, 1750.00, 1, 3, 100.00, 1),
        (4, 4, '2023-04-05', GETDATE(), 'RFND-001', 4, 0x654324, 555.556, 5555.56, 2, 4, 10.00, 2),
        (5, 5, '2023-05-12', GETDATE(), 'ADJ-001', 5, 0x654325, 1.0, 50.00, 3, 4, 50.00, 1);
        SET IDENTITY_INSERT solturaDB.sol_transactions OFF;

		SET IDENTITY_INSERT solturaDB.sol_balances ON;
		INSERT INTO solturaDB.sol_balances (balanceID,amount,expirationDate,lastUpdate,balanceTypeID,planFeatureID,userId)
		VALUES
		(1, 15000.00, DATEADD(MONTH, 3, GETDATE()), GETDATE(), 1, 1, 1),
		(2, 12000.00, DATEADD(MONTH, 2, GETDATE()), GETDATE(), 2, 3, 2),
		(3, 18000.00, DATEADD(YEAR, 1, GETDATE()), GETDATE(), 1, 2, 3),
		(4, 9000.00, DATEADD(MONTH, 4, GETDATE()), GETDATE(), 3, 5, 4),
		(5, 21000.00, DATEADD(YEAR, 1, GETDATE()), GETDATE(), 1, 6, 5),
		(6, 7500.00, DATEADD(MONTH, 1, GETDATE()), GETDATE(), 2, 4, 6),
		(7, 16500.00, DATEADD(MONTH, 6, GETDATE()), GETDATE(), 4, 7, 7),
		(8, 13500.00, DATEADD(MONTH, 3, GETDATE()), GETDATE(), 1, 7, 8),
		(9, 19500.00, DATEADD(YEAR, 2, GETDATE()), GETDATE(), 2, 3, 9),
		(10, 10500.00, DATEADD(MONTH, 5, GETDATE()), GETDATE(), 1, 1, 10),
		(11, 22500.00, DATEADD(YEAR, 1, GETDATE()), GETDATE(), 3, 5, 11),
		(12, 8500.00, DATEADD(MONTH, 2, GETDATE()), GETDATE(), 2, 4, 12),
		(13, 17500.00, DATEADD(YEAR, 1, GETDATE()), GETDATE(), 1, 2, 13),
		(14, 11500.00, DATEADD(MONTH, 7, GETDATE()), GETDATE(), 4, 7, 14),
		(15, 24500.00, DATEADD(YEAR, 2, GETDATE()), GETDATE(), 1, 6, 15),
		(16, 9500.00, DATEADD(MONTH, 1, GETDATE()), GETDATE(), 2, 3, 16),
		(17, 15500.00, DATEADD(MONTH, 4, GETDATE()), GETDATE(), 1, 2, 17),
		(18, 20500.00, DATEADD(YEAR, 1, GETDATE()), GETDATE(), 3, 5, 18),
		(19, 12500.00, DATEADD(MONTH, 3, GETDATE()), GETDATE(), 2, 4, 19),
		(20, 18500.00, DATEADD(YEAR, 1, GETDATE()), GETDATE(), 1, 1, 20),
		(21, 6500.00, DATEADD(MONTH, 2, GETDATE()), GETDATE(), 4, 7, 21),
		(22, 23500.00, DATEADD(YEAR, 2, GETDATE()), GETDATE(), 1, 2, 22),
		(23, 14500.00, DATEADD(MONTH, 5, GETDATE()), GETDATE(), 2, 3, 23),
		(24, 9500.00, DATEADD(MONTH, 1, GETDATE()), GETDATE(), 1, 6, 24),
		(25, 21500.00, DATEADD(YEAR, 1, GETDATE()), GETDATE(), 3, 5, 25),
		(26, 13500.00, DATEADD(MONTH, 4, GETDATE()), GETDATE(), 1, 1, 26),
		(27, 17500.00, DATEADD(YEAR, 1, GETDATE()), GETDATE(), 2, 4, 27),
		(28, 10500.00, DATEADD(MONTH, 6, GETDATE()), GETDATE(), 4, 7, 28),
		(29, 25500.00, DATEADD(YEAR, 2, GETDATE()), GETDATE(), 1, 1, 29),
		(30, 8500.00, DATEADD(MONTH, 2, GETDATE()), GETDATE(), 2, 3, 30);
		SET IDENTITY_INSERT solturaDB.sol_balances OFF;

        COMMIT TRANSACTION;
        PRINT 'Todas las tablas fueron pobladas exitosamente con el formato solicitado';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error al poblar las tablas: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
EXEC sp_PopulateTables;
```


---
## Demostraciones T-SQL
--



 1. Cursor local, mostrando que no es visible fuera de la sesi�n de la base de datos

Crea un cursor LOCAL que solo es visible dentro de la sesión actual, demostrando que no puede ser accedido desde otra sesión.

```sql
    -- 1. Cursor local, mostrando que no es visible fuera de la sesi�n de la base de datos
    USE solturaDB;
    GO
    DECLARE @userID INT, @userName NVARCHAR(100);
    --crea el cursor local 
    DECLARE user_cursor_local CURSOR LOCAL FOR
    SELECT userID, firstName + ' ' + lastName
    FROM solturaDB.sol_users
    WHERE enabled = 1 AND userID BETWEEN 1 AND 4  -- Filtramos para obtener exactamente los 4 usuarios mostrados
    ORDER BY userID;
    OPEN user_cursor_local;
    FETCH NEXT FROM user_cursor_local INTO @userID, @userName;
    PRINT 'Procesando usuarios con cursor LOCAL:';
    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT '  Usuario ' + CAST(@userID AS VARCHAR) + ': ' + @userName;
        FETCH NEXT FROM user_cursor_local INTO @userID, @userName;
    END
    -- Verificaci�n en la misma sesi�n
    PRINT 'Cursor local dejado abierto para demostraci�n';
    IF CURSOR_STATUS('local','user_cursor_local') = 1
        PRINT '  (Verificaci�n: Cursor visible en esta sesi�n)';
    ELSE
        PRINT '  (Error: Cursor no visible en su propia sesi�n)';
    -- No cerramos el cursor para la demostraci�n
    GO
    -- intento de acceder al cursor de otra sesi�n
    PRINT 'Intento de acceder al cursor desde otra sesi�n';
    BEGIN TRY
        DECLARE @testID INT, @testName NVARCHAR(100);
        FETCH NEXT FROM user_cursor_local INTO @testID, @testName;
        PRINT 'ERROR: El cursor es visible en otra sesi�n';
    END TRY
    BEGIN CATCH
        PRINT 'Demostraci�n exitosa:';
        PRINT '  Error: ' + ERROR_MESSAGE();
        PRINT '  Esto prueba que el cursor LOCAL no es visible fuera de su sesi�n original';
    END CATCH;
    GO
    BEGIN TRY             --aqui si cerramos el cursor
        CLOSE user_cursor_local;
        DEALLOCATE user_cursor_local;
    END TRY
    BEGIN CATCH
    END CATCH;
    GO
```



2. Cursor global, accesible desde otras sesiones de la base de datos

Crea un cursor GLOBAL que permanece accesible desde otras sesiones, permitiendo continuar el procesamiento donde se quedó.

```sql
    --2. Cursor global, accesible desde otras sesiones de la base de datos
    USE solturaDB;
    GO
    PRINT 'SESI�N 1';
    PRINT 'Creando cursor GLOBAL...';
    DECLARE @planID INT, @planName VARCHAR(100);
    DECLARE plan_cursor_global CURSOR GLOBAL FOR
    SELECT planID, description 
    FROM solturaDB.sol_plans 
    ORDER BY planID;
    OPEN plan_cursor_global;
    FETCH NEXT FROM plan_cursor_global INTO @planID, @planName;
    PRINT 'Procesando planes con cursor GLOBAL:';
    WHILE @@FETCH_STATUS = 0 AND @planID < 5  -- Limite para demostraci�n
    BEGIN
        PRINT '  Plan ' + CAST(@planID AS VARCHAR) + ': ' + @planName;
        FETCH NEXT FROM plan_cursor_global INTO @planID, @planName;
    END
    PRINT 'Cursor global dejado abierto para acceso desde otras sesiones';
    GO
    PRINT 'SESI�N 2';
    PRINT 'Accediendo al cursor GLOBAL desde otra sesi�n...';
    BEGIN TRY
        DECLARE @currentPlanID INT, @currentPlanName VARCHAR(100);
        FETCH NEXT FROM plan_cursor_global INTO @currentPlanID, @currentPlanName;
        PRINT 'Continuando procesamiento desde otra sesi�n:';
        WHILE @@FETCH_STATUS = 0 AND @currentPlanID < 10  -- Nuevo l�mite
        BEGIN
            PRINT '  Plan ' + CAST(@currentPlanID AS VARCHAR) + ': ' + @currentPlanName;
            FETCH NEXT FROM plan_cursor_global INTO @currentPlanID, @currentPlanName;
        END
        PRINT 'Procesamiento completado en sesi�n 2';
    END TRY
    BEGIN CATCH
        PRINT 'Error al acceder al cursor: ' + ERROR_MESSAGE();
    END CATCH;
    -- Cerrar cursor
    CLOSE plan_cursor_global;
    DEALLOCATE plan_cursor_global;
    GO
```


3. Uso de un trigger (por ejemplo, para log de inserciones en pagos).

Crea un trigger AFTER INSERT que registra en una tabla de logs cada nuevo pago insertado en la tabla sol_payments.

```sql
    -- 3. Uso de un trigger (por ejemplo, para log de inserciones en pagos).
    USE solturaDB;
    GO
    ALTER TABLE solturaDB.sol_logs
    ALTER COLUMN computer NVARCHAR(75) NULL;
    ALTER TABLE solturaDB.sol_logs
    ALTER COLUMN trace NVARCHAR(100) NULL;
    ALTER TABLE solturaDB.sol_logs
    ALTER COLUMN checksum varbinary(250) NULL;
    GO
    CREATE OR ALTER TRIGGER tr_log_payment_insert_3
    ON solturaDB.sol_payments
    AFTER INSERT
    AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO solturaDB.sol_logs (
            description, 
            postTime, 
            computer, 
            username, 
            trace, 
            referenceId1, 
            value1, 
            checksum, 
            logSeverityID, 
            logTypesID, 
            logSourcesID
        )
        SELECT 
            'Nuevo pago - Monto: ' + CAST(ISNULL(i.amount, 0) AS VARCHAR) + ' ' + 
            ISNULL((SELECT TOP 1 acronym FROM solturaDB.sol_currencies WHERE currency_id = i.currency_id ORDER BY currency_id), 'UNK'),
            GETDATE(),
            ISNULL(HOST_NAME(), 'UNKNOWN'),
            ISNULL(SYSTEM_USER, 'system'),
            'PAYMENT_INSERT',
            i.paymentID,
            'M�todo: ' + ISNULL((SELECT TOP 1 name FROM solturaDB.sol_availablePayMethods 
                WHERE available_method_id = i.availableMethodID ORDER BY available_method_id), 'DESCONOCIDO'),
            HASHBYTES('SHA2_256', CAST(i.paymentID AS NVARCHAR(50)) + CAST(ISNULL(i.amount, 0) AS NVARCHAR(20))),
            ISNULL((SELECT TOP 1 logSererityID FROM solturaDB.sol_logsSererity WHERE name = 'Info' ORDER BY logSererityID), 1),
            ISNULL((SELECT TOP 1 logTypesID FROM solturaDB.sol_logTypes WHERE name = 'Payment' ORDER BY logTypesID), 1),
            ISNULL((SELECT TOP 1 logSourcesID FROM solturaDB.sol_logSources WHERE name = 'PaymentSystem' ORDER BY logSourcesID), 1)
        FROM inserted i;
    END;
    GO
```



 4. Uso de sp_recompile, c�mo podr�a estar recompilando todos los SP existentes cada cierto tiempo?

Genera dinámicamente un script para recompilar todos los procedimientos almacenados de la base de datos, útil para actualizar planes de ejecución.

```sql
    -- 4. Uso de sp_recompile, c�mo podr�a estar recompilando todos los SP existentes cada cierto tiempo?
    USE solturaDB;
    GO
    DECLARE @sql NVARCHAR(MAX) = '';
    SELECT @sql = @sql + 'EXEC sp_recompile ''' + SCHEMA_NAME(schema_id) + '.' + name + ''';' + CHAR(13)
    FROM solturaDB.sys.procedures;
    PRINT ' Script para recompilar todos los SPs:';
    PRINT @sql;
    EXEC sp_executesql @sql; -- Descomentar a su propio riesgo
    GO
```



5. Uso de MERGE para sincronizar datos de planes por ejemplo.

Sincroniza datos de planes entre una tabla origen y destino, actualizando registros existentes o insertando nuevos cuando no existen.

```sql
--5. Uso de MERGE para sincronizar datos de planes por ejemplo.
USE solturaDB;
GO
SET IDENTITY_INSERT solturaDB.sol_plans ON
MERGE INTO solturaDB.sol_plans AS target
USING (
    SELECT 21 AS planID, 'Joven Deportista - Atletas' AS description, 5 AS planTypeID UNION ALL
    SELECT 11, 'Full Modern Family - Familiar Plus', 4 UNION ALL
	SELECT 12, 'Professional Joven - Carrera', 4 UNION ALL
	SELECT 7, 'Plan Familiar (4 personas)', 4 UNION ALL
    SELECT 22, 'Familia de Verano (Vacacional)', 4 UNION ALL
    SELECT 23, 'Viajero Frecuente - Millas', 6 UNION ALL
	SELECT 30,  '    N�mada Digital - Remoto Global', 15 UNION ALL
    SELECT 24, 'N�mada Digital', 6
) AS source
ON target.planID = source.planID
WHEN MATCHED AND (target.description <> source.description OR target.planTypeID <> source.planTypeID) THEN
    UPDATE SET 
        target.description = source.description,
        target.planTypeID = source.planTypeID
WHEN NOT MATCHED BY TARGET THEN
    INSERT (planID, description, planTypeID)
    VALUES (source.planID, source.description, source.planTypeID);
SET IDENTITY_INSERT solturaDB.sol_plans OFF
SELECT planID, description, planTypeID 
FROM solturaDB.sol_plans
ORDER BY planID;
GO
``` 



6. COALESCE para manejar valores nulos en configuraciones de usuario.

Maneja valores nulos en configuraciones de usuario devolviendo el primer valor no nulo de una lista de columnas/expresiones.

``` sql
--6.COALESCE para manejar valores nulos en configuraciones de usuario.
USE solturaDB;
GO
SELECT 
    u.userID,
    u.firstName,
    u.lastName,
    COALESCE(up.enabled, 1) AS notifications_enabled,
    COALESCE(nc.settings, '{"alert":true,"email":true,"push":true}') AS notification_settings,
    COALESCE((
        SELECT TOP 1 channel 
        FROM solturaDB.sol_communicationChannels 
        WHERE communicationChannelID = nc.communicationChannelID
    ), 'Email') AS default_channel
FROM solturaDB.sol_users u
LEFT JOIN solturaDB.sol_userPermissions up ON u.userID = up.userID AND up.permissionID = 5
LEFT JOIN solturaDB.sol_notificationConfigurations nc ON u.userID = nc.userID;
GO
``` 



7. SUBSTRING para extraer partes de descripciones.
8. LTRIM para limpiar strings.

Extrae partes de descripciones y limpia espacios en blanco al inicio de strings para presentación consistente.

``` sql
--7 SUBSTRING para extraer partes de descripciones.
--8 LTRIM para limpiar strings.
    USE solturaDB;
    GO
    SELECT 
        planID,
        description AS original_desc,
        LTRIM(description) AS cleaned_desc,
        SUBSTRING(LTRIM(description), 1, 20) AS short_desc,
        CASE 
            WHEN CHARINDEX('-', description) > 0 
            THEN SUBSTRING(description, CHARINDEX('-', description) + 1, LEN(description))
            WHEN CHARINDEX('(', description) > 0 
            THEN SUBSTRING(description, CHARINDEX('(', description), CHARINDEX(')', description) - CHARINDEX('(', description) + 1)
            ELSE ''
        END AS category_info
    FROM solturaDB.sol_plans;
    GO
``` 



9. AVG con agrupamiento (ej. promedio de montos pagados por usuario).

Calcula el promedio de montos pagados agrupados por usuario, mostrando también conteo y suma total.

``` sql
    --9. AVG con agrupamiento (ej. promedio de montos pagados por usuario).
    USE solturaDB;
    GO
    SELECT 
        u.userID,
        u.firstName + ' ' + u.lastName AS member_name,
        COUNT(p.paymentID) AS payment_count,
        AVG(p.amount) AS avg_payment_amount, -- aqui esta el avg :)
        SUM(p.amount) AS total_paid,
        (SELECT COUNT(*) FROM solturaDB.sol_userPlans up WHERE up.userID = u.userID) AS active_plans,
        STRING_AGG(apm.name, ', ') AS payment_methods_used
    FROM solturaDB.sol_users u
    JOIN solturaDB.sol_availablePayMethods apm ON u.userID = apm.userID
    JOIN solturaDB.sol_payments p ON apm.available_method_id = p.availableMethodID
    GROUP BY u.userID, u.firstName, u.lastName
    ORDER BY avg_payment_amount DESC;
    GO
``` 



10. TOP para mostrar top 5 planes m�s populares.

Selecciona solo los 5 planes más populares basados en cantidad de suscriptores, ordenados descendentemente.

```sql
    --10. TOP para mostrar top 5 planes m�s populares.
    USE solturaDB;
    GO
    SELECT TOP 5
        p.planID,
        p.description AS plan_name,
        pt.type AS plan_type,
        COUNT(up.userPlanID) AS subscriber_count,
        (SELECT AVG(pp.amount) 
        FROM solturaDB.sol_planPrices pp 
        WHERE pp.planID = p.planID AND pp."current" = 1) AS avg_price
    FROM solturaDB.sol_plans p
    JOIN solturaDB.sol_planTypes pt ON p.planTypeID = pt.planTypeID
    LEFT JOIN solturaDB.sol_planPrices pp ON p.planID = pp.planID AND pp."current" = 1
    LEFT JOIN solturaDB.sol_userPlans up ON pp.planPriceID = up.planPriceID AND up.enabled = 1
    GROUP BY p.planID, p.description, pt.type
    ORDER BY subscriber_count DESC;
    GO
```




11. && en que caso se usa

No se utiliza && en T-SQL, si no que se usa AND. && genera error de sintaxis en T-SQL

```sql
--11. && en que caso se usa
print '   &&   no se usa en T-SQL, se utiliza AND, && da error de sintaxis'
```



12. SCHEMABINDING demostrar que efectivamente funciona en SPs, vistas, funciones.

Demuestra cómo previene modificaciones en tablas referenciadas por vistas, protegiendo la integridad de los objetos vinculados.

```sql
--12. SCHEMABINDING demostrar que efectivamente funciona en SPs, vistas, funciones.
USE solturaDB;
GO
IF OBJECT_ID('vw_member_subscriptions', 'V') IS NOT NULL
    DROP VIEW vw_member_subscriptions;
GO
CREATE VIEW vw_member_subscriptions
WITH SCHEMABINDING
AS
SELECT 
    u.userID,
    u.firstName,
    u.lastName,
    u.email,
    COUNT_BIG(*) AS subscription_count,
    SUM(CAST(pp.amount AS DECIMAL(10,2))) AS monthly_cost,
    MAX(up.adquisition) AS last_subscription_date
FROM solturaDB.sol_users u
JOIN solturaDB.sol_userPlans up ON u.userID = up.userID
JOIN solturaDB.sol_planPrices pp ON up.planPriceID = pp.planPriceID
JOIN solturaDB.sol_plans p ON pp.planID = p.planID
WHERE up.enabled = 1 AND pp.[current] = 1
GROUP BY u.userID, u.firstName, u.lastName, u.email;
GO

PRINT 'PRUEBA DE SCHEMABINDING ';
PRINT 'Intentando modificar una columna referenciada...';
GO
BEGIN TRY
    ALTER TABLE solturaDB.sol_users ALTER COLUMN firstName NVARCHAR(100);
    PRINT 'ERROR: SCHEMABINDING no est� funcionando (se permiti� la modificaci�n)';
END TRY
BEGIN CATCH
    PRINT 'SCHEMABINDING funciona correctamente:';
    PRINT 'Error: ' + ERROR_MESSAGE()  + '     <<<<<<<    prueba que el schemabinding funciona bien';
END CATCH;
GO
PRINT 'Vista en results table';
SELECT TOP 5 * FROM vw_member_subscriptions;
GO
```



 13. WITH ENCRYPTION demostrar que es posible encriptar un SP y que no lo violenten.    
 14. EXECUTE AS para ejecutar SP con impersonificaci�n, es posible? qu� significa eso

Muestra cómo encriptar el código de un procedimiento almacenado para proteger la propiedad intelectual y ejecuta un procedimiento con los permisos de otro usuario (impersonificación), permitiendo control granular de acceso.

```sql
    -- 13. WITH ENCRYPTION demostrar que es posible encriptar un SP y que no lo violenten.    
    -- 14. EXECUTE AS para ejecutar SP con impersonificaci�n, es posible? qu� significa eso
    --muchos comentarios por que me costo entenderlo hasta a mi :(
    USE solturaDB;
    GO
    -- Tbabla de ejemplos
    IF OBJECT_ID('sol_payments', 'U') IS NOT NULL DROP TABLE sol_payments;
    GO
    CREATE TABLE sol_payments (
        id INT IDENTITY(1,1),
        confirmed BIT
    );
    GO
    INSERT INTO sol_payments (confirmed)
    VALUES (0), (1), (0), (1), (0);
    GO
    --  Crea usuario (para impersonificaci�n)
    IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'app_executor')
        CREATE USER app_executor WITHOUT LOGIN;
    GO
    -- Otorgar permisos limitados a la tabla creada
    GRANT SELECT ON dbo.sol_payments TO app_executor;
    GO
    -- procedimiento con encriptaci�n y impersonificaci�n
    IF OBJECT_ID('sp_demo_secure', 'P') IS NOT NULL DROP PROCEDURE sp_demo_secure;
    GO
    CREATE PROCEDURE sp_demo_secure
    WITH ENCRYPTION, EXECUTE AS 'app_executor'
    AS
    BEGIN
        SET NOCOUNT ON;
        DECLARE @pendientes INT;
        SELECT @pendientes = COUNT(*) FROM sol_payments WHERE confirmed = 0;
        PRINT 'Pagos pendientes: ' + CAST(@pendientes AS VARCHAR);
    END;
    GO
    PRINT ' Confirmar que el c�digo est� encriptado (debe dar null en la tabla de results )';
    SELECT 
        OBJECT_NAME(object_id) AS Procedimiento,
        definition AS CodigoFuente
    FROM sys.sql_modules
    WHERE object_id = OBJECT_ID('sp_demo_secure');
    GO
    PRINT ''
    PRINT ' Ejecutar procedimiento ( como app_executor con impersonificaci�n , funciona) ';
    EXEC sp_demo_secure;
    PRINT 'es posible, EXECUTE AS ejecuta un procedimiento almacenado con los permisos de otro usuario diferente al que lo est� llamando, es decir, a traves de la impersonificaci�n puede ejecutar procedimientos, triggers y funciones.'
    Print ''
    GO
    -- Crea otro usuario para prueba de acceso denegado
    IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'usuario_tester')
    BEGIN
        REVERT; 
        DROP USER usuario_tester;
    END
    GO
    CREATE USER usuario_tester WITHOUT LOGIN;
    GO
    -- Probar acceso directo a la tabla desde un usuario sin permisos
    EXECUTE AS USER = 'usuario_tester';
    PRINT ' Usuario limitado intentando leer la tabla directamente (debe fallar) ';
    BEGIN TRY
        SELECT * FROM sol_payments;
    END TRY
    BEGIN CATCH
        PRINT 'ERROR: Usuario sin permisos no puede acceder directamente a la tabla.';
    END CATCH;
    REVERT;
    GO

```



15. UNION entre planes individuales y empresariales por ejemplo. 

Combina resultados de consultas sobre planes básicos y familiares en un solo conjunto de resultados unificado.

```sql
--15. UNION entre planes individuales y empresariales por ejemplo. 
    USE solturaDB;
    GO
    SELECT 
        p.planID,
        p.description AS plan_name,
        'B�sico' AS plan_category,
        pp.amount AS monthly_price,
        (SELECT COUNT(*) 
        FROM solturaDB.sol_userPlans up
        JOIN solturaDB.sol_planPrices pp2 ON up.planPriceID = pp2.planPriceID
        WHERE pp2.planID = p.planID AND up.enabled = 1) AS subscribers
    FROM solturaDB.sol_plans p
    JOIN solturaDB.sol_planTypes pt ON p.planTypeID = pt.planTypeID AND pt.type LIKE '%B�sico%'
    JOIN solturaDB.sol_planPrices pp ON p.planID = pp.planID AND pp."current" = 1
    UNION ALL
    SELECT 
        p.planID,
        p.description AS plan_name,
        'Familiar' AS plan_category,
        pp.amount AS monthly_price,
        (SELECT COUNT(*) 
        FROM solturaDB.sol_userPlans up
        JOIN solturaDB.sol_planPrices pp2 ON up.planPriceID = pp2.planPriceID
        WHERE pp2.planID = p.planID AND up.enabled = 1) AS subscribers
    FROM solturaDB.sol_plans p
    JOIN solturaDB.sol_planTypes pt ON p.planTypeID = pt.planTypeID AND pt.type LIKE '%Familiar%'
    JOIN solturaDB.sol_planPrices pp ON p.planID = pp.planID AND pp."current" = 1
    ORDER BY plan_category, monthly_price DESC;
    GO
```



16. DISTINCT para evitar duplicados en servicios asignados por ejemplo.

 Elimina duplicados al listar características de planes, mostrando cada combinación única de feature, tipo y precio.

```sql
-- 16. DISTINCT para evitar duplicados en servicios asignados por ejemplo.
    USE solturaDB;
    GO
    SELECT DISTINCT
        pf.planFeatureID,
        pf.description AS feature,
        ft.type AS feature_type,
        fp.finalPrice AS base_price
    FROM solturaDB.sol_planFeatures pf
    JOIN solturaDB.sol_featureTypes ft ON pf.featureTypeID = ft.featureTypeID
    JOIN solturaDB.sol_featurePrices fp ON pf.planFeatureID = fp.planFeatureID AND fp."current" = 1
    JOIN solturaDB.sol_featuresPerPlans fpp ON pf.planFeatureID = fpp.planFeatureID
    JOIN solturaDB.sol_plans p ON fpp.planID = p.planID
    WHERE pf.enabled = 1
    ORDER BY feature_type, feature;
    GO

```
---
## Mantenimiento de la Seguridad


Crear usuarios de prueba


```sql
CREATE LOGIN usuario WITH PASSWORD = '654321';
CREATE LOGIN empleado WITH PASSWORD = '123456';
CREATE LOGIN manager WITH PASSWORD = '456789';


USE solturaDB;
CREATE USER usuario FOR LOGIN usuario;
CREATE USER empleado FOR LOGIN empleado;
CREATE USER manager FOR LOGIN manager;
```

Mostrar cómo permitir o denegar acceso a la base de datos, del todo poder verla o no, poder conectarse o no

```sql
-- Denegar acceso completo a la base de datos (revocar permisos de conexión)
DENY CONNECT TO usuario;

-- PRUEBA DE CONEXIÓN RESTRINGIDA
USE solturaDB;
EXECUTE AS USER = 'usuario';

SELECT firstName FROM solturaDB.sol_users; -- Cualquier consulta simple

-- Esto también verifica si el usuario puede conectarse a la DB
SELECT HAS_DBACCESS('usuario') AS TieneAcceso;

-- Luego para volver a permitir:
GRANT CONNECT TO usuario;
```


Conceder solo permisos de SELECT sobre una tabla a un usuario específico. Será posible crear roles y que existan roles que si puedan hacer ese select sobre esa tabla y otros Roles que no puedan? Demuestrelo con usuarios y roles pertinentes.

```sql

-- 2. PERMISOS SELECT Y ROLES PERSONALIZADOS

-- Quitar permisos por defecto para hacer SELECT en sol_payments
REVOKE SELECT ON solturaDB.sol_payments TO PUBLIC;

-- Otorgar solo a manager
GRANT SELECT ON solturaDB.sol_payments TO manager;


-- PRUEBAS DE PERMISO DE SELECT A UN USUARIO ESPECÍFICO
-- Ejemplo con la tabla de pagos, que contiene la información de los pagos realizados
-- usuario no podrá acceder
EXECUTE AS USER = 'usuario';
SELECT * FROM solturaDB.sol_payments; -- Error
REVERT;

-- empleado no podrá acceder
EXECUTE AS USER = 'empleado';
SELECT * FROM solturaDB.sol_payments; -- Error
REVERT;

-- manager sí podrá
EXECUTE AS USER = 'manager';
SELECT * FROM solturaDB.sol_payments; -- OK
REVERT;




-- ROLES PERSONALIZADOS
-- Crear dos roles
USE solturaDB;
CREATE ROLE AccesoRestringido;
CREATE ROLE SoloLectura;

-- Conceder permiso SELECT al rol SoloLectura
ALTER ROLE AccesoRestringido ADD MEMBER usuario;
ALTER ROLE SoloLectura ADD MEMBER empleado;

DENY SELECT ON solturaDB.sol_payments TO AccesoRestringido;
GRANT SELECT ON solturaDB.sol_payments TO SoloLectura;


-- PRUEBAS DE PERMISO DE SELECT A UN USUARIO ESPECÍFICO

-- usuario en rol AccesoRestringido
EXECUTE AS USER = 'usuario';
SELECT * FROM solturaDB.sol_payments; -- Denegado
REVERT;

-- empleado en rol SoloLectura (antes tenía restringido el acceso a la tabla, pero ahora accede por el rol)
EXECUTE AS USER = 'empleado';
SELECT * FROM solturaDB.sol_payments; -- OK
REVERT;

```

Permitir ejecución de ciertos SPs y denegar acceso directo a las tablas que ese SP utiliza, será que aunque tengo las tablas restringidas, puedo ejecutar el SP?

```sql
-- 3. PERMISOS SOBRE STORED PROCEDURES

-- Denegar acceso a las tablas
DENY SELECT ON solturaDB.sol_deals TO usuario;
DENY SELECT ON solturaDB.sol_partners TO usuario;


-- Crear SP 
CREATE PROCEDURE [solturaDB].[SP_verDealsdePartners]
WITH EXECUTE AS OWNER
AS
BEGIN
	SET NOCOUNT ON

    SELECT p.name AS "Partner", d.dealDescription, d.sealDate, d.endDate, d.discount, d.solturaComission, d.isActive
	FROM sol_deals d
	INNER JOIN sol_partners p ON d.partnerId = p.partnerId 
END;

-- PRUEBAS DE EJECUCIÓN

-- el usuario no puede utilizar el SP si no se le da permiso explícitamete
-- Actuar como el usuario sin permiso
EXECUTE AS USER = 'usuario';

-- Probar acceso directo a las tablas (esperado: error)
SELECT * FROM solturaDB.sol_deals;       
SELECT * FROM solturaDB.sol_partners;   
-- Probar ejecución del SP 
EXEC solturaDB.SP_verDealsdePartners;        -- Error: no tiene permiso

REVERT;

-- Con el permiso, ya debe poder ejecutarlo
GRANT EXECUTE ON solturaDB.SP_verDealsdePartners TO AccesoRestringido;

-- Actuar como el usuario nuevamente
EXECUTE AS USER = 'usuario';

-- Probar SP otra vez (esperado: funciona)
EXEC solturaDB.SP_verDealsdePartners;      
-- Probar acceso directo (sigue sin funcionar)
SELECT * FROM solturaDB.sol_deals;       
SELECT * FROM solturaDB.sol_partners;    

REVERT;
```

RLS - row level security

El RLS en el sistema de soltura se implementó de manera que cada usuario respectivo solo pueda ver los métodos de pago (tarjetas) que le pertenecen

```sql
-- Crear login a nivel de servidor
CREATE LOGIN admin WITH PASSWORD = 'admin123';

-- Crear usuario dentro de la base de datos 
USE solturaDB;
CREATE USER admin FOR LOGIN admin;

GRANT SELECT ON solturaDB.sol_availablePayMethods TO "admin";
GRANT SELECT ON solturaDB.sol_availablePayMethods TO usuario;


CREATE FUNCTION solturaDB.fn_filtrarPorUsuario(@user_id INT)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN
    SELECT 1 AS permitido
    WHERE 
        (
            SESSION_CONTEXT(N'user_id') IS NOT NULL AND 
            @user_id = CAST(SESSION_CONTEXT(N'user_id') AS INT)
        )
        OR
        USER_NAME() = 'admin'
		OR USER_NAME() = 'dbo';


CREATE SECURITY POLICY solturaDB.securityPolicyAvailablePayMethods
ADD FILTER PREDICATE solturaDB.fn_filtrarPorUsuario(userID)
ON solturaDB.sol_availablePayMethods
WITH (STATE = ON);
```



```sql
--PRUEBAS 
-- Usuario sin session_context: no puede ver nada
EXECUTE AS USER = 'usuario';
EXEC sp_set_session_context @key = N'user_id', @value = NULL;
SELECT * FROM solturaDB.sol_availablePayMethods;  -- No mostrará resultados
REVERT;

-- Usuario con session_context: solo puede ver sus filas
EXECUTE AS USER = 'usuario';
EXEC sp_set_session_context @key = N'user_id', @value = 5;  -- Asignamos un user_id específico
SELECT * FROM solturaDB.sol_availablePayMethods;  -- Solo verá las filas con user_id = 5
REVERT;

-- Usuario admin: debe ver todas las filas
EXECUTE AS USER = 'admin';
EXEC sp_set_session_context @key = N'user_id', @value = NULL;
SELECT * FROM solturaDB.sol_availablePayMethods;  -- Verá todas las filas
REVERT;
```

Crear un certificado y llave asimétrica.
Crear una llave simétrica.
Cifrar datos sensibles usando cifrado simétrico y proteger la llave privada con las llaves asimétrica definidas en un certificado del servidor.

```sql
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'safePassword123';

CREATE CERTIFICATE CertificadoDeCifrado
WITH SUBJECT = 'Cifrado de Token';

CREATE ASYMMETRIC KEY SolturaLlaveAsimetrica
    WITH ALGORITHM = RSA_2048;

CREATE SYMMETRIC KEY SolturaLlaveSimetrica
    WITH ALGORITHM = AES_256
    ENCRYPTION BY CERTIFICATE CertificadoDeCifrado;
```

Crear un SP que descifre los datos protegidos usando las llaves anteriores.

Este SP lo que hace es descifrar los identificadores personales de cada usuario para canjear los beneficios de sus planes.

```sql
CREATE PROCEDURE solturaDB.SP_DesencriptarTokens
AS
BEGIN
    OPEN SYMMETRIC KEY SolturaLlaveSimetrica
    DECRYPTION BY CERTIFICATE CertificadoDeCifrado;

    SELECT 
        associateID,
        CONVERT(varchar, DecryptByKey(token)) AS token,
        userID,
        identificationTypeID
    FROM solturaDB.sol_userAssociateIdentifications;

    CLOSE SYMMETRIC KEY SolturaLlaveSimetrica;
END
```


---
## Consultas Misceláneas

1. 
Crear una vista indexada con al menos 4 tablas (ej. usuarios, suscripciones, pagos, servicios). La vista debe ser dinámica, no una vista materializada con datos estáticos. Demuestre que si es dinámica.
```sql
--Crear una vista indexada con al menos 4 tablas (ej. usuarios, suscripciones, pagos, servicios). La vista debe ser din�mica, no una vista materializada con datos estáticos. Demuestre que si es din�mica.
USE solturaDB;
GO
-- crea la vista con SCHEMABINDING
IF OBJECT_ID('dbo.vw_user_subscription_details', 'V') IS NOT NULL
    DROP VIEW dbo.vw_user_subscription_details;
GO
CREATE VIEW dbo.vw_user_subscription_details
WITH SCHEMABINDING
AS
SELECT 
    u.userID,
    u.firstName,
    u.lastName,
    u.email,
    p.planID,
    p.description AS planName,
    pt.type AS planType,
    pp.amount AS monthlyPrice,
    pp.planPriceID,
    up.userPlanID,
    p.planTypeID
FROM solturaDB.sol_users u
JOIN solturaDB.sol_userPlans up ON u.userID = up.userID
JOIN solturaDB.sol_planPrices pp ON up.planPriceID = pp.planPriceID
JOIN solturaDB.sol_plans p ON pp.planID = p.planID
JOIN solturaDB.sol_planTypes pt ON p.planTypeID = pt.planTypeID
WHERE up.enabled = 1 AND pp.[current] = 1;
GO
CREATE UNIQUE CLUSTERED INDEX IX_vw_user_subscription_details       --aqui la indexaci�n
ON dbo.vw_user_subscription_details (userID, planID);
GO
IF OBJECT_ID('dbo.vw_user_subscription_aggregates', 'V') IS NOT NULL
    DROP VIEW dbo.vw_user_subscription_aggregates;
GO
CREATE VIEW dbo.vw_user_subscription_aggregates
AS
SELECT 
    v.userID,
    v.firstName + ' ' + v.lastName AS fullName,
    v.planName,
    v.planType,
    v.monthlyPrice,
    COUNT(fpp.featurePerPlansID) AS featureCount,
    SUM(CAST(fp.finalPrice AS DECIMAL(10,2))) AS totalFeatureValue
FROM dbo.vw_user_subscription_details v
JOIN solturaDB.sol_featuresPerPlans fpp ON v.planID = fpp.planID
JOIN solturaDB.sol_planFeatures pf ON fpp.planFeatureID = pf.planFeatureID
JOIN solturaDB.sol_featurePrices fp ON pf.planFeatureID = fp.planFeatureID AND fp.[current] = 1
GROUP BY v.userID, v.firstName, v.lastName, v.planName, v.planType, v.monthlyPrice;
GO
BEGIN TRANSACTION;
SELECT TOP 1 firstName, lastName, planName, monthlyPrice 
FROM dbo.vw_user_subscription_details 
WHERE userID = 1;
UPDATE solturaDB.sol_planPrices 
SET amount = amount * 1.1 -- Aumento del 10%
WHERE planPriceID IN (SELECT planPriceID FROM solturaDB.sol_userPlans WHERE userID = 1);
-- Ver cambios en la vista
SELECT TOP 1 firstName, lastName, planName, monthlyPrice 
FROM dbo.vw_user_subscription_details 
WHERE userID = 1;
ROLLBACK TRANSACTION; -- Revertir cambios de demostraci�n
-- Consultas de ejemplo usando la vista indexada
SELECT 
    planType,
    COUNT(DISTINCT userID) AS totalUsers,
    AVG(monthlyPrice) AS avgMonthlyPrice
FROM dbo.vw_user_subscription_details
GROUP BY planType
ORDER BY totalUsers DESC;
-- usando la vista de agregados
SELECT 
    planType,
    COUNT(DISTINCT userID) AS totalUsers,
    AVG(totalFeatureValue) AS avgFeatureValue
FROM dbo.vw_user_subscription_aggregates
GROUP BY planType
ORDER BY totalUsers DESC;
```

2.
Crear un procedimiento almacenado transaccional que realice una operación del sistema, relacionado a subscripciones, pagos, servicios, transacciones o planes, y que dicha operación requiera insertar y/o actualizar al menos 3 tablas.
```sql
--Crear un procedimiento almacenado transaccional que realice una operaci�n del sistema, relacionado a subscripciones, pagos, servicios, transacciones o planes, y que dicha operaci�n requiera insertar y/o actualizar al menos 3 tablas.
USE solturaDB;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_RenovarSuscripcionAutomatica')
DROP PROCEDURE dbo.sp_RenovarSuscripcionAutomatica;
GO
CREATE PROCEDURE dbo.sp_RenovarSuscripcionAutomatica
    @userID INT,
    @planPriceID INT,
    @paymentMethodID INT,
    @currencyID INT,
    @resultado BIT OUTPUT,
    @mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @transactionID INT;
    DECLARE @paymentID INT;
    DECLARE @userPlanID INT;
    DECLARE @monto DECIMAL(12,2);
    DECLARE @planID INT;
    DECLARE @nuevoSaldo DECIMAL(10,2) = 0;
    DECLARE @token VARBINARY(255) = CONVERT(VARBINARY(255), 'AUTO_' + CONVERT(VARCHAR(36), NEWID()));
    DECLARE @checksum VARBINARY(250) = CONVERT(VARBINARY(250), HASHBYTES('SHA2_256', CONVERT(VARCHAR(50), GETDATE())));
    DECLARE @refNumber VARCHAR(50) = 'REN-' + CONVERT(VARCHAR(20), GETDATE(), 112) + '-' + RIGHT('00000' + CAST(ABS(CHECKSUM(NEWID())) % 100000 AS VARCHAR(5)), 5);
    DECLARE @authCode VARCHAR(60) = 'AUTH-' + CONVERT(VARCHAR(20), GETDATE(), 112) + '-' + RIGHT('00000' + CAST(ABS(CHECKSUM(NEWID())) % 100000 AS VARCHAR(5)), 5);
    DECLARE @randomSubtype INT = CAST(ABS(CHECKSUM(NEWID())) % 5 + 1 AS INT);
	DECLARE @defaultScheduleID INT = (SELECT TOP 1 scheduleID FROM solturaDB.sol_schedules WHERE name = 'Renovaci�n Autom�tica');
        IF @defaultScheduleID IS NULL
    BEGIN
        INSERT INTO solturaDB.sol_schedules (
            name, repit, repetitions, recurrencyType, endDate, startDate
        )
        VALUES (
            'Renovaci�n Autom�tica', 0, 0, 0, DATEADD(YEAR, 10, GETDATE()), GETDATE()
        );
        SET @defaultScheduleID = SCOPE_IDENTITY();
    END
    BEGIN TRY
        BEGIN TRANSACTION;
        SELECT @monto = pp.amount, @planID = pp.planID
        FROM solturaDB.sol_planPrices pp
        WHERE pp.planPriceID = @planPriceID AND pp.[current] = 1;
        IF @monto IS NULL
        BEGIN
            SET @resultado = 0;
            SET @mensaje = 'El plan especificado no existe o no est� activo';
            ROLLBACK;
            RETURN;
        END
        INSERT INTO solturaDB.sol_payments (
            availableMethodID, currency_id, amount, date_pay,
            confirmed, result, auth, reference,
            charge_token, description, error, checksum, methodID
        )
        VALUES (
            @paymentMethodID, @currencyID, @monto, GETDATE(),
            1, 'Renovaci�n autom�tica', @authCode, @refNumber,
            @token, 'Renovaci�n autom�tica', '', @checksum, @paymentMethodID
        );
        SET @paymentID = SCOPE_IDENTITY();
        SELECT @userPlanID = userPlanID 
        FROM solturaDB.sol_userPlans 
        WHERE userID = @userID AND enabled = 1;
        IF @userPlanID IS NOT NULL
        BEGIN
            UPDATE solturaDB.sol_userPlans
            SET planPriceID = @planPriceID,
                scheduleID = @defaultScheduleID, 
                adquisition = GETDATE(),
                enabled = 1
            WHERE userPlanID = @userPlanID;
        END
        ELSE
        BEGIN
            INSERT INTO solturaDB.sol_userPlans (
                userID, planPriceID, scheduleID, adquisition, enabled
            )
            VALUES (
                @userID, @planPriceID, @defaultScheduleID, GETDATE(), 1
            );
            SET @userPlanID = SCOPE_IDENTITY();
        END
        INSERT INTO solturaDB.sol_transactions (
            payment_id, date, postTime, refNumber,
            user_id, checksum, exchangeRate, convertedAmount,
            transactionTypesID, transactionSubtypesID, amount, exchangeCurrencyID
        )
        VALUES (
            @paymentID, GETDATE(), GETDATE(), @refNumber,
            @userID, @checksum, 1.0, @monto,
            1, @randomSubtype, @monto, @currencyID
        );
        SET @transactionID = SCOPE_IDENTITY();
        IF EXISTS (SELECT 1 FROM solturaDB.sol_balances WHERE userID = @userID AND balanceTypeID = 1 AND expirationDate > GETDATE())
        BEGIN
            UPDATE solturaDB.sol_balances
            SET amount = amount - @monto,
                lastUpdate = GETDATE()
            WHERE userID = @userID AND balanceTypeID = 1 AND expirationDate > GETDATE();

            SET @nuevoSaldo = (SELECT amount FROM solturaDB.sol_balances WHERE userID = @userID AND balanceTypeID = 1);
        END
        -- Registrar en logs
        INSERT INTO solturaDB.sol_logs (
            description, postTime, computer, username,
            trace, referenceId1, referenceId2, value1,
            checksum, logSeverityID, logTypesID, logSourcesID
        )
        VALUES (
            'Renovaci�n autom�tica', GETDATE(), HOST_NAME(), SYSTEM_USER,
            '', @userID, @transactionID, CAST(@monto AS VARCHAR(50)),
            @checksum, 1, 3, 1
        );
        COMMIT TRANSACTION;
        SET @resultado = 1;
        SET @mensaje = 'Renovaci�n exitosa. Nuevo saldo: ' + ISNULL(CAST(@nuevoSaldo AS VARCHAR(20)), '0.00');
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        SET @resultado = 0;
        SET @mensaje = 'Error al renovar suscripci�n: ' + ERROR_MESSAGE();
        INSERT INTO solturaDB.sol_logs (
            description, postTime, computer, username,
            trace, referenceId1, value1, value2,
            checksum, logSeverityID, logTypesID, logSourcesID
        )
        VALUES (
            'Error en renovaci�n autom�tica', GETDATE(), HOST_NAME(), SYSTEM_USER,
            '', @userID, ERROR_MESSAGE(), ERROR_PROCEDURE(),
            @checksum, 3, 3, 1
        );
    END CATCH
END;
GO
DECLARE @resultado BIT, @mensaje VARCHAR(200);
IF NOT EXISTS (SELECT 1 FROM solturaDB.sol_users WHERE userID = 1)
    INSERT INTO solturaDB.sol_users (userID, email, firstName, lastName, password, enabled)
    VALUES (1, 'test@example.com', 'Test', 'User', 0x00, 1);
IF NOT EXISTS (SELECT 1 FROM solturaDB.sol_planPrices WHERE planPriceID = 1)
    INSERT INTO solturaDB.sol_planPrices (planPriceID, planID, amount, currency_id, postTime, "current")
    VALUES (1, 1, 100.00, 1, GETDATE(), 1);

-- ejecucion de procedimiento
EXEC dbo.sp_RenovarSuscripcionAutomatica 
    @userID = 1,
    @planPriceID = 1,
    @paymentMethodID = 1,
    @currencyID = 1,
    @resultado = @resultado OUTPUT,
    @mensaje = @mensaje OUTPUT;
-- resultados
SELECT 
    'Resultado' = CASE WHEN @resultado = 1 THEN '�xito' ELSE 'Fallo' END,
    'Mensaje' = @mensaje,
    'Detalles' = 'PagoID: ' + ISNULL((SELECT TOP 1 CAST(paymentID AS VARCHAR) FROM solturaDB.sol_payments ORDER BY paymentID DESC), 'N/A') +
                ', TransID: ' + ISNULL((SELECT TOP 1 CAST(transactionsID AS VARCHAR) FROM solturaDB.sol_transactions ORDER BY transactionsID DESC), 'N/A') +
                ', UserPlan: ' + ISNULL((SELECT TOP 1 CAST(userPlanID AS VARCHAR) FROM solturaDB.sol_userPlans ORDER BY userPlanID DESC), 'N/A');

-- detalles de las tablas afectadas
SELECT TOP 1 
    '�ltimo Pago' = 'ID: ' + CAST(paymentID AS VARCHAR) + 
                   ', Monto: ' + CAST(amount AS VARCHAR) + 
                   ', M�todo: ' + CAST(methodID AS VARCHAR) + 
                   ', Fecha: ' + CONVERT(VARCHAR, date_pay, 120)
FROM solturaDB.sol_payments 
ORDER BY paymentID DESC;
SELECT TOP 1 
    '�ltima Transacci�n' = 'ID: ' + CAST(t.transactionsID AS VARCHAR) + 
                         ', Monto: ' + CAST(t.amount AS VARCHAR) + 
                         ', Tipo: ' + ISNULL(tt.name, 'N/A') + 
                         ', Fecha: ' + CONVERT(VARCHAR, t.date, 120)
FROM solturaDB.sol_transactions t
LEFT JOIN solturaDB.sol_transactionTypes tt ON t.transactionTypesID = tt.transactionTypeID
ORDER BY t.transactionsID DESC;
SELECT TOP 1 
    'UserPlan Actualizado' = 'ID: ' + CAST(up.userPlanID AS VARCHAR) + 
                           ', PlanID: ' + CAST(up.planPriceID AS VARCHAR) + 
                           ', ScheduleID: ' + CAST(up.scheduleID AS VARCHAR) + 
                           ', Estado: ' + CASE WHEN up.enabled = 1 THEN 'Activo' ELSE 'Inactivo' END
FROM solturaDB.sol_userPlans up
ORDER BY up.userPlanID DESC;

```

3. 
Escribir un SELECT que use CASE para crear una columna calculada que agrupe dinámicamente datos (por ejemplo, agrupar cantidades de usuarios por plan en rangos de monto, no use este ejemplo).
```sql
--Escribir un SELECT que use CASE para crear una columna calculada que agrupe din�micamente datos (por ejemplo, agrupar cantidades de usuarios por plan en rangos de monto, no use este ejemplo).USE solturaDB;
-- Clasificaci�n de usuarios por antig�edad (usando datos reales de las tablas)
SELECT 
    u.userID,
    u.firstName + ' ' + u.lastName AS fullName,
    u.email,
    up.adquisition AS fechaAdquisicion,
    DATEDIFF(MONTH, up.adquisition, GETDATE()) AS mesesActivo,
    CASE 
        WHEN DATEDIFF(MONTH, up.adquisition, GETDATE()) < 6 THEN 'Nuevo (0-6 meses)'
        WHEN DATEDIFF(MONTH, up.adquisition, GETDATE()) BETWEEN 6 AND 12 THEN 'Intermedio (6-12 meses)'
        WHEN DATEDIFF(MONTH, up.adquisition, GETDATE()) BETWEEN 13 AND 24 THEN 'Avanzado (1-2 a�os)'
        ELSE 'Experto (+2 a�os)'
    END AS segmentoAntiguedad
FROM solturaDB.sol_users u
JOIN solturaDB.sol_userPlans up ON u.userID = up.userID
WHERE up.enabled = 1
ORDER BY mesesActivo DESC;

```

4. 
Imagine una cosulta que el sistema va a necesitar para mostrar cierta información, o reporte o pantalla, y que esa consulta vaya a requerir:
4 JOINs entre tablas.
2 funciones agregadas (ej. SUM, AVG).
3 subconsultas or 3 CTEs
Un CASE, CONVERT, ORDER BY, HAVING, una función escalar, y operadores como IN, NOT IN, EXISTS.
Escriba dicha consulta y ejecutela con el query analizer, utilizando el analizador de pesos y costos del plan de ejecución, reacomode la consulta para que sea más eficiente sin necesidad de agregar nuevos índices.
    
Solución Optimizada:
```sql
USE solturaDB;
GO

;WITH ValidPayments AS (
    SELECT p.paymentID, p.amount, t.user_id
    FROM SolturaDB.sol_payments p
    INNER JOIN SolturaDB.sol_transactions t ON p.paymentID = t.payment_id
    WHERE p.confirmed = 1
),
UserTotalPayments AS (
    SELECT user_id, SUM(amount) AS total_paid
    FROM ValidPayments
    GROUP BY user_id
),
ActivePlans AS (
    SELECT userID, planPriceID
    FROM SolturaDB.sol_userPlans
    WHERE adquisition > '2024-01-01'
),
PlanAmounts AS (
    SELECT planPriceID, amount
    FROM SolturaDB.sol_planPrices
),
HighSpenders AS (
    SELECT user_id
    FROM UserTotalPayments
    WHERE total_paid > 150000
)
SELECT 
    u.userID,
    u.firstName + ' ' + u.lastName AS fullName,
    COUNT(DISTINCT ap.planPriceID) AS totalPlans,
    AVG(CAST(pa.amount AS FLOAT)) AS avgPlanAmount,
    ISNULL(ut.total_paid, 0) AS totalPayments,
    CASE 
        WHEN ut.total_paid > 250000 THEN 'VIP'
        WHEN ut.total_paid > 100000 THEN 'Premium'
        ELSE 'Standard'
    END AS userTier,
    CASE 
        WHEN hs.user_id IS NOT NULL THEN 1 ELSE 0
    END AS isHighSpender
FROM SolturaDB.sol_users u
LEFT JOIN ActivePlans ap ON u.userID = ap.userID
LEFT JOIN PlanAmounts pa ON ap.planPriceID = pa.planPriceID
LEFT JOIN UserTotalPayments ut ON u.userID = ut.user_id
LEFT JOIN HighSpenders hs ON u.userID = hs.user_id
WHERE u.email NOT IN ('test@example.com', 'spam@example.com')
GROUP BY u.userID, u.firstName, u.lastName, ut.total_paid, hs.user_id
ORDER BY totalPayments DESC;

```
Solución Sin Optimizar:
```sql

WITH ActivePlans AS (
    SELECT userID, planPriceID
    FROM solturaDB.sol_userPlans
    WHERE adquisition > '2024-01-01'
),
UserTotalPayments AS (
    SELECT user_id, SUM(amount) AS total_paid
    FROM solturaDB.sol_transactions
    GROUP BY user_id
),
HighSpenders AS (
    SELECT user_id
    FROM solturaDB.sol_transactions
    GROUP BY user_id
    HAVING SUM(amount) > 150000
)
SELECT 
    u.userID,
    u.firstName + ' ' + u.lastName AS fullName,
    COUNT(DISTINCT up.planPriceID) AS totalPlans,
    AVG(CAST(pp.amount AS FLOAT)) AS avgPlanAmount,
    SUM(p.amount) AS totalPayments,
    CASE 
        WHEN ut.total_paid > 250000 THEN 'VIP'
        WHEN ut.total_paid > 100000 THEN 'Premium'
        ELSE 'Standard'
    END AS userTier,
    CASE 
        WHEN EXISTS (
            SELECT 1 
            FROM HighSpenders hs 
            WHERE hs.user_id = u.userID
        ) THEN 1
        ELSE 0
    END AS isHighSpender
FROM solturaDB.sol_users u
JOIN solturaDB.sol_userPlans up ON u.userID = up.userID
JOIN solturaDB.sol_planPrices pp ON up.planPriceID = pp.planPriceID
JOIN solturaDB.sol_transactions t ON u.userID = t.user_id
JOIN solturaDB.sol_payments p ON t.payment_id = p.paymentID
LEFT JOIN UserTotalPayments ut ON u.userID = ut.user_id
WHERE p.confirmed = 1 
  AND u.email NOT IN ('test@example.com', 'spam@example.com')
GROUP BY u.userID, u.firstName, u.lastName, ut.total_paid
ORDER BY totalPayments DESC;

```

5. 
Crear una consulta con al menos 3 JOINs que analice información donde podría ser importante obtener un SET DIFFERENCE y un INTERSECTION
```sql
USE solturaDB;
GO

-- Usuarios con planes activos
WITH UsersWithPlans AS (
    SELECT DISTINCT u.userID
    FROM SolturaDB.sol_users u
    JOIN SolturaDB.sol_userPlans up ON u.userID = up.userID
    JOIN SolturaDB.sol_planPrices pp ON up.planPriceID = pp.planPriceID
    WHERE up.enabled = 1
),

-- Usuarios con pagos v�lidos 
UsersWithPayments AS (
    SELECT DISTINCT t.user_id
    FROM SolturaDB.sol_transactions t
    JOIN SolturaDB.sol_payments p ON t.payment_id = p.paymentID
    WHERE p.confirmed = 1
)

-- Usuarios que tienen plan Y han hecho pagos v�lidos
SELECT u.userID, u.firstName + ' ' + u.lastName AS fullName, 'Plan y pago v�lido' AS estado
FROM SolturaDB.sol_users u
WHERE u.userID IN (
    SELECT userID FROM UsersWithPlans
    INTERSECT
    SELECT user_id FROM UsersWithPayments
)

UNION ALL

--Usuarios que tienen plan PERO NO han hecho pagos v�lidos
SELECT u.userID, u.firstName + ' ' + u.lastName AS fullName, 'Plan sin pago v�lido' AS estado
FROM SolturaDB.sol_users u
WHERE u.userID IN (
    SELECT userID FROM UsersWithPlans
    EXCEPT
    SELECT user_id FROM UsersWithPayments
)
ORDER BY estado, fullName;
```

6. 
Crear un procedimiento almacenado transaccional que llame a otro SP transaccional, el cual a su vez llame a otro SP transaccional. Cada uno debe modificar al menos 2 tablas. Se debe demostrar que es posible hacer COMMIT y ROLLBACK con ejemplos exitosos y fallidos sin que haya interrumpción de la ejecución correcta de ninguno de los SP en ninguno de los niveles del llamado.

```sql
USE solturaDB;
GO

CREATE OR ALTER PROCEDURE sp_RegistrarPago
    @AvailableMethodID INT,
    @CurrencyID INT,
    @Amount DECIMAL(10,2),
    @Description NVARCHAR(255),
    @UserID INT,
    @PaymentID INT OUTPUT,
    @Exito BIT OUTPUT,
    @Mensaje NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;
        IF NOT EXISTS (SELECT 1 FROM solturaDB.sol_availablePayMethods WHERE available_method_id = @AvailableMethodID AND userID = @UserID)
        BEGIN
            SET @Exito = 0;
            SET @Mensaje = 'M�todo de pago no disponible para el usuario';
            ROLLBACK;
            RETURN;
        END
        DECLARE @MethodID INT;
        SELECT @MethodID = methodID FROM solturaDB.sol_availablePayMethods WHERE available_method_id = @AvailableMethodID;

        IF NOT EXISTS (SELECT 1 FROM solturaDB.sol_payMethod WHERE payMethodID = @MethodID AND enabled = 1)
        BEGIN
            SET @Exito = 0;
            SET @Mensaje = 'M�todo de pago no habilitado';
            ROLLBACK;
            RETURN;
        END
        INSERT INTO solturaDB.sol_payments (
            availableMethodID, currency_id, amount, date_pay, confirmed,
            result, auth, [reference], charge_token, [description],
            error, checksum, methodID
        )
        VALUES (
            @AvailableMethodID, @CurrencyID, @Amount, GETDATE(), 0,
            'Procesando', NEWID(), 'REF-' + CAST(NEXT VALUE FOR sol_payment_ref_seq AS NVARCHAR(20)),
            CAST('charge_tok_' + CAST(NEWID() AS NVARCHAR(50)) AS VARBINARY(255)),
            @Description, NULL,
            CAST('checksum_' + CAST(NEWID() AS NVARCHAR(50)) AS VARBINARY(250)),
            @MethodID
        );

        SET @PaymentID = SCOPE_IDENTITY();

        COMMIT;
        SET @Exito = 1;
        SET @Mensaje = 'Pago registrado exitosamente';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;

        SET @Exito = 0;
        SET @Mensaje = 'Error en sp_RegistrarPago: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
CREATE OR ALTER PROCEDURE sp_ProcesarCompraDeal
    @DealID INT,
    @UserID INT,
    @AvailableMethodID INT,
    @TransactionID INT OUTPUT,
    @Exito BIT OUTPUT,
    @Mensaje NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @PaymentID INT;
    DECLARE @CurrencyID INT = 1;
    DECLARE @Amount DECIMAL(10,2);
    DECLARE @PartnerID INT;
    DECLARE @Comision DECIMAL(5,2);
    BEGIN TRY
        BEGIN TRANSACTION;
        IF NOT EXISTS (SELECT 1 FROM solturaDB.sol_deals WHERE dealId = @DealID AND isActive = 1)
        BEGIN
            SET @Exito = 0;
            SET @Mensaje = 'Deal no disponible o no activo';
            ROLLBACK;
            RETURN;
        END
        SELECT
            @Amount = fp.finalPrice,
            @PartnerID = d.partnerId,
            @Comision = d.solturaComission
        FROM solturaDB.sol_deals d
        JOIN solturaDB.sol_planFeatures pf ON d.dealId = pf.dealId
        JOIN solturaDB.sol_featurePrices fp ON pf.planFeatureID = fp.planFeatureID
        WHERE d.dealId = @DealID AND fp."current" = 1;

        DECLARE @DescriptionDeal NVARCHAR(255);
        SET @DescriptionDeal = 'Compra de deal ' + CAST(@DealID AS NVARCHAR);

        EXEC sp_RegistrarPago
            @AvailableMethodID, @CurrencyID, @Amount,
            @DescriptionDeal, @UserID,
            @PaymentID OUTPUT, @Exito OUTPUT, @Mensaje OUTPUT;

        IF @Exito = 0
        BEGIN
            ROLLBACK;
            RETURN;
        END
        INSERT INTO solturaDB.sol_transactions (
            payment_id, date, postTime, refNumber, user_id, checksum,
            exchangeRate, convertedAmount, transactionTypesID,
            transactionSubtypesID, amount, exchangeCurrencyID
        )
        VALUES (
            @PaymentID, GETDATE(), GETDATE(), 'TXN-' + CONVERT(NVARCHAR(20), NEXT VALUE FOR sol_txn_ref_seq),
            @UserID, CAST('checksum_txn_' + CAST(NEWID() AS NVARCHAR(50)) AS VARBINARY(250)),
            1.0, @Amount, 1,
            CASE
                WHEN @AvailableMethodID IN (1,4,7,13) THEN 1 -- Tarjeta de cr�dito
                WHEN @AvailableMethodID IN (2,10,16) THEN 2 -- Transferencia bancaria
                WHEN @AvailableMethodID IN (5,6,12) THEN 3 -- Efectivo
                ELSE 4 
            END,
            @Amount, 1
        );
        SET @TransactionID = SCOPE_IDENTITY();
        DECLARE @ComisionAmount DECIMAL(10,2) = @Amount * (@Comision / 100);

        INSERT INTO solturaDB.sol_balances (
            amount, expirationDate, lastUpdate, balanceTypeID, userId
        )
        VALUES (
            @ComisionAmount, DATEADD(MONTH, 6, GETDATE()), GETDATE(), 1, @UserID
        );
        COMMIT;
        SET @Exito = 1;
        SET @Mensaje = 'Compra de deal procesada exitosamente';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        SET @Exito = 0;
        SET @Mensaje = 'Error en sp_ProcesarCompraDeal: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
CREATE OR ALTER PROCEDURE sp_ComprarDealPremium
    @DealID INT,
    @UserID INT,
    @AvailableMethodID INT,
    @TransactionID INT OUTPUT,
    @Exito BIT OUTPUT,
    @Mensaje NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        IF NOT EXISTS (
            SELECT 1
            FROM solturaDB.sol_userPlans up
            JOIN solturaDB.sol_plans p ON up.planPriceID = p.planID
            JOIN solturaDB.sol_planTypes pt ON p.planTypeID = pt.planTypeID
            WHERE up.userID = @UserID
            AND up.enabled = 1
            AND pt.type IN ('Premium', 'Gold - Acceso Total', 'Empresarial Avanzado')
        )
        BEGIN
            SET @Exito = 0;
            SET @Mensaje = 'Usuario no tiene un plan premium para acceder a este deal';
            ROLLBACK;
            RETURN;
        END
        EXEC sp_ProcesarCompraDeal
            @DealID, @UserID, @AvailableMethodID,
            @TransactionID OUTPUT, @Exito OUTPUT, @Mensaje OUTPUT;
        IF @Exito = 0
        BEGIN
            ROLLBACK;
            RETURN;
        END
        UPDATE solturaDB.sol_payments
        SET confirmed = 1, result = 'Aprobado'
        WHERE paymentID = (
            SELECT payment_id FROM solturaDB.sol_transactions WHERE transactionsID = @TransactionID
        );
        COMMIT;
        SET @Exito = 1;
        SET @Mensaje = 'Compra premium procesada exitosamente';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        SET @Exito = 0;
        SET @Mensaje = 'Error en sp_ComprarDealPremium: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
CREATE OR ALTER PROCEDURE sp_ComprarDealPremium
    @DealID INT,
    @UserID INT,
    @AvailableMethodID INT,
    @TransactionID INT OUTPUT,
    @Exito BIT OUTPUT,
    @Mensaje NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        IF NOT EXISTS (
            SELECT 1
            FROM solturaDB.sol_userPlans up
            JOIN solturaDB.sol_plans p ON up.planPriceID = p.planID
            JOIN solturaDB.sol_planTypes pt ON p.planTypeID = pt.planTypeID
            WHERE up.userID = @UserID
            AND up.enabled = 1
            AND pt.type IN ('Premium', 'Gold - Acceso Total', 'Empresarial Avanzado')
        )
        BEGIN
            SET @Exito = 0;
            SET @Mensaje = 'Usuario no tiene un plan premium para acceder a este deal';
            ROLLBACK;
            RETURN;
        END
        EXEC sp_ProcesarCompraDeal
            @DealID, @UserID, @AvailableMethodID,
            @TransactionID OUTPUT, @Exito OUTPUT, @Mensaje OUTPUT;
        IF @Exito = 0
        BEGIN
            ROLLBACK;
            RETURN;
        END
        UPDATE solturaDB.sol_payments
        SET confirmed = 1, result = 'Aprobado'
        WHERE paymentID = (
            SELECT payment_id FROM solturaDB.sol_transactions WHERE transactionsID = @TransactionID
        );
        COMMIT;
        SET @Exito = 1;
        SET @Mensaje = 'Compra premium procesada exitosamente';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        SET @Exito = 0;
        SET @Mensaje = 'Error en sp_ComprarDealPremium: ' + ERROR_MESSAGE();
    END CATCH
END;
GO



--Probar los procedures -> Esta ejecuci�n fallar�, puesto que un usuario con un plan no premiun, intenta acceder a un plan premiun
DECLARE @TransactionID INT, @Exito BIT, @Mensaje NVARCHAR(500);
EXEC sp_ComprarDealPremium 
    @DealID = 1, 
    @UserID = 2, 
    @AvailableMethodID = 2,
    @TransactionID = @TransactionID OUTPUT, 
    @Exito = @Exito OUTPUT, 
    @Mensaje = @Mensaje OUTPUT;
SELECT @Exito AS Exito, @Mensaje AS Mensaje, @TransactionID AS TransactionID;
SELECT * FROM solturaDB.sol_payments WHERE paymentID IN (SELECT payment_id 
														FROM solturaDB.sol_transactions 
														WHERE transactionsID = @TransactionID);
SELECT * FROM solturaDB.sol_transactions WHERE transactionsID = @TransactionID;
```

7. 
Será posible que haciendo una consulta SQL en esta base de datos se pueda obtener un JSON para ser consumido por alguna de las pantallas de la aplicación que tenga que ver con los planes, subscripciones, servicios o pagos. Justifique cuál pantalla podría requerir esta consulta.

Esta consulta puede ser requerida en alguna pantalla cuando algún usuario quiera ver información sobre su supscripción actual.
```sql
USE solturaDB;
GO

DECLARE @UserID INT = 1;

SELECT
    (SELECT TOP 1
        p.description AS planName,
        pt.type AS planType,
        pp.amount AS planAmount,
        c.symbol AS currencySymbol
    FROM solturaDB.sol_userPlans up
    JOIN solturaDB.sol_plans p ON up.planPriceID = p.planID
    JOIN solturaDB.sol_planTypes pt ON p.planTypeID = pt.planTypeID
    JOIN solturaDB.sol_planPrices pp ON p.planID = pp.planID AND pp."current" = 1
    JOIN solturaDB.sol_currencies c ON pp.currency_id = c.currency_id
    WHERE up.userID = @UserID AND up.enabled = 1
    ORDER BY up.adquisition DESC
    FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS planInfo,
    (SELECT
        pf.description AS featureDescription,
        ft.type AS featureType,
        (SELECT TOP 1 fp.finalPrice FROM solturaDB.sol_featurePrices fp 
		JOIN solturaDB.sol_planFeatures plf ON fp.planFeatureID = plf.planFeatureID 
		WHERE plf.planFeatureID = fpp.planFeatureID AND fp."current" = 1 ORDER BY fp.featurePriceID DESC) AS featurePrice
    FROM solturaDB.sol_featuresPerPlans fpp
    JOIN solturaDB.sol_planFeatures pf ON fpp.planFeatureID = pf.planFeatureID
    JOIN solturaDB.sol_featureTypes ft ON pf.featureTypeID = ft.featureTypeID
    WHERE fpp.planID = (SELECT TOP 1 up.planPriceID FROM solturaDB.sol_userPlans up 
						WHERE up.userID = @UserID AND up.enabled = 1 ORDER BY up.adquisition DESC)
    FOR JSON PATH) AS features,
    (SELECT TOP 5 -- Obtener los 5 pagos m�s recientes
        pay.paymentID,
        pay.date_pay,
        pay.amount,
        c2.symbol AS paymentCurrencySymbol,
        pay.result,
        pm.name AS paymentMethod
    FROM solturaDB.sol_payments pay
    JOIN solturaDB.sol_availablePayMethods apm ON pay.availableMethodID = apm.available_method_id
    JOIN solturaDB.sol_payMethod pm ON apm.methodID = pm.payMethodID
    JOIN solturaDB.sol_currencies c2 ON pay.currency_id = c2.currency_id
    WHERE apm.userID = @UserID
    ORDER BY pay.date_pay DESC
    FOR JSON PATH) AS recentPayments
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;
GO



--Esta consulta puede ser requerida en alguna pantalla cuando alg�n usuario quiera ver informaci�n sobre su supscripci�n actual
```

8. 
Podrá su base de datos soportar un SP transaccional que actualice los contratos de servicio de un proveedor, el proveedor podría ya existir o ser nuevo, si es nuevo, solo se inserta. Las condiciones del contrato del proveedor, deben ser suministradas por un Table-Valued Parameter (TVP), si las condiciones son sobre items existentes, entonces se actualiza o inserta realizando las modificacinoes que su diseño requiera, si son condiciones nuevas, entonces se insertan.
```sql
USE solturaDB;
GO

-- Definici�n del Table-Valued Parameter (TVP) para las condiciones del contrato
IF NOT EXISTS (SELECT 1 FROM sys.types WHERE name = 'ContractConditionsType')
BEGIN
  CREATE TYPE dbo.ContractConditionsType AS TABLE
  (
      ItemID INT NULL,  
	  Description NVARCHAR(255) NOT NULL,
      StartDate DATE NOT NULL,
      EndDate DATE NULL,
      Price DECIMAL(10, 2) NOT NULL 
      UNIQUE (ItemID) 
  );
END;
GO

CREATE OR ALTER PROCEDURE sp_ActualizarContratoProveedorConDeals
    @ProveedorID INT = NULL, 
    @NombreProveedor NVARCHAR(255) NULL,
    @CondicionesContrato dbo.ContractConditionsType READONLY,
    @EsContrato BIT = 1,
    @Exito BIT OUTPUT,
    @Mensaje NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF @ProveedorID IS NULL
        BEGIN
            IF @NombreProveedor IS NULL
            BEGIN
                SET @Exito = 0;
                SET @Mensaje = 'El nombre del proveedor es requerido para un nuevo proveedor.';
                ROLLBACK;
                RETURN;
            END

            INSERT INTO solturaDB.sol_partners (name, registerDate, state, identificationtypeId, enterpriseSizeid, identification)
            VALUES (@NombreProveedor, GETDATE(), 1, 1, 1, 'PENDIENTE');

            SET @ProveedorID = SCOPE_IDENTITY();

            IF @ProveedorID IS NULL
            BEGIN
                SET @Exito = 0;
                SET @Mensaje = 'Error al insertar el nuevo proveedor.';
                ROLLBACK;
                RETURN;
            END
        END
        ELSE
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM solturaDB.sol_partners WHERE partnerId = @ProveedorID)
            BEGIN
                SET @Exito = 0;
                SET @Mensaje = 'El proveedor con el ID especificado no existe.';
                ROLLBACK;
                RETURN;
            END
        END
        MERGE solturaDB.sol_deals AS target
        USING @CondicionesContrato AS source
        ON target.partnerId = @ProveedorID AND target.dealDescription = source.Description
        WHEN MATCHED THEN
            UPDATE SET
                target.sealDate = source.StartDate,
                target.endDate = source.EndDate,
                target.isActive = 1
        WHEN NOT MATCHED THEN
            INSERT (partnerId, dealDescription, sealDate, endDate, solturaComission, discount, isActive)
            VALUES (@ProveedorID, source.Description, source.StartDate, source.EndDate, 0.00, source.Price * -1, 1);
        COMMIT TRANSACTION;
        SET @Exito = 1;
        SET @Mensaje = 'Contrato de proveedor actualizado exitosamente (utilizando sol_deals).';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        SET @Exito = 0;
        SET @Mensaje = 'Error al actualizar el contrato del proveedor (utilizando sol_deals): ' + ERROR_MESSAGE();
    END CATCH
END;
GO



--Forma de probar el query :D 
DECLARE @ContractConditions AS dbo.ContractConditionsType;
INSERT INTO @ContractConditions (ItemID, Description, StartDate, EndDate, Price)
VALUES
(1, 'Servicio Inicial', '2025-08-01', '2026-07-31', 300.00);

DECLARE @Exito BIT;
DECLARE @Mensaje NVARCHAR(500);

EXEC sp_ActualizarContratoProveedorConDeals
    @ProveedorID = NULL,
    @NombreProveedor = 'Proveedor C',
    @CondicionesContrato = @ContractConditions,
    @Exito = @Exito OUTPUT,
    @Mensaje = @Mensaje OUTPUT;

--SELECT @Exito AS Exito, @Mensaje AS Mensaje;
SELECT * FROM solturaDB.sol_partners WHERE name = 'Proveedor C';
SELECT * FROM solturaDB.sol_deals WHERE partnerId = (SELECT TOP 1 partnerId FROM solturaDB.sol_partners WHERE name = 'Proveedor C');
GO
```

9. 
Crear un SELECT que genere un archivo CSV de datos basado en un JOIN entre dos tablas

```sql
Use solturaDB
-- Primero, esta es la consulta con JOIN
SELECT 
    u.userID, 
    u.firstName + ' ' + u.lastName AS fullName,
    u.email, 
    up.adquisition, 
    up.enabled
FROM solturaDB.sol_users u
JOIN solturaDB.sol_userPlans up ON u.userID = up.userID;
```
Resultados CSV
|1  |nuevoNombre Sistema|admin@soltura.com           |2023-01-01|0x01|
|---|-------------------|----------------------------|----------|----|
|2  |Nombre2 Pérez      |juan.perez@example.com      |2023-02-15|0x01|
|3  |María Gómez        |maria.gomez@example.com     |2023-03-10|0x01|
|4  |Carlos Rodríguez   |carlos.rodriguez@example.com|2023-04-20|0x01|
|5  |Ana Martínez       |ana.martinez@example.com    |2023-05-05|0x01|
|6  |Luis Hernández     |luis.hdez@example.com       |2023-01-15|0x01|
|7  |Sofía Castro       |sofia.castro@example.com    |2023-02-20|0x01|
|8  |Pedro Mendoza      |pedro.mendoza@example.com   |2023-03-25|0x01|
|9  |Laura Gutiérrez    |laura.gutierrez@example.com |2023-04-10|0x01|
|10 |Diego Ramírez      |diego.ramirez@example.com   |2023-05-15|0x01|
|11 |Elena Sánchez      |elena.sanchez@example.com   |2023-01-20|0x01|
|12 |Javier López       |javier.lopez@example.com    |2023-02-25|0x01|
|13 |Isabel García      |isabel.garcia@example.com   |2023-03-30|0x01|
|14 |Miguel Torres      |miguel.torres@example.com   |2023-04-05|0x01|
|15 |Carmen Ortiz       |carmen.ortiz@example.com    |2023-05-10|0x01|
|16 |Raúl Morales       |raul.morales@example.com    |2023-01-25|0x01|
|17 |Patricia Vargas    |patricia.vargas@example.com |2023-02-28|0x01|
|18 |Oscar Díaz         |oscar.diaz@example.com      |2023-03-05|0x01|
|19 |Adriana Ruiz       |adriana.ruiz@example.com    |2023-04-15|0x01|
|20 |Fernando Molina    |fernando.molina@example.com |2023-05-20|0x01|
|21 |Gabriela Silva     |gabriela.silva@example.com  |2023-01-30|0x01|
|22 |Arturo Cruz        |arturo.cruz@example.com     |2023-02-05|0x01|
|23 |Claudia Reyes      |claudia.reyes@example.com   |2023-03-15|0x01|
|24 |Manuel Aguilar     |manuel.aguilar@example.com  |2023-04-25|0x01|
|25 |Diana Flores       |diana.flores@example.com    |2023-05-30|0x01|
|26 |Roberto Campos     |roberto.campos@example.com  |2023-06-01|0x01|
|27 |Silvia Méndez      |silvia.mendez@example.com   |2023-06-05|0x01|
|28 |Eduardo Guerra     |eduardo.guerra@example.com  |2023-06-10|0x01|
|29 |Lucía Sosa         |lucia.sosa@example.com      |2023-06-15|0x01|
|30 |Hugo Ríos          |hugo.rios@example.com       |2023-06-20|0x01|


10. 
Configurar una tabla de bitácora en otro servidor SQL Server accesible vía Linked Servers con impersonación segura desde los SP del sistema. Ahora haga un SP genérico para que cualquier SP en el servidor principal, pueda dejar bitácora en la nueva tabla que se hizo en el Linked Server.
```sql
USE master;
GO

-- Verifica si el Linked Server ya existe. Si existe, lo elimina.
IF EXISTS (SELECT 1 FROM sys.servers WHERE name = 'LocalServer')
BEGIN
    PRINT 'Eliminando el Linked Server existente...';
    EXEC sp_dropserver @server = 'LocalServer', @droplogins = 'droplogins';
END;
GO

--Se crea un servidor vincluado a una estancia local, esto puesto no tenemos un servidor real. 
EXEC sp_addlinkedserver
    @server = 'LocalServer', 
    @srvproduct = 'SQL Server';

EXEC sp_addlinkedsrvlogin
    @rmtsrvname = 'LocalServer',
    @useself = 'True',
    @locallogin = NULL;

EXEC sp_serveroption 'LocalServer', 'rpc', 'TRUE';
EXEC sp_serveroption 'LocalServer', 'rpc out', 'TRUE';
GO

PRINT 'Servidor vinculado.';

--Se crea una tabla de bit�cora en esta instancia local. 
USE master;
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'RegistroBitacora')
BEGIN
    CREATE TABLE  dbo.RegistroBitacora (
        ID INT PRIMARY KEY IDENTITY(1,1),
        FechaHora DATETIME,
        NombreProcedimiento NVARCHAR(255),
        Mensaje NVARCHAR(MAX),
        UsuarioSQL NVARCHAR(255),
        Servidor NVARCHAR(255),
        Gravedad INT NOT NULL,
        NombreAplicacion NVARCHAR(255) );
    PRINT 'Tabla de bit�cora creada.';
END;
ELSE
    PRINT 'La tabla de bit�cora ya existe.';
GO


-- Utilizando la base de datos, se hace un proceso de almacenamiento de datos.

USE solturaDB;
GO

IF OBJECT_ID('sp_RegistrarEventoBitacora', 'P') IS NOT NULL
BEGIN
    PRINT 'Eliminando el procedimiento almacenado existente...';
    DROP PROCEDURE sp_RegistrarEventoBitacora;
END;
GO

CREATE PROCEDURE sp_RegistrarEventoBitacora (
    @NombreProcedimiento NVARCHAR(255),
    @Mensaje NVARCHAR(MAX),
    @Gravedad INT = 0,
    @NombreAplicacion NVARCHAR(255) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Inserta en la tabla de bit�cora del servidor en la instancia local!!!!!
        INSERT INTO master.dbo.RegistroBitacora (
            FechaHora,
            NombreProcedimiento,
            Mensaje,
            UsuarioSQL,
            Servidor,
            Gravedad,
            NombreAplicacion
        )
        VALUES ( GETDATE(),@NombreProcedimiento, @Mensaje, SUSER_SNAME(),@@SERVERNAME, @Gravedad,
				ISNULL(@NombreAplicacion, APP_NAME()));
    END TRY
    BEGIN CATCH
        PRINT 'Error al registrar en la bit�cora: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

PRINT 'Procedimiento almacenado gen�rico creado exitosamente.';




USE solturaDB;
GO

--Proceso para probar el Script
EXEC sp_RegistrarEventoBitacora
    @NombreProcedimiento = 'PruebaDeBitacora',
    @Mensaje = 'Esto es un mensaje de prueba.',
    @Gravedad = 0,
    @NombreAplicacion = 'Soltura';

-- Verifica el registro en la tabla de bit�cora
SELECT * FROM master.dbo.RegistroBitacora;
GO
```
---
## Concurrencia


Cree una situación de deadlocks entre dos transacciones que podrían llegar a darse en el sistema en el momento de hacer un canje de un servicio donde el deadlock se de entre un SELECT y UPDATE en distintas tablas.



Transacción A
```
BEGIN TRANSACTION;

-- Simular un SELECT en la primera tabla
SELECT * FROM solturaDB.sol_countries
WHERE name = 'Costa Rica Actualizado';

-- Esperar para simular alta concurrencia
WAITFOR DELAY '00:00:10';

-- Intentar actualizar la segunda tabla
UPDATE solturaDB.sol_states
SET name = 'San José '
WHERE name = 'San José Actualizado';

COMMIT;
```

Transacción B
```
BEGIN TRANSACTION;

-- Simular un SELECT en la segunda tabla
SELECT * FROM solturaDB.sol_states
WHERE name = 'San José';

-- Esperar para simular alta concurrencia
WAITFOR DELAY '00:00:10';

-- Intentar actualizar la primera tabla
UPDATE solturaDB.sol_countries
SET name = 'Costa Rica '
WHERE name = 'Costa Rica Actualizado';

COMMIT;
```

Determinar si es posible que suceden deadlocks en cascada, donde A bloquea B, B bloquea C, y C bloquea A, debe poder observar el deadlock en algún monitor.


Lo que pasa es que una de estas se sacrifica por el deadlock

Transacción 1
```
BEGIN TRANSACTION;
UPDATE solturaDB.sol_users SET firstName = 'nuevoNombre' WHERE userID = 1;
WAITFOR DELAY '00:00:03';
UPDATE solturaDB.sol_payments SET amount = amount + 100 WHERE paymentID = 1;
WAITFOR DELAY '00:00:03';
SELECT * FROM solturaDB.sol_balances WHERE userID = 1;
COMMIT TRANSACTION; 
```



Transacción 2
```
BEGIN TRANSACTION;
UPDATE solturaDB.sol_payments SET amount = amount + 200 WHERE paymentID = 2;
WAITFOR DELAY '00:00:03';
UPDATE solturaDB.sol_balances SET amount = amount + 300 WHERE balanceID = 1;
WAITFOR DELAY '00:00:03';
SELECT * FROM solturaDB.sol_users WHERE userID = 1;
COMMIT TRANSACTION;
```

Transacción 3
```
BEGIN TRANSACTION;
UPDATE solturaDB.sol_balances SET amount = amount + 400 WHERE balanceID = 2;
WAITFOR DELAY '00:00:03';
SELECT * FROM solturaDB.sol_payments WHERE paymentID = 3;
WAITFOR DELAY '00:00:03';
UPDATE solturaDB.sol_users SET firstName = 'Nombre2' WHERE userID = 2;
COMMIT TRANSACTION;
```


Determinar como deben usarse los niveles de isolacion: READ UNCOMMITTED, READ COMMITTED, REPEATABLE READ, SERIALIZABLE, mostrando los problemas posibles al usar cada tipo de isolación en casos particulares, se recomienda analizar casos como: obtener un reporte general histórico de alguna operación, calcular el tipo de cambio a utiliza en un momento dado, adquisición de planes cuando se están actualizando, cambios de precio durante subscripciones, agotamiento de existencias de algún beneficio.


UNCOMMITTED


1
```
USE solturaDB;
GO
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
BEGIN TRANSACTION;

SELECT exchangeCurrencyID, exchange_rate
FROM solturaDB.sol_exchangeCurrencies
WHERE sourceID = 1 AND destinyID = 2;


WAITFOR DELAY '00:00:05';  -- Espera a que Sesión B actualice y NO haga COMMIT

-- podría ver el valor nuevo aunque Sesión B no haya hecho COMMIT
SELECT exchangeCurrencyID, exchange_rate
FROM solturaDB.sol_exchangeCurrencies
WHERE sourceID = 1 AND destinyID = 2;

COMMIT;
```


2
```

USE solturaDB;
GO
SET TRANSACTION ISOLATION LEVEL READ COMMITTED; 
BEGIN TRANSACTION;

-- Actualiza la tasa de cambio
UPDATE solturaDB.sol_exchangeCurrencies
SET exchange_rate = 0.0020
WHERE sourceID = 1 AND destinyID = 2;

WAITFOR DELAY '00:00:10';  -- dura más que la espera de Sesión A

ROLLBACK; 
```

COMMITED


1
```
USE solturaDB;
GO
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRANSACTION;

-- Primera lectura del conteo de pagos
SELECT COUNT(*) AS total_pagos
FROM SolturaDB.sol_payments;
-- Supón que devuelve 100

WAITFOR DELAY '00:00:05';  -- durante este tiempo Sesión B inserta nuevos pagos y COMMIT

-- Segunda lectura del mismo conteo
SELECT COUNT(*) AS total_pagos
FROM SolturaDB.sol_payments;


COMMIT;
```


2
```
USE solturaDB;
GO

-- Espera 2s para que Sesión A ejecute la primera lectura
WAITFOR DELAY '00:00:02';

BEGIN TRANSACTION;

INSERT INTO SolturaDB.sol_payments (
    availableMethodID,
    currency_id,
    amount,
    date_pay,
    confirmed,
    result,
    auth,
    reference,
    charge_token,
    description,
    checksum,
    methodID
)
VALUES
    (1,                     -- availableMethodID
     1,                     -- currency_id
     50.00,                 -- amount
     GETDATE(),             -- date_pay
     1,                     -- confirmed
     'Aprobado',            -- result
     'AUTH_B1',             -- auth
     'REF_B1',              -- reference
     CAST('tokentest1' AS VARBINARY(255)),  -- charge_token
     'Prueba B1',           -- description
     HASHBYTES('SHA2_256','PruebaB1'),      -- checksum
     1),                    -- methodID

    (1,                     -- availableMethodID
     1,                     -- currency_id
     75.00,                 -- amount
     GETDATE(),             -- date_pay
     1,                     -- confirmed
     'Aprobado',            -- result
     'AUTH_B2',             -- auth
     'REF_B2',              -- reference
     CAST('tokentest2' AS VARBINARY(255)),  -- charge_token
     'Prueba B2',           -- description
     HASHBYTES('SHA2_256','PruebaB2'),      -- checksum
     1);                    -- methodID

COMMIT;
```

REPETEABLE


1
```
USE solturaDB;
GO
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN TRAN;

SELECT SUM(amount) AS total_consumos
  FROM SolturaDB.sol_transactions
  WHERE user_id = 5;               

WAITFOR DELAY '00:00:05';         

SELECT SUM(amount) AS total_consumos
  FROM SolturaDB.sol_transactions
  WHERE user_id = 5;             

COMMIT;
```

2
```
USE solturaDB;
GO

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
GO


WAITFOR DELAY '00:00:02';
GO

BEGIN TRANSACTION;

INSERT INTO SolturaDB.sol_transactions
  (payment_id, date, postTime, refNumber, user_id, checksum, exchangeRate, convertedAmount, transactionTypesID, transactionSubtypesID, amount, exchangeCurrencyID)
VALUES
  (1, GETDATE(), GETDATE(), 'INV-100', 5, CAST('tokentest3' AS VARBINARY(255)), 1.0, 100.00, 1, 1, 100.00, 1),
  (1, GETDATE(), GETDATE(), 'INV-101', 5, CAST('tokentest4' AS VARBINARY(255)), 1.0,  50.00, 1, 1,  50.00, 1);

COMMIT;
GO
```


SERIALIZABLE

1
```
USE solturaDB;
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRAN;

SELECT planPriceID, amount
  FROM solturaDB.sol_planPrices
  WHERE planID = 3;              

WAITFOR DELAY '00:00:10';        

SELECT planPriceID, amount
  FROM solturaDB.sol_planPrices
  WHERE planID = 3;             

COMMIT;
```


1
```
USE solturaDB;
GO


WAITFOR DELAY '00:00:02';

BEGIN TRAN;
UPDATE solturaDB.sol_planPrices
   SET amount = amount * 1.10
 WHERE planID = 3;               
COMMIT;
```



Crear un cursor de update que bloquee los registros que recorre uno a uno, demuestre en que casos dicho cursor los bloquea y en que casos no, para que el equipo de desarrollo sepa para que escenarios usar cursos y cuando no.


Los cursores sirven para ejecuciones de fila a fila no de alta concurrencia


CURSOR
```
DECLARE payment_cursor CURSOR FOR
SELECT paymentID
FROM solturaDB.sol_payments
WHERE confirmed = 1
ORDER BY paymentID;

DECLARE @paymentID INT;

OPEN payment_cursor;

FETCH NEXT FROM payment_cursor INTO @paymentID;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Bloquea el registro mientras est  dentro de la transacci n
    UPDATE solturaDB.sol_payments
    SET description = CONCAT(description, ' (Verificado)')
    WHERE paymentID = @paymentID;

    -- Simula procesamiento lento
    WAITFOR DELAY '00:00:05';

    FETCH NEXT FROM payment_cursor INTO @paymentID;
END

CLOSE payment_cursor;
DEALLOCATE payment_cursor;
```

Update que provoca un bloquea

```
USE solturaDB;
UPDATE solturaDB.sol_payments
SET result = 'Forzado'
WHERE paymentID = 3;
SELECT * FROM solturaDB.sol_payments
```


Defina lo que es la "transacción de volumen" de su base de datos, por ejemplo, en uber la transacción es buscar un driver, en paypal es procesar un pago, en amazon es buscar artículos, y así sucesivamente, es la operación que más solicitudes recibe el sistema, dicho esto:

La transacción de volumen sería payments.
Determine cuántas transacciones por segundo máximo es capaz de procesar su base de datos, valide el método con el profesor
61 por segundo con 100 hilos

Determine como podría triplicar el valor averiguado anteriormente sin hacer cambios en su base de datos ni incrementar hardware ni modificando el query


## Resultados
# Adquisiones en Costa Rica y Migración de datos

El archivo de migración es MigrationSetup.ipynb

# Migración de datos de MySql a SQL Server

### Primero hay que hacer las conexiones a las bases de datos


```python
import pandas as pd
from sqlalchemy import create_engine
import pyodbc
from shapely import wkb

mySqlConn = None
tSqlConn = None

def connectToDatabases():
    global mySqlConn, tSqlConn
    try:
        
        # Conectarse a MySQL
        mySqlConn = create_engine("mysql+mysqlconnector://root:123456@localhost/pay_assistant_db")

        # Conectarse a SQL Server con pyodbc
        tSqlConn = pyodbc.connect(
            'DRIVER={ODBC Driver 17 for SQL Server};'
            'SERVER=localhost;'
            'DATABASE=solturaDB;'
            'Trusted_Connection=yes;'
        )

        
        print("Éxito al conectarse!")


        # Conectarse a SQL Server
        # TODO
    
    except Exception as e:
        print (f"Error: {e}")
```


```python
connectToDatabases()
```

    Éxito al conectarse!
    

### Una vez hechas las conexiones, se va a extraer todos los datos de mysql a migrar


```python
# Instanciar las variables globales de las tablas con los datos a migrar
df_users = None
df_currencies = None
df_subscriptions = None
df_planPrices = None
df_planFeaturesSubscriptions = None
df_planFeatures = None
df_schedules = None
df_scheduleDetails = None
df_userPlanPrices = None
df_countries = None
df_states = None
df_cities = None
df_addresses = None
df_userAddresses = None
```


```python
# Esta función hace todos los queries de las tablas y los guarda en DataFrames
def extractAllData():
    global df_users, df_currencies, df_subscriptions, df_planPrices,df_planFeatures, df_planFeaturesSubscriptions, df_schedules, df_scheduleDetails, df_userPlanPrices, df_countries
    global df_cities, df_states, df_addresses, df_userAddresses
    df_users = pd.read_sql("SELECT * FROM pay_users;",mySqlConn)
    df_currencies = pd.read_sql("SELECT * FROM pay_currencies;",mySqlConn)
    df_subscriptions = pd.read_sql("SELECT * FROM pay_subscriptions;",mySqlConn)
    df_planPrices = pd.read_sql("SELECT * FROM pay_plan_prices;",mySqlConn)
    df_planFeaturesSubscriptions = pd.read_sql("SELECT * FROM pay_plan_features_subscriptions;",mySqlConn)
    df_planFeatures = pd.read_sql("SELECT * FROM pay_plan_features;",mySqlConn)
    df_schedules = pd.read_sql("SELECT * FROM pay_schedules;",mySqlConn)
    df_scheduleDetails = pd.read_sql("SELECT * FROM pay_schedules_details;",mySqlConn)
    df_userPlanPrices = pd.read_sql("SELECT * FROM pay_users_plan_prices;",mySqlConn)
    df_countries = pd.read_sql("SELECT * FROM pay_countries;",mySqlConn)
    df_states = pd.read_sql("SELECT * FROM pay_states;",mySqlConn)
    df_cities = pd.read_sql("SELECT * FROM pay_city;",mySqlConn)
    df_addresses = pd.read_sql("SELECT * FROM pay_addresses;",mySqlConn)
    df_userAddresses = pd.read_sql("SELECT * FROM pay_users_adresses;",mySqlConn)
```


```python
# Ahora se llama la función para meter todos los datos en los dataFrame
extractAllData()
```


```python
# Esta función lo que hace es preparar el geoposition para insertarlo en SQL Server
def parse_mysql_point(blob):
    if pd.isna(blob):
        return None
    try:
        return wkb.loads(blob[4:]).wkt  # saltar primeros 4 bytes (SRID)
    except Exception as e:
        print("Error con blob:", blob)
        return None

df_addresses['geoposition'] = df_addresses['geoposition'].apply(parse_mysql_point)
```

# Tablas a migrar

Tablas de usuarios:
- users
- userAddresses

Tablas de países:
- countries
- states
- cities

Tablas de direcciones:
- addresses

Tablas de schedules:
- schedules
- scheduleDetails

# Tablas a adaptar
Todo lo que involucra los planes, sus features y precios

### En esta parte se pueden ver los valores de las tablas al extraerse del MySql


```python
df_users
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>user_id</th>
      <th>email</th>
      <th>first_name</th>
      <th>last_name</th>
      <th>password</th>
      <th>enabled</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>PaulaPonce1@gmail.com</td>
      <td>Paula</td>
      <td>Ponce</td>
      <td>b'2bf5309e56428a57f073efd97e7668a08cfc74db0a44...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>EmmaRamos2@gmail.com</td>
      <td>Emma</td>
      <td>Ramos</td>
      <td>b'48e217aeaa990fa02a72367bda2ab6aeb77e87c9b4f4...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>RicardoSalazar3@gmail.com</td>
      <td>Ricardo</td>
      <td>Salazar</td>
      <td>b'228b4b3c75ace3216c8189a12cca88befb322d9696c2...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>AnaGarcía4@gmail.com</td>
      <td>Ana</td>
      <td>García</td>
      <td>b'0c44f0413a7351ae8a456633b6512797ea4cb515fa29...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>MartaMejía5@gmail.com</td>
      <td>Marta</td>
      <td>Mejía</td>
      <td>b'43fa4a3e9cdd525128edaa7b7b7fd330f41d3aeb44c2...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1045</th>
      <td>1046</td>
      <td>CamilaAcosta1046@gmail.com</td>
      <td>Camila</td>
      <td>Acosta</td>
      <td>b'13a33a2c53304fffac7614be31a4bfe851f8a6d9f439...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1046</th>
      <td>1047</td>
      <td>LorenaRamírez1047@gmail.com</td>
      <td>Lorena</td>
      <td>Ramírez</td>
      <td>b'850b066ee061196ac4ed3b237979a7197fa506228af5...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1047</th>
      <td>1048</td>
      <td>FranciscoEstrada1048@gmail.com</td>
      <td>Francisco</td>
      <td>Estrada</td>
      <td>b'288d77e654df324e0d688d227f806c74034c3254792d...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1048</th>
      <td>1049</td>
      <td>JavierGuerrero1049@gmail.com</td>
      <td>Javier</td>
      <td>Guerrero</td>
      <td>b'bd469a97a827aec59ef3593118fb364a0af0db1558f6...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1049</th>
      <td>1050</td>
      <td>ElenaFigueroa1050@gmail.com</td>
      <td>Elena</td>
      <td>Figueroa</td>
      <td>b'21a6cffef3fce12cf6ed2a3ff79ade9ff80b4678fe77...</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
<p>1050 rows × 6 columns</p>
</div>




```python
df_currencies
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>currency_id</th>
      <th>name</th>
      <th>acronym</th>
      <th>symbol</th>
      <th>country_id</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Colón Costarricense</td>
      <td>CRC</td>
      <td>₡</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Dólar Estadounidense</td>
      <td>USD</td>
      <td>$</td>
      <td>2</td>
    </tr>
  </tbody>
</table>
</div>




```python
df_subscriptions 
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>subscription_id</th>
      <th>description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Estándar</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Premium</td>
    </tr>
  </tbody>
</table>
</div>




```python
df_planPrices
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>plan_prices_id</th>
      <th>subscrition_Id</th>
      <th>amount</th>
      <th>currency_id</th>
      <th>postTime</th>
      <th>endDate</th>
      <th>current</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>1</td>
      <td>9.99</td>
      <td>2</td>
      <td>2025-04-30 06:06:52</td>
      <td>2025-12-31</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>2</td>
      <td>39.99</td>
      <td>2</td>
      <td>2025-04-30 06:06:52</td>
      <td>2025-12-31</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
</div>




```python
df_planFeaturesSubscriptions
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>plan_features_id</th>
      <th>subscription_id</th>
      <th>value</th>
      <th>enabled</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>1</td>
      <td>No</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1</td>
      <td>2</td>
      <td>Sí</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2</td>
      <td>1</td>
      <td>50</td>
      <td>1</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2</td>
      <td>2</td>
      <td>200</td>
      <td>1</td>
    </tr>
    <tr>
      <th>4</th>
      <td>3</td>
      <td>1</td>
      <td>5</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
</div>




```python
df_schedules 
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>schedule_id</th>
      <th>name</th>
      <th>repit</th>
      <th>repetitions</th>
      <th>recurrencyType</th>
      <th>endDate</th>
      <th>startDate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Pago Estándar Mensual</td>
      <td>1</td>
      <td>12</td>
      <td>1</td>
      <td>None</td>
      <td>2025-04-30 06:06:52</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Pago Premium Anual</td>
      <td>0</td>
      <td>1</td>
      <td>2</td>
      <td>None</td>
      <td>2025-04-30 06:06:52</td>
    </tr>
  </tbody>
</table>
</div>




```python
df_scheduleDetails 
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>schedules_details_id</th>
      <th>deleted</th>
      <th>schedule_id</th>
      <th>baseDate</th>
      <th>datePart</th>
      <th>last_execute</th>
      <th>next_execute</th>
      <th>description</th>
      <th>detail</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>2025-04-30 06:06:52</td>
      <td>2025-01-01</td>
      <td>None</td>
      <td>2025-02-01</td>
      <td>Pago mensual</td>
      <td>Pago mensual de la suscripción Estándar</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>0</td>
      <td>2</td>
      <td>2025-04-30 06:06:52</td>
      <td>2025-01-01</td>
      <td>None</td>
      <td>2026-01-01</td>
      <td>Pago anual</td>
      <td>Pago anual de la suscripción Premium</td>
    </tr>
  </tbody>
</table>
</div>




```python
df_userPlanPrices 
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>user_plan_price_id</th>
      <th>user_id</th>
      <th>plan_prices_id</th>
      <th>adquision</th>
      <th>enabled</th>
      <th>schedule_id</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>2025-03-28</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>2</td>
      <td>1</td>
      <td>2025-03-19</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>3</td>
      <td>1</td>
      <td>2025-04-16</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>4</td>
      <td>1</td>
      <td>2025-03-16</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>5</td>
      <td>1</td>
      <td>2025-02-08</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1045</th>
      <td>1046</td>
      <td>1046</td>
      <td>2</td>
      <td>2025-03-12</td>
      <td>1</td>
      <td>2</td>
    </tr>
    <tr>
      <th>1046</th>
      <td>1047</td>
      <td>1047</td>
      <td>2</td>
      <td>2025-04-25</td>
      <td>1</td>
      <td>2</td>
    </tr>
    <tr>
      <th>1047</th>
      <td>1048</td>
      <td>1048</td>
      <td>2</td>
      <td>2025-02-12</td>
      <td>1</td>
      <td>2</td>
    </tr>
    <tr>
      <th>1048</th>
      <td>1049</td>
      <td>1049</td>
      <td>2</td>
      <td>2025-02-16</td>
      <td>1</td>
      <td>2</td>
    </tr>
    <tr>
      <th>1049</th>
      <td>1050</td>
      <td>1050</td>
      <td>2</td>
      <td>2025-03-25</td>
      <td>1</td>
      <td>2</td>
    </tr>
  </tbody>
</table>
<p>1050 rows × 6 columns</p>
</div>




```python
df_countries
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>country_id</th>
      <th>name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Costa Rica</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Estados Unidos</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>España</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>México</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>Argentina</td>
    </tr>
    <tr>
      <th>5</th>
      <td>6</td>
      <td>Chile</td>
    </tr>
    <tr>
      <th>6</th>
      <td>7</td>
      <td>Colombia</td>
    </tr>
    <tr>
      <th>7</th>
      <td>8</td>
      <td>Perú</td>
    </tr>
    <tr>
      <th>8</th>
      <td>9</td>
      <td>Brasil</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10</td>
      <td>Francia</td>
    </tr>
  </tbody>
</table>
</div>




```python
df_states
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>state_id</th>
      <th>name</th>
      <th>country_id</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Cartago</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Alajuela</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>Florida</td>
      <td>2</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>Texas</td>
      <td>2</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>Buenos Aires</td>
      <td>5</td>
    </tr>
    <tr>
      <th>5</th>
      <td>6</td>
      <td>Córdoba</td>
      <td>5</td>
    </tr>
    <tr>
      <th>6</th>
      <td>7</td>
      <td>Madrid</td>
      <td>3</td>
    </tr>
    <tr>
      <th>7</th>
      <td>8</td>
      <td>Barcelona</td>
      <td>3</td>
    </tr>
    <tr>
      <th>8</th>
      <td>9</td>
      <td>São Paulo</td>
      <td>9</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10</td>
      <td>Lima</td>
      <td>8</td>
    </tr>
  </tbody>
</table>
</div>




```python
df_cities
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>city_id</th>
      <th>state_id</th>
      <th>name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>1</td>
      <td>Parrita</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>2</td>
      <td>Santa Ana</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>3</td>
      <td>Miami</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>4</td>
      <td>Austin</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>5</td>
      <td>Mar del Plata</td>
    </tr>
    <tr>
      <th>5</th>
      <td>6</td>
      <td>6</td>
      <td>Villa Carlos Paz</td>
    </tr>
    <tr>
      <th>6</th>
      <td>7</td>
      <td>7</td>
      <td>Sevilla</td>
    </tr>
    <tr>
      <th>7</th>
      <td>8</td>
      <td>8</td>
      <td>Sitges</td>
    </tr>
    <tr>
      <th>8</th>
      <td>9</td>
      <td>9</td>
      <td>Campinas</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10</td>
      <td>10</td>
      <td>Arequipa</td>
    </tr>
  </tbody>
</table>
</div>




```python
df_addresses
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>address_id</th>
      <th>line1</th>
      <th>line2</th>
      <th>zipcode</th>
      <th>geoposition</th>
      <th>city_id</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Calle 1 #41</td>
      <td>None</td>
      <td>47290</td>
      <td>POINT (-69.62084863299583 -126.94687827205927)</td>
      <td>4</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Calle 2 #54</td>
      <td>None</td>
      <td>52776</td>
      <td>POINT (-88.69406578940718 -16.93732734484351)</td>
      <td>3</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>Calle 3 #85</td>
      <td>None</td>
      <td>55158</td>
      <td>POINT (-55.874011596547454 -74.45279361163527)</td>
      <td>9</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>Calle 4 #60</td>
      <td>None</td>
      <td>33987</td>
      <td>POINT (68.49769187951244 -42.08641244292858)</td>
      <td>3</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>Calle 5 #21</td>
      <td>None</td>
      <td>27804</td>
      <td>POINT (41.487150202958986 114.58411422985057)</td>
      <td>9</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1045</th>
      <td>1046</td>
      <td>Calle 1046 #32</td>
      <td>None</td>
      <td>99560</td>
      <td>POINT (89.94139725336936 -175.85387046994072)</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1046</th>
      <td>1047</td>
      <td>Calle 1047 #25</td>
      <td>None</td>
      <td>11560</td>
      <td>POINT (54.58595212976073 61.00499924365897)</td>
      <td>10</td>
    </tr>
    <tr>
      <th>1047</th>
      <td>1048</td>
      <td>Calle 1048 #67</td>
      <td>None</td>
      <td>58368</td>
      <td>POINT (68.52666878935571 54.87802851468143)</td>
      <td>7</td>
    </tr>
    <tr>
      <th>1048</th>
      <td>1049</td>
      <td>Calle 1049 #14</td>
      <td>None</td>
      <td>85524</td>
      <td>POINT (62.45690672887201 60.890862868065824)</td>
      <td>9</td>
    </tr>
    <tr>
      <th>1049</th>
      <td>1050</td>
      <td>Calle 1050 #1</td>
      <td>None</td>
      <td>66755</td>
      <td>POINT (-38.03628076616328 -21.324578748386898)</td>
      <td>4</td>
    </tr>
  </tbody>
</table>
<p>1050 rows × 6 columns</p>
</div>




```python
df_userAddresses
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>user_address_id</th>
      <th>user_id</th>
      <th>address_id</th>
      <th>enabled</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>2</td>
      <td>2</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>3</td>
      <td>3</td>
      <td>1</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>4</td>
      <td>4</td>
      <td>1</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>5</td>
      <td>5</td>
      <td>1</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>995</th>
      <td>996</td>
      <td>996</td>
      <td>996</td>
      <td>1</td>
    </tr>
    <tr>
      <th>996</th>
      <td>997</td>
      <td>997</td>
      <td>997</td>
      <td>1</td>
    </tr>
    <tr>
      <th>997</th>
      <td>998</td>
      <td>998</td>
      <td>998</td>
      <td>1</td>
    </tr>
    <tr>
      <th>998</th>
      <td>999</td>
      <td>999</td>
      <td>999</td>
      <td>1</td>
    </tr>
    <tr>
      <th>999</th>
      <td>1000</td>
      <td>1000</td>
      <td>1000</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
<p>1000 rows × 4 columns</p>
</div>




```python
# Cursor para ejecutar los queries e inserts de SQL Server
cursor = tSqlConn.cursor()
```


```python
# Migrar los usuarios y conseguir los IDs del TSQL

# Crear una tabla para tener los viejos userIDs y los nuevos para sustituirlos luego en las otras tablas 
userIDMap = pd.DataFrame(columns = ["oldUserID","newUserID"])

# Insertar uno por uno cada usuario
for index, row in df_users.iterrows():
    try:
        oldUserID = row["user_id"]

        # Insertar con OUTPUT para recuperar el userID generado
        cursor.execute("""
            INSERT INTO solturaDB.sol_users(email, firstName, lastName, password)
            OUTPUT INSERTED.userID
            VALUES (?, ?, ?, ?);
        """, (row["email"], row["first_name"], row["last_name"], row["password"]))
        
        # Recuperar el nuevo userID desde la salida del query
        newUserID = cursor.fetchone()[0]

        # Guarda el nuevo y viejo userID
        userIDMap.loc[len(userIDMap)] = [oldUserID, newUserID]
        # Cambia el userID para saber el nuevo userID del usuario en SQL Server
        df_users.at[index, "user_id"] = newUserID

        # Insertar al usuario nuevo a una tabla auxiliar que indique que es usuario del app assistant y no ha cambiado su contraseña
        cursor.execute("""
            INSERT INTO dbo.sol_migratedUsers(userID, platform, changedPassword)
            VALUES (?, ?, ?);
        """, (newUserID, "Payment Assistant", 0))

    except Exception as e:
        print(f"Error migrando usuario {oldUserID}: {e}")
# Hacer el commit de todo al final                   
tSqlConn.commit()
```


```python
# Crear un diccionario de los IDs para remplazar los user_id en tablas que lo ocupan como FK
idMap = dict(zip(userIDMap["oldUserID"], userIDMap["newUserID"]))

df_userAddresses["user_id"] = df_userAddresses["user_id"].map(idMap)
df_userPlanPrices["user_id"] = df_userPlanPrices["user_id"].map(idMap)
```


```python
# Ver la tabla de userIDs nuevos y viejos
userIDMap
```


```python
# Usuarios antes
df_users
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>user_id</th>
      <th>email</th>
      <th>first_name</th>
      <th>last_name</th>
      <th>password</th>
      <th>enabled</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>PaulaPonce1@gmail.com</td>
      <td>Paula</td>
      <td>Ponce</td>
      <td>b'2bf5309e56428a57f073efd97e7668a08cfc74db0a44...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>EmmaRamos2@gmail.com</td>
      <td>Emma</td>
      <td>Ramos</td>
      <td>b'48e217aeaa990fa02a72367bda2ab6aeb77e87c9b4f4...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>RicardoSalazar3@gmail.com</td>
      <td>Ricardo</td>
      <td>Salazar</td>
      <td>b'228b4b3c75ace3216c8189a12cca88befb322d9696c2...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>AnaGarcía4@gmail.com</td>
      <td>Ana</td>
      <td>García</td>
      <td>b'0c44f0413a7351ae8a456633b6512797ea4cb515fa29...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>MartaMejía5@gmail.com</td>
      <td>Marta</td>
      <td>Mejía</td>
      <td>b'43fa4a3e9cdd525128edaa7b7b7fd330f41d3aeb44c2...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1045</th>
      <td>1046</td>
      <td>CamilaAcosta1046@gmail.com</td>
      <td>Camila</td>
      <td>Acosta</td>
      <td>b'13a33a2c53304fffac7614be31a4bfe851f8a6d9f439...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1046</th>
      <td>1047</td>
      <td>LorenaRamírez1047@gmail.com</td>
      <td>Lorena</td>
      <td>Ramírez</td>
      <td>b'850b066ee061196ac4ed3b237979a7197fa506228af5...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1047</th>
      <td>1048</td>
      <td>FranciscoEstrada1048@gmail.com</td>
      <td>Francisco</td>
      <td>Estrada</td>
      <td>b'288d77e654df324e0d688d227f806c74034c3254792d...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1048</th>
      <td>1049</td>
      <td>JavierGuerrero1049@gmail.com</td>
      <td>Javier</td>
      <td>Guerrero</td>
      <td>b'bd469a97a827aec59ef3593118fb364a0af0db1558f6...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1049</th>
      <td>1050</td>
      <td>ElenaFigueroa1050@gmail.com</td>
      <td>Elena</td>
      <td>Figueroa</td>
      <td>b'21a6cffef3fce12cf6ed2a3ff79ade9ff80b4678fe77...</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
<p>1050 rows × 6 columns</p>
</div>




```python
# Usuarios después
df_users
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>user_id</th>
      <th>email</th>
      <th>first_name</th>
      <th>last_name</th>
      <th>password</th>
      <th>enabled</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>3</td>
      <td>PaulaPonce1@gmail.com</td>
      <td>Paula</td>
      <td>Ponce</td>
      <td>b'2bf5309e56428a57f073efd97e7668a08cfc74db0a44...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>4</td>
      <td>EmmaRamos2@gmail.com</td>
      <td>Emma</td>
      <td>Ramos</td>
      <td>b'48e217aeaa990fa02a72367bda2ab6aeb77e87c9b4f4...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>5</td>
      <td>RicardoSalazar3@gmail.com</td>
      <td>Ricardo</td>
      <td>Salazar</td>
      <td>b'228b4b3c75ace3216c8189a12cca88befb322d9696c2...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>3</th>
      <td>6</td>
      <td>AnaGarcía4@gmail.com</td>
      <td>Ana</td>
      <td>García</td>
      <td>b'0c44f0413a7351ae8a456633b6512797ea4cb515fa29...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>4</th>
      <td>7</td>
      <td>MartaMejía5@gmail.com</td>
      <td>Marta</td>
      <td>Mejía</td>
      <td>b'43fa4a3e9cdd525128edaa7b7b7fd330f41d3aeb44c2...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1045</th>
      <td>1048</td>
      <td>CamilaAcosta1046@gmail.com</td>
      <td>Camila</td>
      <td>Acosta</td>
      <td>b'13a33a2c53304fffac7614be31a4bfe851f8a6d9f439...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1046</th>
      <td>1049</td>
      <td>LorenaRamírez1047@gmail.com</td>
      <td>Lorena</td>
      <td>Ramírez</td>
      <td>b'850b066ee061196ac4ed3b237979a7197fa506228af5...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1047</th>
      <td>1050</td>
      <td>FranciscoEstrada1048@gmail.com</td>
      <td>Francisco</td>
      <td>Estrada</td>
      <td>b'288d77e654df324e0d688d227f806c74034c3254792d...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1048</th>
      <td>1051</td>
      <td>JavierGuerrero1049@gmail.com</td>
      <td>Javier</td>
      <td>Guerrero</td>
      <td>b'bd469a97a827aec59ef3593118fb364a0af0db1558f6...</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1049</th>
      <td>1052</td>
      <td>ElenaFigueroa1050@gmail.com</td>
      <td>Elena</td>
      <td>Figueroa</td>
      <td>b'21a6cffef3fce12cf6ed2a3ff79ade9ff80b4678fe77...</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
<p>1050 rows × 6 columns</p>
</div>




```python
# Ver las tablas actualizadas de df_userAddresses y df_userPlanPrices
df_userAddresses
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>user_address_id</th>
      <th>user_id</th>
      <th>address_id</th>
      <th>enabled</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>3</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>4</td>
      <td>2</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>5</td>
      <td>3</td>
      <td>1</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>6</td>
      <td>4</td>
      <td>1</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>7</td>
      <td>5</td>
      <td>1</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>995</th>
      <td>996</td>
      <td>998</td>
      <td>996</td>
      <td>1</td>
    </tr>
    <tr>
      <th>996</th>
      <td>997</td>
      <td>999</td>
      <td>997</td>
      <td>1</td>
    </tr>
    <tr>
      <th>997</th>
      <td>998</td>
      <td>1000</td>
      <td>998</td>
      <td>1</td>
    </tr>
    <tr>
      <th>998</th>
      <td>999</td>
      <td>1001</td>
      <td>999</td>
      <td>1</td>
    </tr>
    <tr>
      <th>999</th>
      <td>1000</td>
      <td>1002</td>
      <td>1000</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
<p>1000 rows × 4 columns</p>
</div>




```python
df_userPlanPrices
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>user_plan_price_id</th>
      <th>user_id</th>
      <th>plan_prices_id</th>
      <th>adquision</th>
      <th>enabled</th>
      <th>schedule_id</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>3</td>
      <td>1</td>
      <td>2025-03-28</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>4</td>
      <td>1</td>
      <td>2025-03-19</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>5</td>
      <td>1</td>
      <td>2025-04-16</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>6</td>
      <td>1</td>
      <td>2025-03-16</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>7</td>
      <td>1</td>
      <td>2025-02-08</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1045</th>
      <td>1046</td>
      <td>1048</td>
      <td>2</td>
      <td>2025-03-12</td>
      <td>1</td>
      <td>2</td>
    </tr>
    <tr>
      <th>1046</th>
      <td>1047</td>
      <td>1049</td>
      <td>2</td>
      <td>2025-04-25</td>
      <td>1</td>
      <td>2</td>
    </tr>
    <tr>
      <th>1047</th>
      <td>1048</td>
      <td>1050</td>
      <td>2</td>
      <td>2025-02-12</td>
      <td>1</td>
      <td>2</td>
    </tr>
    <tr>
      <th>1048</th>
      <td>1049</td>
      <td>1051</td>
      <td>2</td>
      <td>2025-02-16</td>
      <td>1</td>
      <td>2</td>
    </tr>
    <tr>
      <th>1049</th>
      <td>1050</td>
      <td>1052</td>
      <td>2</td>
      <td>2025-03-25</td>
      <td>1</td>
      <td>2</td>
    </tr>
  </tbody>
</table>
<p>1050 rows × 6 columns</p>
</div>



## Migración de países, estados y ciudades

### Países


```python
countryIDMap = pd.DataFrame(columns=["oldCountryID", "newCountryID"])

for index, row in df_countries.iterrows():
    cursor.execute("SELECT countryID FROM solturaDB.sol_countries WHERE name = ?", row["name"])
    result = cursor.fetchone()

    if result:
        newID = result[0]
    else:
        cursor.execute("""
            INSERT INTO solturaDB.sol_countries(name)
            OUTPUT INSERTED.countryID
            VALUES (?);
        """, row["name"])
        newID = cursor.fetchone()[0]
    
    countryIDMap.loc[len(countryIDMap)] = [row["country_id"], newID]
    df_countries.at[index, "country_id"] = newID

tSqlConn.commit()
```


```python
# Crear un diccionario de los IDs para remplazar los viejos por de los insertados
mapCountries = dict(zip(countryIDMap["oldCountryID"], countryIDMap["newCountryID"]))

df_states["country_id"] = df_states["country_id"].map(mapCountries)
df_currencies["country_id"] = df_currencies["country_id"].map(mapCountries)
```

### Vista de los datos actualizados


```python
countryIDMap
```


```python
# Países antes
df_countries
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>country_id</th>
      <th>name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Costa Rica</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Estados Unidos</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>España</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>México</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>Argentina</td>
    </tr>
    <tr>
      <th>5</th>
      <td>6</td>
      <td>Chile</td>
    </tr>
    <tr>
      <th>6</th>
      <td>7</td>
      <td>Colombia</td>
    </tr>
    <tr>
      <th>7</th>
      <td>8</td>
      <td>Perú</td>
    </tr>
    <tr>
      <th>8</th>
      <td>9</td>
      <td>Brasil</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10</td>
      <td>Francia</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Países después
df_countries
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>country_id</th>
      <th>name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Costa Rica</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Estados Unidos</td>
    </tr>
    <tr>
      <th>2</th>
      <td>4</td>
      <td>España</td>
    </tr>
    <tr>
      <th>3</th>
      <td>3</td>
      <td>México</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>Argentina</td>
    </tr>
    <tr>
      <th>5</th>
      <td>6</td>
      <td>Chile</td>
    </tr>
    <tr>
      <th>6</th>
      <td>7</td>
      <td>Colombia</td>
    </tr>
    <tr>
      <th>7</th>
      <td>8</td>
      <td>Perú</td>
    </tr>
    <tr>
      <th>8</th>
      <td>9</td>
      <td>Brasil</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10</td>
      <td>Francia</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Estados antes
df_states
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>state_id</th>
      <th>name</th>
      <th>country_id</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Cartago</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Alajuela</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>Florida</td>
      <td>2</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>Texas</td>
      <td>2</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>Buenos Aires</td>
      <td>5</td>
    </tr>
    <tr>
      <th>5</th>
      <td>6</td>
      <td>Córdoba</td>
      <td>5</td>
    </tr>
    <tr>
      <th>6</th>
      <td>7</td>
      <td>Madrid</td>
      <td>3</td>
    </tr>
    <tr>
      <th>7</th>
      <td>8</td>
      <td>Barcelona</td>
      <td>3</td>
    </tr>
    <tr>
      <th>8</th>
      <td>9</td>
      <td>São Paulo</td>
      <td>9</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10</td>
      <td>Lima</td>
      <td>8</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Estados después
df_states
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>state_id</th>
      <th>name</th>
      <th>country_id</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Cartago</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Alajuela</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>Florida</td>
      <td>2</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>Texas</td>
      <td>2</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>Buenos Aires</td>
      <td>5</td>
    </tr>
    <tr>
      <th>5</th>
      <td>6</td>
      <td>Córdoba</td>
      <td>5</td>
    </tr>
    <tr>
      <th>6</th>
      <td>7</td>
      <td>Madrid</td>
      <td>4</td>
    </tr>
    <tr>
      <th>7</th>
      <td>8</td>
      <td>Barcelona</td>
      <td>4</td>
    </tr>
    <tr>
      <th>8</th>
      <td>9</td>
      <td>São Paulo</td>
      <td>9</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10</td>
      <td>Lima</td>
      <td>8</td>
    </tr>
  </tbody>
</table>
</div>



### Estados


```python
stateIDMap = pd.DataFrame(columns=["oldStateID", "newStateID"])

for index, row in df_states.iterrows():
    
    cursor.execute("""
        SELECT stateID FROM solturaDB.sol_states 
        WHERE name = ? AND countryID = ?
    """,  (str(row["name"]), int(row["country_id"])))
    result = cursor.fetchone()
    
    if result:
        newID = result[0]
    else:
        cursor.execute("""
            INSERT INTO solturaDB.sol_states(name, countryID)
            OUTPUT INSERTED.stateID
            VALUES (?, ?);
        """,  (str(row["name"]), int(row["country_id"])))
        newID = cursor.fetchone()[0]
    
    stateIDMap.loc[len(stateIDMap)] = [row["state_id"], int(newID)]
    df_states.at[index, "state_id"] = newID

tSqlConn.commit()
```


```python
mapStates = dict(zip(stateIDMap["oldStateID"], stateIDMap["newStateID"]))
df_cities["state_id"] = df_cities["state_id"].map(mapStates)
```

### Vista de los datos actualizados


```python
stateIDMap
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>oldStateID</th>
      <th>newStateID</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>3</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>2</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>10</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>9</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>18</td>
    </tr>
    <tr>
      <th>5</th>
      <td>6</td>
      <td>19</td>
    </tr>
    <tr>
      <th>6</th>
      <td>7</td>
      <td>15</td>
    </tr>
    <tr>
      <th>7</th>
      <td>8</td>
      <td>16</td>
    </tr>
    <tr>
      <th>8</th>
      <td>9</td>
      <td>20</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10</td>
      <td>21</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Estados antes
df_states
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>state_id</th>
      <th>name</th>
      <th>country_id</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Cartago</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Alajuela</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>Florida</td>
      <td>2</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>Texas</td>
      <td>2</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>Buenos Aires</td>
      <td>5</td>
    </tr>
    <tr>
      <th>5</th>
      <td>6</td>
      <td>Córdoba</td>
      <td>5</td>
    </tr>
    <tr>
      <th>6</th>
      <td>7</td>
      <td>Madrid</td>
      <td>3</td>
    </tr>
    <tr>
      <th>7</th>
      <td>8</td>
      <td>Barcelona</td>
      <td>3</td>
    </tr>
    <tr>
      <th>8</th>
      <td>9</td>
      <td>São Paulo</td>
      <td>9</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10</td>
      <td>Lima</td>
      <td>8</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Estados después
df_states
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>state_id</th>
      <th>name</th>
      <th>country_id</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>3</td>
      <td>Cartago</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Alajuela</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>10</td>
      <td>Florida</td>
      <td>2</td>
    </tr>
    <tr>
      <th>3</th>
      <td>9</td>
      <td>Texas</td>
      <td>2</td>
    </tr>
    <tr>
      <th>4</th>
      <td>18</td>
      <td>Buenos Aires</td>
      <td>5</td>
    </tr>
    <tr>
      <th>5</th>
      <td>19</td>
      <td>Córdoba</td>
      <td>5</td>
    </tr>
    <tr>
      <th>6</th>
      <td>15</td>
      <td>Madrid</td>
      <td>4</td>
    </tr>
    <tr>
      <th>7</th>
      <td>16</td>
      <td>Barcelona</td>
      <td>4</td>
    </tr>
    <tr>
      <th>8</th>
      <td>20</td>
      <td>São Paulo</td>
      <td>9</td>
    </tr>
    <tr>
      <th>9</th>
      <td>21</td>
      <td>Lima</td>
      <td>8</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Ciudades antes
df_cities
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>city_id</th>
      <th>state_id</th>
      <th>name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>1</td>
      <td>Parrita</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>2</td>
      <td>Santa Ana</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>3</td>
      <td>Miami</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>4</td>
      <td>Austin</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>5</td>
      <td>Mar del Plata</td>
    </tr>
    <tr>
      <th>5</th>
      <td>6</td>
      <td>6</td>
      <td>Villa Carlos Paz</td>
    </tr>
    <tr>
      <th>6</th>
      <td>7</td>
      <td>7</td>
      <td>Sevilla</td>
    </tr>
    <tr>
      <th>7</th>
      <td>8</td>
      <td>8</td>
      <td>Sitges</td>
    </tr>
    <tr>
      <th>8</th>
      <td>9</td>
      <td>9</td>
      <td>Campinas</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10</td>
      <td>10</td>
      <td>Arequipa</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Ciudades después
df_cities
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>city_id</th>
      <th>state_id</th>
      <th>name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>3</td>
      <td>Parrita</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>2</td>
      <td>Santa Ana</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>10</td>
      <td>Miami</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>9</td>
      <td>Austin</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>18</td>
      <td>Mar del Plata</td>
    </tr>
    <tr>
      <th>5</th>
      <td>6</td>
      <td>19</td>
      <td>Villa Carlos Paz</td>
    </tr>
    <tr>
      <th>6</th>
      <td>7</td>
      <td>15</td>
      <td>Sevilla</td>
    </tr>
    <tr>
      <th>7</th>
      <td>8</td>
      <td>16</td>
      <td>Sitges</td>
    </tr>
    <tr>
      <th>8</th>
      <td>9</td>
      <td>20</td>
      <td>Campinas</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10</td>
      <td>21</td>
      <td>Arequipa</td>
    </tr>
  </tbody>
</table>
</div>



### Ciudades


```python
cityIDMap = pd.DataFrame(columns=["oldCityID", "newCityID"])

for index, row in df_cities.iterrows():
    
    cursor.execute("""
        SELECT cityID FROM solturaDB.sol_city
        WHERE name = ? AND stateID = ?
    """, (row["name"], row["state_id"]))
    result = cursor.fetchone()

    if result:
        newID = result[0]
    else:
        cursor.execute("""
            INSERT INTO solturaDB.sol_city(name, stateID)
            OUTPUT INSERTED.cityID
            VALUES (?, ?);
        """, (row["name"], row["state_id"]))
        newID = cursor.fetchone()[0]

    cityIDMap.loc[len(cityIDMap)] = [row["city_id"], newID]
    df_cities.at[index, "city_id"] = newID

tSqlConn.commit()
```


```python
mapCities = dict(zip(cityIDMap["oldCityID"], cityIDMap["newCityID"]))
df_addresses["city_id"] = df_addresses["city_id"].map(mapCities)
```

### Vista de los datos actualizados


```python
cityIDMap
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>oldCityID</th>
      <th>newCityID</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>16</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>17</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>18</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>19</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>20</td>
    </tr>
    <tr>
      <th>5</th>
      <td>6</td>
      <td>21</td>
    </tr>
    <tr>
      <th>6</th>
      <td>7</td>
      <td>22</td>
    </tr>
    <tr>
      <th>7</th>
      <td>8</td>
      <td>23</td>
    </tr>
    <tr>
      <th>8</th>
      <td>9</td>
      <td>24</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10</td>
      <td>25</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Ciudades antes
df_cities
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>city_id</th>
      <th>state_id</th>
      <th>name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>1</td>
      <td>Parrita</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>2</td>
      <td>Santa Ana</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>3</td>
      <td>Miami</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>4</td>
      <td>Austin</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>5</td>
      <td>Mar del Plata</td>
    </tr>
    <tr>
      <th>5</th>
      <td>6</td>
      <td>6</td>
      <td>Villa Carlos Paz</td>
    </tr>
    <tr>
      <th>6</th>
      <td>7</td>
      <td>7</td>
      <td>Sevilla</td>
    </tr>
    <tr>
      <th>7</th>
      <td>8</td>
      <td>8</td>
      <td>Sitges</td>
    </tr>
    <tr>
      <th>8</th>
      <td>9</td>
      <td>9</td>
      <td>Campinas</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10</td>
      <td>10</td>
      <td>Arequipa</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Ciudades después
df_cities
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>city_id</th>
      <th>state_id</th>
      <th>name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>16</td>
      <td>3</td>
      <td>Parrita</td>
    </tr>
    <tr>
      <th>1</th>
      <td>17</td>
      <td>2</td>
      <td>Santa Ana</td>
    </tr>
    <tr>
      <th>2</th>
      <td>18</td>
      <td>10</td>
      <td>Miami</td>
    </tr>
    <tr>
      <th>3</th>
      <td>19</td>
      <td>9</td>
      <td>Austin</td>
    </tr>
    <tr>
      <th>4</th>
      <td>20</td>
      <td>18</td>
      <td>Mar del Plata</td>
    </tr>
    <tr>
      <th>5</th>
      <td>21</td>
      <td>19</td>
      <td>Villa Carlos Paz</td>
    </tr>
    <tr>
      <th>6</th>
      <td>22</td>
      <td>15</td>
      <td>Sevilla</td>
    </tr>
    <tr>
      <th>7</th>
      <td>23</td>
      <td>16</td>
      <td>Sitges</td>
    </tr>
    <tr>
      <th>8</th>
      <td>24</td>
      <td>20</td>
      <td>Campinas</td>
    </tr>
    <tr>
      <th>9</th>
      <td>25</td>
      <td>21</td>
      <td>Arequipa</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Addresses antes
df_addresses
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>address_id</th>
      <th>line1</th>
      <th>line2</th>
      <th>zipcode</th>
      <th>geoposition</th>
      <th>city_id</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Calle 1 #41</td>
      <td>None</td>
      <td>47290</td>
      <td>POINT (-69.62084863299583 -126.94687827205927)</td>
      <td>19</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Calle 2 #54</td>
      <td>None</td>
      <td>52776</td>
      <td>POINT (-88.69406578940718 -16.93732734484351)</td>
      <td>18</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>Calle 3 #85</td>
      <td>None</td>
      <td>55158</td>
      <td>POINT (-55.874011596547454 -74.45279361163527)</td>
      <td>24</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>Calle 4 #60</td>
      <td>None</td>
      <td>33987</td>
      <td>POINT (68.49769187951244 -42.08641244292858)</td>
      <td>18</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>Calle 5 #21</td>
      <td>None</td>
      <td>27804</td>
      <td>POINT (41.487150202958986 114.58411422985057)</td>
      <td>24</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1045</th>
      <td>1046</td>
      <td>Calle 1046 #32</td>
      <td>None</td>
      <td>99560</td>
      <td>POINT (89.94139725336936 -175.85387046994072)</td>
      <td>16</td>
    </tr>
    <tr>
      <th>1046</th>
      <td>1047</td>
      <td>Calle 1047 #25</td>
      <td>None</td>
      <td>11560</td>
      <td>POINT (54.58595212976073 61.00499924365897)</td>
      <td>25</td>
    </tr>
    <tr>
      <th>1047</th>
      <td>1048</td>
      <td>Calle 1048 #67</td>
      <td>None</td>
      <td>58368</td>
      <td>POINT (68.52666878935571 54.87802851468143)</td>
      <td>22</td>
    </tr>
    <tr>
      <th>1048</th>
      <td>1049</td>
      <td>Calle 1049 #14</td>
      <td>None</td>
      <td>85524</td>
      <td>POINT (62.45690672887201 60.890862868065824)</td>
      <td>24</td>
    </tr>
    <tr>
      <th>1049</th>
      <td>1050</td>
      <td>Calle 1050 #1</td>
      <td>None</td>
      <td>66755</td>
      <td>POINT (-38.03628076616328 -21.324578748386898)</td>
      <td>19</td>
    </tr>
  </tbody>
</table>
<p>1050 rows × 6 columns</p>
</div>




```python
# Addresses después
df_addresses
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>address_id</th>
      <th>line1</th>
      <th>line2</th>
      <th>zipcode</th>
      <th>geoposition</th>
      <th>city_id</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Calle 1 #41</td>
      <td>None</td>
      <td>47290</td>
      <td>b'\x00\x00\x00\x00\x01\x01\x00\x00\x00\xf0\x9e...</td>
      <td>19</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Calle 2 #54</td>
      <td>None</td>
      <td>52776</td>
      <td>b'\x00\x00\x00\x00\x01\x01\x00\x00\x00\xae\xb1...</td>
      <td>18</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>Calle 3 #85</td>
      <td>None</td>
      <td>55158</td>
      <td>b'\x00\x00\x00\x00\x01\x01\x00\x00\x00\x7f\xbf...</td>
      <td>24</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>Calle 4 #60</td>
      <td>None</td>
      <td>33987</td>
      <td>b'\x00\x00\x00\x00\x01\x01\x00\x00\x00h\x7f\n/...</td>
      <td>18</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>Calle 5 #21</td>
      <td>None</td>
      <td>27804</td>
      <td>b'\x00\x00\x00\x00\x01\x01\x00\x00\x00l\xf9\x1...</td>
      <td>24</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1045</th>
      <td>1046</td>
      <td>Calle 1046 #32</td>
      <td>None</td>
      <td>99560</td>
      <td>b'\x00\x00\x00\x00\x01\x01\x00\x00\x00\x00\xf1...</td>
      <td>16</td>
    </tr>
    <tr>
      <th>1046</th>
      <td>1047</td>
      <td>Calle 1047 #25</td>
      <td>None</td>
      <td>11560</td>
      <td>b'\x00\x00\x00\x00\x01\x01\x00\x00\x00\x04,\xb...</td>
      <td>25</td>
    </tr>
    <tr>
      <th>1047</th>
      <td>1048</td>
      <td>Calle 1048 #67</td>
      <td>None</td>
      <td>58368</td>
      <td>b'\x00\x00\x00\x00\x01\x01\x00\x00\x00\xd4\x86...</td>
      <td>22</td>
    </tr>
    <tr>
      <th>1048</th>
      <td>1049</td>
      <td>Calle 1049 #14</td>
      <td>None</td>
      <td>85524</td>
      <td>b'\x00\x00\x00\x00\x01\x01\x00\x00\x00\xf0\xe9...</td>
      <td>24</td>
    </tr>
    <tr>
      <th>1049</th>
      <td>1050</td>
      <td>Calle 1050 #1</td>
      <td>None</td>
      <td>66755</td>
      <td>b'\x00\x00\x00\x00\x01\x01\x00\x00\x00\x93\x12...</td>
      <td>19</td>
    </tr>
  </tbody>
</table>
<p>1050 rows × 6 columns</p>
</div>



## Migración de direcciones y direcciones de usuario

Una vez insertados las ciudades, ya se pueden migrar las direcciones de todos los usuarios


```python
# Crear DataFrame para mapear address_id viejos a nuevos
addressIDMap = pd.DataFrame(columns=["oldAddressID", "newAddressID"])

for index, row in df_addresses.iterrows():
    try:
        oldAddressID = row["address_id"]

        # Insertar la dirección y obtener el nuevo ID generado
        cursor.execute("""
            INSERT INTO solturaDB.sol_addresses(line1, line2, zipcode, geoposition, cityID)
            OUTPUT INSERTED.addressID
            VALUES (?, ?, ?, geometry::STGeomFromText(?, 4326), ?);
        """, (str(row["line1"]), str(row["line2"]) if pd.notna(row["line2"]) else None,
              str(row["zipcode"]), row["geoposition"], row["city_id"]))
        
        newAddressID = cursor.fetchone()[0]

        # Guardar el mapeo
        addressIDMap.loc[len(addressIDMap)] = [oldAddressID, newAddressID]

        # Actualizar el DataFrame original
        df_addresses.at[index, "address_id"] = newAddressID

    except Exception as e:
        print(f"Error migrando dirección {oldAddressID}: {e}")
        break

tSqlConn.commit()
```


```python
addressMap = dict(zip(addressIDMap["oldAddressID"], addressIDMap["newAddressID"]))
df_userAddresses["address_id"] = df_userAddresses["address_id"].map(addressMap)
```

### Vista de los datos actualizados


```python
addressIDMap
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>oldAddressID</th>
      <th>newAddressID</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>6</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>7</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>8</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>9</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>10</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1045</th>
      <td>1046</td>
      <td>1051</td>
    </tr>
    <tr>
      <th>1046</th>
      <td>1047</td>
      <td>1052</td>
    </tr>
    <tr>
      <th>1047</th>
      <td>1048</td>
      <td>1053</td>
    </tr>
    <tr>
      <th>1048</th>
      <td>1049</td>
      <td>1054</td>
    </tr>
    <tr>
      <th>1049</th>
      <td>1050</td>
      <td>1055</td>
    </tr>
  </tbody>
</table>
<p>1050 rows × 2 columns</p>
</div>




```python
# Addresses antes
df_addresses
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>address_id</th>
      <th>line1</th>
      <th>line2</th>
      <th>zipcode</th>
      <th>geoposition</th>
      <th>city_id</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Calle 1 #41</td>
      <td>None</td>
      <td>47290</td>
      <td>b'\x00\x00\x00\x00\x01\x01\x00\x00\x00\xf0\x9e...</td>
      <td>19</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Calle 2 #54</td>
      <td>None</td>
      <td>52776</td>
      <td>b'\x00\x00\x00\x00\x01\x01\x00\x00\x00\xae\xb1...</td>
      <td>18</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>Calle 3 #85</td>
      <td>None</td>
      <td>55158</td>
      <td>b'\x00\x00\x00\x00\x01\x01\x00\x00\x00\x7f\xbf...</td>
      <td>24</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>Calle 4 #60</td>
      <td>None</td>
      <td>33987</td>
      <td>b'\x00\x00\x00\x00\x01\x01\x00\x00\x00h\x7f\n/...</td>
      <td>18</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>Calle 5 #21</td>
      <td>None</td>
      <td>27804</td>
      <td>b'\x00\x00\x00\x00\x01\x01\x00\x00\x00l\xf9\x1...</td>
      <td>24</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1045</th>
      <td>1046</td>
      <td>Calle 1046 #32</td>
      <td>None</td>
      <td>99560</td>
      <td>b'\x00\x00\x00\x00\x01\x01\x00\x00\x00\x00\xf1...</td>
      <td>16</td>
    </tr>
    <tr>
      <th>1046</th>
      <td>1047</td>
      <td>Calle 1047 #25</td>
      <td>None</td>
      <td>11560</td>
      <td>b'\x00\x00\x00\x00\x01\x01\x00\x00\x00\x04,\xb...</td>
      <td>25</td>
    </tr>
    <tr>
      <th>1047</th>
      <td>1048</td>
      <td>Calle 1048 #67</td>
      <td>None</td>
      <td>58368</td>
      <td>b'\x00\x00\x00\x00\x01\x01\x00\x00\x00\xd4\x86...</td>
      <td>22</td>
    </tr>
    <tr>
      <th>1048</th>
      <td>1049</td>
      <td>Calle 1049 #14</td>
      <td>None</td>
      <td>85524</td>
      <td>b'\x00\x00\x00\x00\x01\x01\x00\x00\x00\xf0\xe9...</td>
      <td>24</td>
    </tr>
    <tr>
      <th>1049</th>
      <td>1050</td>
      <td>Calle 1050 #1</td>
      <td>None</td>
      <td>66755</td>
      <td>b'\x00\x00\x00\x00\x01\x01\x00\x00\x00\x93\x12...</td>
      <td>19</td>
    </tr>
  </tbody>
</table>
<p>1050 rows × 6 columns</p>
</div>




```python
# Addresses después
df_addresses
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>address_id</th>
      <th>line1</th>
      <th>line2</th>
      <th>zipcode</th>
      <th>geoposition</th>
      <th>city_id</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>6</td>
      <td>Calle 1 #41</td>
      <td>None</td>
      <td>47290</td>
      <td>POINT (-69.62084863299583 -126.94687827205927)</td>
      <td>19</td>
    </tr>
    <tr>
      <th>1</th>
      <td>7</td>
      <td>Calle 2 #54</td>
      <td>None</td>
      <td>52776</td>
      <td>POINT (-88.69406578940718 -16.93732734484351)</td>
      <td>18</td>
    </tr>
    <tr>
      <th>2</th>
      <td>8</td>
      <td>Calle 3 #85</td>
      <td>None</td>
      <td>55158</td>
      <td>POINT (-55.874011596547454 -74.45279361163527)</td>
      <td>24</td>
    </tr>
    <tr>
      <th>3</th>
      <td>9</td>
      <td>Calle 4 #60</td>
      <td>None</td>
      <td>33987</td>
      <td>POINT (68.49769187951244 -42.08641244292858)</td>
      <td>18</td>
    </tr>
    <tr>
      <th>4</th>
      <td>10</td>
      <td>Calle 5 #21</td>
      <td>None</td>
      <td>27804</td>
      <td>POINT (41.487150202958986 114.58411422985057)</td>
      <td>24</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1045</th>
      <td>1051</td>
      <td>Calle 1046 #32</td>
      <td>None</td>
      <td>99560</td>
      <td>POINT (89.94139725336936 -175.85387046994072)</td>
      <td>16</td>
    </tr>
    <tr>
      <th>1046</th>
      <td>1052</td>
      <td>Calle 1047 #25</td>
      <td>None</td>
      <td>11560</td>
      <td>POINT (54.58595212976073 61.00499924365897)</td>
      <td>25</td>
    </tr>
    <tr>
      <th>1047</th>
      <td>1053</td>
      <td>Calle 1048 #67</td>
      <td>None</td>
      <td>58368</td>
      <td>POINT (68.52666878935571 54.87802851468143)</td>
      <td>22</td>
    </tr>
    <tr>
      <th>1048</th>
      <td>1054</td>
      <td>Calle 1049 #14</td>
      <td>None</td>
      <td>85524</td>
      <td>POINT (62.45690672887201 60.890862868065824)</td>
      <td>24</td>
    </tr>
    <tr>
      <th>1049</th>
      <td>1055</td>
      <td>Calle 1050 #1</td>
      <td>None</td>
      <td>66755</td>
      <td>POINT (-38.03628076616328 -21.324578748386898)</td>
      <td>19</td>
    </tr>
  </tbody>
</table>
<p>1050 rows × 6 columns</p>
</div>




```python
# User Addresses antes
df_userAddresses
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>user_address_id</th>
      <th>user_id</th>
      <th>address_id</th>
      <th>enabled</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>2</td>
      <td>2</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>3</td>
      <td>3</td>
      <td>1</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>4</td>
      <td>4</td>
      <td>1</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>5</td>
      <td>5</td>
      <td>1</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>995</th>
      <td>996</td>
      <td>996</td>
      <td>996</td>
      <td>1</td>
    </tr>
    <tr>
      <th>996</th>
      <td>997</td>
      <td>997</td>
      <td>997</td>
      <td>1</td>
    </tr>
    <tr>
      <th>997</th>
      <td>998</td>
      <td>998</td>
      <td>998</td>
      <td>1</td>
    </tr>
    <tr>
      <th>998</th>
      <td>999</td>
      <td>999</td>
      <td>999</td>
      <td>1</td>
    </tr>
    <tr>
      <th>999</th>
      <td>1000</td>
      <td>1000</td>
      <td>1000</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
<p>1000 rows × 4 columns</p>
</div>




```python
# User Addresses después
df_userAddresses
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>user_address_id</th>
      <th>user_id</th>
      <th>address_id</th>
      <th>enabled</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>1</td>
      <td>6</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>2</td>
      <td>7</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>3</td>
      <td>8</td>
      <td>1</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>4</td>
      <td>9</td>
      <td>1</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>5</td>
      <td>10</td>
      <td>1</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>995</th>
      <td>996</td>
      <td>996</td>
      <td>1001</td>
      <td>1</td>
    </tr>
    <tr>
      <th>996</th>
      <td>997</td>
      <td>997</td>
      <td>1002</td>
      <td>1</td>
    </tr>
    <tr>
      <th>997</th>
      <td>998</td>
      <td>998</td>
      <td>1003</td>
      <td>1</td>
    </tr>
    <tr>
      <th>998</th>
      <td>999</td>
      <td>999</td>
      <td>1004</td>
      <td>1</td>
    </tr>
    <tr>
      <th>999</th>
      <td>1000</td>
      <td>1000</td>
      <td>1005</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
<p>1000 rows × 4 columns</p>
</div>




```python
# Insertar los userAddresses
for index, row in df_userAddresses.iterrows():
    try:
        cursor.execute("""
            INSERT INTO solturaDB.sol_usersAdresses(userID, addressID, enabled)
            VALUES (?, ?, ?);
        """, (int(row["user_id"]), int(row["address_id"]), bool(row["enabled"])))
        
    except Exception as e:
        print(f"Error migrando user_address {row['user_address_id']}: {e}")

tSqlConn.commit()

```

## Migración de los schedules


```python
# Crear DataFrame para mapear schedule_id viejos a nuevos
scheduleIDMap = pd.DataFrame(columns=["oldScheduleID", "newScheduleID"])

for index, row in df_schedules.iterrows():
    try:
        oldScheduleID = int(row["schedule_id"])

        cursor.execute("""
            INSERT INTO solturaDB.sol_schedules(name, repit, repetitions, recurrencyType, endDate, startDate)
            OUTPUT INSERTED.scheduleID
            VALUES (?, ?, ?, ?, ?, ?);
        """, (
            str(row["name"]),
            bool(row["repit"]),
            int(row["repetitions"]),
            int(row["recurrencyType"]),
            row["endDate"] if pd.notna(row["endDate"]) else None,
            row["startDate"]
        ))

        newScheduleID = cursor.fetchone()[0]
        scheduleIDMap.loc[len(scheduleIDMap)] = [int(oldScheduleID), int(newScheduleID)]

        # Actualizar el DataFrame original
        df_schedules.at[index, "schedule_id"] = newScheduleID

    except Exception as e:
        print(f"Error migrando schedule {oldScheduleID}: {e}")
        break

tSqlConn.commit()

```


```python
# Reemplazar schedule_id viejo con el nuevo
scheduleMap = dict(zip(scheduleIDMap["oldScheduleID"], scheduleIDMap["newScheduleID"]))
df_scheduleDetails["schedule_id"] = df_scheduleDetails["schedule_id"].map(scheduleMap)
df_userPlanPrices["schedule_id"] = df_userPlanPrices["schedule_id"].map(scheduleMap)
```


```python
# Crear DataFrame para mapear schedules_details_id viejos a nuevos
scheduleDetailIDMap = pd.DataFrame(columns=["oldScheduleDetailID", "newScheduleDetailID"])

for index, row in df_scheduleDetails.iterrows():
    try:
        oldDetailID = int(row["schedules_details_id"])

        cursor.execute("""
            INSERT INTO solturaDB.sol_schedulesDetails(
                deleted, schedule_id, baseDate, datePart, lastExecute, nextExecute, description, detail
            )
            OUTPUT INSERTED.schedulesDetailsID
            VALUES (?, ?, ?, ?, ?, ?, ?, ?);
        """, (
            bool(row["deleted"]),
            int(row["schedule_id"]),
            row["baseDate"],
            row["datePart"],
            row["last_execute"] if pd.notna(row["last_execute"]) else None,
            row["next_execute"],
            str(row["description"]),
            str(row["detail"])
        ))

        newDetailID = cursor.fetchone()[0]
        scheduleDetailIDMap.loc[len(scheduleDetailIDMap)] = [oldDetailID, newDetailID]

        # Actualizar el DataFrame original
        df_scheduleDetails.at[index, "schedules_details_id"] = newDetailID

    except Exception as e:
        print(f"Error migrando schedule_detail {oldDetailID}: {e}")
        break

tSqlConn.commit()

```

### Vista de los datos 


```python
df_schedules
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>schedule_id</th>
      <th>name</th>
      <th>repit</th>
      <th>repetitions</th>
      <th>recurrencyType</th>
      <th>endDate</th>
      <th>startDate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Pago Estándar Mensual</td>
      <td>1</td>
      <td>12</td>
      <td>1</td>
      <td>None</td>
      <td>2025-04-30 06:06:52</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Pago Premium Anual</td>
      <td>0</td>
      <td>1</td>
      <td>2</td>
      <td>None</td>
      <td>2025-04-30 06:06:52</td>
    </tr>
  </tbody>
</table>
</div>




```python
df_scheduleDetails
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>schedules_details_id</th>
      <th>deleted</th>
      <th>schedule_id</th>
      <th>baseDate</th>
      <th>datePart</th>
      <th>last_execute</th>
      <th>next_execute</th>
      <th>description</th>
      <th>detail</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>2025-04-30 06:06:52</td>
      <td>2025-01-01</td>
      <td>None</td>
      <td>2025-02-01</td>
      <td>Pago mensual</td>
      <td>Pago mensual de la suscripción Estándar</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>0</td>
      <td>2</td>
      <td>2025-04-30 06:06:52</td>
      <td>2025-01-01</td>
      <td>None</td>
      <td>2026-01-01</td>
      <td>Pago anual</td>
      <td>Pago anual de la suscripción Premium</td>
    </tr>
  </tbody>
</table>
</div>



# Adaptación de los planes

Pay assistant va a ser migrada como un partner a soltura, con un contrato temporal donde no haya descuento ni comisión


```python
from datetime import datetime, timedelta

# Instanciar IDs desde antes
partnerId = None
dealId = None

# Datos para de Payment Assistant
partnerData = {
    "name": "Payment Assistant",
    "registerDate": datetime.now(),
    "state": 1,
    "identificationtypeId": 1,
    "enterpriseSizeId": 2,
    "identification": "3-100-123654"
}

# Insertar el partner a TSQL
try:
    cursor.execute("""
        INSERT INTO solturaDB.sol_partners
        (name, registerDate, state, identificationtypeId, enterpriseSizeId, identification)
        OUTPUT INSERTED.partnerID
        VALUES (?, ?, ?, ?, ?, ?);
    """, (
        partnerData["name"],
        partnerData["registerDate"],
        partnerData["state"],
        partnerData["identificationtypeId"],
        partnerData["enterpriseSizeId"],
        partnerData["identification"]
    ))

    partnerId = cursor.fetchone()[0]

except Exception as e:
    print(f"Error insertando partner: {e}")

# Si el partner fue insertado correctamente, insertar el deal
if partnerId is not None:
    try:
        sealDate = datetime.now()
        endDate = sealDate + timedelta(days=150) # Este se va a adaptar a que dure esta cantidad de días

        cursor.execute("""
            INSERT INTO solturaDB.sol_deals
            (partnerId, dealDescription, sealDate, endDate, solturaComission, discount, isActive)
            OUTPUT INSERTED.dealID
            VALUES (?, ?, ?, ?, ?, ?, ?);
        """, (
            partnerId,
            "Beneficios de app: Payment Assistant",
            sealDate,
            endDate,
            0, 
            0,
            1  
        ))

        dealId = cursor.fetchone()[0]

    except Exception as e:
        print(f"Error insertando deal: {e}")


tSqlConn.commit()


```


```python
print(dealId)
```

### Tablas de datos de los planes de Mysql 


```python
df_subscriptions 
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>subscription_id</th>
      <th>description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Estándar</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Premium</td>
    </tr>
  </tbody>
</table>
</div>




```python
df_planPrices
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>plan_prices_id</th>
      <th>subscrition_Id</th>
      <th>amount</th>
      <th>currency_id</th>
      <th>postTime</th>
      <th>endDate</th>
      <th>current</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>1</td>
      <td>9.99</td>
      <td>2</td>
      <td>2025-04-30 06:06:52</td>
      <td>2025-12-31</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>2</td>
      <td>39.99</td>
      <td>2</td>
      <td>2025-04-30 06:06:52</td>
      <td>2025-12-31</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
</div>




```python
df_planFeaturesSubscriptions 
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>plan_features_id</th>
      <th>subscription_id</th>
      <th>value</th>
      <th>enabled</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>1</td>
      <td>No</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1</td>
      <td>2</td>
      <td>Sí</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2</td>
      <td>1</td>
      <td>50</td>
      <td>1</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2</td>
      <td>2</td>
      <td>200</td>
      <td>1</td>
    </tr>
    <tr>
      <th>4</th>
      <td>3</td>
      <td>1</td>
      <td>5</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
</div>




```python
df_planFeatures
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>plan_features_id</th>
      <th>description</th>
      <th>enabled</th>
      <th>dataType</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Acceso a soporte 24/7</td>
      <td>1</td>
      <td>Boolean</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Límite de transacciones mensuales</td>
      <td>1</td>
      <td>Integer</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>Límite de creación de pagos recurrentes</td>
      <td>1</td>
      <td>Integer</td>
    </tr>
  </tbody>
</table>
</div>




```python
df_userPlanPrices
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>user_plan_price_id</th>
      <th>user_id</th>
      <th>plan_prices_id</th>
      <th>adquision</th>
      <th>enabled</th>
      <th>schedule_id</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>3</td>
      <td>1</td>
      <td>2025-03-28</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>4</td>
      <td>1</td>
      <td>2025-03-19</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>5</td>
      <td>1</td>
      <td>2025-04-16</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>6</td>
      <td>1</td>
      <td>2025-03-16</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>7</td>
      <td>1</td>
      <td>2025-02-08</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1045</th>
      <td>1046</td>
      <td>1048</td>
      <td>2</td>
      <td>2025-03-12</td>
      <td>1</td>
      <td>2</td>
    </tr>
    <tr>
      <th>1046</th>
      <td>1047</td>
      <td>1049</td>
      <td>2</td>
      <td>2025-04-25</td>
      <td>1</td>
      <td>2</td>
    </tr>
    <tr>
      <th>1047</th>
      <td>1048</td>
      <td>1050</td>
      <td>2</td>
      <td>2025-02-12</td>
      <td>1</td>
      <td>2</td>
    </tr>
    <tr>
      <th>1048</th>
      <td>1049</td>
      <td>1051</td>
      <td>2</td>
      <td>2025-02-16</td>
      <td>1</td>
      <td>2</td>
    </tr>
    <tr>
      <th>1049</th>
      <td>1050</td>
      <td>1052</td>
      <td>2</td>
      <td>2025-03-25</td>
      <td>1</td>
      <td>2</td>
    </tr>
  </tbody>
</table>
<p>1050 rows × 6 columns</p>
</div>



## Migración de planes




```python
planIDMap = {}

for index, row in df_subscriptions.iterrows():
    description = row["description"]
    planTypeId = 1 if description == "Estándar" else 2

    cursor.execute("""
        INSERT INTO solturaDB.sol_plans (description, planTypeId)
        OUTPUT INSERTED.planID
        VALUES (?, ?);
    """, (description, planTypeId))

    planID = cursor.fetchone()[0]
    planIDMap[int(row["subscription_id"])] = int(planID)

tSqlConn.commit()



```


```python
# Actualizar los subscription_id en df_subscriptions y df_planPrices y df_planFeaturesSubscriptions
df_subscriptions["subscription_id"] = df_subscriptions["subscription_id"].map(planIDMap)
df_planPrices["subscrition_Id"] = df_planPrices["subscrition_Id"].map(planIDMap)
df_planFeaturesSubscriptions["subscription_id"] = df_planFeaturesSubscriptions["subscription_id"].map(planIDMap)
```


```python
planPriceIDMap = {}

for index, row in df_planPrices.iterrows():
    planID = int(row["subscrition_Id"])
    amount = float(row["amount"])
    currency_id = int(row["currency_id"])
    postTime = row["postTime"]
    endDate = row["endDate"]


    cursor.execute("""
        INSERT INTO solturaDB.sol_planPrices (
            planID, amount, currency_id, postTime, endDate, [current]
        )
        OUTPUT INSERTED.planPriceID
        VALUES (?, ?, ?, ?, ?, ?);
    """, (planID, amount, currency_id, postTime, endDate, bool(1)))

    planPriceID = cursor.fetchone()[0]
    planPriceIDMap[int(row["plan_prices_id"])] = int(planPriceID)

tSqlConn.commit()


```


```python
# Actualizar los plan_prices_id en df_planPrices y df_userPlanPrices
df_planPrices["plan_prices_id"] = df_planPrices["plan_prices_id"].map(planPriceIDMap)
df_userPlanPrices["plan_prices_id"] = df_userPlanPrices["plan_prices_id"].map(planPriceIDMap)
```


```python
for index, row in df_userPlanPrices.iterrows():
    user_id = int(row["user_id"])
    plan_prices_id = int(row["plan_prices_id"])
    adquision = row["adquision"]
    enabled = int(row["enabled"])
    schedule_id = int(row["schedule_id"])

    cursor.execute("""
        INSERT INTO solturaDB.sol_userPlans (
            userID, planPriceID, adquisition, enabled, scheduleID
        )
        VALUES (?, ?, ?, ?, ?);
    """, (user_id, plan_prices_id, adquision, enabled, schedule_id))

tSqlConn.commit()
```


```python
# Insertar "Aplicación" como tipo de feature, ya que sol_features necesita un tipo de feature
featureTypeId = None
try:
    cursor.execute("""
        INSERT INTO solturaDB.sol_featureTypes(type)
        OUTPUT INSERTED.featureTypeID
        VALUES (?);
    """, ("Aplicación",))
    featureTypeId = cursor.fetchone()[0]
    featureTypeId = int(featureTypeId)
except Exception as e:
    print(f"Error insertando tipo de feature: {e}")
```


```python
featureTypeId
```


```python
# Crear el nuevo DataFrame de datos adaptado para guardar lo insertado de planFeatures
sol_planFeatures = pd.DataFrame(columns=[
    "featureID", "planFeaturesId", "dealId", "description", "unit", "consumableQuantity", 
    "enabled", "isRecurrent", "scheduleID", "featureTypeID"
])

planFeatureIdMap = {}

# Recorrer los planFeatures y cruzarlos con los planfeatureSubscriptions
for index, planFeature in df_planFeatures.iterrows():
    planFeaturesId = int(planFeature["plan_features_id"])
    description = planFeature["description"]
    unit = planFeature["dataType"]

    # Filtrar las suscripciones que tienen este feature
    relatedSubs = df_planFeaturesSubscriptions[
        df_planFeaturesSubscriptions["plan_features_id"] == planFeaturesId
    ]

    for index, sub in relatedSubs.iterrows():
        rawValue = sub["value"]

        # Convertir valor de texto a número
        if rawValue == "No":
            consumableQuantity = 0
        elif rawValue == "Sí":
            consumableQuantity = 1
        else:
            consumableQuantity = int(rawValue)

        try:
            cursor.execute("""
                INSERT INTO solturaDB.sol_planFeatures(
                    dealId, description, unit, consumableQuantity, enabled,
                    isRecurrent, scheduleID, featureTypeID
                )
                OUTPUT INSERTED.planFeatureID
                VALUES (?, ?, ?, ?, ?, ?, ?, ?);
            """, (
                dealId,
                description,
                unit,
                consumableQuantity,
                1,      # enabled
                0,      # isRecurrent
                3,      #  # scheduleID (Ejecución mensual) 
                featureTypeId
            ))

            featureId = int(cursor.fetchone()[0])

            # Guardar en DataFrame con planFeaturesId incluido
            sol_planFeatures.loc[len(sol_planFeatures)] = [
                featureId,
                planFeaturesId,
                dealId,
                description,
                unit,
                consumableQuantity,
                1,
                0,
                3,
                featureTypeId
            ]

            # Registrar el mapeo para luego adaptarlo
            planFeatureIdMap[planFeaturesId] = featureId

        except Exception as e:
            print(f"Error insertando feature {planFeaturesId}: {e}")

# Confirmar
tSqlConn.commit()

```


```python
# Actualizar los plan_features_id en df_planFeaturesSubscriptions
df_planFeaturesSubscriptions["plan_features_id"] = df_planFeaturesSubscriptions["plan_features_id"].map(planFeatureIdMap)
```


```python
planFeatureIdMap
```


```python
df_planFeaturesSubscriptions
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>plan_features_id</th>
      <th>subscription_id</th>
      <th>value</th>
      <th>enabled</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>9</td>
      <td>25</td>
      <td>No</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>9</td>
      <td>26</td>
      <td>Sí</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>11</td>
      <td>25</td>
      <td>50</td>
      <td>1</td>
    </tr>
    <tr>
      <th>3</th>
      <td>11</td>
      <td>26</td>
      <td>200</td>
      <td>1</td>
    </tr>
    <tr>
      <th>4</th>
      <td>12</td>
      <td>25</td>
      <td>5</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Insertar en sol_featuresPerPlan con el campo enabled en 1
for index, row in df_planFeaturesSubscriptions.iterrows():
    try:
        cursor.execute("""
            INSERT INTO solturaDB.sol_featuresPerPlans (planFeatureID, planID, enabled)
            VALUES (?, ?, ?);
        """, (int(row["plan_features_id"]), int(row["subscription_id"]), 1))
    except Exception as e:
        print(f"Error insertando feature-plan: {row.to_dict()} -> {e}")

tSqlConn.commit()
```
## LINK A CARPETAS EN GITHUB
Scripts

https://github.com/WeebL0rd/Caso-2-BDI/tree/main/Scripts

Queries

https://github.com/WeebL0rd/Caso-2-BDI/tree/main/Queries

Diseño

https://github.com/WeebL0rd/Caso-2-BDI/tree/main/Dise%C3%B1os

Consultas Misceláneas

https://github.com/WeebL0rd/Caso-2-BDI/tree/main/ConsultasMiscelaneas

Concurrencia

https://github.com/WeebL0rd/Caso-2-BDI/tree/main/Concurrencia

Migrado de Datos

https://github.com/WeebL0rd/Caso-2-BDI/tree/main/Scripts/PayAssistant