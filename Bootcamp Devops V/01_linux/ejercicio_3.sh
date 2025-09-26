#!/bin/bash

echo "Texto a escribir "
read newtext

dir1="foo/dummy" dir2="foo/empty"
mkdir -p $dir1 $dir2
touch $dir1/file1.txt $dir1/file2.txt
if [ "$newtext" != "" ]; then
    echo $newtext >> $dir1/file1.txt
else
    echo "Que me gusta la bash!!" >> $dir1/file1.txt
fi

cat $dir1/file1.txt > $dir1/file2.txt
cat /dev/null > $dir1/file1.txt && mv $dir1/file1.txt $dir2/
