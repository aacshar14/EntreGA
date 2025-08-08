from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates

app = FastAPI()
app.mount("/static", StaticFiles(directory="app/static"), name="static")
templates = Jinja2Templates(directory="app/templates")

clientes = [
    {"nombre": "Juan", "sheet": "https://docs.google.com/spreadsheets/d/juan-sheet", "estado": "Activo"},
    {"nombre": "Marta", "sheet": "https://docs.google.com/spreadsheets/d/marta-sheet", "estado": "Activo"},
    {"nombre": "Luis", "sheet": "https://docs.google.com/spreadsheets/d/luis-sheet", "estado": "Inactivo"},
]

@app.get("/", response_class=HTMLResponse)
def landing(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})

@app.get("/clientes", response_class=HTMLResponse)
def panel(request: Request):
    return templates.TemplateResponse("clientes.html", {"request": request, "clientes": clientes})
