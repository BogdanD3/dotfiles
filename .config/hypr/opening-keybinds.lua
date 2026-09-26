-- #######################################################################################
-- opening-keybinds.lua — migrated from opening-keybinds.conf
-- Standalone: no shared variables needed from hyprland.lua, matches original structure.
-- #######################################################################################

-- Open Neovim
hl.bind("ALT + N", hl.dsp.exec_cmd("kitty -e nvim"))
-- Open VSCode
hl.bind("ALT + C", hl.dsp.exec_cmd("setsid code"))
-- Open Brave
hl.bind("ALT + B", hl.dsp.exec_cmd("setsid brave"))
-- Open PavuControl
hl.bind("ALT + P", hl.dsp.exec_cmd("setsid pavucontrol"))
-- Open File Manager
-- (dropped the surrounding single quotes from the original — they were redundant,
-- the path has no spaces so the shell never needed them)
hl.bind("ALT + F", hl.dsp.exec_cmd("/home/bogdan/scripts/launch-lfcd.sh"))

-- Open Vault
hl.bind("ALT + V", hl.dsp.exec_cmd("/home/bogdan/scripts/vault-open.sh"))
-- Start Work (Bots)
hl.bind("ALT + W", hl.dsp.exec_cmd("/home/bogdan/scripts/botwork.sh"))
-- Start Discord
hl.bind("ALT + D", hl.dsp.exec_cmd("/home/bogdan/scripts/open-discord.sh"))
