eval "$(/opt/homebrew/bin/brew shellenv)"

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g j_path "$HOME/Projects"

starship init fish | source
enable_transience

source ~/.asdf/asdf.fish
