#!/bin/bash

FILE=`fd -e pdf -u`
RESULTS=`pdfgrep exam $FILE | bemenu -l "30 up" -p "" --fn "BigBlueTermPlus Nerd Font 12px" --nb "#ffffff" --nf "#000000" --ab "#ffffff" --af "#000000" -W 0.5`
#
# if [[ ! -z $FILE ]] then
#   zathura "$FILE"
# fi
