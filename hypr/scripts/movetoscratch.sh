#!/bin/bash

log_message() {
  # echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> ~/moveto_log.txt
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

target_workspace="\"special:scratch\""
current_workspace=$(hyprctl activewindow -j | jq '.workspace.name')

if [ -z "$current_workspace" ]; then
  log_message "Error: Couldn't determine current workspace"
  exit 1
fi

log_message "Moving from workspace $current_workspace to $target_workspace"

if [ "$current_workspace" = "\"main\"" ]; then
  address=$(hyprctl activewindow -j | jq '.address')
  log_message "Moving window $address to workspace $target_workspace"
  hyprctl dispatch movetoworkspacesilent "$target_workspace,address:$address"
  hyprctl dispatch setfloating "address:$address"
fi
