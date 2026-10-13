#!/usr/bin/env fish
timer $argv[1] && notify-send $argv[2] $argv[3]
