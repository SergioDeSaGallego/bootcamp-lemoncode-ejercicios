#!/bin/bash
dir1="foo/dummy" dir2="foo/empty"
cat $dir1/file1.txt > $dir1/file2.txt
cat /dev/null > $dir1/file1.txt
mv $dir1/file1.txt $dir2/