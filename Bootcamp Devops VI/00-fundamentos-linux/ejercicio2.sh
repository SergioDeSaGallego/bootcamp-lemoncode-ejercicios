#!/bin/bash
empty=foo/empty dummy=foo/dummy
cat $dummy/file1.txt > $dummy/file2.txt
mv $dummy/file2.txt $empty/file2.txt
