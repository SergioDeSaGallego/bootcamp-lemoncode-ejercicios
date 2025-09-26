#!/bin/bash

URL="https://wiki.archlinux.org/title/Main_page"

if [ -z "$1" ]; then
    echo "No puedes invocar este script sin un argumento!"
else
    curl -s $URL > pagina.txt
    if [ -z "$(cat "pagina.txt" | grep -nm 1 "$1" | cut -c1-1)" ]; then
        echo "No se ha encontrado la palabra" '"'$1'"'
    else
        echo "La palabra "'"'$1'"'" aparece "$(cat pagina.txt | grep -c $1)" veces"
        echo "la palabra aparece por primera vez en la línea "$(cat pagina.txt | grep -nm 1 $1 | cut -c1-1)""
    fi
fi