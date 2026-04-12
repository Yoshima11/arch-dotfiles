#!/bin/bash

# Colores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

export GREEN BLUE NC  # Exportar para que watch las vea

watch -c -n3 '
  # --- SECCIÓN RAM ---
  echo -e "'"${BLUE}"'--- MEMORIA DEL SISTEMA ---'"${NC}"'"
  printf "%-20s %-6s %-5s\n" "NAME" "SIZE" "USED"
  free -h | awk '\''/^Mem:/ {printf "%-20s %-6s %-5s\n", "mem", $2, $3}'\''
  echo ""
  swapon --show=NAME,SIZE,USED,PRIO
  echo -e "\n'"${GREEN}"'--- ESTADO DE LA GPU (AMD) ---'"${NC}"'"
  printf "%-10s %-12s %-15s %-10s\n" "GPU" "Uso GPU" "VRAM %" "Temp"

  # Extracción de datos
  GPU_USE=$(rocm-smi --showuse 2>/dev/null | grep -oP '"'"'GPU use \(%\): \K\d+'"'"' | head -n 1)
  VRAM_USE=$(rocm-smi --showmemuse 2>/dev/null | grep -oP '"'"'VRAM%\): \K\d+'"'"' | head -n 1)
  TEMP_RAW=$(rocm-smi --showtemp 2>/dev/null | grep -oP '"'"'Temperature \(Sensor edge\) \(C\): \K[\d.]+'"'"' | head -n 1)

  # Valores por defecto
  VAL_USE=${GPU_USE:-0}
  VAL_VRAM=${VRAM_USE:-0}
  VAL_TEMP=${TEMP_RAW:-0.0}

  # Imprimir fila
  printf "%-10s %-12s %-15s %-10s\n" "Card 0" "$VAL_USE%" "$VAL_VRAM%" "$VAL_TEMP°C"
'
