# PFetch
# if test -e $HOME/.config/pfetch/pfetchrc
#     set -gx PF_SOURCE "$HOME/.config/pfetch/pfetchrc"
# end

# Starship
if test -e $HOME/dots/.config/starship/starship.toml
    set -gx STARSHIP_CONFIG "$HOME/dots/.config/starship/starship.toml"
end
