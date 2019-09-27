#!/bin/bash

# Shell safeguard for non-interactive .bashrc circumstances
# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILESIZE=2000
HISTSIZE=1000000
# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
HISTFILE=~/.bash_history_actual

# append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
export LESSOPEN="|/usr/loca/bin/lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1
# switch the commented lines if OS is ubuntu
# [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# NOTE: .bashrc is intended for use in interactive, non-login shells.
# Custom aliases, functions, and shell configurations sourced here.
export CFG="/home/$USER/cfg"
[[ -f "$HOME/.os" ]] && source "$HOME/.os"
[[ -f "$HOME/.colors" ]] && source "$HOME/.colors"

# aliases
for aa in "$CFG/aliases/".[^.]*
do
  DIR="$( cd "$( dirname "$HOME/$aa" )" >/dev/null 2>&1 && pwd )"
  [[ -f "$DIR/$aa" ]] && source "$DIR/$aa"
done

# custom functions & aliases
for custom_cfg in "$CFG/custom/".[^.]*
do
  DIR="$( cd "$( dirname "$HOME/$custom_cfg" )" >/dev/null 2>&1 && pwd )"
  [[ -f "$DIR/$custom_cfg" ]] && source "$DIR/$custom_cfg"
done


# configure bash color prompt
export PATH="$PATH:/usr/local/bin/"
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export PS1='[${blu}\u${red}@${grn}\h:${nc}\W]🌱 '


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
