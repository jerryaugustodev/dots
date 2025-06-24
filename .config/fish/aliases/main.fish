#Navigation
alias Downloads 'cd $HOME/Downloads'
alias Documents 'cd $HOME/Documents'
alias Videos 'cd $HOME/Videos'
alias dev 'cd $HOME/dev'

# Eza
alias ls 'eza --icons --long'

alias l 'ls -l'
alias la 'ls --all'
alias lt 'ls --tree'
alias ld 'eza --only-dirs --icons --group-directories-first --header --all'
alias lg 'eza --git --git-ignore --icons --group-directories-first --header --long --all'

# Work
alias hrg 'history | rg'
alias left 'ls -t -1'
alias cnt 'find . -type f | wc -l'
alias cpv 'rsync -ah --info=progress2'
alias fdir 'find . -type d -name'
alias ff 'find . -type f -name'
alias rt 'mv --force -t ~/.local/share/Trash '
alias rm 'rm -i'
alias rmf 'rm -rf'
alias free 'free -h'
alias du 'du -sh'
alias disk 'df -h | rg nvme0n1p2 \
    | sed -e "s_/dev/sda[1-9]_\x1b[34m&\x1b[0m_" \
    | sed -e "s_/dev/sd[b-z][1-9]_\x1b[33m&\x1b[0m_" \
    | sed -e "s_[,0-9]*[MG]_\x1b[36m&\x1b[0m_" \
    | sed -e "s_[0-9]*%_\x1b[32m&\x1b[0m_" \
    | sed -e "s_9[0-9]%_\x1b[31m&\x1b[0m_" \
    | sed -e "s_/mnt/[-_A-Za-z0-9]*_\x1b[34;1m&\x1b[0m_"'
alias preview 'fzf --height=50% --layout=reverse --preview="bat --color=always {}"'

# Git
alias sgit 'cd `git rev-parse --show-toplevel` && git checkout master && git pull'
alias cg 'cd "git rev-parse --show-toplevel"'
# alias gst 'git status'
# alias ga 'git add .'
# alias gk 'git checkout'
# alias gc 'git commit'
# alias gm 'git commit -m'
# alias gp 'git pull'
# alias gpr 'git pull --rebase'
# alias gps 'git push'
# alias gl 'git log --oneline --decorate --color --graph'
# alias gb 'git log --show-signature -1'
# alias nah 'git reset --soft HEAD-1'
# alias wip 'git add .;git commit -m "wip" > /dev/null'
# alias gclean 'git branch --merged | ripgrep -v "\*" | xargs -n 1 git branch -d'
# alias gr 'git reset HEAD^'

# Dev tolls
alias pm pnpm
alias yolo 'rm -rf node_modules/ && rm package-lock.json && pm install'
alias playground 'cd ~/workstation/playground/ && eza -a'
alias study 'cd ~/workstation/study/ && eza -a'
alias lzd lazydocker
alias lzg lazygit

# alias break 'pomo break'
# alias work 'pomo work'
# alias -g G '| ripgrep'

# Bookmarks
alias dl 'cd ~/Downloads && eza --long --all'
alias doc 'cd ~/Documents && eza -la'
alias space 'cd ~/workspace && eza -la'
alias dfs 'cd ~/dotfiles && clear && lg -G'

#Shortcuts
alias :q exit

# Emacs
alias emacs "emacsclient -c -a 'emacs'"

# Vim
# alias v vim
alias vi neovide
alias vim nvim
# alias vim nvim

# Biome
# alias biomejs biome

# alias pls "please"
# alias sudoedit "pleaseedit"
alias cat bat
# alias pip 'pip3'
alias af asdf
alias ranger superfile
alias sf superfile
# alias pomo 'pomo.sh'
alias curl curlie
alias c curl

alias p pass
alias fullcycle 'pass show -c courses/fullcycle'
alias twitch 'pass show -c personal/twitch'

# Docker
alias dra 'docker stop $(docker ps -aq) && docker rmi $(docker images -q) -f && docker image prune && docker container prune && docker network prune'

# alias proto 'protoc --go_out=application/grpc/pb --go_opt=paths=source_relative --go-grpc_out=application/grpc/pb --go-grpc_opt=paths=source_relative --proto_path=application/grpc/protofiles application/grpc/protofiles/*.proto'

# alias acento 'setxkbmap -model abnt -layout us -variant intl'

alias copy 'xclip -selection clipboard'
alias paste 'xclip -selection clipboard -o'

alias mp3-dl 'yt-dlp --ignore-config --extract-audio \
    --audio-format "mp3" --audio-quality 0 --embed-thumbnail --embed-metadata \
    --output "$HOME/Downloads/%(title)s.%(ext)s"'

alias mp4-dl 'yt-dlp --ignore-config --format best --embed-thumbnail \
    --add-metadata --metadata-from-title "%(artist)s - %(title)s" \
    --output "$HOME/Videos/%(title)s.%(ext)s"'

# alias wx-config 'wx-config-gtk2'

alias reload 'source ~/.config/fish/aliases/main.fish'

# Wezterm
# alias wezterm='flatpak run org.wezfurlong.wezterm'

# Doto
alias doto='sudo systemctl set-default performance; sudo systemctl disable bluetooth; sudo systemctl disable cups'
