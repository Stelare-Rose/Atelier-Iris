#!/usr/bin/env fish
timer $argv[1] && notify-send $argv[2] $argv[3]
pw-play "$HOME/.sounds/notify1.wav"
pw-play "$HOME/.sounds/notify2.wav"
