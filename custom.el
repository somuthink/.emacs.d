(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(elfeed mu4e wallabag nov anki calibredb shrface popup vterm vertico verb vc-use-package telega solo-jazz-theme smartparens shrink-path pyvenv outli org-modern org-download orderless olivetti myron-themes magit lv jarchive ht hsluv helpfull helpful exec-path-from-shell emms eglot-java eca eat dotenv cyberpunk-theme ct corfu consult-denote company cider base16-theme acme-theme ace-window))
 '(safe-local-variable-values
   '((eval add-hook 'after-save-hook
	   (lambda nil
	     (when
		 (and
		  (string=
		   (buffer-name)
		   "config.org")
		  (y-or-n-p "Tangle configuration?"))
	       (org-babel-tangle)))
	   nil t)
     (org-confirm-babel-evaluate)
     (eval progn
	   (make-variable-buffer-local 'cider-jack-in-nrepl-middlewares)
	   (setq cider-jack-in-nrepl-middlewares
		 '(cider.nrepl/cider-middleware shadow.cljs.devtools.server.nrepl/middleware)))
     (eval add-hook 'after-save-hook
	   (lambda nil
	     (if
		 (y-or-n-p "Tangle?")
		 (org-babel-tangle)))
	   nil t)
     (eval add-hook 'after-save-hook
	   (lambda nil
	     (if
		 (y-or-n-p "Reload?")
		 (load-file user-init-file)))
	   nil t))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(help-key-binding ((t (:background "#FFFFFF" :foreground "#673AB7" :box (:line-width (-1 . -1) :color "grey80")))))
 '(org-document-title ((t (:height 1.4))))
 '(org-level-1 ((t (:height 1.7))))
 '(org-level-2 ((t (:height 1.5))))
 '(org-level-3 ((t (:height 1.25))))
 '(org-level-4 ((t (:height 1.2))))
 '(org-level-5 ((t (:height 1.2))))
 '(org-level-6 ((t (:height 1.2))))
 '(org-level-7 ((t (:height 1.2))))
 '(org-level-8 ((t (:height 1.2))))
 '(org-level-9 ((t (:height 1.2)))))
