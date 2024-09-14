#!/bin/bash

set -e

DOTFILES_DIR="$HOME/dotfiles"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install Homebrew and packages
install_homebrew_and_packages() {
    echo "Checking and installing Homebrew and packages..."
    if ! command_exists brew; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # Add Homebrew to PATH if it's not already there
    if ! command_exists brew; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    packages=(
        zsh tmux curl stow zoxide bat ripgrep eza fzf
        zsh-autosuggestions zsh-syntax-highlighting ngrok thefuck yt-dlp
    )

    for pkg in "${packages[@]}"; do
        if ! brew list --formula | grep -q "^${pkg}\$"; then
            brew install "$pkg"
        fi
    done
}

# Function to setup Oh My Zsh
setup_oh_my_zsh() {
    echo "Setting up Oh My Zsh..."
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    # Add zsh plugins to .zshrc
    echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"
    echo "source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> "$HOME/.zshrc"
}

# Function to setup tmux and its plugins
setup_tmux() {
    echo "Setting up tmux and its plugins..."
    mkdir -p "$HOME/.tmux/plugins"
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    fi
    tmux source "$HOME/.tmux.conf" 2>/dev/null || true
}

# Function to install tmux plugins
install_tmux_plugins() {
    echo "Installing tmux plugins..."
    # Start a temporary tmux session
    tmux new-session -d -s __temp

    # Install plugins
    "$HOME/.tmux/plugins/tpm/bin/install_plugins"

    # Kill the temporary tmux session
    tmux kill-session -t __temp

    echo "Tmux plugins have been installed."
}

# Function to setup stow and symlink dotfiles
setup_stow_and_dotfiles() {
    echo "Setting up stow and symlinking dotfiles..."
    cd "$DOTFILES_DIR" || exit 1

    # Create necessary directories
    mkdir -p "$HOME/.config"

    # Use stow to symlink dotfiles
    stow --restow --target="$HOME" tmux vim zsh
}

# Main execution
main() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        install_homebrew_and_packages
    else
        echo "This script is designed for macOS. Please install required packages manually on your system."
    fi

    setup_oh_my_zsh
    setup_tmux
    setup_stow_and_dotfiles
    install_tmux_plugins

    echo "Setup complete! Please restart your terminal or source your .zshrc to apply changes."
}

main
