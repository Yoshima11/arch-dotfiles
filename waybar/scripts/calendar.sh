#!/bin/bash
zenity --calendar \
  --title="Calendario" \
  --text="Selecciona una fecha:" \
  --width=320 \
  --height=320 \
  --date-format="%d/%m/%Y" \
  --day=$(date +%d) \
  --month=$(date +%m) \
  --year=$(date +%Y) \
  --ok-label="Aceptar" \
  --cancel-label="Cerrar"
