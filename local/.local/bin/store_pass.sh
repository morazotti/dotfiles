#!/bin/bash

passlist=`gpg -d $HOME/passwords.gpg | sed "s|[a-z]*://||g"`
echo $passlist  | grep -i 'nicolas'
