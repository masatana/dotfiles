zmodload zsh/regex
w # show uptime information and who is logged in
echo "" # for spacing
df -h -x tmpfs -x udev
echo ""
TMUX_LS=$(tmux ls 2>&1)
if [[ $TMUX_LS -regex-match "refused$" ]]; then
    echo -e "\e[1;31m No tmux windows! \e[m"
else
    echo -e "\e[1;31m Tmux detected! \e[m"
fi
