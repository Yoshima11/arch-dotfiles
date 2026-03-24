#!/bin/bash

# Configuración
CONTAINER_NAME="comfy_edu"
INTERNAL_SCRIPT="/root/run_comfyui.sh" # Ruta absoluta preferible

echo "--- 🚀 Iniciando Deep Mind Production Suite (AMD) ---"

# 1. Comprobar si el contenedor existe
if [ ! "$(docker ps -a -q -f name=$CONTAINER_NAME)" ]; then
    echo "❌ Error: El contenedor $CONTAINER_NAME no existe."
    exit 1
fi

# 2. Iniciar el contenedor si no está corriendo
if [ ! "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "-> 🔋 Despertando al contenedor..."
    docker start $CONTAINER_NAME
    sleep 3
fi

# 3. Lanzar ComfyUI con optimizaciones críticas para AMD y VRAM
echo "-> 🛠️ Aplicando parches de memoria y lanzando ComfyUI..."

# EXPLICACIÓN DE LAS VARIABLES:
# HSA_OVERRIDE_GFX_VERSION: Obligatorio para que ROCm reconozca tu tarjeta (10.3.0 para serie 6000).
# --lowvram: Vital para que Wan2.1 no sature tus 16GB.
# --use-split-cross-attention: Mejora drásticamente el uso de memoria en AMD.

docker exec -it $CONTAINER_NAME /bin/bash -c "
    export LC_ALL=C && \
    export HSA_OVERRIDE_GFX_VERSION=12.0.0 && \
    export TRITON_BACKEND=rocm && \
    export HSA_ENABLE_SDMA=0 && \
    export DCC_DISABLE=1 && \
    export PYTORCH_ROC_ALLOC_CONF=max_split_size_mb:256 && \
    export ROCM_FHT_DISABLE=1 && \
    export PYTORCH_HIP_ALLOC_CONF=expandable_segments:True && \
    export TORCH_ROCM_AOTRITON_ENABLE_EXPERIMENTAL=1 && \
    export HIP_VISIBLE_DEVICES=0 && \
    cd /root/ComfyUI && \
    python3 main.py --disable-metadata --listen 0.0.0.0 --port 8188 --fast --fp8_e4m3fn-unet --normalvram --use-split-cross-attention
"
