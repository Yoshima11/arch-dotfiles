#!/bin/bash

CONTAINER_NAME="comfyui-rocm"

echo "🛑 Deteniendo ComfyUI..."

# Verificar si el contenedor existe
if ! docker ps -a --format '{{.Names}}' | grep -q "^$CONTAINER_NAME$"; then
    echo "❌ El contenedor $CONTAINER_NAME no existe."
    exit 1
fi

# Detener el proceso de Python de ComfyUI
docker exec $CONTAINER_NAME pkill -f "python main.py" 2>/dev/null

# Verificar si se detuvo
sleep 1
if docker exec $CONTAINER_NAME pgrep -f "python main.py" > /dev/null 2>&1; then
    echo "⚠️  No se pudo detener ComfyUI, forzando..."
    docker exec $CONTAINER_NAME pkill -9 -f "python main.py" 2>/dev/null
fi

echo "✅ ComfyUI detenido. El contenedor sigue corriendo."
echo "💡 Para iniciar de nuevo: ./start_comfy.sh"
