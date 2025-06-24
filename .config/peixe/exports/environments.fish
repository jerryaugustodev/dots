# Language
set -gx LANG en_US.utf8
set -gx LC_ALL en_US.utf8

# Fish
set -x SHELL /usr/bin/fish

# Opts
set -U fish_auto_suggestion on

# GPG TTY
set -gx GPG_TTY (tty)

# Vim
set -gx EDITOR neovide
set -gx ALTERNATIVE_EDITOR ""
set -gx VISUAL ""
# Neovide 0.13.0 terminal attachment (bug?)feature
set -x NEOVIDE_FORK 1

# Terminal type
set -x TERM xterm-256color

# Starts tmux
set -g fish_tmux_autostart true

# Anaconda
# set _CONDA_ROOT /opt/anaconda

## THEMING
# set -Ux BAT_THEME Catppuccin-mocha
set -Ux BAT_THEME Kanagawa

set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#223249,bg:#1F1F28,spinner:#C8C093,hl:#C34043 \
--color=fg:#DCD7BA,header:#C34043,info:#957FB8,pointer:#C8C093 \
--color=marker:#C8C093,fg+:#DCD7BA,prompt:#957FB8,hl+:#C34043"

set -Ux SKIM_DEFAULT_OPTIONS "$SKIM_DEFAULT_OPTIONS \
--color=fg:#DCD7BA,bg:#1F1F28,matched:#223249,matched_bg:#f2cdcd,current:#DCD7BA,current_bg:#45475a,current_match:#1F1F28,current_match_bg:#C8C093,spinner:#a6e3a1,info:#957FB8,prompt:#89b4fa,cursor:#C34043,selected:#eba0ac,header:#94e2d5,border:#6c7086"
