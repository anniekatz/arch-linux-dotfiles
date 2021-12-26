#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias vim='nvim'
alias sudo='sudo '

#PS1='[\u@\h \W]\$ '
PS1="\e[0;35m[\u@\h \W]\$ \e[m "

neofetch
