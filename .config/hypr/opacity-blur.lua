hl.config({
	gestures = {
		workspace_swipe_distance = 700,
		workspace_swipe_cancel_ratio = 0.2,
		workspace_swipe_min_speed_to_force = 5,
		workspace_swipe_direction_lock = true,
		workspace_swipe_direction_lock_threshold = 10,
		workspace_swipe_create_new = true,
	},
	decoration = {
		rounding_power = 2.5,
		rounding = 0,
		blur = {
			enabled = true,
			xray = true,
			special = false,
			new_optimizations = true,
			size = 6,
			passes = 5,
			brightness = 1,
			noise = 0.05,
			contrast = 0.89,
			vibrancy = 0.5,
			vibrancy_darkness = 0.5,
			popups = false,
			popups_ignorealpha = 0.6,
			input_methods = true,
			input_methods_ignorealpha = 0.8,
		},
		shadow = {
			enabled = true,
			range = 20,
			offset = { 0, 2 },
			render_power = 10,
			color = "rgba(00000020)",
		},
		active_opacity = 0.95,
		inactive_opacity = 0.95,
		-- Dim
		dim_inactive = true,
		dim_strength = 0.05,
		dim_special = 0.2,
	},
	animations = {
		enabled = true,
	},
	dwindle = {
		preserve_split = true,
		smart_split = false,
		smart_resizing = false,
		-- precise_mouse_move = true,
	},
})

-- wlr-which-key popup
hl.layer_rule({
	match = { namespace = "^wlr_which_key$" },
	blur_popups = true,
})

-- Floating noctalia shell
hl.window_rule({
	match = { class = "dev.noctalia.noctalia-qs" },
	float = true,
})

-- No xray on noctalia background
hl.layer_rule({
	match = { namespace = "^noctalia-background-.*$" },
	xray = false,
})

-- hl.layer_rule({
--     match = { namespace = "^noctalia-desktop-widgets-eDP-2" },
--     background_effect = {
--         blur = true,
--         xray = false
--     }
-- })

hl.window_rule({
	match = {
		class = ".*org\\.kde\\.okular.*|.*mpv.*|.*vlc.*|.*org\\.kde\\.gwenview.*|^com\\.obsproject\\.Studio$|.*zen.*",
	},
	opacity = 1.00,
	no_blur = true,
})
hl.window_rule({
	match = { title = ".*YouTube.*" },
	opacity = 1.00,
	no_blur = true,
})
