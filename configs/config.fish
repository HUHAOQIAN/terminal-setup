if status is-interactive
    # Abbreviations (modern replacements for common commands)
    abbr -a ls "eza --icons --group-directories-first"
    abbr -a ll "eza -la --icons --group-directories-first"
    abbr -a lt "eza --tree --icons --level=2"
    abbr -a cat "bat"
    abbr -a find "fd"
    abbr -a grep "rg"
    abbr -a top "btop"
    abbr -a lg "lazygit"
    abbr -a cd "z"
end

fish_add_path /opt/homebrew/bin

# Starship prompt
source (/opt/homebrew/bin/starship init fish --print-full-init | psub)

# fnm (Node version manager)
fnm env --use-on-cd --shell fish | source

# SSH key switcher (fallback for multi-account setups)
# Usage: set-ssh-key lewis-official-20260224
# Prefer ~/.ssh/config Host aliases for automatic matching.
function set-ssh-key
    set -l key "$HOME/.ssh/$argv[1]"
    if not test -f "$key"
        echo "Key not found: $key" >&2
        echo "Available keys:" >&2
        for f in ~/.ssh/*.pub
            echo "  "(basename $f .pub) >&2
        end
        return 1
    end
    ssh-add -D 2>/dev/null
    ssh-add "$key"
    echo "Active SSH key: $argv[1]"
end

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
