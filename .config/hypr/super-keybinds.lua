-- #######################################################################################
-- super-keybinds.lua — migrated from super-keybinds.conf
-- Standalone: defines its own local mainMod, exactly like the original .conf did.
-- #######################################################################################

local mainMod = "SUPER"

-- Reset Hyprland Config
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
-- Hyprlock Activate
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))
-- Toggle animations
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("toggle-animations.sh"))
-- Lock Screen
hl.bind("F8", hl.dsp.exec_cmd("power.sh lock"))
-- Reset waybar
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("pkill waybar ; setsid waybar"))

-- Resize screen - not fully working (per your original comment)
-- hl.dsp.exec_raw(string) passes an old-style "DISPATCHER ARGS" string straight
-- into Hyprland's internal dispatch (confirmed on the wiki/community usage) — this
-- is the direct equivalent of the old bind, not a shell subprocess workaround.
-- There's also a typed hl.dsp.window.resize({...}) call, but its exact table schema
-- (likely something like { delta = { x, y } }) isn't documented anywhere I could
-- confirm — if you want the "proper" typed form, test with `hyprctl repl` first,
-- e.g. `hyprctl repl 'hl.dispatch(hl.dsp.window.resize({...}))'`
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.exec_raw("resizeactive -50 0"))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.exec_raw("resizeactive +50 0"))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.exec_raw("resizeactive 0 -50"))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.exec_raw("resizeactive 0 +50"))

-- Screencast
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd("~/scripts/screencast.sh"))
-- Screenshot bind
hl.bind("Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot-menu.sh"))
-- Hyprshade
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("~/scripts/hyprshade.sh"))
-- Toggle Float
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd("~/scripts/toggleallfloat.sh"))
-- Make java project
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.exec_cmd("~/scripts/new-java-project.sh"))
-- Make java file
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd("~/scripts/new-java-file.sh"))
-- Compile java project
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("~/scripts/compile-java.sh"))
