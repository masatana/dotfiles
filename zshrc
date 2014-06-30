export OUTPUT_CHARSET=utf8
case ${UID} in
    0)
        LANG=C
    ;;
esac

source $HOME/.zsh/git-prompt.sh

# autoload settings
autoload -U compinit && compinit
autoload -Uz colors
autoload history-search-end

# export settings
# for go lang
#if [ -x "`which go`" ]; then
#    export GOROOT=`go env GOROOT`
#    export GOPATH=$HOME/go
#    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
#fi

# const  settings
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
SSH_ENV=$HOME/.ssh/environment

# prompt settings
setopt PROMPT_SUBST
setopt TRANSIENT_RPROMPT
precmd () {
    RPROMPT='$(__git_ps1 "[%s]")'
}
PROMPT="[%n@%{$fg_bold[blue]%}${HOST}] %F{blue}%/% %f "
PROMPT2="%_%% "

# setopt settings
setopt hist_ignore_dups
setopt share_history
setopt extended_history
setopt hist_reduce_blanks
setopt auto_cd
setopt auto_pushd
setopt nolistbeep
setopt pushd_ignore_dups
setopt hist_ignore_space
setopt noflowcontrol
setopt complete_aliases
stty -ixon

# alias settings
alias grep="grep --color=auto"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i -v"
alias du="du -h"
alias df="df -h"
alias vimrc="vim ~/.vimrc"
alias tree="tree -N"
alias ls="ls -lh"
alias ipy="ipython3 --pylab"

# zle settings
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# bindkey settings
bindkey -e
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


# settings for each enviornments
case "`uname`" in
    Darwin)
        if [ -d /Applications/MacVim.app/ ]; then
            alias mvim='/Applications/MacVim.app/Contents/MacOS/mvim'
        fi
    ;;
    Linux)
        alias ls="ls --color=auto -lh" # for debian
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

        # ssh settings
        if [ -f "${SSH_ENV}" ]; then
            . ${SSH_ENV} > /dev/null
            ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
                start_agent;
            }
        else
            start_agent;
        fi
        alias -s {png,jpg,bmp,PNG,JPG,BMP}=ristretto
    ;;
esac

# Define function
function chpwd() { ls -Glh }

# local settings (e.g. password)
[[ -s $HOME/.zshrc.local ]] && source "$HOME/.zshrc.local"