# IA Agent - Webhook Simulado

Este proyecto implementa un webhook simulado usando FastAPI para recibir y procesar mensajes.

## Estructura del Proyecto

```
iaagent/
├── main.py           # Aplicación FastAPI principal
├── requirements.txt  # Dependencias de Python
├── Dockerfile       # Configuración de Docker
└── README.md        # Este archivo
```

## Funcionalidades

- **Endpoint POST** `/webhook/simulado`
- Recibe mensajes con estructura: `numero`, `nombre`, `mensaje`
- Retorna confirmación de recepción

## Instalación y Uso

### Opción 1: Ejecutar localmente

1. Instalar dependencias:
```bash
pip install -r requirements.txt
```

2. Ejecutar la aplicación:
```bash
uvicorn main:app --reload
```

3. La API estará disponible en: `http://localhost:8000`

### Opción 2: Usar Docker

1. Construir la imagen:
```bash
docker build -t iaagent .
```

2. Ejecutar el contenedor:
```bash
docker run -p 8000:8000 iaagent
```

## Uso de la API

### Enviar mensaje al webhook:

```bash
curl -X POST "http://localhost:8000/webhook/simulado" \
     -H "Content-Type: application/json" \
     -d '{
       "numero": "+1234567890",
       "nombre": "Juan Pérez",
       "mensaje": "Hola, ¿cómo estás?"
     }'
```

### Respuesta esperada:

```json
{
  "cliente": "Juan Pérez",
  "telefono": "+1234567890",
  "mensaje_recibido": "Hola, ¿cómo estás?",
  "status": "Recibido correctamente"
}
```

## Documentación de la API

Una vez ejecutada la aplicación, puedes acceder a la documentación automática en:
- **Swagger UI**: `http://localhost:8000/docs`
- **ReDoc**: `http://localhost:8000/redoc`
