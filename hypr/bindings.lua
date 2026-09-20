-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind(mainMod .. " + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind(mainMod .. " + SPACE")
-- o.bind(mainMod .. " + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind(mainMod .. " + SHIFT + B")

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

local function send_shortcut_once(mods, key)
  return function()
    hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down" }))

    hl.timer(function()
      hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up" }))
    end, { timeout = 50, type = "oneshot" })
  end
end
for index = 1, 10 do
  local key = "code:" .. tostring(index + 9)
  hl.unbind(mainMod .. " + SHIFT + " .. key)
  hl.unbind(mainMod .. " + SHIFT + ALT + " .. key)
  hl.unbind(mainMod .. " + CTRL + code:" .. tostring(index + 9))
end

for workspace = 1, 10 do
  local key = "code:" .. tostring(workspace + 9)
  o.bind(mainMod .. " + CTRL + " .. key, "Move window to workspace " .. workspace, hl.dsp.window.move({ workspace = tostring(workspace) }))
  o.bind(mainMod .. " + CTRL + ALT + " .. key, "Move window silently to workspace " .. workspace, hl.dsp.window.move({ workspace = tostring(workspace), follow = false }))
end

o.bind(mainMod .. " + SHIFT + 2", nil, "omarchy capture screenshot")

-- Prevent `=[C]:-1:send_key_state: key not found` error. Keycodes via 'wev' command.
local keys = {
  A = 38,
  F = 41,
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
  o.bind(mainMod .. " + " .. key, "", send_shortcut_once("CTRL", keycode))
end

hl.unbind(mainMod .. " + C")
hl.unbind(mainMod .. " + V")
hl.unbind(mainMod .. " + " .. "RETURN")
o.bind(mainMod .. " + V", "", send_shortcut_once("SHIFT", 118)) -- INSERT = 118
o.bind(mainMod .. " + C", "", send_shortcut_once("CTRL", 118))
o.bind(mainMod .. " + grave", "Terminal", { omarchy = "terminal" }) -- grave = ~
o.bind(mainMod .. " + RETURN", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
o.bind(mainMod .. " + Q", "Close window.", hl.dsp.window.close())
