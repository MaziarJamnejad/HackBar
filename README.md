cat > README.md <<'EOF'
# HackBar — Kali XFCE Box HUD

HackBar is a small, boring, exam-safe “operator HUD” for **Kali Linux (XFCE)**.

It pins your active lab context directly to the XFCE panel so you can always see:

- Your **VPN IP** (`tun0`, auto-updating)
- The **target IP**
- The **CTF provider and box name** (HTB / PG / THM / etc.)

This avoids constant context-switching, copy/paste errors, and “wait, what box am I on?” moments.

---

## What this repo contains

HackBar/
├── bin/
│ ├── box_panel.sh # Panel widget renderer (GenMon)
│ └── box_set.sh # One-time prompt script per box
├── config/
│ ├── export-panel-config.sh # Reference-only panel config export
│ ├── genmon-command.txt # Exact GenMon command to use
│ └── xfce4-panel.xml.snipper.example
├── README.md
├── LICENSE
└── .gitignore

yaml
Copy code

You **do not** need to understand all of this to use HackBar.  
Follow the steps below in order.

---

## Requirements

- Kali Linux with **XFCE**
- XFCE panel
- `xfce4-genmon-plugin`
- `xclip` (for click-to-copy)

Install clipboard support:

sudo apt update
sudo apt install -y xclip
Step 1 — Install the scripts

From your home directory:

mkdir -p ~/bin
Copy the scripts from this repo into ~/bin:

cp bin/box_panel.sh ~/bin/
cp bin/box_set.sh ~/bin/
chmod +x ~/bin/box_panel.sh ~/bin/box_set.sh

Why:
~/bin is a standard place for personal scripts

Marking them executable is required for XFCE to run them

Step 2 — Add the widget to the XFCE panel

Right-click the XFCE panel
Select Panel → Add New Items
Add Generic Monitor
Right-click the new item → Properties

Set:
~/bin/box_panel.sh

Period
2 (seconds; 5 is also fine if you prefer fewer refreshes)

Close the dialog and drag the widget where you want it on the panel.

At this point you’ll see something like:
🔒 no-vpn → 🎯 no-target · CTF/Box
That’s expected.

Step 3 — Start a box (one-time per target)

When you start working on a new box, run:
~/bin/box_set.sh

You’ll be prompted for:
TargetIP [10.10.11.23]:
CTF [HTB]:
Box [Optimum]:

Enter your values (or press Enter to accept defaults).

This writes a small local file:
~/.box_state
The panel widget reads this file automatically and updates immediately.

You do not need to restart XFCE or the panel.

How interaction works

Left-click the widget → copies the target IP
Middle-click the widget → copies the VPN IP
VPN IP updates automatically when tun0 changes

Target/box info stays fixed until you run box_set.sh again

About panel configuration files (important)

XFCE panel configs are machine-specific.

They live in:
~/.config/xfce4/
Because plugin IDs differ per system, this repo does NOT provide an “import this config” button.

Instead, this repo includes tools for reference and debugging only.

Export your panel config (optional)
If you want to inspect or share how your panel is configured:

config/export-panel-config.sh

This exports:
xfce4-panel.xml
plugin instance data
an xfconf-query dump

⚠️ These files are not portable.
Do not copy them blindly to another system.

Troubleshooting
Widget shows no-vpn
You are not connected to a VPN
or your interface is not named tun0

Widget doesn’t update
Ensure ~/bin/box_panel.sh is executable

Ensure GenMon command path is correct

Try increasing refresh period to 5 seconds

Click-to-copy doesn’t work
Ensure xclip is installed

Try copying from a terminal:
echo test | xclip -selection clipboard

License
MIT — use it, fork it, adapt it, break it, fix it.

Final note
This is intentionally simple.
If you find yourself wanting to add:
more state
more automation
more cleverness
…pause first.
The goal is less thinking, not more tooling.
