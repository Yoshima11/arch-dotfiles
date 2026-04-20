#!/bin/bash
docker ps -a --filter "name=comfyui-rocm" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
