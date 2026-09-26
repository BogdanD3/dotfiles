#!/bin/bash

VAULT_DIR="$HOME/personal/.secrets"
TMPFS="/dev/shm/vault_tmp"

mkdir -p "$TMPFS"
chmod 700 "$TMPFS"

# ── helpers ──────────────────────────────────────────────────────────────────

decrypt_to_clipboard() {
  local file="$1"
  gpg --decrypt "$file" 2>/dev/null |
    tr -d '\n' |
    wl-copy
  notify-send "Vault" "Copied to clipboard. Clears in 30s." -t 3000
  (sleep 30 && wl-copy --clear) &
}

decrypt_to_tmp() {
  local file="$1"
  local name
  name=$(basename "$file" .gpg)
  local out="$TMPFS/$name"
  gpg --decrypt --output "$out" "$file" 2>/dev/null
  chmod 600 "$out"
  echo "$out"
}

# ── folder handlers ───────────────────────────────────────────────────────────

handle_passwords() {
  local file="$1"
  decrypt_to_clipboard "$file"
}

handle_tokens() {
  local file="$1"
  decrypt_to_clipboard "$file"
}

handle_notes() {
  local file="$1"
  local out
  out=$(decrypt_to_tmp "$file")
  kitty --title "vault-note" nvim "$out" \
    --override font_size=13
  shred -u "$out" 2>/dev/null
}

handle_ssh() {
  local file="$1"
  local out
  out=$(decrypt_to_tmp "$file")
  echo "$out" | wl-copy
  notify-send "Vault" "SSH key path copied. File shredded in 30s." -t 3000
  (sleep 1800 && shred -u "$out" 2>/dev/null) &
}

handle_certs() {
  local file="$1"
  local out
  out=$(decrypt_to_tmp "$file")
  echo "$out" | wl-copy
  notify-send "Vault" "Cert path copied. File shredded in 30s." -t 3000
  (sleep 30 && shred -u "$out" 2>/dev/null) &
}

handle_images() {
  local file="$1"
  local out
  out=$(decrypt_to_tmp "$file")
  libreoffice "$out"
  wait
  shred -u "$out" 2>/dev/null
}

# ── main ──────────────────────────────────────────────────────────────────────

FOLDER=$(find "$VAULT_DIR" -name "*.gpg" |
  sed "s|$VAULT_DIR/||" |
  cut -d'/' -f1 |
  sort -u |
  rofi -dmenu -p "🔐 vault")

[ -z "$FOLDER" ] && exit 0

selected=$(find "$VAULT_DIR/$FOLDER" -name "*.gpg" |
  sed "s|$VAULT_DIR/$FOLDER/||; s|\.gpg$||" |
  rofi -dmenu -p "📁 $FOLDER")

[ -z "$selected" ] && exit 0

FILE="$VAULT_DIR/$FOLDER/${selected}.gpg"

# ── dispatch ──────────────────────────────────────────────────────────────────
# Add a new folder: add a case line and a handle_* function above.

case "$FOLDER" in
passwords) handle_passwords "$FILE" ;;
tokens) handle_tokens "$FILE" ;;
notes) handle_notes "$FILE" ;;
ssh) handle_ssh "$FILE" ;;
certs) handle_certs "$FILE" ;;
images) handle_images "$FILE" ;;
*)
  notify-send "Vault" "Unknown folder: $FOLDER — no handler defined." -t 4000
  ;;
esac
