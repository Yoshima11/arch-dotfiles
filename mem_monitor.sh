#!/bin/bash

# Colores para mejor legibilidad
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # Sin color

while true; do
    clear
    echo -e "${BLUE}========================================================${NC}"
    echo -e "   MONITOR DE RECURSOS (Actualización: 5s) - $(date +%H:%M:%S)"
    echo -e "${BLUE}========================================================${NC}"

    # Uso de RAM del Sistema
    echo -e "${GREEN}[ RAM DEL SISTEMA ]${NC}"
    free -h

    echo ""

    # Uso de VRAM y GPU (AMD ROCm)
    echo -e "${GREEN}[ VRAM / GPU AMD ]${NC}"
    # Extraemos el uso de memoria y el porcentaje de carga
    rocm-smi --showmemuse --showuse | grep -E "GPU|Memory|use"

    echo -e "${BLUE}========================================================${NC}"
    echo "Presiona [CTRL+C] para salir"

    sleep 5
done
