#!/bin/bash

LISTA="lista.txt"

# Comprobamos que el fichero existe
if [[ ! -f "$LISTA" ]]; then
    echo "El fichero $LISTA no existe."
    exit 1
fi

cp "$LISTA" "$LISTA"_backup
echo "------¡COMENZAMOS!------"

while true; do
    # Contar cuántas líneas quedan
    TOTAL=$(wc -l < "$LISTA")

    if [[ "$TOTAL" -eq 0 ]]; then
	echo -e "\e[31mYa no hay nada más en el bombo!\e[0m"
        exit 0
    fi

    echo -e -n "\e[33mPulsa ENTER para sacar una papeleta...\e[0m"
    read  # espera a ENTER

    # Elegir una línea aleatoria
    NUM=$(( RANDOM % TOTAL + 1 ))
    PAPELETA=$(sed -n "${NUM}p" "$LISTA")

    echo -e "\e[38;5;208mHa salido:\e[0m \e[34m$PAPELETA\e[0m"

    # Eliminar la línea del fichero
    sed -i "${NUM}d" "$LISTA"
done

