#!/bin/bash
# Prompts once, writes ~/.box_state for the panel script to read.

STATE_FILE="$HOME/.box_state"

read -rp "TargetIP [10.10.11.23]: " TARGET_IP
read -rp "CTF [HTB]: " CTF
read -rp "Box [Optimum]: " BOX

TARGET_IP="${TARGET_IP:-10.10.11.23}"
CTF="${CTF:-HTB}"
BOX="${BOX:-Optimum}"

cat > "$STATE_FILE" <<EOF
TARGET_IP="$TARGET_IP"
CTF="$CTF"
BOX="$BOX"
EOF

echo "Saved $STATE_FILE:"
cat "$STATE_FILE"
