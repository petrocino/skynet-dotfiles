#!/bin/bash
## Install script for my dotfiles
## Author: Alessandro Petrocino
## Version: 2.2
## Date: 2025-02-18

## Config variables
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$DOTFILES_DIR/.config"
SHELL_DIR="$DOTFILES_DIR/shell"
ZSH_DIR="$CONFIG_DIR/oh-my-zsh"
P10K_DIR="$CONFIG_DIR/powerlevel10k"
P10K_REPO="https://github.com/romkatv/powerlevel10k.git"

# Detect OS
OS=""
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
elif [[ -f "/etc/os-release" ]]; then
    . /etc/os-release
    OS="$ID"
fi

echo -e "\033[0;32mDetected OS: $OS\033[0m"

# Function to create a symlink with backup
link_file() {
    local src=$1
    local dest=$2
    local backup_dir="$HOME/backup/env_deploy_backups"
    local timestamp
    timestamp=$(date +"%Y-%m-%dT%H:%M:%S")

    # Ensure the backup directory exists
    mkdir -p "$backup_dir"

    if [[ -e $dest || -L $dest ]]; then
        local backup_name="${backup_dir}/$(basename "$dest")_$timestamp.bak"
        echo "Backing up existing $dest to $backup_name"
        mv "$dest" "$backup_name"
    fi

    echo "🔗 Linking $src -> $dest"
    ln -s "$src" "$dest"
}

# Ensure .config directory exists
mkdir -p "$HOME/.config"

# Link Shell Configs (Zsh & Bash)
for file in .zshrc .zprofile .bashrc .bash_profile .profile .aliases .aliases.NASCO; do
    if [ -f "$SHELL_DIR/$file" ]; then
        link_file "$SHELL_DIR/$file" "$HOME/$file"
    else
        echo "File $SHELL_DIR/$file does not exist, skipping."
    fi
done


# Ensure .config directory exists
mkdir -p "$HOME/.config"


# Symlink Git config - Specific for Kyndryl Macbook Pro
myComputer=$(uname -n)

# Here, define the hostname of the Kyndryl Macbook Pro before run it
if [[ $myComputer == "JWTN2K-29C15FB2" ]]
then
    ln -sf $DOTFILES_DIR/git/macbook-pro-kyndryl/.gitconfig $HOME/.gitconfig
else
    echo ".gitconfig file - This is not the Macbook Pro at Kyndryl. Doing nothing here"
fi


# Clone Powerlevel10k if not present
if [[ ! -d "$P10K_DIR" ]]; then
    echo "Cloning Powerlevel10k to $P10K_DIR..."
    git clone --depth=1 "$P10K_REPO" "$P10K_DIR"
fi

# Link Powerlevel10k
link_file "$P10K_DIR" "$HOME/.config/powerlevel10k"

# Link Shell Configs (Zsh & Bash)
for file in .zshrc .zprofile .bashrc .bash_profile .profile; do
    link_file "$SHELL_DIR/$file" "$HOME/$file"
done

# Install dependencies
install_dependencies() {
    case "$OS" in
        macos)
            echo "Installing dependencies for macOS..."
            brew install zsh git bash fastfetch ghostty \
                        docker podman lazygit lazydocker 1password-cli \
                        htop btop tmux curl fzf ipcalc stow tldr neovim
            ;;
        rhel|centos|fedora)
            echo "Installing dependencies for RHEL/CentOS/Fedora..."
            sudo dnf install -y zsh git bash fastfetch podman lazygit \
                                lazydocker htop btop tmux curl fzf ipcalc \
                                stow tldr neovim

            # Install Docker (optional, since Fedora prefers Podman)
            sudo dnf install -y dnf-plugins-core
            sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
            sudo dnf install -y docker-ce docker-ce-cli containerd.io
            sudo systemctl enable --now docker
            ;;
        ubuntu|debian)
            echo "Installing dependencies for Ubuntu/Debian..."
            sudo apt update
            sudo apt install -y zsh git bash fastfetch podman lazygit \
                               lazydocker htop btop curl tmux fzf ipcalc \
                               stow tldr neovim

            # Install Docker
            sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
            echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
            sudo apt update
            sudo apt install -y docker-ce docker-ce-cli containerd.io
            sudo systemctl enable --now docker
            ;;
        arch)
            echo "Installing dependencies for Arch..."
            sudo pacman -Sy --noconfirm zsh git bash fastfetch podman lazygit \
                                      lazydocker htop btop curl tmux docker fzf ipcalc \
                                      stow tldr neovim
            sudo systemctl enable --now docker
            ;;
        kali)
            echo "Installing dependencies for Kali..."
            sudo apt update
            sudo apt install -y zsh git bash fastfetch podman lazygit \
                               lazydocker htop btop curl tmux fzf ipcalc \
                               stow tldr neovim
            ;;
        proxmox)
            echo "Installing dependencies for Proxmox..."
            sudo apt update
            sudo apt install -y zsh git bash fastfetch podman lazygit \
                               lazydocker htop btop curl tmux fzf ipcalc \
                               stow tldr neovim
            ;;
        truenas)
            echo "Skipping package installation on TrueNAS..."
            ;;
        *)
            echo "Unsupported OS: $OS"
            ;;
    esac
}

install_dependencies

echo "Setup complete! Restart your shell or run 'exec zsh' or 'exec bash'."