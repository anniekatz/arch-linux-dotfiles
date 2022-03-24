#!/bin/bash

#function run {
#  if ! pgrep $1 ;
#  then
#    $@&
#  fi
#}


lxsession &
nitrogen --restore &
#nm-applet &
optimus-manager-qt &
picom -b --config $HOME/.config/picom/picom.conf &
#volumeicon &
