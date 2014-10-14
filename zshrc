export OUTPUT_CHARSET=utf8
source $HOME/.zsh/git-prompt.sh

# autoload settings
autoload -U compinit && compinit
autoload -Uz colors
autoload history-search-end

# const  settings
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
SSH_ENV=$HOME/.ssh/environment

# prompt settings
setopt PROMPT_SUBST
precmd () {
    PROMPT="%{$fg_bold[green]%}[%n@%m] %F{green}%/% %f
$(__git_ps1 '[%s]')%# %{${reset_color}%}"
}
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
colors
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
alias tmux="TERM=screen-256color-bce tmux"

# zle settings
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# bindkey settings
bindkey -e
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# zstyle
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " _-./;@"
zstyle ':zle:*' word-style unspecified


# settings for each enviornments
case "`uname`" in
    Darwin)
        if [ -d /Applications/MacVim.app/ ]; then
            alias mvim='/Applications/MacVim.app/Contents/MacOS/mvim'
        fi
    ;;
    Linux)
        alias ls="ls --color=auto -lh" # for debian
        alias -s {png,jpg,bmp,PNG,JPG,BMP}=ristretto
        alias -s {pdf}=evince
    ;;
esac

# Define function
function chpwd() { ls -Glh }

# local settings (e.g. password)
[[ -s $HOME/.zshrc.local ]] && source "$HOME/.zshrc.local"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
