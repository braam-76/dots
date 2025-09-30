# function fish_greeting
# 	screenfetch
# end

set -U fish_user_paths $HOME/.local/share/pnpm $fish_user_paths

zoxide init fish | source
starship init fish | source

# Created by `pipx` on 2025-09-25 18:17:07
set PATH $PATH /home/braam/.local/bin
