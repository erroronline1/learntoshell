#!/bin/bash

second=$(xrandr --listactivemonitors | grep '1:')

if [ -n "$second" ]
then
    # set scaling factor to 1 and fractional scaling for hdpi monitor
    gsettings set org.cinnamon.desktop.interface scaling-factor 1
    gsettings set org.cinnamon.settings-daemon.plugins.xsettings overrides "{'Gdk/WindowScalingFactor': <1>}"
    xrandr --output eDP-1 --primary --mode 3840x2400 --rate 59.99 --scale 0.5x0.5 --output DP-3 --mode 3840x1080 --rate 60.00 --scale 1x1 --above eDP-1
else
    # set scaling factor to 2 and reset fractional scaling for hdpi monitor
    gsettings set org.cinnamon.desktop.interface scaling-factor 2
    gsettings set org.cinnamon.settings-daemon.plugins.xsettings overrides "{'Gdk/WindowScalingFactor': <2>}"
    xrandr --output eDP-1 --primary --mode 3840x2400 --rate 59.99 --scale 1x1
fi