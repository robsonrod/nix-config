local mod = "SUPER"

local terminal = "ghostty"
local fileManager = "thunar"
local browser = "brave"
local menu = "wofi"
local run_app = 'wofi --show run --prompt "run:"'

--------------------------------------------------
-- ENVIRONMENT
--------------------------------------------------
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("NIXOS_OZONE_WL", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

--------------------------------------------------
-- CONFIG
--------------------------------------------------
hl.config({
	general = {
		layout = "dwindle",

		gaps_in = 2,
		gaps_out = 1,

		border_size = 2,

		col = {
			active_border = { colors = { "rgba(f5c2e7cc)", "rgba(cba6f7cc)" }, angle = 45 },
			inactive_border = "rgba(585b70aa)",
		},

		resize_on_border = true,
	},

	decoration = {
		rounding = 6,

		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},

		blur = {
			enabled = true,
			size = 8,
			passes = 2,
			new_optimizations = true,
		},
	},

	animations = {
		enabled = false,
	},

	dwindle = {
		preserve_split = true,
	},

	master = {
		new_status = "master",
		new_on_top = true,
	},

	input = {
		kb_layout = "br,us",
		kb_options = "caps:ctrl_modifier,grp:win_space_toggle",

		follow_mouse = 1,
		sensitivity = 0,

		touchpad = {
			natural_scroll = true,
		},
	},

	misc = {
		focus_on_activate = true,
		font_family = "JetBrains Mono Nerd Font",

		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		force_default_wallpaper = 0,
	},

	ecosystem = {
		no_update_news = true,
	},

	debug = {
		disable_logs = false,
	},
})

--------------------------------------------------
-- MONITORS
--------------------------------------------------
hl.monitor({ output = "eDP-1", mode = "3840x2400@60", position = "0x0", scale = "2" })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "3840x0", scale = "1" })
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

--------------------------------------------------
-- DEVICE
--------------------------------------------------
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

--------------------------------------------------
-- GESTURES
--------------------------------------------------
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

--------------------------------------------------
-- AUTOSTART
--------------------------------------------------
hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("waybar")
	hl.exec_cmd("dunst")
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("systemctl --user start hypridle.service")
	hl.exec_cmd("hyprctl setcursor Adwaita 24")
	hl.exec_cmd("thunar --daemon")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)

--------------------------------------------------
-- KEYBINDS
--------------------------------------------------

-- Apps
hl.bind(mod .. " + T", hl.dsp.exec_cmd("GTK_IM_MODULE=simple " .. terminal))
hl.bind(mod .. " + W", hl.dsp.exec_cmd(browser))
hl.bind(mod .. " + F", hl.dsp.exec_cmd(fileManager))
hl.bind(mod .. " + M", hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + ALT + R", hl.dsp.exec_cmd(run_app))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(terminal .. " -e nvim"))

--------------------------------------------------
-- WINDOW MANAGEMENT
--------------------------------------------------
hl.bind("ALT + F4", hl.dsp.exec_cmd("killactive"))
hl.bind("CONTROL + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + B", hl.dsp.window.pseudo())

hl.bind(mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "down" }))

hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

hl.bind("SUPER + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
	hl.bind("L", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })
	hl.bind("H", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
	hl.bind("K", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
	hl.bind("J", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })
	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind("Return", hl.dsp.submap("reset"))
end)

--------------------------------------------------
-- SESSION
--------------------------------------------------
hl.bind(mod .. " + Q", hl.dsp.exec_cmd("wlogout"))
hl.bind(mod .. " + SHIFT + Q", hl.dsp.exec_cmd("exit"))
hl.bind(mod .. " + L", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 1 && hyprlock"))

--------------------------------------------------
-- WORKSPACE BINDS
--------------------------------------------------
for i = 1, 10 do
	local key = i % 10
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind("CONTROL + ALT + right", hl.dsp.focus({ workspace = "m+1" }))
hl.bind("CONTROL + ALT + left", hl.dsp.focus({ workspace = "m-1" }))

--------------------------------------------------
-- SPECIAL WORKSPACE
--------------------------------------------------
hl.bind(mod .. "+ S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

--------------------------------------------------
-- MOUSE
--------------------------------------------------
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

--------------------------------------------------
-- SCREEN RECORDING
--------------------------------------------------
hl.bind(mod .. " + F10", hl.dsp.exec_cmd("quickrec"))
hl.bind(mod .. " + F11", hl.dsp.exec_cmd("regionrec"))

--------------------------------------------------
-- SCREENSHOTS
--------------------------------------------------
hl.bind(mod .. " + PRINT", hl.dsp.exec_cmd("grimblast copy area"))
hl.bind(mod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("grimblast save area ~/Pictures/Screenshots"))

--------------------------------------------------
-- AUDIO
--------------------------------------------------
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))

--------------------------------------------------
-- BRIGHTNESS
--------------------------------------------------
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { repeating = true })

--------------------------------------------------
-- MEDIA
--------------------------------------------------
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))

--------------------------------------------------
-- LID SWITCH
--------------------------------------------------
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("hyprctl dispatch dpms off"))
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("hyprctl dispatch dpms on"))

--------------------------------------------------
-- WINDOW RULES
--------------------------------------------------
hl.window_rule({ name = "ws-firefox", match = { class = "firefox" }, workspace = "1 silent" })
hl.window_rule({ name = "ws-terminal", match = { class = "com.mitchellh.ghostty" }, workspace = "2 silent" })
hl.window_rule({ name = "ws-brave", match = { class = "brave-browser" }, workspace = "4 silent" })

hl.window_rule({ name = "pavucontrol-center", match = { class = "pavucontrol" }, center = true })
hl.window_rule({ name = "pavucontrol-float", match = { class = "pavucontrol" }, float = true })

hl.window_rule({ name = "blueman-manager-center", match = { class = "blueman-manager" }, center = true })
hl.window_rule({ name = "blueman-manager-float", match = { class = "blueman-manager" }, float = true })

hl.window_rule({ name = "file-roller-float", match = { class = "^(file-roller)$" }, float = true })
hl.window_rule({ name = "file-roller-center", match = { class = "^(file-roller)$" }, center = true })
hl.window_rule({ name = "modal-open", match = { title = "^(Open)$" }, float = true })
hl.window_rule({ name = "modal-choose-files", match = { title = "^(Choose Files)$" }, float = true })
hl.window_rule({ name = "modal-save-as", match = { title = "^(Save As)$" }, float = true })
hl.window_rule({ name = "modal-confirm-replace", match = { title = "^(Confirm to replace files)$" }, float = true })
hl.window_rule({ name = "modal-file-op-progress", match = { title = "^(File Operation Progress)$" }, float = true })
