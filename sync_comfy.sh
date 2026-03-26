#!/bin/bash
# Configuración
CONTAINER_NAME="comfy_edu"  # Cambia si tu contenedor tiene otro nombre
DOCKER_OUTPUT="/root/ComfyUI/output"
LOCAL_OUTPUT="$HOME/Documents/IA/comfy_out"

# Crear carpeta local si no existe
mkdir -p "$LOCAL_OUTPUT"

echo "🔄 Sincronizando desde Docker ($CONTAINER_NAME:$DOCKER_OUTPUT) a $LOCAL_OUTPUT"

# Opción A: Sincronización simple (copia todo, sobrescribe)
docker cp "$CONTAINER_NAME:$DOCKER_OUTPUT/." "$LOCAL_OUTPUT/"

# Opción B: Sincronización con rsync (solo archivos nuevos/modificados)
# docker exec "$CONTAINER_NAME" tar -C /root/ComfyUI -cf - output | tar -xf - -C "$LOCAL_OUTPUT"

echo "✅ Sincronización completada"
ls -la "$LOCAL_OUTPUT" | head -10
