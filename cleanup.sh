#!/bin/bash

# Script para limpiar y detener n8n
echo "🧹 Limpiando n8n..."

# Detener y remover contenedores
echo "📦 Deteniendo contenedores..."
docker compose down

# Remover volúmenes (opcional - descomenta si quieres eliminar datos)
# echo "🗑️ Removiendo volúmenes..."
# docker compose down -v

# Remover imágenes (opcional - descomenta si quieres eliminar imágenes)
# echo "🖼️ Removiendo imágenes..."
# docker rmi n8nio/n8n:1.106.3

echo "✅ Limpieza completada"
echo "💡 Para volver a ejecutar: ./setup.sh"
