# My dotfiles (no dependency version)

## How to Setup

```sh
$ mkdir ~/dotfiles
$ git clone git@github.com:masatana/dotfiles.git ~/dotfiles
$ cd dotfiles
$ chmod 700 setup.sh
$ ./setup.sh
$ vim ~/.vimrc
```

or, just copy and paste ;)

## How to Uninstall

```sh
$ ./setup.sh -u
```

## Xubuntu setting

```bash
$ cp ./terminalrc ~/.config/xfce4/terminal/terminalrc

## Note
If you want to write sensitive information, please write it in .vimrc.local

