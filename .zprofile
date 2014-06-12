zmodload zsh/regex
w # show uptime information and who is logged in
echo "" # for spacing
TMUX_LS=$(tmux ls 2>&1)
if [[ $TMUX_LS -regex-match "refused$" ]]; then
    echo -e "\e[1;31m There are some tmux windows! \e[m"
fi
