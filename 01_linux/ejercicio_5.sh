#!/bin/bash

if [ -z "$1" ] && [ -z "$2"]; then
    echo Se necesitan únicamente dos parámetros para ejecutar este script
else
    curl -s $1 > pagina.txt
    if [ -z "$(cat "pagina.txt" | grep -nm 1 "$2" | cut -c1-1)" ]; then
        echo "No se ha encontrado la palabra" '"'$2'"'
    else
        echo "La palabra "'"'$2'"'" aparece "$(cat pagina.txt | grep -c $2)" veces"
        if [ "$(cat pagina.txt | grep -c $2)" == 1 ];then
            echo "La palabra aparece únicamente en la línea "$(cat pagina.txt | grep -nm 1 $2 | cut -c1-1)""
        else
            echo "La palabra aparece por primera vez en la línea "$(cat pagina.txt | grep -nm 1 $2 | cut -c1-1)""
        fi
    fi
fi