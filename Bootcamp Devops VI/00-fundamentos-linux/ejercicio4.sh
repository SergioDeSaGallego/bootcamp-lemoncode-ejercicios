#!/bin/bash



web=https://www.lipsum.com/feed/html
echo ${1?"Necesitas una palabra a buscar"}

curl -s $web > pagina.txt

if [ -z "$(cat pagina.txt | grep -nm 1 $1)" ]; then
    echo "No se ha encontrado la palabra \"$1\""
else
    echo "La palabra \"$1\" aparece "$(cat pagina.txt | grep -c $1)" veces"
    echo "La palabra \"$1\" aparece por primera vez en la línea "$(cat pagina.txt | grep -nm 1 $1 | cut -d : -f 1)""
fi

