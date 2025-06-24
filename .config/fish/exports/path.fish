# Bun
if test -e $HOME/.bun/bin
  set -gx PATH $HOME/.bun/bin $PATH
end

# Local
if test -e $HOME/.local/bin
  set -gx PATH $HOME/.local/bin $PATH
end

# Cargo Rust
if test -e $HOME/.cargo/bin
    set -gx PATH $HOME/.cargo/bin $PATH
end

# Golang
if test -e $HOME/go/bin
  set -gx PATH $HOME/go/bin $PATH
end
