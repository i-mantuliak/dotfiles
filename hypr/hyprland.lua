local terminal = "alacritty"
local fileManager = "dolphin"
-- local menu = "rofi -show drun"
local menu = "noctalia msg panel-toggle launcher"

hl.on("hyprland.start", function()
  hl.exec_cmd("noctalia")
  hl.exec_cmd("wl-clip-persist --clipboard regular")
end)

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_SCALE_FACTOR", "1")
hl.env("GDK_SCALE", "1")
-- Dark Mode
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("GTK_THEME", "Adwaita:dark")

hl.monitor({ output   = "", scale = "1.33", })

hl.config({ xwayland = { force_zero_scaling = true } })
hl.config({ cursor = { no_warps = true } })
hl.config({ dwindle = { preserve_split = true, }, })
hl.config({ scrolling = { wrap_focus = false, }, })
hl.config({ binds = { scroll_event_delay = 0, }, })
hl.config({ general = { border_size = 2, gaps_in  = 5, gaps_out = 10, layout = "dwindle", }, })

hl.animation({ leaf = "global", enabled = true,  speed = 3, bezier = "default" })

hl.config({
    input = {
        kb_layout  = "us, ru",
        kb_options = "ctrl:swapcaps,grp:lctrl_toggle",
        follow_mouse = 2,
        sensitivity = -0.5, -- -1.0 - 1.0, 0 means no modification.
        scroll_factor = 2,
    },
})

---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"

--- MacOS bindings
local function send_shortcut_once(mods, key)
  return function()
    hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down" }))
    hl.timer(function()
      hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up" }))
    end, { timeout = 50, type = "oneshot" })
  end
end

for i = 1, 10 do
  local key = "code:" .. (i + 9)
  hl.unbind(mainMod .. " + SHIFT + " .. key)
  hl.unbind(mainMod .. " + CTRL + " .. key)
  hl.unbind(mainMod .. " + SHIFT + ALT + " .. key)
end
hl.unbind(mainMod .. " + C")
hl.unbind(mainMod .. " + V")
hl.unbind(mainMod .. " + " .. "RETURN")

local keys = {
  A = 38,
  F = 41,
  G = 42,
  Q = 24,
  R = 27,
  S = 39,
  T = 28,
  W = 25,
  X = 53,
  Z = 52,
}
for key, keycode in pairs(keys) do
  hl.unbind(mainMod .. " + " .. key)
  hl.bind(mainMod .. " + " .. key, send_shortcut_once("CTRL", keycode))
end

hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + V", send_shortcut_once("SHIFT", "INSERT"))
hl.bind(mainMod .. " + C", send_shortcut_once("CTRL", "INSERT"))
hl.bind(mainMod .. " + grave", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + RETURN", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

local nav = {
  -- home / end of the line
  { mainMod,               "Left",  "",           "Home" },
  { mainMod,               "Right", "",           "End"  },
  { mainMod .. " + SHIFT", "Left",  "SHIFT",      "Home" },
  { mainMod .. " + SHIFT", "Right", "SHIFT",      "End"  },

  -- by words
  { "ALT",                 "Left",  "CTRL",       "Left"  },
  { "ALT",                 "Right", "CTRL",       "Right" },
  { "ALT + SHIFT",         "Left",  "CTRL SHIFT", "Left"  },
  { "ALT + SHIFT",         "Right", "CTRL SHIFT", "Right" },

  -- home / end of the document
  { mainMod,               "Up",    "CTRL",       "Home" },
  { mainMod,               "Down",  "CTRL",       "End"  },
  { mainMod .. " + SHIFT", "Up",    "CTRL SHIFT", "Home" },
  { mainMod .. " + SHIFT", "Down",  "CTRL SHIFT", "End"  },
}

for _, b in ipairs(nav) do
  local combo = b[1] .. " + " .. b[2]
  hl.unbind(combo) -- убираем дефолтные бинды (например, фокус на SUPER + стрелки)
  hl.bind(combo, send_shortcut_once(b[3], b[4]), { repeating = true })
end

local layouts = { slash = "scrolling", comma = "dwindle" }
for key, layout in pairs(layouts) do
    hl.bind(mainMod .. " + " .. key, function()
        hl.config({ general = { layout = layout } })
    end)
end

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,        hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)
hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})
-- For Noctalia Color templates
require("noctalia").apply_theme()
