#!/bin/bash

readonly DOT_FILES=(zshrc vimrc vim tmux.conf zshenv vimperatorrc zprofile zlogout ipython zsh)
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
        if [ -e $HOME/$file ]; then
            rm -rf $HOME/$DOT$file
        fi
    done
else
    for file in ${DOT_FILES[@]}
    do
        ln -fvsn $HOME/dotfiles/$file $HOME/$DOT$file
    done
    # git setting (assume that git has been already installed)
    if [ ! -e $HOME/.gitconfig ]; then
        git config --global user.name "masatana"
        git config --global user.email "plaza.tumbling+github@gmail.com"
        git config --global color.ui auto
    fi
fi
