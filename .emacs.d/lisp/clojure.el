(use-package clojure-mode
    :ensure t
    :init (add-hook 'clojure-mode-hook 'turn-on-eldoc-mode))

(use-package aggressive-indent
  :ensure t
  :init (add-hook 'clojure-mode-hook (lambda ()
				       (aggressive-indent-mode 1))))

(use-package paredit
  :ensure t
  :init (progn
	  (add-hook 'clojure-mode-hook (lambda () (paredit-mode 1)))
	  (add-hook 'cider-repl-mode-hook (lambda () (paredit-mode 1)))))

(use-package clj-refactor
  :ensure t
  :init (add-hook 'clojure-mode-hook (lambda ()
				       (clj-refactor-mode 1)
				       (cljr-add-keybindings-with-prefix "C-c C-m")
				       (dolist (mapping '(("json" . "cheshire.core")
							  ("async" . "clojure.core.async")))
					 (add-to-list 'cljr-magic-require-namespaces mapping t)))))

(use-package cider
  :ensure t)

(use-package flycheck-clojure
  :ensure t
  :init (add-hook 'cider-mode-hook (lambda () (flycheck-mode 1))))

(use-package flycheck
  :ensure t
  :init (flycheck-clojure-setup))
