#!/usr/bin/bash
find $HOME/.config -name "*.org" -exec emacs -q --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "{}")' \;

