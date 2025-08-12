# 🚀 Configuración HTTPS para n8n y WhatsApp

## 📋 Prerrequisitos

- ✅ SSL certificado configurado con Let's Encrypt
- ✅ Acceso SSH a la VM de GCP
- ✅ Docker y Docker Compose instalados

## 🔧 Configuración Automática

### Opción 1: Script Automático (Recomendado)

```bash
# Conectar por SSH a GCP
ssh hgsadepe@n8ne01.entrega.space

# Navegar al directorio del proyecto
cd ~/EntreGA/compose

# Dar permisos de ejecución al script
chmod +x setup-ssl.sh

# Ejecutar script de configuración
./setup-ssl.sh
```

### Opción 2: Configuración Manual

```bash
# 1. Detener n8n actual
docker compose -f docker-compose-gcp.yml down

# 2. Copiar configuración HTTPS
cp env.txt .env

# 3. Levantar n8n con HTTPS
docker compose -f docker-compose-gcp.yml up -d

# 4. Verificar funcionamiento
curl -k https://n8ne01.entrega.space:5678
```

## 🌐 URLs de Acceso

- **n8n Interface:** https://n8ne01.entrega.space:5678
- **Login:** admin / EntreGA2025!
- **Webhook Base:** https://n8ne01.entrega.space:5678/webhook/

## 🔗 Configuración de WhatsApp

Una vez que n8n esté funcionando con HTTPS:

1. **Abrir workflow** `WA-003-WhatsApp-IA-Complete`
2. **Configurar WhatsApp Trigger** con credenciales
3. **Usar URL HTTPS** para webhook
4. **Activar workflow**

## ✅ Verificación

```bash
# Verificar que n8n esté funcionando
curl -k https://n8ne01.entrega.space:5678

# Verificar certificado SSL
sudo certbot certificates

# Verificar logs de n8n
docker logs compose-n8n-1
```

## 🆘 Solución de Problemas

### Error: "Invalid parameter"
- Verificar que todas las credenciales estén configuradas
- Asegurar que el workflow esté activado

### Error: "Webhook not registered"
- Verificar que el workflow esté activo
- Esperar 30 segundos después de activar

### Error: "SSL certificate"
- Verificar que Let's Encrypt esté funcionando
- Revisar logs de nginx/apache
