# Dotfiles

This repository contains my personal dotfiles for configuring various tools and applications on Unix-like systems.

## Included Configurations

Currently, this repository includes:

- `tmux.conf`: Configuration for the tmux terminal multiplexer
- `.vimrc`: Configuration for the Vim text editor

## Setup

### Prerequisites

- Git
- [Stow](https://www.gnu.org/software/stow/)
- Zsh (recommended)

### Installation

1. Clone this repository:
   ```
   git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
   ```

2. Navigate to the dotfiles directory:
   ```
   cd ~/dotfiles
   ```

3. Run the setup script:
   ```
   ./setup.sh
   ```

   This script will:
   - Install Homebrew and necessary packages (on macOS)
   - Set up Oh My Zsh
   - Configure tmux and its plugins
   - Use stow to symlink the dotfiles to your home directory

### Manual Stow Usage

If you prefer to stow files manually:

```
stow --target=$HOME tmux vim
```

This will symlink the tmux and vim configurations to your home directory.

## Customization

Feel free to modify any of the dotfiles to suit your preferences. After making changes, you may need to:

- Source your `.zshrc` file: `source ~/.zshrc`
- Reload tmux configuration: `tmux source-file ~/.tmux.conf`

## Todo

- [ ] Add `.aliases` file
- [ ] Include `.zshrc` configuration
- [ ] Set up Powerline
- [ ] Add more tool configurations (e.g., git, ssh)

## Contributing

If you have suggestions for improvements, feel free to open an issue or submit a pull request.
