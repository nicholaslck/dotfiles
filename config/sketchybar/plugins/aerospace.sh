#!/bin/bash

source $CONFIG_DIR/constants.sh

WORKSPACES=("1" "2" "3" "4" "5" "6" "7" "8" "9")

if [ -z "$FOCUSED_WORKSPACE" ]; then
  FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
fi

##### Get all active workspaces #####
# active_workspaces=$(aerospace list-workspaces --all)

##### Get all app names #####
workspace_apps=()
while IFS='-' read -r workspace app; do
  if [[ -n "${workspace_apps[$workspace]}" ]]; then
    workspace_apps[$workspace]+=" / $app"
  else
    workspace_apps[$workspace]="$app"
  fi
done < <(aerospace list-windows --all --format "%{workspace}-%{app-name}")

##### Re-draw each items #####
args=()
for sid in "${WORKSPACES[@]}"; do

  app_names=${workspace_apps[$sid]}
  background_color=$COLOR_BACKGROUND_ACTIVE

  background_drawing=off
  icon_color=$COLOR_FOREGROUND_SECONDARY
  label_color=$COLOR_FOREGROUND_SECONDARY

  icon="$sid:"
  label="$app_names"

  if [ "$sid" = "$FOCUSED_WORKSPACE" ]; then
    background_drawing=on
    icon_color=$COLOR_FOREGROUND_PRIMARY
    label_color=$COLOR_FOREGROUND_PRIMARY
  elif [ "$sid" = "$PREV_WORKSPACE" ]; then
    icon_color=$COLOR_FOREGROUND_PRIMARY
    label_color=$COLOR_FOREGROUND_PRIMARY
  fi

  args+=(
    --set "space.$sid"
    background.color=$background_color
    background.drawing=$background_drawing
    icon.color=$icon_color
    label.color=$label_color
    icon="$icon"
    label="$label"
  )
done

sketchybar "${args[@]}"
