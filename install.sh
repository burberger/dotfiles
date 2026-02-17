#!/bin/bash
set -euo pipefail

TEMP_DIR=""
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/SourceCodePro.zip"
SYNTAX_HIGHLIGHTING_PATH=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
AUTOSUGGESTIONS_PATH=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

function cleanup {
    if [[ -d "$TEMP_DIR" ]]; then
        rm -rf "$TEMP_DIR"
    fi
}

function check_compatibility {
    # Fails if we're not running on fedora
    grep -q "ID=fedora" /etc/os-release
}

function install_packages {
    sudo dnf install -y \
        git \
        neovim \
        zsh \
        alacritty \
        lazygit
}

function setup_zsh_plugins {
    # Install oh-my-zsh if our login shell is bash
    if [[ "$SHELL" == "/bin/bash" ]]; then
        sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
    fi

    # ZSH Plugins which are separately manually managed
    if [[ ! -d $SYNTAX_HIGHLIGHTING_PATH ]]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$SYNTAX_HIGHLIGHTING_PATH"
    fi

    if [[ ! -d $AUTOSUGGESTIONS_PATH ]]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions "$AUTOSUGGESTIONS_PATH"
    fi
}

function setup_font {
    # https://docs.fedoraproject.org/en-US/quick-docs/fonts/#user-fonts
    TEMP_DIR=$(mktemp -d)
    wget -P "$TEMP_DIR" $FONT_URL
    unzip "$TEMP_DIR/SourceCodePro.zip" -d "$TEMP_DIR"
    mkdir -p "$HOME/.local/share/fonts"
    cp "$TEMP_DIR/SauceCodeProNerdFontMono-Regular.ttf" "$HOME/.local/share/fonts"
    # Update font cache
    fc-cache
}

function create_link {
    # Only creates link if it doesn't already exist
    if [[ ! -e "$2" ]]; then
        ln -s "$1" "$2"
    fi
}

function create_links {
    WORKING_DIR=$(pwd)
    create_link "$WORKING_DIR/zshrc" "$HOME/.zshrc"
    create_link "$WORKING_DIR/alacritty" "$HOME/.config/alacritty"
    create_link "$WORKING_DIR/nvim" "$HOME/.config/nvim"
}

function full_install {
    install_packages
    setup_zsh_plugins
    setup_font
    create_links
}

function update {
    sudo dnf update
    omz update

    CURRENT_DIR=$(pwd)
    cd "$SYNTAX_HIGHLIGHTING_PATH"
    git pull
    cd "$AUTOSUGGESTIONS_PATH"
    git pull
    cd "$CURRENT_DIR"
}

# Always clean up any generated temp files on exit.
trap cleanup EXIT
check_compatibility

# No arguments, run a full install
if [[ "$#" -eq "0" ]]; then
    full_install
    exit
fi

while [[ "$#" -gt 0 ]]; do
    case $1 in
        "install_packages" )
            install_packages
            ;;
        "setup_zsh_plugins" )
            setup_zsh_plugins
            ;;
        "setup_font" )
            setup_font
            ;;
        "create_links" )
            create_links
            ;;
        "update" )
            update
            ;;
        "--help" | "-h" )
            echo "Usage: $0 [install_stage] [--help] [-h]"
            echo "Installs and configures tools. If run with no arguments will run all install stages."
            echo ""
            echo "Valid install stages:"
            echo "  install_packages - Installs system packages from dnf"
            echo "  setup_zsh_plugins - Installs oh-my-zsh and external ZSH plugins"
            echo "  setup_font - Install monospace nerd font"
            echo "  create_links - Symbolic link to each config file in the repo from its expected location"
            echo "  update - Update plugins"
            ;;
        * )
            "Invalid argument: $1"
            exit 1
            ;;
    esac
    shift
done

