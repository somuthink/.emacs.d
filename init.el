(setq custom-file (locate-user-emacs-file "custom.el"))

(load custom-file)

(setq ns-command-modifier 'meta)

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ;; ("melpa-stable" . "https://stable.melpa.org/packages/")
        ))
(setq use-package-always-ensure t)
(package-initialize)

(use-package exec-path-from-shell
  :ensure t
  :init
  (exec-path-from-shell-initialize)
  )

(setq-default ring-bell-function 'ignore)

(delete-selection-mode t)

(setq make-backup-files nil)
(with-eval-after-load 'dired
  (require 'dired-x))
(add-hook 'dired-mode-hook #'dired-hide-details-mode)

(fset 'yes-or-no-p 'y-or-n-p)

;; (setq url-proxy-services
;;     '(("no_proxy" . "^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)")
;;       ("http" . "127.0.0.1:1087")
;;       ("https" . "127.0.0.1:1087")))

(setq-default cursor-type 'bar)
    (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
    (tool-bar-mode -1)
    (scroll-bar-mode -1)

(use-package solo-jazz-theme
  :ensure t
  :init
  (load-theme 'solo-jazz t))

(use-package helpful
        :vc (:repo "Wilfred/helpful" :fetcher github))

(use-package ct
  :vc (:repo "neeasade/ct.el" :fetcher github))

(use-package myron-themes
  :vc (:repo "neeasade/myron-themes" :fetcher github))

(set-face-attribute 'default nil
                      :family     "Go Mono"
                      :height       155)

(use-package ace-window
  :bind
  ("M-o" . ace-window)
  )

(global-set-key (kbd "C-x C-m") 'execute-extended-command)
(global-set-key (kbd "C-x b") 'switch-to-buffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x k") 'kill-current-buffer)
;; (global-set-key (kbd "M-p") 'previous-buffer)
;; (global-set-key (kbd "M-n") 'next-buffer)

(global-set-key (kbd "M-B") 'previous-buffer)
(global-set-key (kbd "M-F") 'next-buffer)

(defun reload-init-file ()
	 (interactive)
	 (load-file user-init-file))
(global-set-key (kbd "C-c C-r") 'reload-init-file)

(use-package vertico
  :ensure t
  :custom
  (vertico-scroll-margin 0)
  (vertico-count 20)
  (vertico-resize t)
  (vertico-cycle t) 
  :init
  (vertico-mode))

(use-package savehist
  :init
  (savehist-mode))

(use-package orderless
:ensure t
:custom
(completion-category-defaults nil)
(completion-styles '(orderless basic))
(completion-category-overrides '((file (styles partial-completion))))
(completion-pcm-leading-wildcard t)
)

(use-package consult
   :ensure t
  ;; Replace bindings. Lazily loaded by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g r" . consult-grep-match)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-find)                  ;; Alternative: consult-fd
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("C-s" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Tweak the register preview for `consult-register-load',
  ;; `consult-register-store' and the built-in commands.  This improves the
  ;; register formatting, adds thin separator lines, register sorting and hides
  ;; the window mode line.
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep consult-man
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (keymap-set consult-narrow-map (concat consult-narrow-key " ?") #'consult-narrow-help)
)

(setopt tab-always-indent 'complete)
(use-package corfu
    :after orderless
    :ensure t
    :custom
    (corfu-quit-at-boundary nil)
    (corfu-quit-no-match t)
    (corfu-auto-prefix 1)
    (corfu-auto t)
(corfu-auto-delay 0.0)
    :init
  (global-corfu-mode))

(use-package magit)

(use-package project
  :custom
  (project-vc-extra-root-markers '(".project" "workspace.edn" ".dir-locals.el"))
  )

(use-package dotenv
  :ensure nil
  :after project
  :vc (:repo "pkulev/dotenv.el" :fetcher github)
  :config
  (defun dotenv-project ()
    "Load .env file when switching projects."
    (interactive)
    (when-let ((project (project-current)))
      (dotenv-update-project-env (project-root project))))
  ;; (project-find-functions . dotenv-project)
  )

(use-package org
  :bind ("C-c a" . org-agenda)

  :config
  ;; Resize Org headings
  (custom-set-faces
   '(org-document-title ((t (:height 1.4))))
   '(org-level-1          ((t (:height 1.7))))
   '(org-level-2          ((t (:height 1.5))))
   '(org-level-3          ((t (:height 1.25))))
   '(org-level-4          ((t (:height 1.2))))
   '(org-level-5          ((t (:height 1.2))))
   '(org-level-6          ((t (:height 1.2))))
   '(org-level-7          ((t (:height 1.2))))
   '(org-level-8          ((t (:height 1.2))))
   '(org-level-9          ((t (:height 1.2)))))

  (plist-put org-format-latex-options :scale 2)

  :custom
  (org-agenda-files '("~/Documents/org"))
  (org-agenda-window-setup 'other-window)
  (org-hide-leading-stars t)
  (org-pretty-entities t)
  (org-startup-indented t)
  (org-startup-folded 'content)

  (org-preview-latex-default-process 'dvisvgm)
  (org-image-actual-width 500))

(use-package org-download
  :init
  (require 'org-download)
  :custom
  (org-download-method 'attach))

(use-package verb
  :bind (:map org-mode-map
              ("C-c v" . verb-send-request-on-point)
              )
  )

(use-package denote
  :hook (dired-mode . denote-dired-mode)
  :bind
  (("C-c n n" . denote)
   ("C-c n r" . denote-rename-file)
   ("C-c n l" . denote-link)
   ("C-c n b" . denote-backlinks)
   ("C-c n d" . denote-dired)
   ("C-c n g" . denote-grep))
  :config
  (denote-rename-buffer-mode 1)
  :custom
  (denote-directory "~/Documents/org")
  )

(use-package consult-notes
  :bind 

  :config
  (consult-notes-org-headings-mode)
  (consult-notes-denote-mode))

(use-package emms
  :config
  (require 'emms-setup)
  (emms-all)
  :custom
  (emms-source-file-default-directory "~/Music")
  (emms-player-list '(emms-player-mpv))
  (emms-source-file-directory-tree-function 'emms-source-file-directory-tree-internal)

  )

(use-package  vterm
  :ensure t)

(use-package smartparens
   :ensure t
   :hook (prog-mode cider-mode)
   :custom
   (sp-base-key-bindings 'sp)
   (sp-override-key-bindings
   '(("C-M-n" . sp-transpose-sexp)
     ("C-M-p" . sp-backward-transpose-sexp)
     ("C-k" . sp-kill-hybrid-sexp)
     ("C-c C-<right>" . sp-slurp-hybrid-sexp)
     ("M-F" . nil)
     ("M-B" . nil)
     ))
   :config
   (defun sp-backward-transpose-sexp ()
     (interactive)
     (sp-transpose-sexp -1)
     )
)

(use-package eglot
  :ensure t
  :hook ((( clojure-mode clojurec-mode clojurescript-mode java-mode)
          . eglot-ensure))
  ;; :preface
  ;; (defun eglot-disable-in-cider ()
  ;;   (when (eglot-managed-p)
  ;;     (if (bound-and-true-p cider-mode)
  ;;         (progn
  ;;           (remove-hook 'completion-at-point-functions 'eglot-completion-at-point t)
  ;;           (remove-hook 'xref-backend-functions 'eglot-xref-backend t))
  ;;       (add-hook 'completion-at-point-functions 'eglot-completion-at-point nil t)
  ;;       (add-hook 'xref-backend-functions 'eglot-xref-backend nil t))))
  :custom
  (eglot-autoshutdown t)
  (eglot-events-buffer-size 0)
  (eglot-extend-to-xref nil)
  (eglot-ignored-server-capabilities
   '(:hoverProvider
     :documentHighlightProvider
     :documentFormattingProvider
     :documentRangeFormattingProvider
     :documentOnTypeFormattingProvider
     :colorProvider
     :foldingRangeProvider))
  (eglot-stay-out-of '(yasnippet)))

(use-package jarchive
:ensure t
:after eglot
:config
(jarchive-setup))

(use-package cider :ensure t)

(defun portal.api/open ()
  (interactive)
  (cider-nrepl-sync-request:eval
    "(do (ns dev)
  (require '[portal.api :as p])
         (def portal (p/open {:launcher :emacs}))
         (add-tap p/submit))"))

(defun portal.api/clear ()
  (interactive)
  (cider-nrepl-sync-request:eval "(portal.api/clear)"))

(defun portal.api/close ()
  (interactive)
  (cider-nrepl-sync-request:eval "(portal.api/close)"))

;; (with-eval-after-load 'eglot
;;   (let ((cache (expand-file-name (md5 (project-root (project-current t)))
;;                                  (locate-user-emacs-file "jdtls-cache"))))
;;     (add-to-list 'eglot-server-programs `(java-mode "jdtls" "-data" ,cache))))
