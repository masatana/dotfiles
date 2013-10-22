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

# zshのコマンド履歴を管理する
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups # コマンド履歴が重複しないようにする
setopt share_history # コマンド履歴を共有する
setopt hist_reduce_blanks

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end



# PROMPTの表示を変える e.g. /user/home
PROMPT="
%{$fg_bold[blue]%}${HOST} %F{blue}%/% %f
[%n]$ "
# export PROMPT="%{$fg_bold[blue]%}${HOST} $PROMPT"
PROMPT2="%_%% "
# SPROMPT="%r is correct? [n,y,a,e]: "
# export CLICOLOR=1
# export LSCOLORS=ExFxCxDxBxegedabagacad
# ホスト毎にホスト名の部分の色を作る

# その他オプション
setopt auto_cd # ディレクトリ名のみで移動できる
setopt auto_pushd # これまでに移動したディレクトリが一覧表示される
# setopt correct # 自動修正機能
setopt nolistbeep # 音を鳴らさない
autoload -Uz colors
export LSCOLORS=exfxcxdxbxegedabagacad
alias grep="grep --color=auto"

alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i -v"

case "`uname`" in
    Darwin)
        if [ -d /Applications/MacVim.app/ ]; then
            alias mvim='/Applications/MacVim.app/Contents/MacOS/mvim'
        fi
        # 何かこの形式だとUbuntu上のzshで色がつかない
        alias ls="ls -G -lh"
        # alias python2="python"
        alias py3="python3"
        export PATH=$PATH:/usr/local/Cellar/ruby/2.0.0-p247/bin:/usr/local/bin/
    ;;
    Linux)
        alias ls="ls --color=auto -lh"
    ;;
esac

export PATH=$PATH:$HOME/.cabal/bin/
<<<<<<< HEAD

TRAPEXIT() {
    ssh-agent -k
}
=======
export GOROOT="/usr/local/Cellar/go/1.1.2"
>>>>>>> 9d0aef984e814efcf8228a73ceb425d3fcb9aed4
