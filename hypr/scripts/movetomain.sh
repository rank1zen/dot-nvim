#!/bin/bash

current_workspace=$(hyprctl activewindow -j | jq '.workspace.name')
if [ "$current_workspace" = "special:scratch" ]; then
  address=$(hyprctl activewindow -j | jq '.address')
  hyprctl dispatch movetoworkspacesilent "main,address:$address"
  hyprctl dispatch settiled "address:$address"
fi
