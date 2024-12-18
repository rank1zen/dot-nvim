#!/bin/bash

FILE=`fd -e pdf -u | bemenu -l "30 up" -p "" --fn "BigBlueTermPlus Nerd Font 12px" --nb "#ffffff" --nf "#000000" --ab "#ffffff" --af "#000000" --ff '#ff0000' --fb '#ffffff' --fbf '#ff0000' --hf '#ff0000' --sf '#ff0000'`

if [[ ! -z $FILE ]] then
  zathura "$FILE"
fi

