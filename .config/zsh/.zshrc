#!/usr/bin/env zsh

export PROMPT=$'%F{white}%~ %B%F{red}>%f%b '
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"

# bindkey -e
set -o emacs

setopt HIST_SAVE_NO_DUPS
autoload -Uz compinit && compinit

_comp_options+=(globdots)
source $ZDOTDIR/plugins/completion.zsh

# Created by `pipx` on 2026-01-06 11:53:29

# pnpm
export PNPM_HOME="/home/braam/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/home/braam/.opam/opam-init/init.zsh' ]] || source '/home/braam/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration
