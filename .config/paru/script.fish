#!/usr/bin/env fish

# Paths to the driver and program lists
set DRIVERS_LIST "drivers.txt"
set PROGRAMS_LIST "programs.txt"

# Dotfiles repository and destination directory
set DOTFILES_REPO "https://github.com/jerryaugusto/dots" # Replace with your repository URL
set DOTFILES_DIR "~/dots"

# Function to display highlighted messages
function info
    echo -e "\033[1;34m[INFO] $argv\033[0m"
end

function success
    echo -e "\033[1;32m[SUCCESS] $argv\033[0m"
end

function error
    echo -e "\033[1;31m[ERROR] $argv\033[0m"
end

# Check if paru is installed
info "Checking if 'paru' is installed..."
if not command -v paru >/dev/null
    error "'paru' not found. Installing now..."
    if sudo pacman -S --needed --noconfirm base-devel git && git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si --noconfirm && cd ..
        success "'paru' installed successfully."
    else
        error "Failed to install 'paru'. Check the logs."
        exit 1
    end
else
    success "'paru' is already installed."
end

# Update the system
info "Updating repositories and packages..."
if paru -Syu --noconfirm
    success "System updated successfully."
else
    error "Failed to update the system."
    exit 1
end

# Install drivers
if test -f $DRIVERS_LIST
    info "Installing drivers listed in $DRIVERS_LIST..."
    for driver in (cat $DRIVERS_LIST)
        info "Installing driver: $driver"
        if paru -S $driver --noconfirm --needed
            success "Driver $driver installed successfully."
        else
            error "Failed to install driver $driver."
        end
    end
else
    error "File $DRIVERS_LIST not found!"
end

# Install programs
if test -f $PROGRAMS_LIST
    info "Installing programs listed in $PROGRAMS_LIST..."
    for program in (cat $PROGRAMS_LIST)
        info "Installing program: $program"
        if paru -S $program --noconfirm --needed
            success "Program $program installed successfully."
        else
            error "Failed to install program $program."
        end
    end
else
    error "File $PROGRAMS_LIST not found!"
end

# Clone and sync dotfiles
info "Setting up dotfiles..."
if not test -d $DOTFILES_DIR
    info "Cloning dotfiles from repository $DOTFILES_REPO..."
    if git clone $DOTFILES_REPO $DOTFILES_DIR
        success "Dotfiles cloned successfully."
    else
        error "Failed to clone the dotfiles repository."
        exit 1
    end
else
    info "Dotfiles directory already exists. Skipping cloning."
end

info "Synchronizing dotfiles to ~/.config..."
if cp -r $DOTFILES_DIR/* ~/.config/
    success "Dotfiles synchronized successfully."
else
    error "Failed to synchronize dotfiles."
    exit 1
end

# Apply additional configurations
info "Applying Fish shell configurations..."
if fish -c "source ~/.config/fish/config.fish"
    success "Fish shell configurations applied."
else
    error "Failed to apply Fish shell configurations."
end

# Finalization
info "All steps completed!"
success "Your system is ready with personalized configurations. 🚀"
