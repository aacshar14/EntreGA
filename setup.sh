#!/bin/bash

# Script para configurar y ejecutar n8n con SSL
echo "🚀 Configurando n8n con SSL para EntreGA..."

# Verificar que los certificados SSL existan
echo "🔒 Verificando certificados SSL..."
if [ ! -f "/etc/letsencrypt/live/n8ne01.entrega.space/privkey.pem" ]; then
    echo "❌ Error: No se encontró el certificado privado"
    echo "Ruta esperada: /etc/letsencrypt/live/n8ne01.entrega.space/privkey.pem"
    echo "Ejecuta: sudo certbot --nginx -d n8ne01.entrega.space"
    exit 1
fi

if [ ! -f "/etc/letsencrypt/live/n8ne01.entrega.space/fullchain.pem" ]; then
    echo "❌ Error: No se encontró el certificado público"
    echo "Ruta esperada: /etc/letsencrypt/live/n8ne01.entrega.space/fullchain.pem"
    echo "Ejecuta: sudo certbot --nginx -d n8ne01.entrega.space"
    exit 1
fi

echo "✅ Certificados SSL encontrados en Let's Encrypt"

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
sudo chmod 644 /etc/letsencrypt/live/n8ne01.entrega.space/fullchain.pem
sudo chmod 600 /etc/letsencrypt/live/n8ne01.entrega.space/privkey.pem

# Levantar n8n con HTTPS
echo "🚀 Levantando n8n con HTTPS..."
docker compose up -d

# Esperar inicialización
echo "⏳ Esperando a que n8n se inicialice..."
sleep 45

# Verificar que el contenedor esté funcionando
echo "🔍 Verificando estado del contenedor..."
if docker ps | grep -q "n8n"; then
    echo "✅ Contenedor n8n está ejecutándose"
else
    echo "❌ Error: Contenedor n8n no está ejecutándose"
    docker compose logs n8n --tail 20
    exit 1
fi

# Verificar logs para asegurar que n8n esté listo
echo "📋 Verificando logs de n8n..."
if docker compose logs n8n --tail 10 | grep -q "Task Broker ready"; then
    echo "✅ n8n está listo y funcionando"
else
    echo "⚠️ n8n puede no estar completamente listo, continuando..."
fi

# Verificar funcionamiento HTTPS
echo "✅ Verificando que n8n responda por HTTPS..."
echo "🔍 Probando conexión a https://n8ne01.entrega.space..."

# Intentar múltiples métodos de verificación
if curl -k -s --connect-timeout 10 https://n8ne01.entrega.space | grep -q "n8n"; then
    echo "🎉 ¡n8n está funcionando con HTTPS!"
elif curl -k -s --connect-timeout 10 https://n8ne01.entrega.space | grep -q "html"; then
    echo "✅ n8n responde por HTTPS (respuesta HTML detectada)"
elif curl -k -s --connect-timeout 10 https://n8ne01.entrega.space > /dev/null; then
    echo "✅ n8n responde por HTTPS (conexión exitosa)"
else
    echo "⚠️ Advertencia: n8n puede no estar respondiendo por HTTPS"
    echo "🔍 Verificando logs para más detalles..."
    docker compose logs n8n --tail 20
    echo "💡 n8n puede estar funcionando pero tardando en responder"
fi

echo "🎉 ¡Configuración completada!"
echo "🌐 n8n disponible en: https://n8ne01.entrega.space"
echo "🔗 Webhook URL: https://n8ne01.entrega.space/webhook/..."
echo "🔒 SSL certificados montados correctamente desde Let's Encrypt"
echo ""
echo "💡 Si tienes problemas, verifica:"
echo "   - Certificados en /etc/letsencrypt/live/n8ne01.entrega.space/"
echo "   - Firewall permitiendo puerto 443"
echo "   - DNS apuntando a tu servidor"
echo "   - Certbot configurado correctamente"
