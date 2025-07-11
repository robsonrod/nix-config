#!/usr/bin/env bash

export PATH="${PATH}:$HOME/.config/bin"

if [[ "$COMPUTER_NAME" == "xps" ]]; then
	xrandr --output $MONITOR --primary --mode 3840x2400 --pos 0x0 --rotate normal --output DP-1-2 --off --output HDMI-2 --off --output HDMI-1 --off --output DP-1 --off --output DP-1-3 --off --output DP-2 --off --output DP-1-1 --off
	xrandr --output $MONITOR --brightness 0.60
fi


# reload .Xresources
xrdb -merge ~/.Xresources

# change keyboard layout
xmodmap ~/.Xmodmap


# enables power saving
xset dpms 240 300 360 &

# fix cursor shape
xsetroot -cursor_name left_ptr &

# make short-pressed Ctrl behave like Escape:
xcape -e 'Control_L=Escape'

# polkit
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# java gui fixes
export _JAVA_AWT_WM_NONREPARENTING=1

# set wallpaper
feh --bg-scale $HOME/.config/wallpaper/wallpaper.jpg

# fix mouse shape
xsetroot -cursor_name left_ptr &

dunst &

#picom &

bluetoothctl power off &>/dev/null &

screensaver &
