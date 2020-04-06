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

# Relink vimrc for neovim
echo "Configuring nvim"
NVIM_PATH=$HOME/.config/nvim
if [ ! -d $NVIM_PATH ]
then
    mkdir -p $NVIM_PATH
fi
ln -s `pwd`/.vimrc $NVIM_PATH/init.vim

# Install packages
sudo apt install vim-gtk3 zsh tmux build-essential curl

# Vim plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing vim plugins"
vim +PlugInstall +qall
nvim +PlugInstall +UpdateRemotePlugins +qa

# ZSH syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
