#!/bin/bash

device=`lsblk -ln | awk '{print $1}' | dmenu -l 5 -i -p "Which device do you wish to mount?"`
place=`find / -maxdepth 2 | dmenu -l 5 -i -p "Where do you want to mount it?"`
[[ "$place" == "/home/nicolas/" ]] && exit
[[ ! -d $place ]] && mkdir $place
sudo mount $device $place

