export LC_ALL=C
export HSA_OVERRIDE_GFX_VERSION=12.0.0
export HSA_ENABLE_SDMA=0
export DCC_DISABLE=1
export PYTORCH_ROC_ALLOC_CONF=max_split_size_mb:256
export ROCM_FHT_DISABLE=1
python3 ~/ComfyUI/main.py --listen 0.0.0.0 --port 8188 --use-split-cross-attent
