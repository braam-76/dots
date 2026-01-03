#!/usr/bin/env zsh

bindkey -e

setopt HIST_SAVE_NO_DUPS
autoload -Uz compinit; compinit

_comp_options+=(globdots)
source $ZDOTDIR/plugins/completion.zsh
