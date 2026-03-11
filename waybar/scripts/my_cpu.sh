#!/bin/bash

# Forzamos punto decimal
IDLE=$(LC_ALL=C top -bn1 | grep "%Cpu(s)" | awk '{print $8}')
CPU_USAGE=$(echo "100 - $IDLE" | bc)

# Temperatura
CPU_TEMP=$(sensors | grep "Package id 0" | awk '{print $4}' | tr -d '+')

# Datos extra para el Tooltip (Carga media de 1, 5 y 15 min)
LOAD_AVG=$(cat /proc/loadavg | awk '{print $1", "$2", "$3}')
# Número de núcleos
CORES=$(nproc)

# Texto de la barra
TEXT=" $CPU_USAGE% [$CPU_TEMP]"

# Construcción del Tooltip
TOOLTIP="   NÚCLEOS:  $CORES\r"
TOOLTIP+=" 🌡️ TEMP:     $CPU_TEMP\r"
TOOLTIP+=" ⚖️ CARGA:    $LOAD_AVG"

# Salida JSON
echo "{\"text\": \"$TEXT\", \"tooltip\": \"$TOOLTIP\"}"
