hl.config({
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		vrr = 0,
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
		animate_manual_resizes = false,
		animate_mouse_windowdragging = false,
		enable_swallow = false,
		swallow_regex = "(foot|kitty|allacritty|Alacritty)",
		on_focus_under_fullscreen = 2,
		allow_session_lock_restore = true,
		session_lock_xray = true,
		initial_workspace_tracking = false,
		focus_on_activate = true,
	},
	binds = {
		scroll_event_delay = 0,
		hide_special_on_workspace_change = true,
	},
	cursor = {
		zoom_factor = 1,
		zoom_rigid = false,
		zoom_disable_aa = true,
		hotspot_padding = 1,
	},
	general = {
		gaps_in = 1,
		gaps_out = 1,
		border_size = 2,
		gaps_workspaces = 50,
		no_focus_fallback = true,
		allow_tearing = true, -- This just allows the `immediate` window rule to work
		snap = {
			enabled = true,
			window_gap = 4,
			monitor_gap = 5,
			respect_gaps = true,
		},
	},
	xwayland = {
		force_zero_scaling = true,
	},
	ecosystem = {
		no_update_news = true,
	},
})
