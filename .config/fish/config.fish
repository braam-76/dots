if status is-interactive
# Commands to run in interactive sessions can go here
end

direnv hook fish | source
zoxide init fish | source
starship init fish | source

# uv
fish_add_path "/home/braam/.local/bin"
