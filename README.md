HackBar — Minimal Box Context HUD (XFCE & GNOME)

HackBar is a small, boring, exam-safe operator HUD for CTF labs.

It keeps your current box context visible at all times so you don’t lose track of:

🔒 VPN IP (tun0, auto-updating)

🎯 Target IP

🏷️ CTF / box name (HTB / PG / THM / etc.)

No dashboards. No daemons. No cleverness.
Just a reminder of where you are.

Supported environments

HackBar supports two display backends, with the same underlying state:

XFCE (Kali Linux)

Uses XFCE panel + GenMon

Supports click-to-copy

Supports richer layout (icons, spacing)

GNOME (Zorin / Ubuntu)

Uses Executor GNOME extension

Single-line status bar output (GNOME limitation)

Copy actions via keyboard shortcuts

Both read from the same local state file: ~/.box_state.

Repository layout
HackBar/
├── bin/
│   ├── box_panel.sh      # XFCE GenMon renderer
│   ├── box_set.sh        # Prompt once per box
│   └── gnome_status.sh   # GNOME / Executor status output
├── config/               # XFCE panel export helpers (reference only)
├── docs/
│   └── BarImage.png
├── README.md
└── LICENSE


You do not need everything here to use HackBar.

Common setup (all environments)

Make the scripts available:

mkdir -p ~/bin
cp bin/*.sh ~/bin/
chmod +x ~/bin/*.sh


Start a box (one-time per target):

~/bin/box_set.sh


This writes:

~/.box_state


All display methods update automatically.

XFCE setup (Kali)
Requirements
sudo apt install -y xfce4-genmon-plugin xclip

Add to panel

Panel → Add New Items → Generic Monitor

Command:

~/bin/box_panel.sh


Period: 2 seconds

Interaction

Left-click → copy target IP

Middle-click → copy VPN IP

GNOME setup (Zorin / Ubuntu)
Requirements
sudo apt install -y wl-clipboard xclip

Install Executor

https://extensions.gnome.org/extension/2932/executor/

Configure Executor

Command:

~/bin/gnome_status.sh


Interval: 2 seconds

Position: Left (recommended)

GNOME status bars are single-line only.
HackBar prints a compact one-line string by design.

Copy actions (recommended)

Bind keyboard shortcuts to:

~/bin/box_set.sh
hackbar copy target
hackbar copy vpn

Notes on panel configuration

XFCE panel configs are machine-specific

This repo does not ship importable panel configs

config/ scripts are reference-only

This is intentional.

Git hygiene

Ignored by design:

~/.box_state

Exported panel config files

No lab details should ever hit git.

Design philosophy

One widget, one job

No background services

No fragile imports

Exam-safe

Boring by design

If it ever feels clever, it’s probably wrong.

License

MIT.
