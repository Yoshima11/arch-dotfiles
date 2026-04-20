#!/bin/bash

CONTAINER_NAME="comfyui-rocm"

# Iniciar el contenedor si está detenido
if ! docker ps --format '{{.Names}}' | grep -q "^$CONTAINER_NAME$"; then
    echo "🔄 Iniciando contenedor..."
    docker start $CONTAINER_NAME
    sleep 2
fi

# Detener cualquier instancia previa de ComfyUI
docker exec $CONTAINER_NAME pkill -f "python main.py" 2>/dev/null

# Iniciar ComfyUI con todas las variables y parámetros
echo "🚀 Iniciando ComfyUI con optimizaciones para RDNA 4..."

docker exec -it \
  -e HSA_OVERRIDE_GFX_VERSION=12.0.0 \
  -e PYTORCH_HIP_ALLOC_CONF="expandable_segments:True" \
  -e PYTORCH_HIP_ALLOC_CONF="max_split_size_mb:256" \
  comfyui-rocm \
  /bin/bash -c "cd /opt/comfyui && python main.py \
    --listen 0.0.0.0 \
    --port 8188 \
    --use-pytorch-cross-attention \
    --lowvram \
    --bf16-unet \
    --disable-smart-memory
"

# echo "✅ ComfyUI iniciado en http://localhost:8188"
# echo "📋 Ver logs: ./log_comfy.sh"
# echo "🛑 Detener ComfyUI: ./stop_comfy.sh"
