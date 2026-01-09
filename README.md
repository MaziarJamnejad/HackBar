# HackBar — Kali XFCE Box HUD

A minimal operator HUD for Kali Linux (XFCE) that pins your active lab context
directly to the panel.

Shows:
- Live VPN IP (`tun0`)
- Target IP
- Provider + box name (HTB / PG / THM / etc.)

Includes:
- Click-to-copy target IP (left click)
- Click-to-copy VPN IP (middle click)

---

## Requirements

- Kali Linux (XFCE)
- `xfce4-genmon-plugin`
- `xclip`

Install clipboard support:
```bash
sudo apt update
sudo apt install -y xclip
