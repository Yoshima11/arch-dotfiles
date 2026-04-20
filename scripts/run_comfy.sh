#!/bin/bash

CONTAINER_NAME="comfyui-rocm"
BASE_DIR="/mnt/sdb1/docker-proyects/comfyui-rocm"

# ============================================
# Configuración de ROCm y PyTorch para RDNA 4
# ============================================
export HSA_OVERRIDE_GFX_VERSION="12.0.0"
export PYTORCH_ROCM_ARCH="gfx1200"
export HIP_VISIBLE_DEVICES="0"
export PYTORCH_ALLOC_CONF="expandable_segments:True"
export PYTORCH_HIP_ALLOC_CONF="max_split_size_mb:256,garbage_collection_threshold:0.3"
export OMP_NUM_THREADS="4"

# Detener y eliminar si existe
docker stop $CONTAINER_NAME 2>/dev/null
docker rm $CONTAINER_NAME 2>/dev/null

echo "🚀 Creando contenedor con optimizaciones para RDNA 4..."
docker run -d \
  --name $CONTAINER_NAME \
  --device=/dev/kfd \
  --device=/dev/dri \
  --group-add=video \
  --group-add=render \
  --ipc=host \
  --shm-size=16G \
  --ulimit memlock=-1:-1 \
  --cap-add=SYS_PTRACE \
  --security-opt seccomp=unconfined \
  -p 8188:8188 \
  -v $BASE_DIR/models:/root/ComfyUI/models \
  -v $BASE_DIR/output:/root/ComfyUI/output \
  -v $BASE_DIR/input:/root/ComfyUI/input \
  -v $BASE_DIR/custom_nodes:/root/ComfyUI/custom_nodes \
  rocm/pytorch:rocm7.2_ubuntu24.04_py3.13_pytorch_release_2.10.0 \
  /bin/bash -c "
    if [ ! -d /opt/comfyui ]; then
      echo '📦 Instalando ComfyUI...'
      apt update && apt install -y git
      git clone https://github.com/comfyanonymous/ComfyUI.git /opt/comfyui
      cd /opt/comfyui
      pip install -r requirements.txt

      echo '📦 Instalando ComfyUI Manager...'
      cd /opt/comfyui/custom_nodes
      git clone https://github.com/ltdrdata/ComfyUI-Manager.git
      cd ComfyUI-Manager
      pip install -r requirements.txt

      echo '🔗 Configurando volúmenes...'
      cd /opt/comfyui
      rm -rf models output input custom_nodes
      ln -s /root/ComfyUI/models models
      ln -s /root/ComfyUI/output output
      ln -s /root/ComfyUI/input input
      ln -s /root/ComfyUI/custom_nodes custom_nodes

      echo '✅ Instalación completa.'
    fi
    tail -f /dev/null
  "

echo "✅ Contenedor creado. Usa ./start.sh para iniciar ComfyUI"
