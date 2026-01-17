#!/bin/bash
CURRENT_SINK=$(pactl get-default-sink)
EDIFIER="alsa_output.usb-BY_EDIFIER_EDIFIER_G2_II_GAMING_HEADSET_20190628-00.analog-stereo"
DEXP="bluez_output.F1:16:44:9C:55:30"

if [ "$CURRENT_SINK" == "$EDIFIER" ]; then
    pactl set-default-sink "$DEXP"
else
    pactl set-default-sink "$EDIFIER"
fi
