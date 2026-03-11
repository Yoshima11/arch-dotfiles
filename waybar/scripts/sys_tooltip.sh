#!/bin/bash

# --- Rutas de Hardware ---
GPU_PATH="/sys/class/drm/card1/device"

# --- Datos de CPU y MEM ---
# Calculamos el uso restando la inactividad (id) del 100
CPU_USAGE=$(top -bn1 | grep "%Cpu(s)" | awk '{print 100 - $8}' | tr ',' '.')
CPU_TEMP=$(sensors | grep "Package id 0" | awk '{print $4}' | tr -d '+')

# Extraemos RAM usada y total en MiB para calcular el %
RAM_TOTAL=$(free -m | grep Mem | awk '{print $2}')
RAM_USED=$(free -m | grep Mem | awk '{print $3}')
RAM_PERCENT=$(echo "scale=2; ($RAM_USED / $RAM_TOTAL) * 100" | bc | awk '{printf "%.1f", $1}')

# --- Datos de GPU y VRAM ---
if [ -d "$GPU_PATH" ]; then
    GPU_LOAD=$(cat "$GPU_PATH/gpu_busy_percent" 2>/dev/null || echo "0")

    # Obtener VRAM en bytes (Usada / Total)
    VRAM_USED=$(cat "$GPU_PATH/mem_info_vram_used" 2>/dev/null || echo "0")
    VRAM_TOTAL=$(cat "$GPU_PATH/mem_info_vram_total" 2>/dev/null || echo "1") # Evitar división por cero

    # Calcular porcentaje real de ocupación
    VRAM_USAGE=$(echo "scale=2; ($VRAM_USED / $VRAM_TOTAL) * 100" | bc | awk '{printf "%d", $1}')

    # Temperaturas y Power (Aseguramos limpieza de caracteres)
    GPU_EDGE=$(sensors | grep "edge" | head -1 | awk '{print $2}' | tr -d '+')
    GPU_MEM_TEMP=$(sensors | grep -E "mem:|mem" | head -1 | awk '{print $2}' | tr -d '+')
    GPU_WATTS=$(sensors | grep "PPT" | awk '{print $2}')
    GPU_FAN=$(sensors | grep "fan1" | tail -1 | awk '{print $2}')
else
    GPU_LOAD="0"
    VRAM_USAGE="0"
    GPU_EDGE="N/A"
fi

# --- Salida Final ---
echo -e "━━━━━━━━━━━━━━━━━━━━━━"
echo -e "  🧠 DEEP MIND STATUS "
echo -e "━━━━━━━━━━━━━━━━━━━━━━"
echo -e "   CPU: $CPU_USAGE%  [$CPU_TEMP]"
echo -e "   RAM: $RAM_PERCENT%  ($RAM_USED MiB)"
echo -e " 󰢮  GPU: $GPU_LOAD%  [$GPU_EDGE]"
echo -e " 󰍛  VRAM: $VRAM_USAGE%  [$GPU_MEM_TEMP]"
echo -e " ⚡ PWR: $GPU_WATTS"
echo -e " 🌀 FAN: $GPU_FAN RPM"
echo -e "━━━━━━━━━━━━━━━━━━━━━━"
