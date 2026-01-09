# HackBar — Kali XFCE Box HUD

HackBar is a small, boring, exam-safe **operator HUD** for **Kali Linux (XFCE)**.

It pins your active lab context directly to the XFCE panel so you can always see, at a glance:

- 🔒 Your **VPN IP** (`tun0`, auto-updating)
- 🎯 The **target IP**
- 🏷️ The **CTF provider and box name** (HTB / PG / THM / etc.)

This avoids constant context-switching, copy/paste errors, and  
*“wait — what box am I on?”* moments.

---

## What it looks like

![HackBar XFCE panel example](docs/BarImage.png)

The layout shown includes:
- HackBar GenMon widget (VPN → target · provider/box)
- Date and time as **two side-by-side clock widgets**
- Monospace fonts and clean spacing

---

## What this repo contains

    HackBar/
    ├── bin/
    │   ├── box_panel.sh        # XFCE GenMon widget renderer
    │   └── box_set.sh          # One-time prompt per box
    ├── config/
    │   ├── export-panel-config.sh      # Reference-only panel config export
    │   ├── genmon-command.txt          # Exact GenMon command
    │   └── xfce4-panel.xml.snipper.example
    ├── README.md
    ├── LICENSE
    └── .gitignore

You do **not** need to understand all of this to use HackBar.  
Just follow the steps below, in order.

---

## Requirements

- Kali Linux with **XFCE**
- XFCE panel
- `xfce4-genmon-plugin` (Generic Monitor / GenMon)
- `xclip` (for click-to-copy)

Install required packages:

    sudo apt update
    sudo apt install -y xfce4-genmon-plugin xclip

---

## Step 1 — Install the scripts

From your home directory:

    mkdir -p ~/bin

Copy the scripts from this repo into `~/bin`:

    cp bin/box_panel.sh ~/bin/
    cp bin/box_set.sh ~/bin/
    chmod +x ~/bin/box_panel.sh ~/bin/box_set.sh

Why this matters:
- `~/bin` is a standard place for personal scripts
- Scripts must be executable for XFCE to run them

---

## Step 2 — Add HackBar to the XFCE panel

1. Right-click the XFCE panel  
2. Select **Panel → Add New Items**  
3. Add **Generic Monitor**  
4. Right-click the new item → **Properties**

Set:

- **Command**  
      ~/bin/box_panel.sh

- **Period**  
      2  
  (seconds; `5` is also fine if you prefer fewer refreshes)

Close the dialog and drag the widget where you want it on the panel.

At this point you’ll see something like:

    🔒 no-vpn → 🎯 no-target · CTF/Box

That’s expected.

---

## Step 3 — Start a box (one-time per target)

When you begin working on a new box, run:

    ~/bin/box_set.sh

You’ll be prompted for:

    TargetIP [10.10.11.23]:
    CTF [HTB]:
    Box [Optimum]:

Enter your values (or press Enter to accept defaults).

This writes a small local file:

    ~/.box_state

The panel widget reads this file automatically and updates immediately.  
You do **not** need to restart XFCE or the panel.

---

## How interaction works

- **Left-click** the widget → copies the **target IP**
- **Middle-click** the widget → copies the **VPN IP**
- VPN IP updates automatically when `tun0` changes
- Target / box info stays fixed until you run `box_set.sh` again

---

## Replicating the full panel layout (recommended)

XFCE panel configs are **machine-specific** (plugin IDs differ per system), so there is no reliable “import this config” file.

Instead, HackBar supports a **prompt-driven replication workflow** using ChatGPT.

### Workflow

1. Export your panel configuration:

       config/export-panel-config.sh

2. Open ChatGPT
3. Paste the contents of `PROMPT.md`
4. Upload:
   - `panel-export/xfce4-panel.xml`
   - `panel-export/xfconf-xfce4-panel.txt`
   - (Optional) a screenshot of your current or desired panel

ChatGPT should generate **machine-specific, step-by-step instructions** to:
- Recreate the HackBar GenMon widget
- Add **two side-by-side clock widgets** (date-only + time-only)
- Match ordering, spacing, and fonts

Before uploading, redact anything sensitive  
(usernames, internal hostnames, private IPs).

---

## About panel config files

XFCE panel configuration lives in:

    ~/.config/xfce4/

These files are:
- Not portable
- Machine-specific
- Often contain personal paths or hostnames

For this reason:
- This repo does **not** ship an importable panel config
- Exported configs are **reference-only**

This is intentional.

---

## Make the box command available everywhere (recommended)

HackBar keeps scripts inside the repository, but exposes the box setup command explicitly so it can be run from any directory.

This avoids aliases, avoids shell-specific tricks, and keeps repositories clean and auditable.

---

## 1) Choose a personal tools directory

Pick (or create) a directory that you use for personal, runnable tools.

This should be a directory you control and trust.

Common choices include:
~/tools
~/bin
~/.local/bin

In the steps below, this will be referred to as:
/absolute/path/to/your/tools

Replace this with the actual path you choose.

---

## 2) Add that directory to your PATH (zsh)

Kali uses zsh by default.

Edit your zsh configuration file:
'nano ~/.zshrc'

Add the following line near the bottom, replacing the path with your own:
export PATH="/absolute/path/to/your/tools:$PATH"

Reload zsh and refresh the command cache:
source ~/.zshrc
rehash

If you use bash instead of zsh, add the same line to ~/.bashrc and reload it.

---

## 3) Expose the HackBar command with a symlink

The HackBar setup script lives inside the repository at:
<path-where-you-cloned-HackBar>/bin/box_set.sh

PATH does not recurse into subdirectories, so the script must be exposed explicitly.

Create a symlink in your tools directory:
ln -s <path-where-you-cloned-HackBar>/bin/box_set.sh /absolute/path/to/your/tools/box-set

Example, if you cloned HackBar into ~/tools/HackBar:
ln -s ~/tools/HackBar/bin/box_set.sh ~/tools/box-set

---

## 4) Verify

Check that the command is visible:
command -v box-set

The output should point to your tools directory.

---

## 5) Use it from anywhere

You can now run the box setup command from any directory:

box-set

---

## Git hygiene

This repo intentionally ignores:

- `~/.box_state` (contains live IPs and box names)
- Exported panel configuration directories

This prevents accidental leakage of lab details.

---

## Design philosophy

- One widget = one job
- No background daemons
- No GNOME extensions
- No fragile panel imports
- Exam-safe
- Boring by design

If it ever feels clever, it’s probably wrong.

---

## License

MIT — use it, fork it, adapt it, improve it.

---

## Final note

HackBar exists to **reduce thinking**, not add tooling.

If you ever feel tempted to make it smarter,  
pause first — the simplicity *is* the feature.
