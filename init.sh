#!/bin/bash
git submodule update --init --recursive
find $HOME/.config -name "*.org" -exec emacs -q --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "{}")' \;


curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall > /dev/null 2>&1
