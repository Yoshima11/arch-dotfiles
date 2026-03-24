#!/bin/bash

# Extraemos datos de RAM (Mem) y Swap del comando 'free'
# RAM
read -r R_TOTAL R_USED R_FREE R_BUFF < <(free -m | awk '/Mem:/ {print $2, $3, $4, $6}')
# SWAP
read -r S_TOTAL S_USED S_FREE < <(free -m | awk '/Inter:/ {print $2, $3, $4}')

# Calcular porcentaje de uso de RAM
RAM_PERC=$(echo "scale=2; ($R_USED / $R_TOTAL) * 100" | bc | awk '{printf "%d", $1}')

# Texto que se verá en la barra (RAM %)
TEXT=" $RAM_PERC%"

# Construcción del Tooltip con bordes y Swap
TOOLTIP=" 🧠 RAM TOTAL: ${R_TOTAL} MiB\r"
TOOLTIP+=" 📈 USADO:     ${R_USED} MiB\r"
TOOLTIP+=" 📦 CACHÉ:     ${R_BUFF} MiB\r"
TOOLTIP+=" 📉 LIBRE:     ${R_FREE} MiB\r"
TOOLTIP+=" -------------------- \r"
TOOLTIP+=" 🔄 SWAP TOTAL: ${S_TOTAL} MiB\r"
TOOLTIP+=" ⚠️ USADO:     ${S_USED} MiB\r"
TOOLTIP+=" ✅ LIBRE:     ${S_FREE} MiB"

# Salida JSON para Waybar
echo "{\"text\": \"$TEXT\", \"tooltip\": \"$TOOLTIP\"}"
