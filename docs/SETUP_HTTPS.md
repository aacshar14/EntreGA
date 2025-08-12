# 🚀 Configuración HTTPS para n8n y WhatsApp

## 📋 Prerrequisitos

- ✅ SSL certificado configurado con Let's Encrypt
- ✅ Acceso SSH a la VM de GCP
- ✅ Docker y Docker Compose instalados
- ✅ Certificados SSL en `/etc/letsencrypt/live/n8ne01.entrega.space/`

## 🔧 Configuración Automática

### Opción 1: Script Automático (Recomendado)

```bash
# Conectar por SSH a GCP
ssh hgsadepe@n8ne01.entrega.space

# Navegar al directorio del proyecto
cd ~/EntreGA

# Hacer pull de los cambios
git pull origin main

# Navegar al directorio compose
cd compose

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

# 3. Verificar certificados SSL
sudo certbot certificates

# 4. Levantar n8n con HTTPS y certificados SSL
docker compose -f docker-compose-gcp.yml up -d

# 5. Verificar funcionamiento
curl -k https://n8ne01.entrega.space:5678
```

## 🔒 Configuración SSL

### Certificados Montados

El Docker Compose monta automáticamente:
- **Clave privada:** `/etc/letsencrypt/live/n8ne01.entrega.space/privkey.pem`
- **Certificado público:** `/etc/letsencrypt/live/n8ne01.entrega.space/fullchain.pem`

### Variables de Entorno SSL

```bash
N8N_SSL_KEY=/etc/ssl/private/privkey.pem
N8N_SSL_CERT=/etc/ssl/certs/fullchain.pem
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

# Verificar certificados montados
docker exec compose-n8n-1 ls -la /etc/ssl/
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
- Verificar que los certificados estén montados en el contenedor
- Revisar permisos de certificados: `sudo chmod 644 /etc/letsencrypt/live/n8ne01.entrega.space/fullchain.pem`

### Error: "SSL routines:ssl3_get_record:wrong version number"
- Verificar que n8n se haya reiniciado completamente
- Verificar que las variables de entorno SSL estén configuradas
- Verificar que los certificados estén montados correctamente

## 🔄 Reinicio Completo

Si hay problemas persistentes:

```bash
# Detener completamente
docker compose -f docker-compose-gcp.yml down

# Eliminar contenedor y volúmenes
docker rm -f compose-n8n-1
docker volume rm compose_n8n_data

# Levantar desde cero
docker compose -f docker-compose-gcp.yml up -d
```
