#!/bin/bash

# Table of dotfiles to register
FILES="
.tmux.conf
.vimrc
.zshrc
"

# Link each file in home
for f in $FILES
do
    echo $f
    ln -s `pwd`/$f $HOME/$f
done

# Install packages
sudo apt install vim-gtk3 zsh tmux build-essential

# Vim plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qall

# ZSH syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
