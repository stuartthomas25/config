(setq user-full-name "Stuart Nathan Thomas"
      user-mail-address "snthomas@umd.edu")

;; (when (not (string-equal system-type "darwin"))
;;     (disable-packages! macos))

(defun snt/pdf-relabel ()
  (interactive)
  (shell-command (format "~/bin/pdfrelabel %d \"%s\"" (pdf-view-current-page) (buffer-file-name)))
  (revert-buffer))

(defun update-pdf-colors ()
  (interactive)
  (setq pdf-view-midnight-colors
        (cons (face-attribute 'default :foreground) (face-attribute 'default :background)))
  (setq pdf-view-midnight-invert nil))


;; (add-hook 'pdf-view-mode-hook 'pdf-view-midnight-minor-mode)

(after! pdf-tools (update-pdf-colors))

(map! :mode pdf-view-mode (:n "C-h" 'pdf-view-align-left) (:n "C-l" 'pdf-view-align-right))

(add-hook 'doom-load-theme-hook 'update-pdf-colors 100) ;; depth=100 ensure last

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "Fira Code" :size 12)
      doom-variable-pitch-font (font-spec :family "Fira Code")
      doom-unicode-font (font-spec :family "Fira Code")
      doom-big-font (font-spec :family "Fira Code" :size 19))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme (if (file-exists-p "~/.light") 'doom-gruvbox-light 'doom-gruvbox))

;; (use-package! doom-ewal-themes)

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)


(add-hook 'doom-switch-buffer-hook #'hide-mode-line-mode)
;; (global-hide-mode-line-mode -1)
(map! :leader :desc "Toggle Doom Mode Line" :g "d" (lambda () (interactive) (global-hide-mode-line-mode 'toggle)))

;; (map! :n "RET" #'(lambda () (interactive) (evil-open-below 1) (evil-force-normal-state)))
;; (map! :n "S-RET" #'(lambda () (interactive) (evil-open-above 1) (evil-force-normal-state)))

;; (map! (:when (not buffer-read-only)
;;  :n "RET" #'(lambda () (interactive) (evil-open-below 1) (evil-force-normal-state))
;;  :n "S-RET" #'(lambda () (interactive) (evil-open-above 1) (evil-force-normal-state))))

(setq display-line-numbers-type 'visual)
(setq doom-inhibit-large-file-detection t)

(map! :n "Q" #'evil-record-macro)
(map! :n "q" #'kill-current-buffer)

(modify-syntax-entry ?- "w" emacs-lisp-mode-syntax-table)
(modify-syntax-entry ?_ "w" emacs-lisp-mode-syntax-table)

(setq evil-split-window-below t
      evil-vsplit-window-right t)

(map! :leader :desc "Switch window focus" :g "k" #'other-window)

;; (map! :desc "Next Tab" :rn "J" #'+workspace/switch-right)
;; (map! :desc "Previous Tab" :rn "K" #'+workspace/switch-left)

(map! :leader :desc "Next Tab" :g "l" #'+workspace/switch-right)
(map! :leader :desc "Previous Tab" :g "L" #'+workspace/switch-left)

(map! :leader :desc "Swap Workspace Left" :g "TAB L" #'+workspace/swap-right)
(map! :leader :desc "Swap Workspace Right" :g "TAB H" #'+workspace/swap-left)

(map! :n "M-RET" #'(lambda () (interactive) (+evil/insert-newline-above 1) (evil-next-line)))
(map! :n "RET" #'(lambda () (interactive) (+evil/insert-newline-below 1) (evil-next-line)))

(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

(use-package! julia-quail)

;; Enable the www ligature in every possible major mode
(set-ligatures! 't '("www"))

;; Enable ligatures in programming modes
(set-ligatures! 'prog-mode '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\" "{-" "::"
                                     ":::" ":=" "!!" "!=" "!==" "-}" "----" "-->" "->" "->>"
                                     "-<" "-<<" "-~" "#{" "#[" "##" "###" "####" "#(" "#?" "#_"
                                     "#_(" ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*" "/**"
                                     "/=" "/==" "/>" "//" "///" "&&" "||" "||=" "|=" "|>" "^=" "$>"
                                     "++" "+++" "+>" "=:=" "==" "===" "==>" "=>" "=>>" "<="
                                     "=<<" "=/=" ">-" ">=" ">=>" ">>" ">>-" ">>=" ">>>" "<*"
                                     "<*>" "<|" "<|>" "<$" "<$>" "<!--" "<-" "<--" "<->" "<+"
                                     "<+>" "<=" "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<"
                                     "<~" "<~~" "</" "</>" "~@" "~-" "~>" "~~" "~~>" "%%"))

(map! :leader :desc "Open Terminal" :g "j" #'multi-term)
(map! :leader :desc "Open eshell" :g "e" 'eshell)
(global-unset-key [remap delete-frame])
(map! :leader :desc "Close Frame" :r "q f" #'delete-frame)

(map! :desc "Next buffer" :g "<mouse-9>" #'next-buffer)
(map! :desc "Next buffer" :g "<mouse-8>" #'previous-buffer)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook 'org-hide-block-all)
(add-hook 'org-mode-hook '(lambda () (require 'org-ref)))

(after! org
        (setq org-startup-indented t)
        (setq org-startup-with-latex-preview  t)
        (setq org-startup-with-inline-images t)
        (plist-put org-format-latex-options :scale 1.5))


(defun org-latex-preview-buffer ()
  (interactive)
  (org-latex-preview '(16)))
(map! (:map org-mode-map :localleader :desc "Preview LaTeX in buffer" "L" #'org-latex-preview-buffer))
(map! (:map org-mode-map :localleader :desc "Preview LaTeX at point" "j" #'org-latex-preview))

(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode))

(use-package! org-modern)
(add-hook 'org-mode-hook #'org-modern-mode)
(add-hook 'org-agenda-finalize-hook #'org-modern-agenda)
;; (add-hook 'org-mode-hook #'org-inline-pdf-mode)

(setq org-babel-julia-command "julia --sysimage ~/.julia/sysimages/sys_itensors.so")

(defun snt/s-truncate (LEN STR)
  " like s-truncate but adds spaces if the string is shorter than LEN"
  (let ((stem (s-truncate LEN STR)))
    (concat stem (s-repeat (- LEN (length stem)) " "))))

(defun snt/parse-msg (msg)
    (let ((subject (plist-get msg :subject))
          (from (plist-get (car (plist-get msg :from)) :name)))
      (concat (snt/s-truncate 20 from) " | " (snt/s-truncate 50 subject))))

(defun snt/get-new-msgs ()
  (let ((output (car (read-from-string (concat "(" (shell-command-to-string "mu find flag:unread --format=sexp") ")")))))
    (if (listp (car output)) output '())))


(defun snt/dashboard-insert-mail (list-size)
    (let ((data (snt/get-new-msgs)))
        (dashboard-insert-section
            "Mail"
            ;; (butlast msgs (- (length msgs) list-size))
            (butlast data (- (length data) list-size))
            list-size
            'mail
            "m"
            `(lambda (&rest _) (mu4e-view-message-with-message-id (plist-get ',el :message-id)))
            (format "%s" (snt/parse-msg el)))))


  (use-package! dashboard
    :init      ;; tweak dashboard config before loading it
    (setq dashboard-set-heading-icons t)
    (setq dashboard-set-file-icons t)
    ;; (setq dashboard-banner-logo-title "\nKEYBINDINGS:\nOpen dired file manager  (SPC .)\nOpen buffer list         (SPC b i)\nFind recent files        (SPC f r)\nOpen the eshell          (SPC e s)\nToggle big font mode     (SPC t b)")
    ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
    (setq dashboard-item-names '(("Recent Files:" . "Recently opened files:")
			         ("Agenda:" . "Things to do:")
			         ("Projects:" . "Recent Projects:")))
    (setq dashboard-startup-banner (concat doom-private-dir "doom-emacs-dash.png"))  ;; use custom image as banner
    (setq dashboard-banner-logo-title nil)

    (setq dashboard-center-content t) ;; set to 't' for centered content
    (setq dashboard-items
          '(
            (recents . 10)
            (projects . 5)
            (agenda . 15)
            (mail . 5)))

    (setq dashboard-match-agenda-entry "/+TODO")
    (setq dashboard-agenda-time-string-format "%a, %b %d")
    (setq dashboard-agenda-time-string-format "%a, %b %d")
    (setq dashboard-agenda-prefix-format "(%(projectile-project-name)) %i %-12:c %s ")
    (setq dashboard-agenda-sort-strategy '(time-up todo-state-up))
    :config
    (dashboard-modify-heading-icons '((mail . "mail")))
    (add-to-list 'dashboard-item-generators  '(mail . snt/dashboard-insert-mail))
    (dashboard-setup-startup-hook)
    (setq dashboard-set-footer nil)
    (setq dashboard-force-refresh t)
    (setq dashboard-set-init-info nil)
    (setq dashboard-filter-agenda-entry 'dashboard-filter-agenda-by-todo)
                                        ;(add-hook 'dashboard-mode-hook #'dashboard-refresh-buffer)
    (dashboard-modify-heading-icons '((recents . "file-text")
				      (bookmarks . "book")))
    (push (lambda (f)
	    (with-selected-frame  f (dashboard-refresh-buffer)))
	  after-make-frame-functions)
    (setq doom-fallback-buffer-name "*dashboard*"))

(after! mu4e
  (set-email-account!
   "umd"
   '((mu4e-sent-folder       . "/umd/[Gmail]/Sent Mail")
     (mu4e-drafts-folder       . "/umd/[Gmail]/Drafts")
     (mu4e-trash-folder      . "/umd/[Gmail]/Bin")
     (smtpmail-smtp-user     . "snthomas@umd.edu"))
   t)

  (setq org-msg-signature "

#+begin_signature
Best wishes, \\\\
Stuart Thomas (he/him) \\\\
snthomas@umd.edu \\\\
+1 (407) 701-7788
#+end_signature")


  (setq mu4e-get-mail-command "mbsync umd"
        ;; get emails and index every 5 minutes
        mu4e-update-interval 300
        ;; send emails with format=flowed
        mu4e-compose-format-flowed t
        ;; don't need to run cleanup after indexing for gmail
        mu4e-index-cleanup t
        mu4e-index-lazy-check nil)
  ;; more sensible date format
  ;; (mu4e-headers-date-format "%d.%m.%y")
  (after! auth-source (setq auth-sources (nreverse auth-sources)))
  ;; tell message-mode how to send mail
  (setq message-send-mail-function 'smtpmail-send-it)
  ;; if our mail server lives at smtp.example.org; if you have a local
  ;; mail-server, simply use 'localhost' here.
  (setq smtpmail-smtp-server "smtp.google.com")


  (defvar my-mu4e-account-alist
    '(("umd"
       (mu4e-sent-folder "/umd/[Gmail]/Sent Mail")
       (user-mail-address "snthomas@umd.edu")
       (smtpmail-smtp-user "snthomas@umd.edu")
       (smtpmail-local-domain "gmail.com")
       (smtpmail-default-smtp-server "smtp.gmail.com")
       (smtpmail-smtp-server "smtp.gmail.com")
       (smtpmail-smtp-service 587)
       )
      ;; Include any other accounts here ...
      ))

  ;; (setq mu4e-compose-context-policy 'pick-first)
  (defun my-mu4e-set-account ()
    "Set the account for composing a message.
    This function is taken from:
        https://www.djcbsoftware.nl/code/mu/mu4e/Multiple-accounts.html"
    (let* ((account
            (if mu4e-compose-parent-message
                (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
                  (string-match "/\\(.*?\\)/" maildir)
                  (match-string 1 maildir))
              (completing-read (format "Compose with account: (%s) "
                                       (mapconcat #'(lambda (var) (car var))
                                                  my-mu4e-account-alist "/"))
                               (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
                               nil t nil nil (caar my-mu4e-account-alist))))
           (account-vars (cdr (assoc account my-mu4e-account-alist))))
      (if account-vars
          (mapc #'(lambda (var)
                    (set (car var) (cadr var)))
                account-vars)
        (error "No email account found"))))
  (add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)
  (mu4e-update-mail-and-index t))

(require 'mu4e)

(setq gnus-blocked-images nil)

(add-hook 'mu4e-main-mode-hook #'(lambda () (mu4e~headers-jump-to-maildir "/umd/INBOX")))
(remove-hook 'mu4e-main-mode-hook #'evil-collection-mu4e-update-main-view)
(remove-hook 'mu4e-main-mode-hook #'+mu4e-init-h)

(map! :leader :desc "Open Mu4e" :g "o m" 'mu4e)

(map! :desc "Search forward in PDF" :n "g P" #'pdf-sync-forward-search)

(after! tex-mode
        (add-to-list 'tex--prettify-symbols-alist '("\\left(" . 10222))
        (add-to-list 'tex--prettify-symbols-alist '("\\right)" . 10223))
        (add-to-list 'tex--prettify-symbols-alist '("\\sqrt" . 08730))
        (add-to-list 'tex--prettify-symbols-alist '("\\sqrt" . 08730)))

(setq org-latex-src-block-backend 'listings)

(map! :i "C-(" (lambda ()
                (interactive)
                (insert "\\left(  \\right)")
                (if (eq (point) (line-end-position))
                        (evil-backward-char 7)
                        (evil-backward-char 8))))
;; (use-package! org-latex-impatient
;;   :defer t
;;   :hook (org-mode . org-latex-impatient-mode)
;;   :init
;;   (setq org-latex-impatient-tex2svg-bin
;;         ;; location of tex2svg executable
;;         "~/node_modules/mathjax-node-cli/bin/tex2svg"))

(setq LaTeX-default-environment "equation")
(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)

(setq TeX-arg-right-insert-p nil)
(setq TeX-electric-sub-and-superscript nil)

(after! tex
    (push '(output-pdf "PDF Tools") TeX-view-program-selection))

(setq bibtex-completion-pdf-field "File")

(defun my/bibtex-open-pdf (url &optional other)
  (message "Loading PDF...")
  (open-link url (concat (file-name-as-directory bibtex-completion-library-path) key ".pdf")))

(setq bibtex-completion-browser-function 'my/bibtex-open-pdf)


(defun my/find-bib ()
  (interactive)
  (let ((root (projectile-acquire-root)))
    (setq bibtex-completion-library-path (concat root "references")
          bibtex-completion-bibliography (concat root "bib.bib"))))

(defun my/open-bib ()
  (interactive)
  (my/find-bib)
  (helm-bibtex-with-local-bibliography))

(map! :leader :desc "Open helm-bibtex" :g "z" 'my/open-bib)

(setq bibtex-autokey-titlewords 0)
(setq bibtex-autokey-titleword-length 0)
(setq bibtex-autokey-year-title-separator "")
(setq bibtex-autokey-year-length 4)
(setq biblio-bibtex-use-autokey t)


 (setq bibtex-completion-fallback-options '(
  ("CrossRef                                  (biblio.el)" lambda
  (search-expression)
  (biblio-lookup #'biblio-crossref-backend search-expression))
 ("arXiv                                     (biblio.el)" lambda
  (search-expression)
  (biblio-lookup #'biblio-arxiv-backend search-expression))
 ;; ("DBLP (computer science bibliography)      (biblio.el)" lambda
 ;;  (search-expression)
 ;;  (biblio--lookup-1 #'biblio-dblp-backend search-expression))
 ;; ("HAL (French open archive)                 (biblio.el)" lambda
 ;;  (search-expression)
 ;;  (biblio--lookup-1 #'biblio-hal-backend search-expression))
 ("IEEE                                      (biblio.el)" lambda
  (search-expression)
  (biblio--lookup-1 #'biblio-ieee-backend search-expression))
 ("Google Scholar                            (web)" . "https://scholar.google.co.uk/scholar?q=%s")
 ;; ("Pubmed                                    (web)" . "https://www.ncbi.nlm.nih.gov/pubmed/?term=%s")
 ;; ("Bodleian Library                          (web)" . "http://solo.bodleian.ox.ac.uk/primo_library/libweb/action/search.do?vl(freeText0)=%s&fn=search&tab=all")
 ;; ("Library of Congress                       (web)" . "https://www.loc.gov/search/?q=%s&all=true&st=list")
 ;; ("Deutsche Nationalbibliothek               (web)" . "https://portal.dnb.de/opac.htm?query=%s")
 ;; ("British National Library                  (web)" . "http://explore.bl.uk/primo_library/libweb/action/search.do?&vl(freeText0)=%s&fn=search")
 ;; ("Bibliothèque nationale de France          (web)" . "http://catalogue.bnf.fr/servlet/RechercheEquation?host=catalogue?historique1=Recherche+par+mots+de+la+notice&niveau1=1&url1=/jsp/recherchemots_simple.jsp?host=catalogue&maxNiveau=1&categorieRecherche=RechercheMotsSimple&NomPageJSP=/jsp/recherchemots_simple.jsp?host=catalogue&RechercheMotsSimpleAsauvegarder=0&ecranRechercheMot=/jsp/recherchemots_simple.jsp&resultatsParPage=20&x=40&y=22&nbElementsHDJ=6&nbElementsRDJ=7&nbElementsRCL=12&FondsNumerise=M&CollectionHautdejardin=TVXZROM&HDJ_DAV=R&HDJ_D2=V&HDJ_D1=T&HDJ_D3=X&HDJ_D4=Z&HDJ_SRB=O&CollectionRezdejardin=UWY1SPQM&RDJ_DAV=S&RDJ_D2=W&RDJ_D1=U&RDJ_D3=Y&RDJ_D4=1&RDJ_SRB=P&RDJ_RLR=Q&RICHELIEU_AUTRE=ABCDEEGIKLJ&RCL_D1=A&RCL_D2=K&RCL_D3=D&RCL_D4=E&RCL_D5=E&RCL_D6=C&RCL_D7=B&RCL_D8=J&RCL_D9=G&RCL_D10=I&RCL_D11=L&ARSENAL=H&LivrePeriodique=IP&partitions=C&images_fixes=F&son=S&images_animees=N&Disquette_cederoms=E&multimedia=M&cartes_plans=D&manuscrits=BT&monnaies_medailles_objets=JO&salle_spectacle=V&Monographie_TN=M&Periodique_TN=S&Recueil_TN=R&CollectionEditorial_TN=C&Ensemble_TN=E&Spectacle_TN=A&NoticeB=%s")
 ;; ("Gallica Bibliothèque Numérique            (web)" . "http://gallica.bnf.fr/Search?q=%s")

 ))

(defconst doi-regex "10\\.[0-9]\\{4,5\\}\\/[^;, {}]+")

(defun my/doi-to-reference ()
  (interactive)
  (let ((line (thing-at-point 'line t)))
    (string-match doi-regex line)
    (let ((doi (match-string 0 line)))
      (kill-whole-line)
      (biblio-doi-insert-bibtex doi))))

(map! (:map bibtex-mode-map :localleader "d" :desc "Replace DOI in line with Bibtex reference" #'my/doi-to-reference))

(defconst stumacs-urls-to-avoid '("scitation" "link.aps.org/article/"))

;; returns t if retrieved successfully
(defun display-pdf (url &optional fname)
  (message (concat "Retrieving " url))
  (unless (-any? (lambda (m) (string-match-p m url)) stumacs-urls-to-avoid)
    (let ((buffer (url-retrieve-synchronously url nil nil 5))
          (filename (if fname fname (make-temp-file "stumacs" nil ".pdf"))))
      (when (and buffer (equal 200 (url-http-symbol-value-in-buffer 'url-http-response-status buffer)))
        (message "Successfully retrieved PDF")
        (with-current-buffer buffer
            (goto-char (point-min))
            (re-search-forward "^$")
            (write-region (point) (point-max) filename))
        (find-file filename)
        t))))

(defun callback (status &optional fname)
  "Uri callback.
STATUS: the status"
  ;; remove headers
  (message "Recieved search results...")
  (message status)
  (goto-char url-http-end-of-headers)
  ;; (print status)
  ;; (print (plist-get status :error))
  (let* ((json (json-read))
         (pdf-links (cdr (assoc 'link (assoc 'message json))) ))
    (advice-add 'url-http-handle-authentication :around #'ignore)
    (catch 'success
      (seq-doseq (link pdf-links)
        (let ((url (cdr (assoc 'URL link))))
           (message "%s" (concat "Trying " url))
          (if (display-pdf url fname) (throw 'success t))))
      (message "Unsuccessful"))
  (advice-remove 'url-http-handle-authentication #'ignore)))

(defun open-doi (doi &optional fname)
  (interactive "sDOI: ")
  (message "Opening DOI: %s" doi)
  (url-retrieve (url-encode-url (format "http://api.crossref.org/v1/works/%s\n" doi)) 'callback (list fname) t t))

(defun open-arxiv (arxivid &optional fname)
  (interactive "sArXiv Id: ")
  (message "Opening ArXiv article: %s" arxivid)
  (display-pdf (format "https://arxiv.org/pdf/%s.pdf" arxivid) fname))


(defun open-link (uri &optional fname default-open-function)
  "Open a doi link.
 URI: the uri"
  (interactive "sURI: ")
  (message "Opening link: %s" uri)
  (unless default-open-function (setq default-open-function #'browse-url-default-browser))
  (cond ((string-match doi-regex uri) (open-doi (match-string 0 uri) fname))
        ;; ((string-match doi-regex uri) (open-doi (concat "10.1038/" (match-string 1 uri)) fname))
        ((string-match "[0-9]\\{4\\}\\.[0-9]\\{5\\}\\(v[0-9]+\\)*$" uri) (open-arxiv (match-string 0 uri) fname))
        ((string-match "arxiv:\\([-a-z]+\\/[0-9]\\{7\\}\\(v[0-9]+\\)*\\)$" uri) (open-arxiv (match-string 1 uri) fname)) ;;old style, identifier
        ((string-match "arxiv\\.org\\/abs\\/\\([-a-z]+\\/[0-9]\\{7\\}\\(v[0-9]+\\)*\\)$" uri) (open-arxiv (match-string 1 uri) fname)) ;; old style, url
        ( t (funcall default-open-function uri))))

(setq pdf-links-browse-uri-function 'open-link)
(url-handler-mode 1)

(setq browse-url-browser-function #'open-link)

(setq conda-env-home-directory "/opt/miniforge3")
(setq conda-anaconda-home "/opt/miniforge3")

(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match
that used by the user's shell.

This is particularly useful under Mac OS X and macOS, where GUI
apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string
              "[ \t\n]*$" "" (shell-command-to-string
                      "$SHELL --login -i -c 'echo $PATH'"
                            ))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-shell-PATH)

;; https://emacs.stackexchange.com/questions/18775/how-to-get-a-fully-functional-julia-repl-in-emacs
(defun my/julia-repl ()
  "Runs Julia in a screen session in a `term' buffer."
  (interactive)
  (require 'term)
  ;; (let ((termbuf (apply 'make-term "Julia REPL" "screen" nil (split-string-and-unquote "arch -x86_64 /usr/local/bin/julia"))))
  (let ((termbuf (apply 'make-term "Julia REPL" "screen" nil (split-string-and-unquote "/Applications/Julia-1.8.app/Contents/Resources/julia/bin/julia --sysimage /Users/stuart/.julia/sysimages/sys_itensors.so"))))
    (set-buffer termbuf)
    (term-mode)
    (term-char-mode)
    (switch-to-buffer termbuf)))

(setq term-escape-char [24])

(setq term-scroll-to-bottom-on-output t)


(defvar ob-julia-prompt "julia>")
(defvar my/ob-julia-end-of-input nil)
;; (after! ob-julia
;;   (defun org-babel-execute:julia (body params)
;;     (let* ((buffname (cdr (assoc :session params)))
;;            (proc (get-process (replace-regexp-in-string "\*" "" buffname)))
;;            (sendstr (concat " \n" (dired-replace-in-string "\n" "\e\n " body) "\n"))
;;            (buffersize 100)
;;            (cursor 0))
;;       (with-current-buffer (get-buffer buffname) (evil-insert 1))
;;       (while (< cursor (length sendstr))
;;         (term-send-string buffname (substring sendstr cursor (min (length sendstr) (+ cursor buffersize))))
;;         (setq cursor (+ cursor buffersize))
;;         (sleep-for 0.))
;;       (setq my/ob-julia-end-of-input (point)))))
(require 'vterm)
(use-package! ob-julia-vterm)
(add-to-list 'org-babel-load-languages '(julia-vterm . t))
(add-to-list 'org-babel-load-languages '(bibtex . t))
(org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)

(after! ob-julia
    (defalias 'org-babel-execute:julia 'org-babel-execute:julia-vterm))

(defun org-babel-execute:bibtex (BODY PARAMS)
  (open-link BODY)
  nil)


;; (defun my/ob-julia-callback (arg)
;;   (print arg)
;;   (seq-doseq (buff my/waiting-buffers)
;;     (with-current-buffer (get-buffer "*Julia REPL*")
;;       (beginning-of-line)
;;       (if (not (string-equal ob-julia-prompt (replace-regexp-in-string "[ \t\n]*\\'" "" (buffer-substring (point) (point-max)))))
;;         (message "Done!")
;;         (setq my/waiting-buffers (remove buff my/waiting-buffers))))))

(add-hook 'julia-mode-hook (lambda () (set-input-method 'julia)))

;; (add-to-list window-buffer-change-functions 'my/ob-julia-callback)
;; (setq window-buffer-change-functions '(my/ob-julia-callback doom-run-switch-buffer-hooks-h))
;;

(after! flycheck
        (setq flycheck-check-syntax-automatically (delq 'idle-change flycheck-check-syntax-automatically))) ;; this conflicts with tramp

(setq rmh-elfeed-org-files '("~/org/elfeed.org"))
(add-hook! 'elfeed-search-mode-hook 'elfeed-update)
(after! elfeed
  (setq elfeed-search-filter "+arxiv"))

(map! :leader :desc "Open Elfeed" :g "o x" '=rss)

;; (defun my/link-advice (oldbrowse link)
;;   (interactive)
;;   (open-link link nil oldbrowse))
;; (advice-add 'browse-url :around 'my/link-advice)

(after! projectile
  (setq projectile-indexing-method 'alien)
  (setq projectile-enable-caching nil)
  (add-to-list 'projectile-other-file-alist '("tex" "pdf"))
  (add-to-list 'projectile-other-file-alist '("pdf" "tex"))
  (setq projectile-project-search-path '(("~/Projects" . 3))))
