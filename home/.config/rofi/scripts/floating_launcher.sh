#!/usr/bin/env bash

theme="style_11"
dir="$HOME/.config/rofi/themes/"

rofi -no-lazy-grab -show drun -modi drun -theme $dir/"$theme"
