from fastapi import FastAPI
from pydantic import BaseModel
from fastapi.responses import JSONResponse

app = FastAPI()

class Mensaje(BaseModel):
    numero: str
    nombre: str
    mensaje: str

@app.post("/webhook/simulado")
async def webhook_simulado(data: Mensaje):
    respuesta = {
        "cliente": data.nombre,
        "telefono": data.numero,
        "mensaje_recibido": data.mensaje,
        "status": "Recibido correctamente"
    }
    return JSONResponse(content=respuesta)
