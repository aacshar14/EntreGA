
# 🧂 EntréGA - Inventario Multi-Cliente

EntréGA es una solución ligera y sin complicaciones para controlar el inventario de productos como salsas, galletas u otros bienes físicos, ideal para pequeños negocios y clientes informales.

Usa Google Sheets como entrada, FastAPI como backend y n8n como integrador. 100% Docker-ready y pensado para escalar.

## 🚀 Características

### Backend (FastAPI + SQLite)
- ✅ Endpoints REST para registrar entregas y pagos
- ✅ Filtro multi-cliente por nombre (`cliente`)
- ✅ Endpoint `/entregas/masivo` para integración con Google Sheets vía n8n
- ✅ Docker-ready con configuración optimizada
- ✅ Documentación automática con Swagger UI
- ✅ Base de datos SQLite para simplicidad

### Landing Page
- ✅ Página inicial explicativa del servicio (`/`)
- ✅ Panel de clientes con enlaces a Google Sheets (`/clientes`)
- ✅ Basado en FastAPI + Jinja2

## 📦 Instalación y Uso

### Requisitos
- Docker y docker-compose
- Python 3.11+ (para desarrollo local)

### 🐳 Deployment Local

```bash
# Clona el repositorio
git clone https://github.com/aacshar14/EntreGA.git
cd EntreGA

# Levanta el backend
cd backend
docker compose up --build -d

# Verifica que esté corriendo
docker ps
curl http://localhost:8000/
```

### ☁️ Deployment en GCP Cloud Shell

```bash
# 1. Abrir Google Cloud Shell
# 2. Clonar el repositorio
git clone https://github.com/aacshar14/EntreGA.git
cd EntreGA

# 3. Instalar docker-compose si es necesario
sudo apt-get update
sudo apt-get install -y docker-compose-plugin

# 4. Ejecutar la aplicación
cd backend
docker compose up --build -d

# 5. Verificar
docker ps
curl http://localhost:8000/

# 6. Abrir Web Preview en puerto 8000
```

### 🖥️ Deployment en GCP Compute Engine

```bash
# 1. Crear VM en GCP
# 2. Instalar Docker
sudo apt-get update
sudo apt-get install -y docker.io docker-compose-plugin
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

# 3. Clonar y ejecutar
git clone https://github.com/aacshar14/EntreGA.git
cd EntreGA/backend
docker compose up --build -d

# 4. Configurar firewall
gcloud compute firewall-rules create entrega-backend \
    --allow tcp:8000 \
    --source-ranges 0.0.0.0/0
```

## 📄 Endpoints de la API

| Método | Ruta | Descripción |
|--------|------|-------------|
| GET    | `/` | Health check |
| POST   | `/entrega` | Registrar una entrega |
| POST   | `/pago` | Registrar un pago |
| GET    | `/saldo/{cliente}` | Ver saldo de cliente |
| GET    | `/inventario?cliente=nombre` | Ver inventario por cliente |
| POST   | `/entregas/masivo` | Carga masiva desde Google Sheets |

### 📖 Documentación de la API
- **Swagger UI**: `http://localhost:8000/docs`
- **OpenAPI Spec**: `http://localhost:8000/openapi.json`

## 🧩 Integración con n8n

El flujo n8n exportable está incluido para automatizar la carga desde Google Sheets.

### Archivos de Integración
- `docs/n8n_google_sheets_salsa_flow.json` - Flujo de n8n
- `docs/README_agente_mcp.md` - Documentación del agente MCP

## 🏗️ Estructura del Proyecto

```
EntreGA/
├── backend/                 # Backend FastAPI
│   ├── app/
│   │   ├── main.py         # API endpoints
│   │   ├── models.py       # SQLAlchemy models
│   │   ├── crud.py         # Database operations
│   │   └── database.py     # Database configuration
│   ├── Dockerfile          # Container configuration
│   ├── docker-compose.yml  # Orchestration
│   └── requirements.txt    # Python dependencies
├── landing/                # Landing page
│   ├── app/
│   │   ├── main.py        # Web routes
│   │   └── templates/     # HTML templates
│   ├── Dockerfile
│   └── requirements.txt
└── docs/                   # Documentation
    ├── README_agente_mcp.md
    └── n8n_google_sheets_salsa_flow.json
```

## 🔧 Comandos Útiles

### Gestión de Contenedores
```bash
# Ver logs en tiempo real
docker logs -f backend-salsa-agent-1

# Reiniciar la aplicación
docker compose restart

# Actualizar desde GitHub
git pull origin main
docker compose up --build -d

# Verificar estado
docker ps
curl http://localhost:8000/
```

### Desarrollo Local
```bash
# Instalar dependencias
pip install -r backend/requirements.txt

# Ejecutar sin Docker
cd backend
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

## 🚀 URLs de Acceso

### Local
- **API**: http://localhost:8000/
- **Documentación**: http://localhost:8000/docs
- **Landing**: http://localhost:8000/clientes

### GCP Cloud Shell
- **Web Preview**: Disponible desde Cloud Shell en puerto 8000

### GCP Compute Engine
- **API**: http://[VM-IP]:8000/
- **Documentación**: http://[VM-IP]:8000/docs

## 💡 Casos de Uso Ideales

- 🏪 Emprendimientos informales (taquerías, neverías, reposterías)
- 📦 Negocios con productos perecederos
- 💰 Control básico de pagos y entregas
- 📊 Inventario multi-cliente
- 🔄 Integración con Google Sheets

## 🛠️ Tecnologías Utilizadas

- **Backend**: FastAPI, SQLAlchemy, SQLite
- **Frontend**: Jinja2, HTML, CSS
- **Containerización**: Docker, Docker Compose
- **Integración**: n8n, Google Sheets API
- **Cloud**: Google Cloud Platform

## 📝 Changelog

### v1.0.0 (2025-08-08)
- ✅ Backend FastAPI funcional
- ✅ Docker containerization
- ✅ GCP deployment support
- ✅ Multi-cliente inventory system
- ✅ Google Sheets integration ready
- ✅ API documentation with Swagger

## ✍️ Autor

Proyecto creado por Hugo González con apoyo de ChatGPT para facilitar la digitalización de inventario de pequeños negocios.

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo LICENSE para más detalles.

---

**¡EntréGA - Simplificando el control de inventario para pequeños negocios!** 🧂✨

