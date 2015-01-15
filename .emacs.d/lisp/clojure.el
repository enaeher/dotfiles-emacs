(use-package clojure-mode
  :init (add-hook 'clojure-mode-hook (lambda ()
				       (clj-refactor-mode 1)
				       (aggressive-indent-mode 1)
				       (paredit-mode 1))))

(use-package cider
  :ensure t
  :init
  (progn
    (cljr-add-keybindings-with-prefix "C-c C-m")
    (add-hook 'nrepl-connected-hook #'cljr-update-artifact-cache)
    (add-hook 'nrepl-connected-hook #'cljr-warm-ast-cache)
    (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
    (add-hook 'cider-mode-hook 'company-mode)
    (add-hook 'cider-repl-mode-hook 'company-mode)
    (setq nrepl-hide-special-buffers nil)))

(use-package squiggly-clojure
  :init (add-hook 'cider-mode-hook (lambda () (flycheck-mode 1))))

(use-package flycheck
  :init (flycheck-clojure-setup))
