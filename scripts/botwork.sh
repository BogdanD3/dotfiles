#!/bin/bash

# ─── Desktop 1: StealthBot ──────────────────────────────────────────────────

hyprctl dispatch workspace 1
sleep 0.5

SOCKET1="/tmp/kitty-botwork-ws1-$$"
kitty --listen-on "unix:$SOCKET1" &
sleep 1.2

# Tab 1: cd + venv + nvim
kitten @ --to "unix:$SOCKET1" send-text "cd ~/Cyber/StealthBot && source .venv/bin/activate\n"
sleep 0.3
kitten @ --to "unix:$SOCKET1" send-text "nvim .\n"
sleep 0.3

# Otvori Tab 2
kitten @ --to "unix:$SOCKET1" launch --type=tab --tab-title="StealthBot-shell"
sleep 0.5

# Tab 2: cd + venv, ostaje u shellu
kitten @ --to "unix:$SOCKET1" send-text "cd ~/Cyber/StealthBot && source .venv/bin/activate\n"

# ─── Desktop 2: SiteForStealth ──────────────────────────────────────────────

hyprctl dispatch workspace 2
sleep 0.5

SOCKET2="/tmp/kitty-botwork-ws2-$$"
kitty --listen-on "unix:$SOCKET2" &
sleep 1.2

# Tab 1: cd + nvim
kitten @ --to "unix:$SOCKET2" send-text "cd ~/Cyber/SiteForStealthTest && source .venv/bin/activate\n"
sleep 0.3
kitten @ --to "unix:$SOCKET2" send-text "nvim .\n"
sleep 0.3

# Otvori Tab 2
kitten @ --to "unix:$SOCKET2" launch --type=tab --tab-title="http-server"
sleep 0.5

# Tab 2: cd + python server
kitten @ --to "unix:$SOCKET2" send-text "cd ~/Cyber/SiteForStealthTest && python -m http.server 5500\n"

# ─── Desktop 4: Firefox ─────────────────────────────────────────────────────

hyprctl dispatch workspace 4
sleep 0.3
firefox &

# ─── Vrati na Desktop 1 ─────────────────────────────────────────────────────

sleep 0.5
hyprctl dispatch workspace 1

echo "[botwork] Setup complete!"
