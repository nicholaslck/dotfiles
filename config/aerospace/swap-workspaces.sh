#!/bin/bash

TARGET_WS=$1

if [ -z "$TARGET_WS" ]; then
  echo "Usage: $0 <target_workspace>"
  exit 1
fi

# 1. Get the current workspace
CURRENT_WS=$(aerospace list-workspaces --focused)

if [ "$CURRENT_WS" == "$TARGET_WS" ]; then
  echo "Cannot swap with self."
  exit 0
fi

# 2. get all windows from current workspace and target workspace
LIST_CURRENT=$(aerospace list-windows --workspace "$CURRENT_WS" --format "%{window-id}")
LIST_TARGET=$(aerospace list-windows --workspace "$TARGET_WS" --format "%{window-id}")

# 3. exchange window
# move all target windows to current
for wid in $LIST_TARGET; do
  aerospace move-node-to-workspace --window-id "$wid" "$CURRENT_WS"
done

# move all current windows to target
for wid in $LIST_CURRENT; do
  aerospace move-node-to-workspace --window-id "$wid" "$TARGET_WS"
done
