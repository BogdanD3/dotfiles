-- #######################################################################################
-- hyprland.lua — migrated from hyprland.conf (Hyprland 0.56.1 -> Lua config)
-- Migrated 2026-08-11. Keep your original hyprland.conf.bak until this is fully tested.
--
-- Lines tagged MIGRATION-NOTE were NOT confirmed against the official example at
-- https://github.com/hyprwm/Hyprland/blob/main/example/hyprland.lua — verify against
-- https://wiki.hypr.land/ and `hyprctl configerrors` before trusting them.
-- #######################################################################################

-- You can (and should!) split config into multiple files, same as before.
-- Each of these is self-contained (defines its own mainMod where needed).
require("super-keybinds")
require("opening-keybinds")

------------------
---- MONITORS ----
------------------
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output = "eDP-1",
    mode = "1920x1080",
    position = "0x0",
    scale = 1,
})

---------------------
---- MY PROGRAMS ----
---------------------
local terminal = "kitty"
local fileManager = "dolphin"
local menu = "rofi -show drun"

-------------------
---- AUTOSTART ----
-------------------
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
-- exec-once is now a callback registered on the hyprland.start event.
-- Order preserved from your original config (trailing "&" dropped — not needed here).
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("~/scripts/batterylevel-notifications.sh")
    hl.exec_cmd("hypridle -c /home/bogdan/.config/hypr/hypridle.conf")
    hl.exec_cmd("hyprshade on /usr/share/hyprshade/shaders/vibrance.glsl")
    hl.exec_cmd("gammastep -c /home/bogdan/.config/gammastep/config.ini")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("XCURSOR_SIZE", "16")
hl.env("HYPRCURSOR_SIZE", "36")
hl.env("HYPRCURSOR_THEME", "Future-Cyan-Hyprcursor_Theme")

-----------------------
----- PERMISSIONS -----
-----------------------
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Requires a full Hyprland restart to apply, same as before.
hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 20,
        border_size = 2,
        col = {
            active_border = { colors = { "rgba(cba6f7ff)", "rgba(7b529fff)", "rgba(2e2e4eff)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 10,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 0.7,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee1a1a1a, -- was rgba(1a1a1aee) — confirmed conversion pattern from official example
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
    animations = {
        enabled = true,
    },
})

-- Bezier curves: old "bezier = name, x1, y1, x2, y2" -> points = {{x1,y1},{x2,y2}}
hl.curve("default", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.curve("wind", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.curve("overshot", { type = "bezier", points = { {0.13, 0.99}, {0.29, 1.08} } })
hl.curve("liner", { type = "bezier", points = { {1, 1}, {1, 1} } })
hl.curve("bounce", { type = "bezier", points = { {0.4, 0.9}, {0.6, 1.0} } })
hl.curve("snappyReturn", { type = "bezier", points = { {0.4, 0.9}, {0.6, 1.0} } })
hl.curve("slideInFromRight", { type = "bezier", points = { {0.5, 0.0}, {0.5, 1.0} } })

-- Animations. All leaf names below are confirmed against the current wiki's
-- animation tree (https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/):
-- global -> windows/windowsIn/windowsOut/windowsMove, layers/layersIn/layersOut,
-- fade/fadeIn/fadeOut/fadeSwitch/fadeShadow/fadeGlow/fadeDim/fadeLayers(In/Out)/
-- fadePopups(In/Out)/fadeDpms, border, workspaces(In/Out)/specialWorkspace,
-- zoomFactor, borderangle (styles: once, loop).
hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "snappyReturn", style = "slidevert" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, bezier = "snappyReturn", style = "slidevert right" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "snappyReturn", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 6, bezier = "bounce", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 5, bezier = "bounce", style = "slidevert right" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 10, bezier = "default" })
-- fadeLayers is its own parent leaf (distinct from fadeLayersIn/fadeLayersOut) —
-- your original .conf set the parent directly, so it's mapped to the parent here too.
hl.animation({ leaf = "fadeLayers", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 7, bezier = "overshot", style = "slidevert" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "liner" })
hl.animation({ leaf = "layers", enabled = true, speed = 4, bezier = "bounce", style = "slidevert right" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "liner", style = "loop" })

-- Layouts / misc
hl.config({
    dwindle = { preserve_split = true },
    master = { new_status = "master" },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },
})

---------------
---- INPUT ----
---------------
hl.config({
    input = {
        kb_layout = "us, me",
        kb_variant = "",
        kb_model = "",
        kb_options = "grp:alt_shift_toggle",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
        },
    },
})

-- MIGRATION-NOTE: this device block used the wiki's placeholder name "epic-mouse-v1"
-- in your original .conf too. If that was never your real mouse, delete this block —
-- otherwise run `hyprctl devices` to get the real name and replace it.
hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- The wiki explicitly recommends against binding hl.dsp.exit() directly (it can
-- interfere with uwsm's ordered session shutdown) and endorses this exact
-- hyprshutdown-first-then-fallback pattern instead — this isn't a guess.
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("~/.config/lf/opener"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9], move window with mainMod + SHIFT + [1-9]
-- (your original had no SHIFT+0/movetoworkspace-10 bind — preserved that gap)
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    if i ~= 10 then
        hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
    end
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("~/scripts/toggle-mic.sh"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
-- Your original config had no active window/layer rules (only a commented example),
-- so there's nothing to migrate here. Add hl.window_rule({...}) here if you add rules later.
