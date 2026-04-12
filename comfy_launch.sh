#!/bin/bash

# 1. Ruta al entorno virtual (corregida la letra 'a' que faltaba en activate)
VENV_PATH="/mnt/sdb1/ComfyUI/venv/bin/activate"
COMFYUI_DIR="/mnt/sdb1/ComfyUI"

if [ -f "$VENV_PATH" ]; then
    source "$VENV_PATH"
    echo "✅ Entorno virtual activado."
else
    echo "❌ Error: No se encontró el entorno en $VENV_PATH"
    exit 1
fi

#export ROCM_PATH=/opt/rocm
#export MIOPEN_DEBUG_DISABLE_KERNEL_CACHE=1
#export MIOPEN_DEBUG_AI_KERNEL_SELECTION=0
#export LD_LIBRARY_PATH=/opt/rocm/lib:$LD_LIBRARY_PATh

export PYTHONPATH=/opt/rocm/lib:$PYTHONPATH
export MIGRAPHX_MLIR_USE_SPECIFIC_OPS="attention"

## el modo de búsqueda predeterminado de miopen causa una lentitud inicial significativa, no produce ningún beneficio para los flujos de trabajo que probé
#export MIOPEN_DEBUG_CONV_IMPLICIT_GEMM_FWD_XDL_OPS=0
#export MIOPEN_FIND_MODE=1
#export MIOPEN_SYSTEM_DB_PATH=/opt/rocm/share/miopen/db
#export MIOPEN_USER_DB_PATH=~/.config/miopen
#export MIOPEN_DEBUG_DISABLE_AI_HEURISTICS=1

#export HSA_OVERRIDE_GFX_VERSION=12.0.0 # Busca en Google el número correcto aquí, depende de la GPU que tengas
#export HIP_VISIBLE_DEVICES=0

# más lento, pero más estable / menos OOMs. ¿No tienes OOMs? Quizás no necesites esto.
# export PYTORCH_NO_HIP_MEMORY_CACHING=1

# triton
#export TORCH_ROCM_AOTRITON_ENABLE_EXPERIMENTAL=1
#export FLASH_ATTENTION_TRITON_AMD_ENABLE=TRUE
# Rendimiento de attn_fwd significativamente más rápido para flujos de trabajo wan2.2
#export FLASH_ATTENTION_FWD_TRITON_AMD_CONFIG_JSON='{"BLOCK_M":128,"BLOCK_N":64,"waves_per_eu":1,"PRE_LOAD_V":false,"num_stages":1,"num_warps":8}'

# pytorch cambia a NHWC para rocm > 7, causa regresiones significativas de miopen para upscaling
# pendiente: ¿arreglado ya? ¿desde qué versión de pytorch?
#export PYTORCH_MIOPEN_SUGGEST_NHWC=1

# miopen
## Dile a comfyui que *no* deshabilite miopen/cudnn, de lo contrario el rendimiento de upscaling es mucho peor
#export COMFYUI_ENABLE_MIOPEN=1

#export PYTORCH_HIP_ALLOC_CONF=garbage_collection_threshold:0.6,max_split_size_mb:512

python3 $COMFYUI_DIR/main.py \
    --enable-manager \
    --use-pytorch-cross-attention \
    --normalvram \
    --preview-method auto \
    --disable-smart-memory \
    --disable-pinned-memory
