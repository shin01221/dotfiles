-- Keybindings for Hyprland scrolling layout
local mainMod = "SUPER"

-- Applications
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("ghostty"), { description = "Open ghostty terminal" })
-- hl.bind(
-- 	mainMod .. " + ALT + D",
-- 	hl.dsp.exec_cmd("qs -c noctalia-shell ipc call launcher windows"),
-- 	{ description = "Open window launcher" }
-- )
hl.bind(
	mainMod .. " + SHIFT + RETURN",
	hl.dsp.exec_cmd("env NO_TMUX=1 foot"),
	{ description = "Open foot terminal (no tmux)" }
)
hl.bind(
	mainMod .. " + D",
	hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"),
	{ description = "Toggle application launcher" }
)
-- hl.bind(
-- 	mainMod .. " + PRINT",
-- 	hl.dsp.exec_cmd("qs -c noctalia-shell ipc call plugin:screen-toolkit annotate"),
-- 	{ description = "Screenshot with annotation" }
-- )
hl.bind(
	mainMod .. " + ALT + PRINT",
	hl.dsp.exec_cmd("noctalia msg screenshot-fullscreen all"),
	{ description = "Full screenshot all monitors" }
)
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("wayscriber -a"), { description = "Toggle wayscriber" })
hl.bind(mainMod .. " + EQUAL", hl.dsp.exec_cmd("noctalia msg volume-up"), { description = "Volume up" })
hl.bind(mainMod .. " + MINUS", hl.dsp.exec_cmd("noctalia msg volume-down"), { description = "Volume down" })
-- hl.bind(
-- 	mainMod .. " + ALT + RETURN",
-- 	hl.dsp.exec_cmd("~/.local/bin/scratchpad.sh foot-dropterm"),
-- 	{ description = "Toggle scratchpad terminal" }
-- )
hl.bind(
	mainMod .. " + BRACKETRIGHT",
	hl.dsp.exec_cmd("playerctl --ignore-player=firefox --player=tauon,spotify,mpd position 10+"),
	{ description = "Seek forward 10s" }
)
hl.bind(
	mainMod .. " + BRACKETLEFT",
	hl.dsp.exec_cmd("playerctl --ignore-player=firefox --player=tauon,spotify,mpd position 10-"),
	{ description = "Seek backward 10s" }
)
-- Volume & brightness multimedia keys
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0"),
	{ locked = true, repeating = true, description = "Raise volume" }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"),
	{ locked = true, repeating = true, description = "Lower volume" }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true, description = "Mute audio" }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true, description = "Mute microphone" }
)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, description = "Play/Pause" })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"), { locked = true, description = "Stop" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true, description = "Previous track" })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true, description = "Next track" })
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("~/.local/bin/brightnesscontrol.sh -i"),
	{ locked = true, repeating = true, description = "Increase brightness" }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("~/.local/bin/brightnesscontrol.sh -d"),
	{ locked = true, repeating = true, description = "Decrease brightness" }
)
-- Layout / UI
hl.bind(
	mainMod .. " + U",
	hl.dsp.exec_cmd("hyprctl switchxkblayout all next"),
	{ description = "Switch keyboard layout" }
)
-- hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("toggle-overview"), { description = "Toggle window overview" })
hl.bind(mainMod .. " + Q", hl.dsp.window.close(), { description = "Close active window" })
hl.bind(mainMod .. " + LEFT", hl.dsp.focus({ direction = "left" }), { description = "Focus left" })
hl.bind(mainMod .. " + DOWN", hl.dsp.focus({ workspace = "+1" }), { description = "Focus workspace down" })
hl.bind(mainMod .. " + UP", hl.dsp.focus({ workspace = "-1" }), { description = "Focus workspace down" })
hl.bind(mainMod .. " + RIGHT", hl.dsp.focus({ direction = "right" }), { description = "Focus right" })
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }), { description = "Focus left" })
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }), { description = "Focus right" })
hl.bind(mainMod .. " + J", hl.dsp.focus({ workspace = "+1" }), { description = "Focus workspace down" })
hl.bind(mainMod .. " + k", hl.dsp.focus({ workspace = "-1" }), { description = "Focus workspace down" })
hl.bind(mainMod .. " + CTRL + J", hl.dsp.focus({ workspace = "+1" }), { description = "Focus workspace down" })
hl.bind(mainMod .. " + CTRL + K", hl.dsp.focus({ workspace = "-1" }), { description = "Focus workspace up" })

-- Workspace navigation
-- hl.bind(
-- 	mainMod .. " + CTRL + PAGE_DOWN",
-- 	hl.dsp.window.move({ workspace = "+1" }),
-- 	{ description = "Move window to workspace below" }
-- )
-- hl.bind(
-- 	mainMod .. " + CTRL + PAGE_UP",
-- 	hl.dsp.window.move({ workspace = "-1" }),
-- 	{ description = "Move window to workspace above" }
-- )
hl.bind(
	mainMod .. " + CTRL + J",
	hl.dsp.window.move({ workspace = "+1" }),
	{ description = "Move window to workspace below" }
)
hl.bind(
	mainMod .. " + CTRL + K",
	hl.dsp.window.move({ workspace = "-1" }),
	{ description = "Move window to workspace above" }
)
hl.bind(
	mainMod .. " + SHIFT + U",
	hl.dsp.window.move({ workspace = "+1" }),
	{ description = "Move window to workspace below" }
)
hl.bind(
	mainMod .. " + SHIFT + I",
	hl.dsp.window.move({ workspace = "-1" }),
	{ description = "Move window to workspace above" }
)

-- Scroll
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "+1" }), { description = "Focus workspace down" })
hl.bind(mainMod .. " + mouse_down ", hl.dsp.focus({ workspace = "-1" }), { description = "Focus workspace up" })
hl.bind(
	mainMod .. " + CTRL + mouse_down",
	hl.dsp.window.move({ workspace = "+1" }),
	{ description = "Move window to workspace below" }
)
hl.bind(
	mainMod .. " + CTRL + mouse_up",
	hl.dsp.window.move({ workspace = "-1" }),
	{ description = "Move window to workspace above" }
)
hl.bind(mainMod .. " + ALT + mouse_down", hl.dsp.focus({ direction = "right" }), { description = "Focus right" })
hl.bind(mainMod .. " + ALT + mouse_up", hl.dsp.focus({ direction = "left" }), { description = "Focus left" })

-- Workspace switching [0-9]
for i = 1, 9 do
	hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }), { description = "Focus workspace " .. i })
	hl.bind(
		mainMod .. " + SHIFT + " .. i,
		hl.dsp.window.move({ workspace = i }),
		{ description = "Move window to workspace " .. i }
	)
end

-- Window management
hl.bind(
	mainMod .. " + ALT + BRACKETLEFT",
	hl.dsp.window.swap({ direction = "left" }),
	{ description = "Swap window left" }
)
hl.bind(
	mainMod .. " + ALT + BRACKETRIGHT",
	hl.dsp.window.swap({ direction = "right" }),
	{ description = "Swap window right" }
)
hl.bind(
	mainMod .. " + SHIFT + BRACKETRIGHT",
	hl.dsp.window.swap({ direction = "right" }),
	{ description = "Move window right" }
)
hl.bind(
	mainMod .. " + SHIFT + BRACKETLEFT",
	hl.dsp.window.swap({ direction = "left" }),
	{ description = "Move window left" }
)
hl.bind(mainMod .. " + R", hl.dsp.window.fullscreen({ mode = "maximized" }), { description = "Toggle maximize" })
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.group.toggle(), { description = "Toggle group" })
hl.bind(
	mainMod .. " + CTRL + R",
	hl.dsp.exec_cmd("hyprctl dispatch movewindow ru"),
	{ description = "Move window up in stack" }
)
hl.bind(mainMod .. " + ALT + F", hl.dsp.window.fullscreen({ mode = "maximized" }), { description = "Toggle maximize" })
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }), { description = "Toggle fullscreen" })
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating" })
hl.bind(mainMod .. " + CTRL + C", hl.dsp.window.center(), { description = "Center window" })
hl.bind(
	mainMod .. " + ALT + H",
	hl.dsp.exec_cmd("hyprctl dispatch resizeactive -5% 0"),
	{ description = "Resize narrower" }
)
hl.bind(
	mainMod .. " + ALT + L",
	hl.dsp.exec_cmd("hyprctl dispatch resizeactive +5% 0"),
	{ description = "Resize wider" }
)
hl.bind(
	mainMod .. " + ALT + K",
	hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 -5%"),
	{ description = "Resize shorter" }
)
hl.bind(
	mainMod .. " + ALT + J",
	hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 +5%"),
	{ description = "Resize taller" }
)
hl.bind(mainMod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle window floating" })
hl.bind(
	mainMod .. " + SHIFT + H",
	hl.dsp.window.move({ workspace = "-1" }),
	{ description = "Move window to previous workspace" }
)
hl.bind(
	mainMod .. " + SHIFT + L",
	hl.dsp.window.move({ workspace = "+1" }),
	{ description = "Move window to next workspace" }
)
hl.bind(mainMod .. " + G", hl.dsp.group.toggle(), { description = "Toggle group" })

-- Special actions
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd("hyprctl dispatch killactive"), { description = "Kill active window" })
hl.bind("CTRL + ALT + DELETE", hl.dsp.exec_cmd("hyprctl dispatch exit"), { description = "Exit Hyprland" })
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprctl dispatch dpms off"), { description = "Power off monitors" })
hl.bind(
	mainMod .. " + BACKSPACE",
	hl.dsp.exec_cmd("noctalia msg panel-toggle session"),
	{ description = "Toggle session menu" }
)
hl.bind(
	mainMod .. " + T",
	hl.dsp.exec_cmd("hyprctl dispatch togglespecialworkspace"),
	{ description = "Toggle scratchpad" }
)

-- wlr-which-key popups
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("wlr-which-key -k m niri"), { description = "Which-key: m prefix" })
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("wlr-which-key -k n niri"), { description = "Which-key: n prefix" })
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("wlr-which-key -k a niri"), { description = "Which-key: a prefix" })
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("wlr-which-key -k c niri"), { description = "Which-key: c prefix" })
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("wlr-which-key -k s niri"), { description = "Which-key: s prefix" })

-- Mouse bindings
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window with mouse" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window with mouse" })
