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
export LSCOLORS=gxfxcxdxbxegedabagacag
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'
export CLICOLOR=true

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}


if ! type vim > /dev/null 2>&1
then
    alias vim=vi
fi
