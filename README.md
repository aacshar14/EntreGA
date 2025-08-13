
# EntreGA - n8n Workflow Automation

Sistema de automatización de workflows con n8n para EntreGA, configurado con SSL y certificados personalizados.

## 🚀 Configuración Rápida

### Prerrequisitos
- Docker y Docker Compose instalados
- Certificados SSL en `/opt/n8n-certs/`
- Dominio configurado y apuntando al servidor

### Instalación

1. **Clonar el repositorio:**
   ```bash
   git clone <your-repo>
   cd EntreGA
   ```

2. **Verificar certificados SSL:**
   ```bash
   sudo ls -la /opt/n8n-certs/
   ```

3. **Ejecutar setup:**
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

### Uso

- **Iniciar n8n:** `./setup.sh`
- **Detener n8n:** `./cleanup.sh`
- **Ver logs:** `docker compose logs -f n8n`

## 🔒 Configuración SSL

El sistema está configurado para usar HTTPS con certificados personalizados:

- **Puerto:** 443 (HTTPS estándar)
- **Protocolo:** HTTPS
- **Dominio:** n8ne01.entrega.space
- **Certificados:** Montados desde `/opt/n8n-certs/`

## 🌐 Acceso

- **URL:** https://n8ne01.entrega.space
- **Usuario:** admin
- **Contraseña:** EntreGA2025!

## 📁 Estructura del Proyecto

```
EntreGA/
├── docker-compose.yml      # Configuración principal de Docker
├── env.txt                 # Variables de entorno
├── setup.sh               # Script de instalación
├── cleanup.sh             # Script de limpieza
└── README.md              # Este archivo
```

## 🔧 Variables de Entorno

Las principales variables están en `env.txt`:

- `N8N_PROTOCOL=https`
- `WEBHOOK_URL=https://n8ne01.entrega.space`
- `N8N_BASIC_AUTH_ACTIVE=true`
- `N8N_ENCRYPTION_KEY=EntreGA2025!EncryptionKey32Chars`

## 🚨 Solución de Problemas

### Certificados SSL no encontrados
```bash
# Verificar que existan en /opt/n8n-certs/
sudo ls -la /opt/n8n-certs/
```

### Permisos de certificados
```bash
sudo chmod 644 /opt/n8n-certs/fullchain.pem
sudo chmod 600 /opt/n8n-certs/privkey.pem
```

### Verificar funcionamiento
```bash
curl -k https://n8ne01.entrega.space
```

## 📝 Notas

- Los datos de n8n se almacenan en un volumen Docker persistente
- El sistema se reinicia automáticamente en caso de fallo
- Los certificados SSL deben estar en `/opt/n8n-certs/`
- Puerto 443 del host se mapea al puerto 5678 del contenedor

