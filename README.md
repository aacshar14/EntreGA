
# EntreGA - n8n Workflow Automation

Sistema de automatización de workflows con n8n para EntreGA, configurado con SSL y certificados Let's Encrypt.

## 🚀 Configuración Rápida

### Prerrequisitos
- Docker y Docker Compose instalados
- Certificados SSL de Let's Encrypt para `n8ne01.entrega.space`
- Dominio configurado y apuntando al servidor

### Instalación

1. **Clonar el repositorio:**
   ```bash
   git clone <your-repo>
   cd EntreGA
   ```

2. **Verificar certificados SSL:**
   ```bash
   sudo ls -la /etc/letsencrypt/archive/n8ne01.entrega.space/
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

El sistema está configurado para usar HTTPS con certificados Let's Encrypt:

- **Puerto:** 5678
- **Protocolo:** HTTPS
- **Dominio:** n8ne01.entrega.space
- **Certificados:** Montados desde `/etc/letsencrypt/archive/`

## 🌐 Acceso

- **URL:** https://n8ne01.entrega.space:5678
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
- `WEBHOOK_URL=https://n8ne01.entrega.space:5678`
- `N8N_BASIC_AUTH_ACTIVE=true`
- `N8N_ENCRYPTION_KEY=EntreGA2025!EncryptionKey32Chars`

## 🚨 Solución de Problemas

### Certificados SSL no encontrados
```bash
sudo certbot --nginx -d n8ne01.entrega.space
```

### Permisos de certificados
```bash
sudo chmod 644 /etc/letsencrypt/archive/n8ne01.entrega.space/fullchain1.pem
sudo chmod 600 /etc/letsencrypt/archive/n8ne01.entrega.space/privkey1.pem
```

### Verificar funcionamiento
```bash
curl -k https://n8ne01.entrega.space:5678
```

## 📝 Notas

- Los datos de n8n se almacenan en un volumen Docker persistente
- El sistema se reinicia automáticamente en caso de fallo
- Los certificados SSL se renuevan automáticamente con Let's Encrypt

