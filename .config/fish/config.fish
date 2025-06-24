# Environments
if test -f $HOME/dots/.config/fish/exports/environments.fish
    source $HOME/dots/.config/fish/exports/environments.fish
end

# Abbr & Aliases
if test -f $HOME/dots/.config/fish/aliases/main.fish
    source $HOME/dots/.config/fish/aliases/main.fish
end

if test -f $HOME/dots/.config/fish/aliases/abbr.fish
  source $HOME/dots/.config/fish/aliases/abbr.fish
end

# Load private config
if test -f $HOME/dots/.config/fish/functions/private.fish
    source $HOME/dots/.config/fish/functions/private.fish
end

# PATH configurations
if test -f $HOME/dots/.config/fish/exports/path.fish
    source $HOME/dots/.config/fish/exports/path.fish
end

# Files
if test -f $HOME/dots/.config/fish/exports/files.fish
    source $HOME/dots/.config/fish/exports/files.fish
end

# Theme
if test -f $HOME/dots/.config/fish/themes/Kanagawa.theme
    source $HOME/dots/.config/fish/themes/Kanagawa.theme
end

# Ghostty
if test -f $GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish
  source $GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish
end

# Starship
starship init fish | source

# Zoxide cd alternative
zoxide init fish | source

# mise
#mise activate fish | source
