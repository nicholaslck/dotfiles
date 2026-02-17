#!/bin/bash

source $CONFIG_DIR/constants.sh

workspace_apps=()

get_workspace_apps() {
  while IFS='-' read -r window_id workspace app; do
    if [[ -n "${workspace_apps[$workspace]}" ]]; then
      workspace_apps[$workspace]+="/$app"
    else
      workspace_apps[$workspace]="$app"
    fi
  done < <(aerospace list-windows --all --format "%{window-id}-%{workspace}-%{app-name}" | sort -t'-' -k1,1n)
}

args=()
if [ "$SENDER" = "aerospace_workspace_change" ]; then
  for sid in "${WORKSPACES[@]}"; do
    if [ "$sid" = "$FOCUSED_WORKSPACE" ]; then
      background_drawing=on
      icon_color=$COLOR_FOREGROUND_PRIMARY
      label_color=$COLOR_FOREGROUND_PRIMARY
    elif [ "$sid" = "$PREV_WORKSPACE" ]; then
      background_drawing=off
      icon_color=$COLOR_FOREGROUND_PRIMARY
      label_color=$COLOR_FOREGROUND_PRIMARY
    else
      background_drawing=off
      icon_color=$COLOR_FOREGROUND_SECONDARY
      label_color=$COLOR_FOREGROUND_SECONDARY
    fi
    args+=(
      --set "space.$sid"
      background.drawing=$background_drawing
      icon.color=$icon_color
      label.color=$label_color
    )
  done
  sketchybar "${args[@]}"

elif [ "$SENDER" = "space_windows_change" ]; then
  # new window added or deleted
  get_workspace_apps

  for sid in "${WORKSPACES[@]}"; do
    app_names="${workspace_apps[$sid]:-}"
    label="$app_names"
    args+=(
      --set "space.$sid"
      label="$label"
    )
  done
  sketchybar "${args[@]}"
else
  # initialization
  FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
  get_workspace_apps

  for sid in "${WORKSPACES[@]}"; do

    app_names="${workspace_apps[$sid]:-}"
    icon="$sid:"
    label="$app_names"

    background_color=$COLOR_BACKGROUND_ACTIVE
    background_drawing=off
    icon_color=$COLOR_FOREGROUND_SECONDARY
    label_color=$COLOR_FOREGROUND_SECONDARY

    if [ "$sid" = "$FOCUSED_WORKSPACE" ]; then
      background_drawing=on
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
fi

if [ ${#args[@]} -gt 0 ]; then
  sketchybar "${args[@]}"
fi
