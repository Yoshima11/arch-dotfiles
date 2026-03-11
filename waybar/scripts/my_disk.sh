#!/bin/bash

# Función para obtener datos de una ruta específica
get_disk_usage() {
    df -h "$1" 2>/dev/null | awk 'NR==2 {print $5}'
}

# 1. Datos para la barra (Usaremos el principal /)
ROOT_USAGE=$(get_disk_usage "/")

# 2. Construcción del Tooltip detallado
# Definimos las rutas que queremos monitorear
PATHS=("/" "/mnt/sdb1" "/mnt/sdc2")

TOOLTIP=""
for p in "${PATHS[@]}"; do
    if [ -d "$p" ]; then
        # Extraemos: Uso%, Libre, Total
        INFO=$(df -h "$p" | awk 'NR==2 {print $5, $4, $2}')
        USAGE=$(echo $INFO | awk '{print $1}')
        FREE=$(echo $INFO | awk '{print $2}')
        TOTAL=$(echo $INFO | awk '{print $3}')

        # Formateamos la línea para que quede alineada (Nombre, %, Libre/Total)
        TOOLTIP+=$(printf " 📂 %-10s %4s  (%s/%s libre)\\r" "$p" "$USAGE" "$FREE" "$TOTAL")
    fi
done
TOOLTIP+=""

# Texto para la barra (puedes añadir más si quieres verlos todos ahí)
TEXT=" $ROOT_USAGE"

# Salida JSON
echo "{\"text\": \"$TEXT\", \"tooltip\": \"$TOOLTIP\"}"
