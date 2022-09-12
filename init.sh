#!/bin/bash
git submodule update --init --recursive
find $HOME/.config -name "*.org" -exec emacs -q --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "{}")' \;

