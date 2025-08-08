from fastapi import FastAPI, Depends
from pydantic import BaseModel
from typing import List
from .database import init_db, SessionLocal
from .crud import registrar_entrega, registrar_pago, calcular_saldo, inventario_por_cliente, registrar_entregas_masivo
from sqlalchemy.orm import Session

app = FastAPI()

@app.on_event("startup")
def startup_event():
    init_db()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.get("/")
def root():
    return {"message": "Agente multi-cliente activo"}

@app.post("/entrega")
def post_entrega(producto: str, cantidad: int, entrega: str, caducidad: str, cliente: str, db: Session = Depends(get_db)):
    return registrar_entrega(db, producto, cantidad, entrega, caducidad, cliente)

@app.post("/pago")
def post_pago(cantidad: int, fecha: str, cliente: str, db: Session = Depends(get_db)):
    return registrar_pago(db, cantidad, fecha, cliente)

@app.get("/saldo/{cliente}")
def get_saldo(cliente: str, db: Session = Depends(get_db)):
    return calcular_saldo(db, cliente)

@app.get("/inventario")
def get_inventario(cliente: str, db: Session = Depends(get_db)):
    return inventario_por_cliente(db, cliente)

class EntradaMasiva(BaseModel):
    producto: str
    cantidad: int
    fecha_entrega: str
    fecha_caducidad: str
    cliente: str

@app.post("/entregas/masivo")
def post_masivo(entradas: List[EntradaMasiva], db: Session = Depends(get_db)):
    data = [e.dict() for e in entradas]
    return registrar_entregas_masivo(db, data)
