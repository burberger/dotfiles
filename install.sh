#!/bin/bash
set -euxo pipefail

function install_packages {
    sudo dnf install -y \
        git \
        neovim \
        zsh \
        alacritty
}

function setup_zsh_plugins {
    # ZSH Plugins
    SYNTAX_HIGHLIGHTING_PATH=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    AUTOSUGGESTIONS_PATH=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    if [[ ! -d $SYNTAX_HIGHLIGHTING_PATH ]]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $SYNTAX_HIGHLIGHTING_PATH
    fi

    if [[ ! -d $AUTOSUGGESTIONS_PATH ]]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions $AUTOSUGGESTIONS_PATH
    fi
}

function setup_fonts {
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/SourceCodePro.zip
    unzip SourceCodePro.zip
}

function create_link {
    if [[ ! -e "$2" ]]; then
        ln -s $1 $2
    fi
}

function create_links {
    WORKING_DIR=`pwd`
    create_link $WORKING_DIR/zshrc $HOME/.zshrc
    create_link $WORKING_DIR/alacritty $HOME/.config/alacritty
    create_link $WORKING_DIR/nvim $HOME/.config/nvim
}

install_packages
setup_zsh_plugins
#setup_fonts
create_links
