#!/usr/bin/env bash

swww init &

# setting wallpaper
swww img $HOME/.config/wallpaper/wallpaper.jpg &

nm-applet --indicator &

waybar &

dunst
