#!/usr/bin/env bash

# Paths to the driver and program lists
COMPRESSION_LIST="$PWD/compression.txt"
DRIVERS_LIST="$PWD/drivers.txt"
FONTS_LIST="$PWD/fonts.txt"
INTERFACE_LIST="$PWD/interface.txt"
TOOLS_LIST="$PWD/tools.txt"

# Dotfiles repository and destination directory
DOTFILES_REPO="https://github.com/jerryaugusto/dots" # Replace with your repository URL
DOTFILES_DIR="$HOME/dots"

# Function to display messages with colors
info() {
    echo -e "\e[1;34m[INFO] $1\e[0m"
}

success() {
    echo -e "\e[1;32m[SUCCESS] $1\e[0m"
}

error() {
    echo -e "\e[1;31m[ERROR] $1\e[0m"
}

# Check if paru is installed
info "Checking if 'paru' is installed..."
if ! command -v paru &> /dev/null; then
    error "'paru' not found. Installing now..."
    if sudo pacman -S --needed --noconfirm base-devel git && \
       git clone https://aur.archlinux.org/paru.git && \
       cd paru && makepkg -si --noconfirm && cd .. && rm -rf paru; then
        success "'paru' installed successfully."
    else
        error "Failed to install 'paru'. Check the logs."
        exit 1
    fi
else
    success "'paru' is already installed."
fi

# Update the system
info "Updating repositories and packages..."
if paru -Syu --noconfirm; then
    success "System updated successfully."
else
    error "Failed to update the system."
    exit 1
fi

# Install compression tools
if [[ -f $COMPRESSION_LIST ]]; then
    info "Installing compression tools listed in $COMPRESSION_LIST..."
    while read -r tool; do
        info "Installing tool: $tool"
        if paru -S "$tool" --noconfirm --needed; then
            success "Tool $tool installed successfully."
        else
            error "Failed to install tool $tool."
        fi
    done < "$COMPRESSION_LIST"
else
    error "File $COMPRESSION_LIST not found!"
fi

# Install drivers
if [[ -f $DRIVERS_LIST ]]; then
    info "Installing drivers listed in $DRIVERS_LIST..."
    while read -r driver; do
        info "Installing driver: $driver"
        if paru -S "$driver" --noconfirm --needed; then
            success "Driver $driver installed successfully."
        else
            error "Failed to install driver $driver."
        fi
    done < "$DRIVERS_LIST"
else
    error "File $DRIVERS_LIST not found!"
fi

# Install fonts
if [[ -f $FONTS_LIST ]]; then
    info "Installing fonts listed in $FONTS_LIST..."
    while read -r font; do
        info "Installing font: $font"
        if paru -S "$font" --noconfirm --needed; then
            success "Font $font installed successfully."
        else
            error "Failed to install font $font."
        fi
    done < "$FONTS_LIST"
else
    error "File $FONTS_LIST not found!"
fi

# Install interface
if [[ -f $INTERFACE_LIST ]]; then
    info "Installing interface listed in $INTERFACE_LIST..."
    while read -r interface; do
        info "Installing interface: $interface"
        if paru -S "$interface" --noconfirm --needed; then
            success "Interface $interface installed successfully."
        else
            error "Failed to install interface $interface."
        fi
    done < "$INTERFACE_LIST"
else
    error "File $INTERFACE_LIST not found!"
fi

# Install tools
if [[ -f $TOOLS_LIST ]]; then
    info "Installing tools listed in $TOOLS_LIST..."
    while read -r tool; do
        info "Installing tool: $tool"
        if paru -S "$tool" --noconfirm --needed; then
            success "Tool $tool installed successfully."
        else
            error "Failed to install tool $tool."
        fi
    done < "$TOOLS_LIST"
else
    error "File $TOOLS_LIST not found!"
fi

# Install programs
# if [[ -f $PROGRAMS_LIST ]]; then
#     info "Installing programs listed in $PROGRAMS_LIST..."
#     while read -r program; do
#         info "Installing program: $program"
#         if paru -S "$program" --noconfirm --needed; then
#             success "Program $program installed successfully."
#         else
#             error "Failed to install program $program."
#         fi
#     done < "$PROGRAMS_LIST"
# else
#     error "File $PROGRAMS_LIST not found!"
# fi

# Clone and sync dotfiles
info "Setting up dotfiles..."
if [[ ! -d $DOTFILES_DIR ]]; then
    info "Cloning dotfiles from repository $DOTFILES_REPO..."
    if git clone "$DOTFILES_REPO" "$DOTFILES_DIR"; then
        success "Dotfiles cloned successfully."
    else
        error "Failed to clone the dotfiles repository."
        exit 1
    fi
else
    info "Dotfiles directory already exists. Skipping cloning."
fi

info "Synchronizing dotfiles to ~/.config..."
if cp -r "$DOTFILES_DIR/"* "$HOME/.config/"; then
    success "Dotfiles synchronized successfully."
else
    error "Failed to synchronize dotfiles."
    exit 1
fi

# Apply additional configurations
info "Applying Fish shell configurations..."
if command -v fish &> /dev/null && fish -c "source $HOME/.config/fish/config.fish"; then
    success "Fish shell configurations applied."
else
    error "Failed to apply Fish shell configurations."
fi

# Finalization
info "All steps completed!"
success "Your system is ready with personalized configurations. 🚀"
