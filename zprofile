zmodload zsh/regex
w # show uptime information and who is logged in
echo "" # for spacing

if [ -e "$HOME/Dropbox" -a `uname` = "Linux" ]; then
    ifconfig > "$HOME/Dropbox/`date +%Y-%m-%d`@$HOST.txt"
fi
