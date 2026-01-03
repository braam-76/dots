#!/usr/bin/env zsh

export PROMPT=$'%F{white}%~ %B%F{red}>%f%b '
export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export EDITOR="emacs -nw"
export VISUAL="emacs"

export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000
