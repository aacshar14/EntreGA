from fastapi import FastAPI, Depends, Request
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
from pydantic import BaseModel
from typing import List
from .database import init_db, SessionLocal
from .crud import registrar_entrega, registrar_pago, calcular_saldo, inventario_por_cliente, registrar_entregas_masivo
from sqlalchemy.orm import Session

app = FastAPI()

# Mount static files and templates for landing page
app.mount("/static", StaticFiles(directory="app/static"), name="static")
templates = Jinja2Templates(directory="app/templates")

# Sample client data with real Google Sheets URL
clientes = [
    {
        "nombre": "Juan Pérez", 
        "sheet": "https://docs.google.com/spreadsheets/d/1QrXgIT4l2FdNQssWvegwNyOzRWqeQyCu-YkYfWN4v7g/edit?gid=0#gid=0", 
        "estado": "Activo",
        "ultima_entrega": "2025-08-07",
        "productos": ["Salsa Verde", "Salsa Roja", "Tortillas"]
    },
    {
        "nombre": "Marta García", 
        "sheet": "https://docs.google.com/spreadsheets/d/1QrXgIT4l2FdNQssWvegwNyOzRWqeQyCu-YkYfWN4v7g/edit?gid=0#gid=0", 
        "estado": "Activo",
        "ultima_entrega": "2025-08-08",
        "productos": ["Salsa Verde", "Guacamole", "Queso"]
    },
    {
        "nombre": "Luis Rodríguez", 
        "sheet": "https://docs.google.com/spreadsheets/d/1QrXgIT4l2FdNQssWvegwNyOzRWqeQyCu-YkYfWN4v7g/edit?gid=0#gid=0", 
        "estado": "Inactivo",
        "ultima_entrega": "2025-07-15",
        "productos": ["Salsa Roja", "Crema"]
    },
]

@app.on_event("startup")
def startup_event():
    init_db()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Landing page routes
@app.get("/", response_class=HTMLResponse)
def landing(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})

@app.get("/clientes", response_class=HTMLResponse)
def panel(request: Request):
    return templates.TemplateResponse("clientes.html", {"request": request, "clientes": clientes})

# API routes
@app.get("/api/")
def root():
    return {"message": "Agente multi-cliente activo"}

@app.post("/api/entrega")
def post_entrega(producto: str, cantidad: int, entrega: str, caducidad: str, cliente: str, db: Session = Depends(get_db)):
    return registrar_entrega(db, producto, cantidad, entrega, caducidad, cliente)

@app.post("/api/pago")
def post_pago(cantidad: int, fecha: str, cliente: str, db: Session = Depends(get_db)):
    return registrar_pago(db, cantidad, fecha, cliente)

@app.get("/api/saldo/{cliente}")
def get_saldo(cliente: str, db: Session = Depends(get_db)):
    return calcular_saldo(db, cliente)

@app.get("/api/inventario")
def get_inventario(cliente: str, db: Session = Depends(get_db)):
    return inventario_por_cliente(db, cliente)

class EntradaMasiva(BaseModel):
    producto: str
    cantidad: int
    fecha_entrega: str
    fecha_caducidad: str
    cliente: str

@app.post("/api/entregas/masivo")
def post_masivo(entradas: List[EntradaMasiva], db: Session = Depends(get_db)):
    data = [e.dict() for e in entradas]
    return registrar_entregas_masivo(db, data)
