(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("d8b0f3a798b5de68e24e4b7d8ab8fed8c68d1dc2ae6a908c27e9f6c9afce5dd5" default))
 '(org-babel-load-languages '((python . t) (emacs-lisp . t)))
 '(org-babel-python-command "python3")
 '(outli-heading-config
   '((clojurescript-mode ";;" 59 t nil)
     (clojure-mode ";;" 59 t nil)
     (clojurec-mode ";;" 59 t nil)
     (tex-mode "%%" 37 t nil)
     (markdown-mode "" 35 none t)
     (org-mode)
     (t
      (let*
	  ((c
	    (or comment-start "#"))
	   (space
	    (unless
		(eq
		 (aref c
		       (1-
			(length c)))
		 32)
	      " ")))
	(concat c space))
      42 nil nil)))
 '(package-selected-packages
   '(denote telega eat helpfull ct ct.el myron-themes eca pyvenv vterm jarchive eglot-java htmlize a emms eglot outli verb prism doom-modeline dotenv vc-use-package))
 '(package-vc-selected-packages
   '((helpfull :vc-backend Git :url "https://github.com/Wilfred/helpful")
     (ct :vc-backend Git :url "https://github.com/neeasade/ct.el")
     (myron-themes :vc-backend Git :url "https://github.com/neeasade/myron-themes")
     (org-project :vc-backend Git :url "https://github.com/delehef/org-project")
     (tabspaces :vc-backend Git :url "https://github.com/mclear-tools/tabspaces")
     (dotenv :vc-backend Git :url "https://github.com/pkulev/dotenv.el")
     (vc-use-package :vc-backend Git :url "https://github.com/slotThe/vc-use-package")))
 '(safe-local-variable-values
   '((eval progn
	   (make-variable-buffer-local 'cider-jack-in-nrepl-middlewares)
	   (add-to-list 'cider-jack-in-nrepl-middlewares "shadow.cljs.devtools.server.nrepl/middleware"))
     (eval progn
	   (local-set-key
	    (kbd "C-c C-r")
	    (lambda nil
	      (interactive)
	      (cider-interactive-eval "(require 'user) (in-ns 'user) (reset)"))))
     (eval progn
	   (local-set-key
	    (kbd "C-c C-r")
	    (lambda nil
	      (interactive)
	      (cider-interactive-eval "(require 'user) (in-ns 'user) (reset)" nil nil))))
     (eval progn
	   (local-set-key
	    (kbd "C-c C-r")
	    (lambda nil
	      (interactive)
	      (cider-interactive-eval "(require 'user) (in-ns 'user) (reset)" nil nil
				      (cider--nrepl-pr-request-map)))))
     (eval progn
	   (local-set-key
	    (kbd "C-c C-r")
	    (lambda nil
	      (interactive)
	      (cider-interactive-eval "(require 'development) (in-ns 'development) (restart)" nil nil
				      (cider--nrepl-pr-request-map)))))
     (eval progn
	   (make-variable-buffer-local 'cider-jack-in-nrepl-middlewares)
	   (setq cider-jack-in-nrepl-middlewares
		 '(cider.nrepl/cider-middleware shadow.cljs.devtools.server.nrepl/middleware)))
     (eval defun datomic.sqlite/conn nil "Connect to the Datomic SQLite database in ./storage/sqlite.db"
	   (interactive)
	   (let
	       ((ns
		 (cider-current-ns)))
	     (cider-nrepl-sync-request:eval
	      (format "(in-ns '%s)\12              (def conn (d/connect \"datomic:sql://app?jdbc:sqlite:./storage/sqlite.db\"))" ns))))
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
