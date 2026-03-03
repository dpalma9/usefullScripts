#!/bin/bash

# Comprobación de parámetros
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <fichero_origen> <directorio_destino>"
    exit 1
fi

FICHERO="$1"
DIRECTORIO="$2"

# Comprobar que el fichero existe
if [ ! -f "$FICHERO" ]; then
    echo "Error: El fichero '$FICHERO' no existe."
    exit 1
fi

# Comprobar que el directorio existe
if [ ! -d "$DIRECTORIO" ]; then
    echo "Error: El directorio '$DIRECTORIO' no existe."
    exit 1
fi

# Recorrer solo las subcarpetas directas
for carpeta in "$DIRECTORIO"*/; do
    if [ -d "$carpeta" ]; then
        cp "$FICHERO" "$carpeta"
        echo "Copiado en: $carpeta"
    fi
done

echo "Proceso completado."

