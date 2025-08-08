# 🧂 Agente MCP - Inventario Multi-Cliente

Este proyecto es un sistema de inventario digital para productos como salsas, galletas, etc., pensado para pequeños negocios o clientes informales que usan Google Sheets para registrar entregas, caducidades y pagos.

## 🚀 ¿Qué incluye?

### Backend (FastAPI + SQLite)
- Endpoints REST para registrar entregas y pagos
- Filtro multi-cliente por nombre (`cliente`)
- Endpoint `/entregas/masivo` para integración con Google Sheets vía n8n
- Docker-ready (`docker-compose.yml` incluido)

### Landing Page
- Página inicial explicativa del servicio (`/`)
- Panel de clientes con enlaces a Google Sheets (`/clientes`)
- Basado en FastAPI + Jinja2

---

## 📦 Cómo usar

### Requisitos
- Docker y docker-compose

### Comandos

```bash
# Clona el repositorio
git clone https://github.com/tuusuario/agente-mcp.git
cd agente-mcp

# Levanta todo con Docker
docker-compose up --build
```

La app estará disponible en:
- `http://localhost:8000/` (Landing)
- `http://localhost:8000/clientes` (Panel)
- `http://localhost:8000/docs` (Swagger API)

---

## 📄 Endpoints clave

| Método | Ruta | Descripción |
|--------|------|-------------|
| POST   | `/entrega` | Registrar una entrega |
| POST   | `/pago` | Registrar un pago |
| GET    | `/saldo/{cliente}` | Ver saldo de cliente |
| GET    | `/inventario?cliente=nombre` | Ver inventario por cliente |
| POST   | `/entregas/masivo` | Carga masiva desde Google Sheets |

---

## 🧩 Integración con n8n

El flujo n8n exportable está incluido para automatizar la carga desde Google Sheets.

---

## 📘 Manual para clientes

Se incluye un manual Word (`manual_agente_mcp.docx`) para entregar a tus clientes con instrucciones para usar el sistema.

---

## 💡 Ideal para

- Emprendimientos informales (taquerías, neverías, reposterías)
- Negocios con productos perecederos
- Control básico de pagos y entregas

---

## ✍️ Autor

Proyecto creado por Hugo González con apoyo de ChatGPT para facilitar la digitalización de inventario de pequeños negocios.

