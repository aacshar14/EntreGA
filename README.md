
# EntreGA - n8n Workflow Automation + IA Agent

Sistema de automatización de workflows con n8n para EntreGA, incluyendo un agente de IA integrado.

## 🚀 Configuración Rápida

### Prerrequisitos
- Docker y Docker Compose instalados
- Dominio configurado y apuntando al servidor
- Directorio `./iaagent` con el código del agente de IA

### Instalación

1. **Clonar el repositorio:**
   ```bash
   git clone <your-repo>
   cd EntreGA
   ```

2. **Verificar que existe el directorio del agente:**
   ```bash
   ls -la ./iaagent
   ```

3. **Ejecutar setup:**
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

### Uso

- **Iniciar servicios:** `./setup.sh`
- **Detener servicios:** `./cleanup.sh`
- **Ver logs n8n:** `docker compose logs -f n8n`
- **Ver logs agente:** `docker compose logs -f entrega-agent`

## 🌐 Configuración de Servicios

### n8n (Puerto 5678)
- **Protocolo:** HTTP
- **Puerto:** 5678:5678
- **URL:** http://n8ne01.entrega.space:5678
- **Usuario:** admin
- **Contraseña:** EntreGA2025!

### Agente IA (Puerto 8000)
- **Puerto:** 8000:8000
- **URL:** http://n8ne01.entrega.space:8000
- **Tipo:** Servicio personalizado construido desde `./iaagent`

## 📁 Estructura del Proyecto

```
EntreGA/
├── docker-compose.yml      # Configuración principal de Docker
├── env.txt                 # Variables de entorno
├── setup.sh               # Script de instalación
├── cleanup.sh             # Script de limpieza
├── iaagent/               # Código del agente de IA
└── README.md              # Este archivo
```

## 🔧 Variables de Entorno

Las principales variables están en `env.txt`:

- `N8N_PROTOCOL=http`
- `WEBHOOK_URL=https://n8ne01.entrega.space`
- `N8N_BASIC_AUTH_ACTIVE=true`
- `N8N_ENCRYPTION_KEY=EntreGA2025!EncryptionKey32Chars`

## 🚨 Solución de Problemas

### Verificar funcionamiento
```bash
# n8n
curl http://n8ne01.entrega.space:5678

# Agente IA
curl http://n8ne01.entrega.space:8000
```

### Verificar logs
```bash
# Logs de n8n
docker compose logs n8n --tail 20

# Logs del agente
docker compose logs entrega-agent --tail 20
```

## 📝 Notas

- Los datos de n8n se almacenan en un volumen Docker persistente
- El sistema se reinicia automáticamente en caso de fallo
- El agente IA se construye desde el código fuente en `./iaagent`
- Ambos servicios comparten la red `entrega_network`
- Puerto 5678 del host se mapea al puerto 5678 del contenedor n8n
- Puerto 8000 del host se mapea al puerto 8000 del contenedor del agente

