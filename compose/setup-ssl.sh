#!/bin/bash

# Script para configurar SSL y actualizar n8n para HTTPS
echo "🚀 Configurando SSL y HTTPS para n8n..."

# Detener n8n actual
echo "📦 Deteniendo n8n actual..."
cd ~/EntreGA/compose
docker compose -f docker-compose-gcp.yml down

# Copiar archivo .env
echo "📝 Copiando configuración HTTPS..."
cp env.txt .env

# Verificar que SSL esté funcionando
echo "🔒 Verificando certificado SSL..."
sudo certbot certificates

# Levantar n8n con HTTPS
echo "🚀 Levantando n8n con HTTPS..."
docker compose -f docker-compose-gcp.yml up -d

# Esperar a que n8n se inicialice
echo "⏳ Esperando a que n8n se inicialice..."
sleep 20

# Verificar que n8n esté funcionando
echo "✅ Verificando que n8n esté funcionando..."
curl -k -s https://n8ne01.entrega.space:5678 | head -5

echo "🎉 ¡Configuración HTTPS completada!"
echo "🌐 n8n ahora está disponible en: https://n8ne01.entrega.space:5678"
echo "🔗 Webhook URL: https://n8ne01.entrega.space:5678/webhook/..."
