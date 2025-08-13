#!/bin/bash

# Script para configurar y ejecutar n8n
echo "🚀 Configurando n8n para EntreGA..."

# Copiar archivo de configuración
echo "📝 Copiando configuración..."
cp env.txt .env

# Verificar configuración
echo "🔍 Verificando configuración..."
if grep -q "N8N_PROTOCOL=http" .env; then
    echo "✅ Configuración HTTP encontrada"
else
    echo "❌ Error: .env no tiene configuración HTTP"
    exit 1
fi

# Levantar n8n
echo "🚀 Levantando n8n..."
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

# Verificar funcionamiento HTTP
echo "✅ Verificando que n8n responda por HTTP..."
echo "🔍 Probando conexión a http://n8ne01.entrega.space:5678..."

# Intentar múltiples métodos de verificación
if curl -s --connect-timeout 10 http://n8ne01.entrega.space:5678 | grep -q "n8n"; then
    echo "🎉 ¡n8n está funcionando por HTTP!"
elif curl -s --connect-timeout 10 http://n8ne01.entrega.space:5678 | grep -q "html"; then
    echo "✅ n8n responde por HTTP (respuesta HTML detectada)"
elif curl -s --connect-timeout 10 http://n8ne01.entrega.space:5678 > /dev/null; then
    echo "✅ n8n responde por HTTP (conexión exitosa)"
else
    echo "⚠️ Advertencia: n8n puede no estar respondiendo por HTTP"
    echo "🔍 Verificando logs para más detalles..."
    docker compose logs n8n --tail 20
    echo "💡 n8n puede estar funcionando pero tardando en responder"
fi

echo "🎉 ¡Configuración completada!"
echo "🌐 n8n disponible en: http://n8ne01.entrega.space:5678"
echo "🤖 Agente IA disponible en: http://n8ne01.entrega.space:8000"
echo "🔗 Webhook URL: http://n8ne01.entrega.space:5678/webhook/..."
echo ""
echo "💡 Si tienes problemas, verifica:"
echo "   - Firewall permitiendo puertos 5678 y 8000"
echo "   - DNS apuntando a tu servidor"
echo "   - Directorio ./iaagent existe para el agente"
