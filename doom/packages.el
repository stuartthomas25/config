;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)

;(package! zotero :recipe
          ;(:host github
           ;:repo "emacsmirror/zotero"))
(package! dashboard)
  ; :recipe (:local-repo "~/src/emacs-dashboard"))

; (package! zotelo)
;; (package! zotero
;;   :recipe (:local-repo "~/Desktop/emacs-zotero"))
(package! helm-bibtex)
(package! org-ref)
;; (package! org-latex-impatient)
;; (package! ob-julia-vterm)
(package! ob-julia-vterm :recipe
  (:host github
   :repo "stuartthomas25/ob-julia-vterm.el"
   :branch "patch-2"
   :files ("*.el")))
(package! org-auto-tangle)
(package! wolfram-mode)
(package! ob-mathematica)
;; (package! ewal)
(package! org-modern :pin "4afaa86c51b1f0b41c2a6ea8199befeb7c55eeb2")
(package! org-inline-pdf)
(package! org-roam-server)
(package! julia-quail :recipe (:host github :repo "stuartthomas25/julia-quail"))
(package! polymode)
(package! arxiv-mode)
(package! calibredb)
(package! slurm-mode)
(package! lean4-mode :recipe
  (:host github
   :repo "leanprover/lean4-mode"
   :files ("*.el" "data")))
