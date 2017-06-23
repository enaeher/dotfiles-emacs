(use-package clojure-mode
    :ensure t
    :init (progn
	    (add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)
	    (add-hook 'clojure-mode-hook 'sayid-setup-package)))

(use-package aggressive-indent
  :ensure t
  :init (add-hook 'clojure-mode-hook (lambda ()
				       (aggressive-indent-mode 1))))

(use-package paredit
  :ensure t
  :init (progn
	  (add-hook 'clojure-mode-hook (lambda () (paredit-mode 1)))
	  (add-hook 'cider-repl-mode-hook (lambda () (paredit-mode 1)))))

;; (use-package clj-refactor
;;   :ensure t
;;   :init (add-hook 'clojure-mode-hook (lambda ()
;;				       (clj-refactor-mode 1)
;;				       (cljr-add-keybindings-with-prefix "C-c C-m")
;;				       (progn
;;					 (put-clojure-indent 'fact 'defun)
;;					 (put-clojure-indent 'facts 'defun)
;;					 (put-clojure-indent 'future-fact 'defun)
;;					 (put-clojure-indent 'future-facts 'defun))
;;				       (dolist (mapping '(("json" . "cheshire.core")
;;							  ("async" . "clojure.core.async")))
;;					 (add-to-list 'cljr-magic-require-namespaces mapping t)))))

(use-package cider
  :ensure t)

(use-package rainbow-delimiters
    :ensure t
    :init (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode))
