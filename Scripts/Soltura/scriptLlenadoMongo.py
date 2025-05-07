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
            "_id": ObjectId(),
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
            "_id": ObjectId(),
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
    return usuarios

# ─── FUNCIÓN: Insertar departamentos ────────────────────────────────────────
def insertarDepartamentos():
    departamentos = [
        {
            "_id": ObjectId(),
            "nombreDepartamento": "Atención al Cliente",
            "mediosContacto": ["telefono", "email", "whatsapp"],
            "horario": {
                "lunesAViernes": "08:00-17:00",
                "sabados": "09:00-13:00",
                "domingos": "cerrado"
            }
        },
        {
            "_id": ObjectId(),
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
            "_id": ObjectId(),
            "IDAgente": "AGT001",
            "nombre": "Carlos Ramírez",
            "email": "carlos@soltura.com",
            "lenguajes": ["es-CR", "en-US"],
            "horario": {
                "lunesAViernes": "08:00-17:00",
                "sabados": "09:00-12:00",
                "domingos": "cerrado"
            },
            "departamento": departamentos[0]["_id"],
            "nivelAutoridad": "senior",
            "maxCasosSimultaneos": 5
        },
        {
            "_id": ObjectId(),
            "IDAgente": "AGT002",
            "nombre": "Lucía Vega",
            "email": "lucia@soltura.com",
            "lenguajes": ["es-CR"],
            "horario": {
                "lunesAViernes": "10:00-18:00",
                "sabados": "cerrado",
                "domingos": "cerrado"
            },
            "departamento": departamentos[1]["_id"],
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
            "ClienteID": usuarios[0]["_id"],
            "agentesAsignados": [agentes[0]["_id"]],
            "asunto": "¿Cómo cambio mi contraseña?",
            "descripcion": "Necesito ayuda para restablecer mi clave.",
            "fechaCreacion": datetime.now(),
            "lastUpdated": datetime.now(),
            "prioridad": "media",
            "satisfaccionCliente": None,
            "historial": [
                {
                    "autor": usuarios[0]["_id"],
                    "fecha": datetime.now(),
                    "mensaje": "Hola, necesito cambiar mi contraseña",
                    "lenguaje": "es-CR"
                },
                {
                    "autor": agentes[0]["_id"],
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
            "ClienteID": usuarios[1]["_id"],
            "agentesAsignados": [agentes[1]["_id"]],
            "asunto": "Problemas con la facturación",
            "descripcion": "Me cobraron un monto incorrecto en mi factura.",
            "fechaCreacion": datetime.now(),
            "lastUpdated": datetime.now(),
            "prioridad": "alta",
            "satisfaccionCliente": None,
            "historial": [
                {
                    "autor": usuarios[1]["_id"],
                    "fecha": datetime.now(),
                    "mensaje": "Mi factura tiene un cobro que no reconozco.",
                    "lenguaje": "es-CR"
                },
                {
                    "autor": agentes[1]["_id"],
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
            "nombre": "Gimnasio SmartFit",
            "tipo": "salud",
            "descripcion": "Acceso a SmartFit en horarios regulares",
            "unidad": "horas",
            "cantidad": 6,
            "frecuencia": "semanal",
            "activo": True
        },
        {
            "nombre": "Lavandería y aplanchado",
            "tipo": "hogar",
            "descripcion": "Servicio completo de lavandería y planchado",
            "unidad": "servicios",
            "cantidad": 1,
            "frecuencia": "mensual",
            "activo": True
        },
        {
            "nombre": "Limpieza básica de hogar",
            "tipo": "hogar",
            "descripcion": "Limpieza básica con personal capacitado",
            "unidad": "días",
            "cantidad": 2,
            "frecuencia": "mensual",
            "activo": True
        },
        {
            "nombre": "Combustible",
            "tipo": "movilidad",
            "descripcion": "Monto mensual para combustible gas o diésel",
            "unidad": "CRC",
            "cantidad": 50000,
            "frecuencia": "mensual",
            "activo": True
        },
        {
            "nombre": "Corte de pelo (Tito Barbers)",
            "tipo": "estética",
            "descripcion": "Corte profesional en Tito Barbers",
            "unidad": "cortes",
            "cantidad": 1,
            "frecuencia": "mensual",
            "activo": True
        },
        {
            "nombre": "Cenas seleccionadas",
            "tipo": "alimentación",
            "descripcion": "Cenas de restaurantes aliados",
            "unidad": "cenas",
            "cantidad": 2,
            "frecuencia": "mensual",
            "activo": True
        },
        {
            "nombre": "Almuerzos seleccionados",
            "tipo": "alimentación",
            "descripcion": "Almuerzos de restaurantes aliados",
            "unidad": "almuerzos",
            "cantidad": 4,
            "frecuencia": "mensual",
            "activo": True
        },
        {
            "nombre": "Plan móvil (Kolbi)",
            "tipo": "tecnología",
            "descripcion": "Plan de datos y llamadas ilimitadas",
            "unidad": "servicio",
            "cantidad": 1,
            "frecuencia": "mensual",
            "activo": True
        },
        {
            "nombre": "Parqueo",
            "tipo": "movilidad",
            "descripcion": "Horas de parqueo en puntos seleccionados",
            "unidad": "horas",
            "cantidad": 10,
            "frecuencia": "mensual",
            "activo": True
        },
        {
            "nombre": "Grooming para mascota",
            "tipo": "mascotas",
            "descripcion": "Servicio de grooming para una mascota",
            "unidad": "servicio",
            "cantidad": 1,
            "frecuencia": "mensual",
            "activo": True
        },
        {
            "nombre": "Revisión veterinaria",
            "tipo": "mascotas",
            "descripcion": "Consulta veterinaria básica",
            "unidad": "consulta",
            "cantidad": 1,
            "frecuencia": "mensual",
            "activo": True
        },
        {
            "nombre": "Clases de natación o fútbol (niños)",
            "tipo": "educación",
            "descripcion": "Clases recreativas para niños",
            "unidad": "clases",
            "cantidad": 3,
            "frecuencia": "mensual",
            "activo": True
        },
        {
            "nombre": "Uber Eats",
            "tipo": "alimentación",
            "descripcion": "Pedidos con envío gratis y 20% descuento",
            "unidad": "pedidos",
            "cantidad": 10,
            "frecuencia": "mensual",
            "activo": True
        },
        {
            "nombre": "Uber Rides",
            "tipo": "movilidad",
            "descripcion": "Saldo para viajes en Uber",
            "unidad": "CRC",
            "cantidad": 7000,
            "frecuencia": "mensual",
            "activo": True
        }
    ]
    return db.beneficios.insert_many(beneficios).inserted_ids

# ─── FUNCIÓN: Insertar paquetes ────────────────────────────────────────────
def insertarPaquetes(IdsBeneficios):
    paquetes = [
        {
            "titulo": "Paquete Profesional Joven",
            "descripcion": "Ideal para profesionales activos que buscan conveniencia",
            "beneficios": IdsBeneficios[0:9],
            "precioMensual": 25000,
            "moneda": "CRC",
            "maxPersonas": 1,
            "disponible": True,
            "fechaCreacion": datetime.utcnow(),
            "fechaUltimaActualizacion": datetime.utcnow()
        },
        {
            "titulo": "Paquete Full Modern Family",
            "descripcion": "Pensado para familias modernas que buscan bienestar integral",
            "beneficios": IdsBeneficios[8:] + IdsBeneficios[9:],
            "precioMensual": 45000,
            "moneda": "CRC",
            "maxPersonas": 4,
            "disponible": True,
            "fechaCreacion": datetime.utcnow(),
            "fechaUltimaActualizacion": datetime.utcnow()
        }
    ]
    return db.paquetesInformativos.insert_many(paquetes).inserted_ids


# ─── FUNCIÓN: Insertar Reviews con Respuestas ────────────────────────────────
def insertarReviews(usuarios, paquetes):
    reviews = [
        {
            "usuarioID": usuarios[0]["_id"],
            "paqueteID": paquetes[0]["_id"],
            "calificacion": 4,
            "comentario": "Buen paquete, pero me gustaría más soporte técnico.",
            "fecha": datetime.now(),
            "respuestas": [
                {
                    "usuarioID": usuarios[1]["_id"],
                    "comentario": "Entiendo lo que dices, el soporte técnico podría mejorar.",
                    "fecha": datetime.now()
                },
                {
                    "usuarioID": usuarios[2]["_id"],
                    "comentario": "¿Qué tipo de soporte crees que falta? Podría ayudar.",
                    "fecha": datetime.now()
                }
            ]
        },
        {
            "usuarioID": usuarios[1]["_id"],
            "paqueteID": paquetes[1]["_id"],
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
            "_id": ObjectId(),
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
            "_id": ObjectId(),
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
            "_id": ObjectId(),
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
            "_id": ObjectId(),
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
            "_id": ObjectId(),
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
    return [anuncio["_id"] for anuncio in anuncios]


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
