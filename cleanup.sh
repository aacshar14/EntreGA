#!/bin/bash

# Script para limpiar y detener n8n
echo "🧹 Limpiando n8n..."

# Verificar que estamos en el directorio correcto
if [ ! -d "compose" ]; then
    echo "❌ Error: Directorio 'compose' no encontrado"
    echo "Ejecuta este script desde la raíz del proyecto EntreGA"
    exit 1
fi

# Cambiar al directorio compose
cd compose

# Detener y remover contenedores
echo "📦 Deteniendo contenedores..."
docker compose down

# Remover volúmenes (opcional - descomenta si quieres eliminar datos)
# echo "🗑️ Removiendo volúmenes..."
# docker compose down -v

# Remover imágenes (opcional - descomenta si quieres eliminar imágenes)
# echo "🖼️ Removiendo imágenes..."
# docker rmi n8nio/n8n:latest

echo "✅ Limpieza completada"
echo "💡 Para volver a ejecutar: ./setup.sh"
echo "📍 Asegúrate de ejecutar desde la raíz del proyecto EntreGA"
