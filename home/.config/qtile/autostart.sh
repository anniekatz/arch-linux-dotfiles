#!/bin/bash

#function run {
#  if ! pgrep $1 ;
#  then
#    $@&
#  fi
#}


nitrogen --restore &
picom -b --config $HOME/.config/picom/picom.conf &
lxsession &
volumeicon &

# Autostart apps taken care of by LightDM currently
#nm-applet &
#optimus-manager-qt &
