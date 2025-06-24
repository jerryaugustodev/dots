# Oh-my-posh
# oh-my-posh init fish | source
# oh-my-posh init fish --config $HOME/dots/.config/oh-my-posh/themes/kanagawa.omp.json | source

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
if test -f $HOME/dots/.config/fish/themes/Kanagawa.fish
    source $HOME/dots/.config/fish/themes/Kanagawa.fish
end

# Automatically spawn "Warpify" subshells
# if status is-interactive
#     printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "fish"}}\x9c'
# end

# set -Ux FZF_TMUX_OPTS "-p 55%,60%"
# apt install: pacman -S.
# apt remove: pacman -Rs.
# apt autoremove: pacman -Qdtq | pacman -Rs -.
# apt autoclean: pacman -Scc.
# apt search: pacman -Ss.

# functions --copy fish_prompt fish_prompt_orig; function fish_prompt; fish_prompt_orig; echo; end

# bun
# set --export BUN_INSTALL "$HOME/.bun"
# set --export PATH $BUN_INSTALL/bin $PATH

# Starship
starship init fish | source

# Zoxide cd alternative
zoxide init fish | source

# mise
#mise activate fish | source
