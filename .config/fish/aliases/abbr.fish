# Natigation
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr .3 'cd ../../..'
abbr .4 'cd ../../../..'
abbr .5 'cd ../../../../..'
abbr 1 'cd -'
abbr 2 'cd -2'
abbr 3 'cd -3'
abbr 4 'cd -4'
abbr 5 'cd -5'

abbr ~ 'cd $HOME'
# abbr -- 'cd -'

# Git stuffs
abbr ga "git add"
abbr gc "git commit --verbose -m"
abbr gp "git push"
abbr gpl "git pull"
abbr gpr "git pull --rebase origin main"
abbr gco "git checkout"
abbr gs "git status"

# Docker
abbr d docker
abbr ds 'docker stop $(docker ps -aq)'
abbr dri 'docker rmi $(docker images -q) -f'
abbr drm 'docker rm $(docker ps -aq) -f'

# Tmux
abbr tn "tmux new -s (pwd | sed 's/.*\///g')"
