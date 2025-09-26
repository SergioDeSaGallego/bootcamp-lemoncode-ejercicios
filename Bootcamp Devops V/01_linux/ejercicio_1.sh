#!/bin/bash
mkdir -p foo/dummy foo/empty && dirpath="foo/dummy"
touch $dirpath/file1.txt $dirpath/file2.txt && echo \
    "Me encanta la bash!!" >> $dirpath/file1.txt