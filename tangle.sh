#!/usr/bin/bash
find $HOME/.config -name "*.org" -exec emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "{}")' \;

