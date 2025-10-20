#!/bin/bash



if [ -z $1 -o -z $2 ]; then
    echo "Se necesitan únicamente dos parámetros para ejecutar este script"
elif [ $3 ]; then
    echo "Se necesitan únicamente dos parámetros para ejecutar este script"
else
    curl -s $1 > pagina.txt

    if [ -z "$(cat pagina.txt | grep -nm 1 $2)" ]; then
        echo "No se ha encontrado la palabra \"$2\""
    else
        num=$(cat pagina.txt | grep -c $2)
        echo $num
        if [ $num -eq 1 ]; then
            echo "La palabra \"$2\" aparece 1 vez"
            echo "Aparece únicamente en la línea "$(cat pagina.txt | grep -nm 1 $2 | cut -d : -f 1)""
        else
            echo "La palabra \"$2\" aparece $num veces"
            echo "La palabra \"$2\" aparece por primera vez en la línea "$(cat pagina.txt | grep -nm 1 $2 | cut -d : -f 1)""
        fi
    fi
fi

