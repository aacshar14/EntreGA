#!/bin/bash

# Script para configurar SSL y HTTPS para n8n
echo "🚀 Configurando SSL y HTTPS para n8n..."

# Verificar que los certificados SSL existan
echo "🔒 Verificando certificados SSL..."
if [ ! -f "/etc/letsencrypt/live/n8ne01.entrega.space/privkey.pem" ]; then
    echo "❌ Error: No se encontró el certificado privado"
    echo "Ejecuta: sudo certbot --nginx -d n8ne01.entrega.space"
    exit 1
fi

if [ ! -f "/etc/letsencrypt/live/n8ne01.entrega.space/fullchain.pem" ]; then
    echo "❌ Error: No se encontró el certificado público"
    echo "Ejecuta: sudo certbot --nginx -d n8ne01.entrega.space"
    exit 1
fi

echo "✅ Certificados SSL encontrados"

# Detener n8n actual
echo "📦 Deteniendo n8n actual..."
cd ~/EntreGA/compose
docker compose -f docker-compose-gcp.yml down

# Copiar archivo .env
echo "📝 Copiando configuración HTTPS..."
cp env.txt .env

# Verificar que .env tenga HTTPS
echo "🔍 Verificando configuración HTTPS..."
if grep -q "N8N_PROTOCOL=https" .env; then
    echo "✅ Configuración HTTPS encontrada en .env"
else
    echo "❌ Error: .env no tiene configuración HTTPS"
    exit 1
fi

# Verificar permisos de certificados
echo "🔐 Verificando permisos de certificados..."
sudo chmod 644 /etc/letsencrypt/live/n8ne01.entrega.space/fullchain.pem
sudo chmod 600 /etc/letsencrypt/live/n8ne01.entrega.space/privkey.pem

# Levantar n8n con HTTPS y certificados SSL
echo "🚀 Levantando n8n con HTTPS y certificados SSL..."
docker compose -f docker-compose-gcp.yml up -d

# Esperar a que n8n se inicialice
echo "⏳ Esperando a que n8n se inicialice..."
sleep 30

# Verificar que n8n esté funcionando
echo "✅ Verificando que n8n esté funcionando..."
if curl -k -s https://n8ne01.entrega.space:5678 | grep -q "n8n"; then
    echo "🎉 ¡n8n está funcionando con HTTPS!"
else
    echo "❌ Error: n8n no responde por HTTPS"
    echo "Verificando logs..."
    docker logs compose-n8n-1 --tail 20
    exit 1
fi

echo "🎉 ¡Configuración HTTPS completada!"
echo "🌐 n8n ahora está disponible en: https://n8ne01.entrega.space:5678"
echo "🔗 Webhook URL: https://n8ne01.entrega.space:5678/webhook/..."
echo "🔒 SSL certificados montados correctamente"
