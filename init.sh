#!/bin/bash
git submodule update --init --recursive
# find $CONFIG -name "*.org" -exec emacs -q --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "{}")' \;

emacscommands=$(find $CONFIG -name "*.org" | awk '{print "(ignore-errors (org-babel-tangle-file \"" $0 "\"))"}' | paste -s -d' ');
emacs -q --batch --eval "(require 'org)" --eval "(progn $emacscommands)"

if ! [[ -e ~/.vim/autoload/plug.vim ]]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
vim +PlugInstall +qall
