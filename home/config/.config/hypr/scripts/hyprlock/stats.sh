# ~/.config/hypr/hyprlock.conf
# Production Lock Screen | 60fps Animations | Mathematical Layout

# ==========================================
# CORE CONFIGURATION
# ==========================================
general {
    no_fade_in = false
    no_fade_out = false
    hide_cursor = true
    grace = 0
    disable_loading_bar = true
    enable_fingerprint = true
    fingerprint_ready_message =
    fingerprint_present_message =
    text_trim = true
    fractional_scaling = 2
    immediate_render = true
}

auth {
    pam:enabled = true
    pam:module = hyprlock
    fingerprint:enabled = true
    fingerprint:ready_message =
    fingerprint:present_message =
    fingerprint:retry_delay = 250
}

# ==========================================
# ADVANCED ANIMATION SYSTEM
# ==========================================
animations {
    enabled = true
}

# Precision-tuned bezier curves for 60fps fluidity
bezier = fluid_in, 0.23, 1, 0.32, 1
bezier = fluid_out, 0.4, 0, 0.23, 1
bezier = elastic_out, 0.18, 0.89, 0.32, 1.28
bezier = silk, 0.25, 0.46, 0.45, 0.94

# Layered fade-in with temporal offset for visual hierarchy
animation = fade, 1, 3, fluid_in
animation = fadeIn, 1, 2.8, fluid_in
animation = fadeOut, 1, 2, fluid_out

# Input field micro-animations
animation = inputFieldColors, 1, 2.5, silk
animation = inputFieldFade, 1, 2.2, fluid_in
animation = inputFieldDots, 1, 2, silk
animation = inputFieldWidth, 1, 2.5, elastic_out

# ==========================================
# BACKGROUND
# ==========================================
background {
    monitor =
    path = ~/Pictures/wallpapers/night_car_vintage.jpg

    # Enhanced blur for depth
    blur_size = 7
    blur_passes = 4
    noise = 0.015
    contrast = 1.15
    brightness = 0.82
    vibrancy = 0.45
    vibrancy_darkness = 0.12
}

# ==========================================
# GREETING MESSAGE
# ==========================================
label {
    monitor =
    text = cmd[update:60000] ~/.config/hypr/scripts/hyprlock_greeting.sh
    color = rgba(216, 222, 233, 0.65)
    font_size = 18
    font_family = SF Pro Display Medium

    position = 0, 430
    halign = center
    valign = center
    zindex = 10
}

# ==========================================
# TIME DISPLAY
# ==========================================
label {
    monitor =
    text = cmd[update:1000] date +"%H:%M"
    color = rgba(216, 222, 233, 0.90)
    font_size = 120
    font_family = SF Pro Display Light

    position = 0, 260
    halign = center
    valign = center
    zindex = 10

    shadow_passes = 2
    shadow_size = 4
    shadow_color = rgba(0, 0, 0, 0.3)
}

# ==========================================
# DATE DISPLAY
# ==========================================
label {
    monitor =
    text = cmd[update:60000] date +"%A, %B %-d"
    color = rgba(216, 222, 233, 0.75)
    font_size = 24
    font_family = SF Pro Display Bold

    position = 0, 170
    halign = center
    valign = center
    zindex = 10
}

# ==========================================
# WEATHER DISPLAY (Enhanced)
# ==========================================
label {
    monitor =
    text = cmd[update:30000] ~/.config/hypr/scripts/hyprlock_weather.sh
    color = rgba(216, 222, 233, 0.70)
    font_size = 20
    font_family = JetBrainsMono Nerd Font

    position = 0, 120
    halign = center
    valign = center
    zindex = 10
}

# ==========================================
# USER BOX (BACKGROUND)
# ==========================================
shape {
    monitor =
    size = 320, 62
    color = rgba(255, 255, 255, 0.06)
    rounding = -1
    border_size = 0
    rotate = 0
    xray = false

    position = 0, -120
    halign = center
    valign = center
    zindex = 0

    shadow_passes = 2
    shadow_size = 8
    shadow_color = rgba(0, 0, 0, 0.15)
}

# ==========================================
# USERNAME DISPLAY
# ==========================================
label {
    monitor =
    text = 󰀄  $USER
    color = rgba(216, 222, 233, 0.85)
    font_size = 18
    font_family = JetBrainsMono Nerd Font, SF Pro Display

    position = 0, -120
    halign = center
    valign = center
    zindex = 10
}

# ==========================================
# PASSWORD INPUT FIELD
# ==========================================
input-field {
    monitor =
    size = 320, 62
    outline_thickness = 0

    dots_size = 0.22
    dots_spacing = 0.25
    dots_center = true
    dots_rounding = -1

    outer_color = rgba(0, 0, 0, 0)
    inner_color = rgba(255, 255, 255, 0.06)
    font_color = rgba(216, 222, 233, 0.95)

    fade_on_empty = true
    fade_timeout = 2000

    font_family = SF Pro Display
    font_size = 16

    placeholder_text = <span foreground="##d8dee999">Password</span>
    hide_input = false
    rounding = -1

    check_color = rgba(255, 193, 7, 0.9)
    fail_color = rgba(244, 67, 54, 0.9)
    fail_text = <span foreground="##ff5252" size="small"><i>Authentication failed</i></span>

    capslock_color = rgba(255, 193, 7, 0.9)

    position = 0, -200
    halign = center
    valign = center
    zindex = 10

    shadow_passes = 2
    shadow_size = 8
    shadow_color = rgba(0, 0, 0, 0.15)
}

# ==========================================
# FINGERPRINT STATUS
# ==========================================
label {
    monitor =
    text = cmd[update:500] ~/.config/hypr/scripts/hyprlock_fingerprint.sh
    color = rgba(51, 204, 255, 0.85)
    font_size = 14
    font_family = JetBrainsMono Nerd Font

    position = 0, -280
    halign = center
    valign = center
    zindex = 10
}

# ==========================================
# UNIFIED SYSTEM STATS
# ==========================================
label {
    monitor =
    text = cmd[update:2000] ~/.config/hypr/scripts/hyprlock_stats.sh
    color = rgba(216, 222, 233, 0.55)
    font_size = 13
    font_family = JetBrainsMono Nerd Font

    position = 0, 70
    halign = center
    valign = bottom
    zindex = 10
}

# ==========================================
# NETWORK STATUS
# ==========================================
label {
    monitor =
    text = cmd[update:5000] ~/.config/hypr/scripts/hyprlock_network.sh
    color = rgba(216, 222, 233, 0.55)
    font_size = 13
    font_family = JetBrainsMono Nerd Font

    position = 0, 100
    halign = center
    valign = bottom
    zindex = 10
}

# ==========================================
# MUSIC DISPLAY
# ==========================================
label {
    monitor =
    text = cmd[update:1000] ~/.config/hypr/scripts/hyprlock_music.sh
    color = rgba(216, 222, 233, 0.65)
    font_size = 15
    font_family = JetBrainsMono Nerd Font

    position = 0, 140
    halign = center
    valign = bottom
    zindex = 10

    shadow_passes = 1
    shadow_size = 3
    shadow_color = rgba(0, 0, 0, 0.2)
}

# ==========================================
# LAYOUT INDICATOR
# ==========================================
label {
    monitor =
    text = $LAYOUT[EN, ]
    color = rgba(216, 222, 233, 0.45)
    font_size = 12
    font_family = SF Pro Display Medium

    position = 30, 30
    halign = left
    valign = bottom
    zindex = 10
}
