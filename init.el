;;;;;;;; Straight bootstrap 
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


(setq visible-bell t)
(setq confirm-kill-emacs 'yes-or-no-p)
(setq show-paren-style 'expression)
;; (setq show-paren-when-point-inside-paren +1)
(set-default-coding-systems 'utf-8)     ; Default to utf-8 encoding
(prefer-coding-system       'utf-8)     ; Add utf-8 at the front for automatic detection.
(set-terminal-coding-system 'utf-8)     ; Set coding system of terminal output
(set-keyboard-coding-system 'utf-8)     ; Set coding system for keyboard input on TERMINAL
(set-language-environment "English")    ; Set up multilingual environment

;;;;;;;; Packages
(setq package-list
      '(cape                ; Completion At Point Extensions
        orderless           ; Completion style for matching regexps in any order
        vertico             ; VERTical Interactive COmpletion
        marginalia          ; Enrich existing commands with completion annotations
        consult             ; Consulting completing-read
        eglot
        corfu               ; Completion Overlay Region FUnction
        corfu-terminal
        denote
        ;; deft                ; Quickly browse, filter, and edit plain text notes
        ;; elpher              ; A friendly gopher and gemini client 
        ;; elfeed              ; Emacs Atom/RSS feed reader
        ;; elfeed-org          ; Configure elfeed with one or more org-mode files
        embark
        embark-consult
        f                   ; Modern API for working with files and directories
        ;;;;; Citations
        citar               ; Citation-related commands for org, latex, markdown
        citar-embark
        ;; citeproc            ; A CSL 1.0.2 Citation Processor
        ;; flyspell-correct-popup ; Correcting words with flyspell via popup interface
        ;; flyspell-popup      ; Correcting words with Flyspell in popup menus
        guess-language      ; Robust automatic language detection
        helpful             ; A better help buffer
        htmlize             ; Convert buffer text and decorations to HTML
        mini-frame          ; Show minibuffer in child frame on read-from-minibuffer
        imenu-list          ; Show imenu entries in a separate buffer
        magit               ; A Git porcelain inside Emacs.
        markdown-mode       ; Major mode for Markdown-formatted text
        multi-term          ; Managing multiple terminal buffers in Emacs.
        ;; pinentry            ; GnuPG Pinentry server implementation
        use-package         ; A configuration macro for simplifying your .emacs
        ;; vc-backup           ; VC backend for versioned backups
        yaml-mode           ; YAML mode
        ;; consult-recoll      ; Consult interface for recoll query
        org-auto-tangle     ; Tangle org file when it is saved
        org-appear
        exec-path-from-shell; Get environment variables such as $PATH from the shell 
        which-key
        guru-mode
        ligature
        rainbow-mode
        aggressive-indent
        ;; Lsp-mode
        ;; lsp-pyright
        flycheck
        ;;;;; elixir packages
        elixir-mode
        exunit
        alchemist
        ;;;;; python packages
        anaconda-mode
        blacken
        numpydoc
        pyvenv
        ;;;;; scheme
        geiser
        geiser-guile
        geiser-racket
        ;;;;; lisp
        sly
        sly-asdf
        sly-quicklisp
        sly-repl-ansi-color))

;; Install packages that are not yet installed
(dolist (package package-list)
  (straight-use-package package))

(straight-use-package
'(nano-emacs :type git :host github :repo "rougier/nano-emacs"))

;; NANO theme
;; (straight-use-package
;; '(nano-theme :type git :host github :repo "rougier/nano-theme"))

(require 'nano)
;; (require 'nano-theme-dark)
(setq nano-font-family-monospaced "JetBrainsMono NF")
(setq nano-font-size 13)
(nano-faces)
;; (nano-theme-light)

;; ;; Special case for pdf-tools that has recently (2022) changed maintainer
;; (straight-use-package
;;  '(pdf-tools :type git :host github :repo "vedang/pdf-tools"))
;;
;;
;; ;; Display org properties in the agenda buffer (modified version)
;; (straight-use-package
;;  '(org-agenda-property :type git :host github :repo "Malabarba/org-agenda-property"
;;                        :fork (:host github :repo "rougier/org-agenda-property")))
;;
;; ;; NANO splash
;; (straight-use-package
;;  '(nano-splash :type git :host github :repo "rougier/nano-splash"))
;;
;; ;; NANO modeline
;; (straight-use-package
;;  '(nano-modeline :type git :host github :repo "rougier/nano-modeline"))
;;
;; NANO agenda
(straight-use-package
 '(nano-agenda :type git :host github :repo "rougier/nano-agenda"))
;;
;; ;; NANO agenda
(straight-use-package
 '(minibuffer-header :type git :host github :repo "rougier/minibuffer-header"))
;;
;; SVG tags, progress bars & icons
(straight-use-package
 '(svg-lib :type git :host github :repo "rougier/svg-lib"))
;;
;; Replace keywords with SVG tags
(straight-use-package
 '(svg-tag-mode :type git :host github :repo "rougier/svg-tag-mode"))
;;
;; ;; Dashboard for mu4e
;; (straight-use-package
;;  '(mu4e-dashboard :type git :host github :repo "rougier/mu4e-dashboard"))
;;
;; ;; Folding mode for mu4e
;; (straight-use-package
;;  '(mu4e-folding :type git :host github :repo "rougier/mu4e-folding"))
;;
;; ;; Relative date formatting
;; (straight-use-package
;;  '(relative-date :type git :host github :repo "rougier/relative-date"))
;;
;; org imenu
(straight-use-package
 '(org-imenu :type git :host github :repo "rougier/org-imenu"))

;; pdf-drop-mode
(straight-use-package
 '(pdf-drop-mode :type git :host github :repo "rougier/pdf-drop-mode"))


;; Bilbliography manager in org mode
(straight-use-package
  '(org-bib :type git :host github :branch "org-imenu" :repo "rougier/org-bib-mode"))
;;

;;;;;;; Imenu
(require 'imenu)
(require 'imenu-list)

;;;;;;;; Org
(setq-default org-directory "~/Documents/my_org"
              org-ellipsis " …"              ; Nicer ellipsis
              org-tags-column 1              ; Tags next to header title
              org-hide-emphasis-markers t    ; Hide markers
              org-cycle-separator-lines 2    ; Number of empty lines between sections
              org-use-tag-inheritance nil    ; Tags ARE NOT inherited 
              org-use-property-inheritance t ; Properties ARE inherited
              org-indent-indentation-per-level 2 ; Indentation per level
              org-link-use-indirect-buffer-for-internals t ; Indirect buffer for internal links
              org-fontify-quote-and-verse-blocks t ; Specific face for quote and verse blocks
              org-return-follows-link nil    ; Follow links when hitting return
              org-image-actual-width nil     ; Resize image to window width
              org-indirect-buffer-display 'other-window ; Tab on a task expand it in a new window
              org-outline-path-complete-in-steps nil) ; No steps in path display

(setq org-latex-create-formula-image-program 'dvisvgm)

(setq-default org-src-fontify-natively t         ; Fontify code in code blocks.
              org-adapt-indentation nil          ; Adaptive indentation
              org-src-tab-acts-natively t        ; Tab acts as in source editing
              org-confirm-babel-evaluate nil     ; No confirmation before executing code
              org-edit-src-content-indentation 0 ; No relative indentation for code blocks
              org-fontify-whole-block-delimiter-line t) ; Fontify whole block
;; Return or left-click with mouse follows link
(customize-set-variable 'org-return-follows-link t)
(customize-set-variable 'org-mouse-1-follows-link t)

;; Display links as the description provided
(customize-set-variable 'org-link-descriptive t)

;; Hide markup markers
(customize-set-variable 'org-hide-emphasis-markers t)
(add-hook 'org-mode-hook 'org-appear-mode)

;; disable auto-pairing of "<" in org-mode
;; (add-hook 'org-mode-hook (lambda ()
;;     (setq-local electric-pair-inhibit-predicate
;;     `(lambda (c)
;;         (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))


;;;;;;;; Completion

(require 'corfu)
(add-to-list 'load-path
             (expand-file-name "straight/build/corfu/extensions"
                               straight-base-dir))
(require 'corfu-popupinfo)

(setq corfu-cycle t                ; Enable cycling for `corfu-next/previous'
      corfu-auto t                 ; Enable auto completion
      corfu-auto-delay 60.0        ; Delay before auto-completion shows up
      corfu-separator ?\s          ; Orderless field separator
      corfu-quit-at-boundary nil   ; Never quit at completion boundary
      corfu-quit-no-match t        ; Quit when no match
      corfu-preview-current nil    ; Disable current candidate preview
      corfu-preselect-first nil    ; Disable candidate preselection
      corfu-on-exact-match nil     ; Configure handling of exact matches
      corfu-echo-documentation 1 ; Disable documentation in the echo area
      corfu-scroll-margin 5)       ; Use scroll margin

(global-corfu-mode 1)
(corfu-popupinfo-mode 1)
(eldoc-add-command #'corfu-insert)
(define-key corfu-map (kbd "M-p") #'corfu-popupinfo-scroll-down)
(define-key corfu-map (kbd "M-n") #'corfu-popupinfo-scroll-up)
(define-key corfu-map (kbd "M-d") #'corfu-popupinfo-toggle)
;; TAB cycle if there are only few candidates
(setq completion-cycle-threshold 3)
;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
;; Corfu commands are hidden, since they are not supposed to be used via M-x.
(setq read-extended-command-predicate
      #'command-completion-default-include-p)
;; Enable indentation+completion using the TAB key.
;; completion-at-point is often bound to M-TAB.
(setq tab-always-indent 'complete)

;; Completion in source blocks
(require 'cape)
;; (add-to-list 'completion-at-point-functions 'cape-symbol)
;; Add useful defaults completion sources from cape
(add-to-list 'completion-at-point-functions #'cape-file)
(add-to-list 'completion-at-point-functions #'cape-dabbrev)

;; Silence the pcomplete capf, no errors or messages!
;; Important for corfu
(advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent)

;; Ensure that pcomplete does not write to the buffer
;; and behaves as a pure `completion-at-point-function'.
(advice-add 'pcomplete-completions-at-point :around #'cape-wrap-purify)
(add-hook 'eshell-mode-hook
          (lambda () (setq-local corfu-quit-at-boundary t
                            corfu-quit-no-match t
                            corfu-auto nil)
            (corfu-mode)))

(require 'orderless)
  
(setq completion-styles '(substring orderless basic)
      orderless-component-separator 'orderless-escapable-split-on-space
      read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t)
(customize-set-variable 'completion-styles '(orderless basic))
(customize-set-variable 'completion-category-overrides '((file (styles . (partial-completion)))))

;;;;;;;; Vertico
(require 'vertico)

;; (setq completion-styles '(basic substring partial-completion flex))

(setq vertico-resize nil        ; How to resize the Vertico minibuffer window.
      vertico-count 8           ; Maximal number of candidates to show.
      vertico-count-format nil) ; No prefix with number of entries

(vertico-mode 1)

;(add-hook 'vertico-mode-hook #'minibuffer-vertico-setup)
;(add-hook 'minibuffer-setup-hook #'minibuffer-vertico-setup)

;;;;;;; Marginalia
(require 'marginalia)

(setq-default marginalia--ellipsis "…"    ; Nicer ellipsis
              marginalia-align 'right     ; right alignment
              marginalia-align-offset -1) ; one space on the right
(customize-set-variable 'marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))

;; Set some consult bindings
(global-set-key (kbd "C-s") 'consult-line)
(define-key minibuffer-local-map (kbd "C-r") 'consult-history)

(setq completion-in-region-function #'consult-completion-in-region)
(marginalia-mode 1)
;;

;;;;;;;; Embark
;;; Embark
(require 'embark)
(require 'embark-consult)

(global-set-key [remap describe-bindings] #'embark-bindings)
(global-set-key (kbd "C-.") 'embark-act)

;; Use Embark to show bindings in a key prefix with `C-h`
(setq prefix-help-command #'embark-prefix-help-command)

(with-eval-after-load 'embark-consult
  (add-hook 'embark-collect-mode-hook #'consult-preview-at-point-mode))

;;;;;;;; Eglot
(require 'eglot)
;; This is optional. It automatically runs `M-x eglot` for you whenever you are in `elixir-mode`

;; (add-hook 'python-mode-hook 'eglot-ensure)
;; Make sure to edit the path appropriately, use the .bat script instead for Windows
(add-to-list 'eglot-server-programs '(elixir-mode "~/.local/bin/elixir-ls/language_server.sh"))
;; (add-to-list 'eglot-server-programs '(python-mode . ("~/.local/bin/pyright-langserver" "--stdio")))


;;;;;;;; Denote
(require 'denote)
(setq denote-directory "~/Documents/my_denotes")

;;;;;;;; Flycheck
(require 'flycheck)
(global-flycheck-mode 1)

;;;;;;;; Guru-mode
(require 'guru-mode)
(guru-global-mode 1)
;; (add-hook 'prog-mode-hook 'guru-mode)

;;;;;;;; Latex
(use-package tex
 :defer t
 :straight auctex)
;; Using tectonic with auctex [https://tectonic-typesetting.github.io/book/latest/howto/auctex-setup/] 
(require 'latex)
(setq TeX-engine-alist '((default
                          "Tectonic"
                          "tectonic -X compile -f plain %T"
                          "tectonic -X watch"
                          nil)))
(setq LaTeX-command-style '(("" "%(latex)")))
(setq TeX-process-asynchronous t
      TeX-check-TeX nil
      TeX-engine 'default)
(let ((tex-list (assoc "TeX" TeX-command-list))
      (latex-list (assoc "LaTeX" TeX-command-list)))
  (setf (cadr tex-list) "%(tex)"
        (cadr latex-list) "%l"))

;;;;;;;; Elixir
(require 'elixir-mode)
;; (add-hook 'elixir-mode-hook 'flycheck-elixir-credo-setup)
(add-to-list 'elixir-mode-hook
             (defun auto-activate-ruby-end-mode-for-elixir-mode ()
               (set (make-variable-buffer-local 'ruby-end-expand-keywords-before-re)
                    "\\(?:^\\|\\s-+\\)\\(?:do\\)")
               (set (make-variable-buffer-local 'ruby-end-check-statement-modifiers) nil)
               (ruby-end-mode +1)))
(add-hook 'elixir-mode-hook #'alchemist-mode)
(add-hook 'elixir-mode-hook #'eglot-ensure)

;;;;;;;; Python
(require 'anaconda-mode)
(add-hook 'python-mode-hook #'anaconda-mode)
(add-hook 'python-mode-hook #'blacken-mode)
(add-hook 'python-mode-hook #'eldoc-mode)
(add-hook 'python-mode-hook #'eglot-ensure)
(add-hook 'python-mode-hook #'pyvenv-mode)
(add-hook 'python-mode-hook #'pyvenv-tracking-mode)

;;; pyvenv
;; restart python when the virtual environment changes
(add-hook 'pyvenv-post-activate-hooks #'pyvenv-restart-python)

;; default to the commonly used "venv" folder for the virtual
;; environment
(customize-set-variable 'pyvenv-default-virtual-env-name "venv")

;;;;;;;; Scheme
(require 'geiser)
(require 'geiser-guile)
(require 'geiser-racket)
(require 'geiser-autodoc)
(add-hook 'scheme-mode #'aggressive-indent-mode)

;;;;;;;; Lisp
(require 'sly)
(require 'sly-quicklisp)
(require 'sly-repl-ansi-color)
(require 'sly-asdf)

(add-hook 'lisp-mode-hook #'sly-editing-mode)
(add-hook 'lisp-mode-hook #'aggressive-indent-mode)

;;;;;;;; Bibliography
(require 'citar)
(require 'citar-embark)
(with-eval-after-load 'citar
  (define-key minibuffer-local-map (kbd "C-c b") 'citar-insert-citation)
  (define-key minibuffer-local-map (kbd "M-b") 'citar-insert-preset))

;; (org-cite-global-bibliography '("~/Documents/my_references/references.bib"))
;; (org-cite-insert-processor 'citar)
;; (org-cite-follow-processor 'citar)
;; (org-cite-activate-processor 'citar)
;; (citar-bibliography org-cite-global-bibliography)

(add-hook 'org-mode-hook #'citar-embark-mode)
(add-hook 'LaTeX-mode-hook #'citar-embark-mode)

(require 'org-bib)
(setq bibtex-autokey-titleword-length 0
      bibtex-autokey-name-year-separator ":"
      bibtex-autokey-name-case-convert-function 'capitalize
      bibtex-autokey-year-length 4
      bibtex-autokey-names 1
      bibtex-autokey-titleword-separator ""
      bibtex-autokey-year-title-separator ""
      bibtex-autokey-edit-before-use nil
      imenu-list-position 'left
      imenu-list-size 100
      org-imenu-depth 2
      org-image-actual-width `( ,(truncate (* (frame-pixel-width) 0.85)))
      org-startup-with-inline-images t)

(defun my/org-bib-mode-hook ()

  (with-current-buffer "*Ilist*"
    (setq header-line-format
        '(:eval
          (nano-modeline-render nil
                                (buffer-name imenu-list--displayed-buffer)
                                (format "(view mode: %s, filter: %s)"
                                        (if (eq org-bib--view-mode-current 'none)
                                            "-"
                                          org-bib--view-mode-current)
                                        (if (eq org-imenu-filter-string "*")
                                            "-"
                                          org-imenu-filter-string))
                                "")))
    (face-remap-add-relative 'hl-line :inherit 'nano-strong-i)))

(add-hook 'org-bib-mode-hook #'my/org-bib-mode-hook)

(defun my/biblio ()
  "Create a new frame for editing bibliography"
  
  (interactive)
  (require 'org-bib)
  (setq imenu-list-position 'left
        imenu-list-size 100
        org-imenu-depth 2)

  (select-frame (make-frame '((name . "my/biblio")
                              (width . 180)
                              (height . 45))))
  (find-file "~/Documents/my_references/references.org")
  (org-bib-mode))

;; (autoload 'my/biblio
;;   (expand-file-name "init.el" user-emacs-directory)
;;   "Autoloaded my/config command."
;;   t)

;;;;;;;; Instatext
(load-file "~/.emacs.d/instatext.el")
