;; Load custom settings separately
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file t)

;; macOS: CMD as Meta
(setq ns-command-modifier 'meta)

;; Package archives
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

(setq use-package-always-ensure t)
(package-initialize)

;; Disable distractions
(setq-default ring-bell-function 'ignore)
(fset 'yes-or-no-p 'y-or-n-p)

;; Editing defaults
(delete-selection-mode t)

;; File handling
(setq make-backup-files nil)

;; Shell environment
(use-package exec-path-from-shell
  :init (exec-path-from-shell-initialize))

;; Load nano from local source
(add-to-list 'load-path (expand-file-name "~/.config/nano-emacs"))

;; Core nano modules
(require 'nano-layout)
(require 'nano-help)
(require 'nano-writer)
(require 'nano-modeline)

;; Font configuration
(setq nano-font-family-monospaced "Default"
      nano-font-family-proportional nil
      nano-font-size 18)

;; Theme setup
(require 'nano-theme)
(require 'nano-faces)
(require 'nano-theme-dark)
(require 'nano-theme-light)

(cond
 ((member "-dark" command-line-args) (nano-theme-set-dark))
 (t (nano-theme-set-light)))

(call-interactively 'nano-refresh-theme)

(use-package ace-window
  :bind ("M-o" . ace-window))

(setq-default cursor-type 'bar)
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Modern completion
(use-package vertico
  :custom
  (vertico-scroll-margin 0)
  (vertico-count 20)
  (vertico-resize t)
  (vertico-cycle t)
  :init (vertico-mode))

(use-package orderless
  :custom
  (completion-category-defaults nil)
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-pcm-leading-wildcard t))

(use-package savehist
  :init (savehist-mode))

(use-package consult
  :bind (
         ;; consult features
         ("C-c M-x" . consult-mode-command)
         ("C-c i" . consult-info)
         ("C-c h" . consult-history)
         ("C-x r b" . consult-bookmark)
         ;; buffers
         ("C-x b" . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x p b" . consult-project-buffer)

         ;; fix & find
         ("M-g f" . consult-flymake)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("C-s" . consult-line)

         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         
         ("M-s e" . consult-isearch-history)      
         ("M-s l" . consult-line)  
         ("M-s L" . consult-line-multi)
         )
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
  )

(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.0)
  :init (global-corfu-mode))

(use-package org
  :bind ("C-c a" . org-agenda)
  :custom
  (org-agenda-files '("~/Documents/org"))
  (org-hide-leading-stars t)
  (org-pretty-entities t)
  (org-startup-indented t)
  (org-startup-folded 'content))

(use-package denote
  :bind (("C-c n n" . denote)
         ("C-c n r" . denote-rename-file)
         ("C-c n l" . denote-link)
         ("C-c n d" . denote-dired))
  :custom
  (denote-directory "~/Documents/org"))

(use-package consult-denote
  :bind (("M-n n" . consult-denote-find)
         ("M-n g" . consult-denote-grep))
  :custom
  (denote-directory "~/Documents/org"))

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package project
  :custom
  (project-vc-extra-root-markers '(".project" ".dir-locals.el")))

(use-package eglot
  :hook ((clojure-mode . eglot-ensure)
         (java-mode . eglot-ensure)))

(use-package smartparens
  :hook (prog-mode)
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
  (smartparens-global-mode)
  (defun sp-backward-transpose-sexp ()
    (interactive)
    (sp-transpose-sexp -1)
    ))

(use-package cider
  :commands cider-connect)

(use-package vterm
  :commands vterm)

;; Buffer management
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x k") 'kill-current-buffer)

;; Extended commands
(global-set-key (kbd "C-x C-m") 'execute-extended-command)

;; Reload config
(defun reload-init-file ()
  (interactive)
  (load-file user-init-file))
(global-set-key (kbd "C-c C-r") 'reload-init-file)

;; Org mode headings
(set-face-attribute 'org-document-title nil :height 1.4)
(set-face-attribute 'org-level-1 nil :height 1.7)
(set-face-attribute 'org-level-2 nil :height 1.5)
(set-face-attribute 'org-level-3 nil :height 1.25)
(set-face-attribute 'org-level-4 nil :height 1.2)
(set-face-attribute 'org-level-5 nil :height 1.2)
(set-face-attribute 'org-level-6 nil :height 1.2)
(set-face-attribute 'org-level-7 nil :height 1.2)
(set-face-attribute 'org-level-8 nil :height 1.2)

;; Help key bindings
(set-face-attribute 'help-key-binding nil
                    :background "#FFFFFF"
                    :foreground "#673AB7"
                    :box '(:line-width (-1 . -1) :color "grey80"))
