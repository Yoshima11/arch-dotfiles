#!/bin/bash

CONTAINER_NAME="comfyui-rocm"

# Verificar si el contenedor existe
if ! docker ps -a --format '{{.Names}}' | grep -q "^$CONTAINER_NAME$"; then
    echo "❌ El contenedor $CONTAINER_NAME no existe."
    exit 1
fi

# Verificar si el contenedor está corriendo
if ! docker ps --format '{{.Names}}' | grep -q "^$CONTAINER_NAME$"; then
    echo "⚠️  El contenedor no está corriendo. Iniciándolo..."
    docker start $CONTAINER_NAME
    sleep 2
fi

echo "=========================================="
echo "📋 Logs de ComfyUI (Ctrl+C para salir)"
echo "=========================================="
docker logs -f $CONTAINER_NAME
