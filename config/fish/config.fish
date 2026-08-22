set -gx PATH "$HOME/.local/bin" $PATH
mise activate fish | source

/opt/homebrew/bin/brew shellenv fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g j_path "$HOME/Projects"

starship init fish | source
enable_transience

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

bind  'up-line'       # Cmd + i
bind  'down-line'     # Cmd + k
bind  'forward-char' # Cmd + l
bind  'backward-char' # Cmd + j
bind  'backward-word' # Cmd + u
bind  'forward-word' # Cmd + o
