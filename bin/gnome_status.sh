#!/usr/bin/env bash
set -euo pipefail

STATE_FILE="$HOME/.box_state"

# tun0 ip
TUN_IP="$(ip -4 -o addr show dev tun0 2>/dev/null | awk '{print $4}' | cut -d/ -f1 | head -n1)"
[[ -z "${TUN_IP:-}" ]] && TUN_IP="no-vpn"

# defaults
TARGET_IP="no-target"
CTF="CTF"
BOX="Box"
if [[ -f "$STATE_FILE" ]]; then
  # shellcheck disable=SC1090
  source "$STATE_FILE"
fi
TARGET_IP="${TARGET_IP:-no-target}"
CTF="${CTF:-CTF}"
BOX="${BOX:-Box}"

echo "${TUN_IP}/${TARGET_IP} ${CTF}/${BOX}"
