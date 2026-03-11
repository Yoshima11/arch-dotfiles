#!/bin/bash

# --- Rutas de Hardware ---
GPU_PATH="/sys/class/drm/card1/device"

if [ -d "$GPU_PATH" ]; then
    # --- Datos para la BARRA ---
    GPU_LOAD=$(cat "$GPU_PATH/gpu_busy_percent" 2>/dev/null || echo "0")
    GPU_TEMP=$(sensors | grep "edge" | head -1 | awk '{print $2}' | tr -d '+')

    # --- Datos para el TOOLTIP ---
    VRAM_U=$(cat "$GPU_PATH/mem_info_vram_used" 2>/dev/null || echo "0")
    VRAM_T=$(cat "$GPU_PATH/mem_info_vram_total" 2>/dev/null || echo "1")
    VRAM_USAGE=$(echo "scale=2; ($VRAM_U / $VRAM_T) * 100" | bc | awk '{printf "%d", $1}')

    GPU_MEM_TEMP=$(sensors | grep -E "mem:|mem" | head -1 | awk '{print $2}' | tr -d '+')
    GPU_WATTS=$(sensors | grep "PPT" | awk '{print $2}')
    GPU_FAN=$(sensors | grep "fan1" | tail -1 | awk '{print $2}')

    # Texto de la barra
    TEXT=" $GPU_LOAD% [$GPU_TEMP]"

    # Construimos el Tooltip con tus bordes (usamos \n para saltos de línea)
    # Importante: No uses comillas dobles dentro del texto o romperán el JSON
    TOOLTIP=" 󰍛  VRAM: $VRAM_USAGE%  [$GPU_MEM_TEMP]\r"
    TOOLTIP+=" ⚡ PWR: $GPU_WATTS\r"
    TOOLTIP+=" 🌀 FAN: $GPU_FAN RPM"
else
    TEXT="N/A"
    TOOLTIP="GPU no detectada"
fi

# Salida en JSON
echo "{\"text\": \"$TEXT\", \"tooltip\": \"$TOOLTIP\"}"
