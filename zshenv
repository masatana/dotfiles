# -*- coding: utf-8 -*-
if [ -z "$LANG" ]; then
    export LANG=en_US.UTF-8
fi

# ignore duplicate path
typeset -U path

if [ -x "`which go`" ]; then
    export GOROOT=`go env GOROOT`
    export GOPATH=$HOME/go
fi

path=(
    $HOME/bin/bin(N-/)
    $HOME/bin(N-/)
    $HOME/.cabal/bin(N-/)
    $HOME/go/bin
    /usr/local/bin(N-/)
    /usr/local/sbin(N-/)
    /usr/bin(N-/)
    /bin(N-/)
    /usr/sbin(N-/)
    /sbin(N-/)
    $path
)

export EDITOR=vim
export KCODE=u
export LSCOLORS=exfxcxdxbxegedabagacad
export CLICOLOR=true


if ! type vim > /dev/null 2>&1
then
    alias vim=vi
fi
