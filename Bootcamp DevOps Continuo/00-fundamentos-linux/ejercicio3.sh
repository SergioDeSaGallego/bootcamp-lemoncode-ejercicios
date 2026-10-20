#!/bin/bash

empty=foo/empty dummy=foo/dummy
mkdir -p $empty $dummy && touch $dummy/{file1.txt,file2.txt}

if [ $1 ]; then
    echo $1 >> $dummy/file1.txt
else
    echo "Que me gusta la bash!!!" > $dummy/file1.txt
fi

cat $dummy/file1.txt > $dummy/file2.txt
mv $dummy/file2.txt $empty/file2.txt