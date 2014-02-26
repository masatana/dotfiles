export OUTPUT_CHARSET=utf8
case ${UID} in
    0)
        LANG=C
    ;;
esac

autoload -U compinit && compinit

#Set language enviornment to Japanese UTF-8.
export LANG=ja_JP.UTF-8
export EDITOR=vim
export KCODE=u

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups
setopt share_history
setopt hist_reduce_blanks

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


setopt auto_cd
function chpwd() { ls -Glh }
setopt auto_pushd
setopt nolistbeep
autoload -Uz colors
export LSCOLORS=exfxcxdxbxegedabagacad
alias grep="grep --color=auto"
export CLICOLOR=true

alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i -v"
alias du="du -h"
alias df="df -h"
alias vimrc="vim ~/.vimrc"
alias tree="tree -N"

PROMPT="
%{$fg_bold[blue]%}${HOST} %F{blue}%/% %f
[%n]$ "
PROMPT2="%_%% "

case "`uname`" in
    Darwin)
        if [ -d /Applications/MacVim.app/ ]; then
            alias mvim='/Applications/MacVim.app/Contents/MacOS/mvim'
        fi
        alias ls="ls -G -lh"
        alias py3="python3"
        export PATH=$PATH:/usr/local/Cellar/ruby/2.0.0-p247/bin:/usr/local/bin
    ;;
    Linux)
        alias ls="ls --color=auto -lh"
        export PATH=$PATH:/home/masatana/bin/src/go/bin
    ;;
esac

# for haskell
export PATH=$PATH:$HOME/.cabal/bin

# for go lang
if [ -x "`which go`" ]; then
    export GOROOT=`go env GOROOT`
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi


SSH_ENV=$HOME/.ssh/environment
function start_agent {
    echo "Initializing new SSH agent..."
    /usr/bin/ssh-agent | sed 's/~echo/#echo/' > ${SSH_ENV}
    echo succeeded
    chmod 600 ${SSH_ENV}
    . ${SSH_ENV} > /dev/null
    /usr/bin/ssh-add
    /usr/bin/ssh-add $HOME/.ssh/bitbucket_id_rsa
    /usr/bin/ssh-add $HOME/.ssh/github_id_rsa
}

if [ -f "${SSH_ENV}" ]; then
    . ${SSH_ENV} > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi


# tmux (auto start)
# comment out: there is a bug when use `tmux a` then `protocol version mismatch (client 7, server 6) on fast04
##[[ -z "$TMUX" && ! -z "$PS1" ]] && tmux
#is_tmux_running() {
#    [ ! -z "$TMUX" ]
#}
#has_shell_started_interactively() {
#    [ ! -z "$PS1" ]
#}
#
#resolve_alias() {
#    cmd="$1"
#    while
#        whence "$cmd" >/dev/null 2>/dev/null && [ "$(whence "$cmd")" != "$cmd" ]
#    do
#        cmd=$(whence "$cmd")
#    done
#    echo "$cmd"
#}
#if ! is_tmux_running && has_shell_started_interactively; then
#    for cmd in tmux; do
#        if whence $cmd >/dev/null 2>/dev/null; then
#            $(resolve_alias "$cmd")
#            break
#        fi
#    done
#fi

# local settings (e.g. password)
[[ -s $HOME/.zshrc.local ]] && source "$HOME/.zshrc.local"
