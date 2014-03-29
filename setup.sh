#!/bin/bash

readonly DOT_FILES=(.zshrc .vimrc .vim .tmux.conf .zshenv)

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
            rm -rf $HOME/$file
        fi
    done
else
    for file in ${DOT_FILES[@]}
    do
        ln -fvsn $HOME/dotfiles/$file $HOME/$file
    done
fi
