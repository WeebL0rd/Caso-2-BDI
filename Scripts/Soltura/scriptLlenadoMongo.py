# ─── IMPORTS ───────────────────────────────────────────────────────────────
from pymongo import MongoClient
from datetime import datetime
from bson import ObjectId

# ─── CONEXIÓN A MONGO ──────────────────────────────────────────────────────
client = MongoClient("mongodb://localhost:27017/")
db = client["soltura"]

# ─── FUNCIÓN: Insertar usuarios ─────────────────────────────────────────────
def insertar_usuarios():
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
def insertar_departamentos():
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
def insertar_agentes(departamentos):
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

def insertar_casos(usuarios, agentes):
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


# ─── EJECUCIÓN PRINCIPAL ────────────────────────────────────────────────────
if __name__ == "__main__":
    usuarios = insertar_usuarios()
    departamentos = insertar_departamentos()
    agentes = insertar_agentes(departamentos)
    insertar_casos(usuarios, agentes)
    print("Datos insertados correctamente.")
