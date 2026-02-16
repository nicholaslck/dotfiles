#!/bin/bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh
if [ -z "$FOCUSED_WORKSPACE" ]; then
  FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
fi

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  BACKGROUND_DRAWING=on
else
  BACKGROUND_DRAWING=off
fi

# read all apps name in workspace
app_names=()
while IFS= read -r line; do
  app_names+=("$line")
done < <(aerospace list-windows --workspace $1 --format "%{app-name}")

# concat app_names with comma separator
printf -v label_app_names "%s/" "${app_names[@]}"
label_app_names="${label_app_names%/}"

sketchybar --set $NAME \
  background.drawing=$BACKGROUND_DRAWING \
  label="$1: $label_app_names"
