#!/bin/bash

# Script para configurar y ejecutar n8n con SSL
echo "🚀 Configurando n8n con SSL para EntreGA..."

# Verificar que los certificados SSL existan
echo "🔒 Verificando certificados SSL..."
if [ ! -f "/etc/letsencrypt/archive/n8ne01.entrega.space/privkey1.pem" ]; then
    echo "❌ Error: No se encontró el certificado privado"
    echo "Ruta esperada: /etc/letsencrypt/archive/n8ne01.entrega.space/privkey1.pem"
    echo "Ejecuta: sudo certbot --nginx -d n8ne01.entrega.space"
    exit 1
fi

if [ ! -f "/etc/letsencrypt/archive/n8ne01.entrega.space/fullchain1.pem" ]; then
    echo "❌ Error: No se encontró el certificado público"
    echo "Ruta esperada: /etc/letsencrypt/archive/n8ne01.entrega.space/fullchain1.pem"
    echo "Ejecuta: sudo certbot --nginx -d n8ne01.entrega.space"
    exit 1
fi

echo "✅ Certificados SSL encontrados"

# Copiar archivo de configuración
echo "📝 Copiando configuración..."
cp env.txt .env

# Verificar configuración HTTPS
echo "🔍 Verificando configuración HTTPS..."
if grep -q "N8N_PROTOCOL=https" .env; then
    echo "✅ Configuración HTTPS encontrada"
else
    echo "❌ Error: .env no tiene configuración HTTPS"
    exit 1
fi

# Verificar permisos de certificados
echo "🔐 Verificando permisos de certificados..."
sudo chmod 644 /etc/letsencrypt/archive/n8ne01.entrega.space/fullchain1.pem
sudo chmod 600 /etc/letsencrypt/archive/n8ne01.entrega.space/privkey1.pem

# Levantar n8n con HTTPS
echo "🚀 Levantando n8n con HTTPS..."
docker compose up -d

# Esperar inicialización
echo "⏳ Esperando a que n8n se inicialice..."
sleep 30

# Verificar funcionamiento
echo "✅ Verificando que n8n esté funcionando..."
if curl -k -s https://n8ne01.entrega.space:5678 | grep -q "n8n"; then
    echo "🎉 ¡n8n está funcionando con HTTPS!"
else
    echo "❌ Error: n8n no responde por HTTPS"
    echo "Verificando logs..."
    docker logs entrega-n8n-1 --tail 20
    exit 1
fi

echo "🎉 ¡Configuración completada!"
echo "🌐 n8n disponible en: https://n8ne01.entrega.space:5678"
echo "🔗 Webhook URL: https://n8ne01.entrega.space:5678/webhook/..."
echo "🔒 SSL certificados montados correctamente"
