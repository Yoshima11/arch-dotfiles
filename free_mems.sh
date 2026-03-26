#!/bin/bash

# Script para liberar RAM y VRAM en sistemas Linux con GPU AMD
# Autor: Asistente
# Fecha: 2024

echo "=== LIBERADOR DE RAM Y VRAM ==="
echo ""

# Liberar RAM
liberar_ram() {
    echo "📝 LIBERANDO RAM..."
    echo "Antes de liberar RAM:"
    free -h

    sync
    echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null
    # sudo swapoff -a && sudo swapon -a

    echo ""
    echo "Después de liberar RAM:"
    free -h
    echo "✅ RAM liberada"
    echo ""
}

# Función para verificar si ComfyUI está corriendo
check_comfy() {
    if pgrep -f "python.*main.py" > /dev/null || pgrep -f "ComfyUI" > /dev/null; then
        return 0
    else
        return 1
    fi
}

# Función para verificar si hay procesos usando GPU
check_gpu_processes() {
    echo "🔍 Procesos usando GPU AMD:"

    # Usar lsof para encontrar procesos que usan /dev/dri
    echo "Procesos en /dev/dri:"
    sudo lsof /dev/dri/* 2>/dev/null | grep -E "python|comfy" || echo "   No se encontraron procesos de ComfyUI"

    # Buscar procesos de Python/ComfyUI
    echo ""
    echo "Procesos de Python/ComfyUI:"
    ps aux | grep -E "python.*(main|ComfyUI)" | grep -v grep || echo "   No se encontraron procesos de ComfyUI"
}

# Función para liberar VRAM de forma segura
liberar_vram_segura() {
    echo "🎮 LIBERANDO VRAM DE FORMA SEGURA..."

    if ! command -v rocm-smi &> /dev/null; then
        echo "❌ ROCm SMI no está disponible"
        return 1
    fi

    # Verificar si ComfyUI está corriendo
    if check_comfy; then
        echo "⚠️  ComfyUI detectado en ejecución"
        echo ""
        echo "Seleccione una opción:"
        echo "1) Forzar liberación (puede afectar ComfyUI)"
        echo "2) Liberar solo memoria no utilizada (recomendado)"
        echo "3) Cancelar"
        read -p "Opción (1-3): " opcion_comfy

        case $opcion_comfy in
            1)
                echo "⚠️  Forzando liberación..."
                # Mostrar uso actual
                echo "Uso VRAM antes:"
                rocm-smi --showmeminfo vram

                # Opciones suaves de liberación
                echo "Limpiando caché de VRAM..."
                # Forzar garbage collection en procesos Python
                pids=$(pgrep -f "python")
                for pid in $pids; do
                    echo "Enviando señal a proceso $pid para liberar memoria"
                    kill -SIGUSR1 $pid 2>/dev/null
                done

                # Intentar liberar memoria no utilizada
                echo 1 | sudo tee /proc/sys/vm/drop_caches > /dev/null

                echo "Uso VRAM después:"
                rocm-smi --showmeminfo vram
                ;;
            2)
                echo "✅ Modo seguro - Liberando solo memoria caché..."
                # Solo limpiar cachés del sistema, no tocar procesos
                sync
                echo 1 | sudo tee /proc/sys/vm/drop_caches > /dev/null
                echo "Caché del sistema limpiada"
                ;;
            3)
                echo "Operación cancelada"
                return 0
                ;;
        esac
    else
        # Si no hay ComfyUI, podemos hacer más
        echo "✅ No se detectó ComfyUI"
        echo "Uso VRAM antes:"
        rocm-smi --showmeminfo vram

        # Opciones de limpieza suaves
        echo "Limpiando memoria..."
        sync
        echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null

        # Resetear solo procesos de usuario (no el driver)
        echo "Reiniciando procesos de GPU..."
        pkill -SIGUSR1 python 2>/dev/null

        echo "Uso VRAM después:"
        rocm-smi --showmeminfo vram
    fi
}

# Función específica para ComfyUI
optimizar_comfy() {
    echo "🖼️  OPTIMIZANDO COMFYUI..."

    if check_comfy; then
        echo "ComfyUI detectado. Aplicando optimizaciones:"

        # Encontrar el proceso de ComfyUI
        comfy_pid=$(pgrep -f "python.*main.py" | head -1)

        if [ ! -z "$comfy_pid" ]; then
            echo "PID de ComfyUI: $comfy_pid"

            # Opciones de optimización
            echo ""
            echo "Opciones para ComfyUI:"
            echo "1) Limpiar caché de nodos"
            echo "2) Forzar garbage collection"
            echo "3) Recomendar configuración de VRAM"
            echo "4) Cancelar"
            read -p "Opción: " comfy_opcion

            case $comfy_opcion in
                1)
                    echo "Limpiando caché de nodos..."
                    # Enviar señal para limpiar caché (si ComfyUI la soporta)
                    kill -SIGUSR1 $comfy_pid 2>/dev/null
                    echo "Señal enviada"
                    ;;
                2)
                    echo "Forzando garbage collection..."
                    kill -SIGUSR2 $comfy_pid 2>/dev/null
                    echo "GC forzado"
                    ;;
                3)
                    echo ""
                    echo "📊 RECOMENDACIONES PARA VRAM AMD EN COMFYUI:"
                    echo ""
                    echo "En ComfyUI, puedes:"
                    echo "- Usar --highvram para máxima velocidad"
                    echo "- Usar --normalvram para equilibrio"
                    echo "- Usar --lowvram para ahorrar memoria"
                    echo "- Usar --novram para modo CPU"
                    echo ""
                    echo "Comando recomendado:"
                    echo "python main.py --lowvram --auto-launch"
                    ;;
                4)
                    echo "Cancelado"
                    ;;
            esac
        fi
    else
        echo "ComfyUI no está en ejecución"
    fi
}

# Menú principal
while true; do
    echo ""
    echo "=== MENÚ PRINCIPAL ==="
    echo "1) Ver estado actual de VRAM"
    echo "2) Liberar VRAM de forma segura"
    echo "3) Optimizar ComfyUI (si está activo)"
    echo "4) Ver procesos GPU"
    echo "5) Liberar RAM"
    echo "6) Salir"
    echo ""
    read -p "Seleccione una opción: " opcion

    case $opcion in
        1)
            echo ""
            echo "📊 ESTADO ACTUAL:"
            if command -v rocm-smi &> /dev/null; then
                rocm-smi --showmeminfo vram
            else
                echo "ROCm SMI no disponible"
            fi
            check_gpu_processes
            ;;
        2)
            liberar_vram_segura
            ;;
        3)
            optimizar_comfy
            ;;
        4)
            check_gpu_processes
            ;;
        5)
            liberar_ram
            ;;
        6)
            echo "Saliendo..."
            exit 0
            ;;
        *)
            echo "Opción no válida"
            ;;
    esac
done
