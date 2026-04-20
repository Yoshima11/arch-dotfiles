#!/bin/bash

case "$1" in
    up)
        docker start searxng-mcp 2>/dev/null || \
        docker run -d --name searxng-mcp --rm \
            -p 8080:8080 \
            -v ~/Programas/SearXNG-Websearch-MCP/searxng-config:/etc/searxng \
            searxng/searxng:latest
        echo "✅ SearXNG iniciado en http://localhost:8080"
        ;;
    down)
        docker stop searxng-mcp
        echo "✅ SearXNG detenido"
        ;;
    *)
        echo "Uso: $0 {up|down}"
        ;;
esac
