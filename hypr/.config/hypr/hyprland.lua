local theme = require("themes/catppuccin-macchiato")
require("monitors")

local mainMod = "SUPER"

-- Environment variables
hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", 1)
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", 1)
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("SSH_AUTH_SOCK", os.getenv("XDG_RUNTIME_DIR") .. "/ssh-agent.socket")
hl.env("_JAVA_OPTIONS", "-Dawt.useSystemAAFontSettings=on")

-- Config
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 5,
        border_size = 1,
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
        col = {
            active_border   = { colors = { theme.blue, theme.surface2, theme.surface2, theme.blue }, angle = 45 },
            inactive_border = { colors = { theme.surface0 }, angle = 45 },
        },
    },
    decoration = {
        rounding = 10,
        rounding_power = 2,
        active_opacity = 1,
        inactive_opacity = 0.8,
        shadow = {
            enabled = true,
            range = 16,
            render_power = 4,
            color = "rgba(000000ff)",
        },
        blur = {
            enabled = true,
            size = 5,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
    animations = { enabled = true },
    dwindle    = { preserve_split = true },
    master     = { new_status = "master" },
    misc = {
        force_default_wallpaper  = 0,
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
    },
    input = {
        kb_layout    = "pl",
        follow_mouse = 1,
        mouse_refocus = false,
        sensitivity  = 0,
        touchpad = {
            scroll_factor  = 0.2,
            natural_scroll = true,
        },
    },
    cursor = {
        no_hardware_cursors = false,
        no_break_fs_vrr     = true,
        min_refresh_rate    = 48,
    },
})

-- Animations
hl.curve("smoothOut",   { type = "bezier", points = { {0.22, 1},    {0.36, 1} } })
hl.curve("smoothInOut", { type = "bezier", points = { {0.4,  0},    {0.2,  1} } })
hl.curve("spring",      { type = "bezier", points = { {0.34, 1.56}, {0.64, 1} } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,  bezier = "smoothOut" })
hl.animation({ leaf = "windows",       enabled = true, speed = 5.2, bezier = "smoothOut" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.8, bezier = "spring",      style = "popin 92%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 3.6, bezier = "smoothInOut", style = "popin 80%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 2.4, bezier = "smoothInOut" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 2.1, bezier = "smoothInOut" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.0, bezier = "smoothOut" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.8, bezier = "smoothOut" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4.0, bezier = "smoothOut",    style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 2.6, bezier = "smoothInOut",  style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 2.0, bezier = "smoothInOut" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.6, bezier = "smoothInOut" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 2.6, bezier = "smoothInOut", style = "slide" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 2.4, bezier = "smoothOut",   style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 2.4, bezier = "smoothInOut", style = "slide" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 8.5, bezier = "spring" })

-- Keybindings
hl.bind(mainMod .. " + T",         hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + B",         hl.dsp.exec_cmd("google-chrome-stable"))
hl.bind(mainMod .. " + C",         hl.dsp.window.close())
hl.bind(mainMod .. " + M",         hl.dsp.exit())
hl.bind(mainMod .. " + F",         hl.dsp.exec_cmd("nautilus"))
hl.bind(mainMod .. " + backslash", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle_floating.sh"))
hl.bind(mainMod .. " + R",         hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
hl.bind(mainMod .. " + V",         hl.dsp.exec_cmd("noctalia msg panel-toggle clipboard"))
hl.bind(mainMod .. " + S",         hl.dsp.exec_cmd("noctalia msg panel-toggle control-center"))
hl.bind(mainMod .. " + comma",         hl.dsp.exec_cmd("noctalia msg settings-toggle"))
hl.bind(mainMod .. " + Return",         hl.dsp.window.fullscreen({ mode = "maximized",  action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + L",         hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ 1 && noctalia msg session lock"))
hl.bind(mainMod .. " + H",         hl.dsp.window.move({ workspace = "special" }))

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x =  128, y =    0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -128, y =    0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x =    0, y = -128, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x =    0, y =  128, relative = true }), { repeating = true })

-- Workspaces 1-10 (key 0 = workspace 10)
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:274", hl.dsp.window.close())
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("noctalia msg volume-up"),      { locked = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("noctalia msg volume-down"),    { locked = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("noctalia msg volume-mute"),    { locked = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("noctalia msg mic-mute"),       { locked = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("noctalia msg brightness-up"),  { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("noctalia msg brightness-down"),{ locked = true })
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"),              { locked = true })
hl.bind("XF86AudioPause",        hl.dsp.exec_cmd("playerctl play-pause"),        { locked = true })
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"),        { locked = true })
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"),          { locked = true })

hl.bind("switch:on:Lid Switch",  hl.dsp.exec_cmd("hyprctl eval \"hl.monitor({output = 'eDP-1', disabled = true})\""), { locked = true })
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("hyprctl eval \"hl.monitor({output = 'eDP-1', disabled = false, mode = 'preferred', position = 'auto', scale = 1.0})\" && brightnessctl set 90%"), { locked = true })

hl.bind("CTRL + Escape",    hl.dsp.exec_cmd("noctalia msg bar-toggle"))
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd("noctalia msg panel-toggle session"))
hl.bind("Print",            hl.dsp.exec_cmd("noctalia msg screenshot-region"))
hl.bind("SHIFT + Print",    hl.dsp.exec_cmd("noctalia msg screenshot-fullscreen"))
hl.bind("CTRL + Print",     hl.dsp.exec_cmd("noctalia msg screenshot-fullscreen all"))

-- Window rules
hl.window_rule({ name = "suppress-maximize-events", match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({ name = "terminal-opacity",         match = { class = "kitty" },                           opacity = "0.8 override 0.7 override" })
hl.window_rule({ name = "browser-opacity",          match = { class = "google-chrome-stable" },            opacity = "1.0 override 1.0 override" })
hl.window_rule({ name = "float-opacity",            match = { float = true },                              opacity = "0.92 0.85" })
hl.window_rule({ name = "modal-dialogs",            match = { modal = true }, float = true, center = true, min_size = { 400, 200 }, persistent_size = true, })
hl.window_rule({ name = "utility-apps",             match = { class = "^(blueman-manager|nm-connection-editor|pavucontrol|system-config-printer|signal)$" }, float = true, center = true, min_size = { 400, 200 }, persistent_size = true, })
hl.window_rule({ name = "nautilus",                 match = { class = "^(org\\.gnome\\.Nautilus)$" }, float = true, center = true, size = { 1000, 700 }, persistent_size = true, opacity = "1.0 override 1.0 override" })
hl.layer_rule({ name = "noctalia", match = { namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$" }, no_anim = true, ignore_alpha = 0.5, blur = true, blur_popups = true })
hl.window_rule({ match = { class = "dev.noctalia.Noctalia" }, float = true, size = { 1080, 920 } })

-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("noctalia")
    hl.exec_cmd("brightnessctl set 90%")
    hl.exec_cmd("udiskie")
    hl.exec_cmd("signal-desktop --start-in-tray")
end)
