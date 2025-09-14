function fish_greeting
	screenfetch
end

set -U fish_user_paths $HOME/.local/share/pnpm $fish_user_paths

zoxide init fish | source
starship init fish | source
