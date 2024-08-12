if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    for pkg in zsh tmux curl stow; do
        if ! brew list --formula | grep -q "^${pkg}\$"; then
            brew install "$pkg"
        fi
    done

    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
fi

git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
tmux source "$HOME/.tmux.conf"
