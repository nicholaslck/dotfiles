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
  # change focused workspace
  for sid in "${WORKSPACES[@]}"; do
    if [ "$sid" = "$FOCUSED_WORKSPACE" ]; then
      icon_color=$COLOR_ROSEWATER
      label_color=$COLOR_ROSEWATER
      icon=" $sid:"
    elif [ "$sid" = "$PREV_WORKSPACE" ]; then
      icon_color=$COLOR_TEXT
      label_color=$COLOR_TEXT
      icon="$sid:"
    else
      icon_color=$COLOR_OVERLAY_1
      label_color=$COLOR_OVERLAY_1
      icon="$sid:"
    fi
    args+=(
      --set "space.$sid"
      icon.color=$icon_color
      label.color=$label_color
      icon="$icon"
    )
  done

elif [ "$SENDER" = "space_windows_change" || "$SENDER" = "aerospace_windows_change" ]; then
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

else
  # initialization
  FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
  get_workspace_apps

  for sid in "${WORKSPACES[@]}"; do

    if [ "$sid" = "$FOCUSED_WORKSPACE" ]; then
      icon_color=$COLOR_ROSEWATER
      label_color=$COLOR_ROSEWATER
      icon=" $sid:"
    else
      icon_color=$COLOR_OVERLAY_1
      label_color=$COLOR_OVERLAY_1
      icon="$sid:"
    fi

    app_names="${workspace_apps[$sid]:-}"
    label="$app_names"

    args+=(
      --set "space.$sid"
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
