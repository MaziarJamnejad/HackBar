#!/bin/bash
# XFCE GenMon renderer: shows tun0 IP + target IP + provider/box
# Left click: copy TARGET IP
# Middle click: copy tun0 IP

STATE_FILE="$HOME/.box_state"

# Live tun0 IP
TUN_IP="$(ip -4 -o addr show dev tun0 2>/dev/null | awk '{print $4}' | cut -d/ -f1 | head -n1)"
[ -z "$TUN_IP" ] && TUN_IP="no-vpn"

# Saved box state defaults
TARGET_IP="no-target"
CTF="CTF"
BOX="Box"

if [ -f "$STATE_FILE" ]; then
  # shellcheck disable=SC1090
  source "$STATE_FILE"
fi

[ -z "${TARGET_IP:-}" ] && TARGET_IP="no-target"
[ -z "${CTF:-}" ] && CTF="CTF"
[ -z "${BOX:-}" ] && BOX="Box"

LABEL="$CTF/$BOX"

# Clipboard commands (requires xclip)
COPY_TARGET="bash -lc 'printf %s \"$TARGET_IP\" | xclip -selection clipboard'"
COPY_TUN="bash -lc 'printf %s \"$TUN_IP\" | xclip -selection clipboard'"

# GenMon markup
echo "<txt>🖥 $TUN_IP  →  🎯 $TARGET_IP  ·  $LABEL</txt>"
echo "<tool>Left click copies target IP. Middle click copies tun0 IP.</tool>"
echo "<click>$COPY_TARGET</click>"
echo "<mclick>$COPY_TUN</mclick>"
