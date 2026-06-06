hl.config({
	input = {
		kb_layout = "us,ara",
		repeat_rate = 50,
		repeat_delay = 300,
		follow_mouse = 1,
		sensitivity = -0.1,
		force_no_accel = 0,
		numlock_by_default = false,
		kb_options = "caps:super",
		touchpad = {
			natural_scroll = false,
			disable_while_typing = true,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "swipe",
	action = "move",
})
hl.gesture({
	fingers = 3,
	direction = "pinch",
	action = "fullscreen",
})
hl.gesture({
	fingers = 4,
	direction = "horizontal",
	action = "workspace",
})
-- hl.gesture({
--     fingers = 4,
--     direction = "up",
--     action = function()
--         hl.dispatch(hl.dsp.global("quickshell:overviewWorkspacesToggle"))
--     end
-- })
-- hl.gesture({
--     fingers = 4,
--     direction = "down",
--     action = function()
--         hl.dispatch(hl.dsp.global("quickshell:overviewWorkspacesToggle"))
--     end
-- })
