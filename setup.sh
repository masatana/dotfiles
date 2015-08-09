#!/bin/bash

readonly DOT_FILES=(vimrc vim tmux.conf ipython gvimrc screenrc)
readonly DOT="."

while getopts u OPT
do
    case $OPT in
        "u" ) FLG_UNINSTALL="TRUE";;
    esac
done

if [ $FLG_UNINSTALL ]; then
    for file in ${DOT_FILES[@]}
    do
        if [ -e $HOME/$DOT$file ]; then
            rm -r $HOME/$DOT$file
        fi
    done
    exit 0
fi

# Set dotfiles
for file in ${DOT_FILES[@]}
do
    ln -fvsn $HOME/dotfiles/$file $HOME/$DOT$file
done

# git setting (assume that git has been already installed)
if [ ! -e $HOME/.gitconfig ]; then
    git config --global user.name "masatana"
    git config --global user.email "plaza.tumbling@gmail.com"
    git config --global color.ui auto
    git config --global core.editor vim
fi

# I like neobundle.vim
if [ ! -e $HOME/.vim/bundle/neobundle.vim/README.md ]; then
    wget https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh
    sh ./install.sh
fi

if [ ! -d $HOME/.oh-my-zsh ] && type curl; then
    curl -L http://install.ohmyz.sh | sh
fi
