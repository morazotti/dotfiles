#!/bin/bash
dirs=("$HOME/Downloads/srcs/dwm/" "$HOME/Downloads/srcs/st-0.8.2/")

for item in ${dirs[*]}; do
    cd $item
    echo config.h | sudo entr -p make install &
done
