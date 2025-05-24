#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
#PS1='[\u@\h \W]\$ '
alias vim="nvim"
alias sudo='sudo '
alias upd='yay -Syu && sudo flatpak update && sudo flatpak upgrade'
alias mkinit='sudo mkinitcpio -p linux'
alias reflect='sudo systemctl start reflector'

#PS1='[\u@\h \W]\$ '
#PS1="\e[0;31m[\u@\h \W]\$ \e[m "
PS1="\[\e[0;31m\][\u@\h \W]\$ \[\e[m\] "

neofetch

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
