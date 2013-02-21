#!/bin/bash

script="proc.tpl"
data="data.tar.gz"
dest="Makefile.bin"

md5=`md5sum "$data" | awk '{printf $1}'`
line=`wc -l "$script" | awk '{printf $1}'`

sed -e "s/@MD5SUM@/$md5/g" -e "s/@LINENUM@/$line/g" "$script" > "$dest"
cat "$data" >> "$dest"
chmod +x "$dest"

