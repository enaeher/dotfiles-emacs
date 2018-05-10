(use-package clojure-mode
    :ensure t
    :init (progn
	    (add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)))
	    

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
                                       (yas-minor-mode 1)
				       (cljr-add-keybindings-with-prefix "C-c C-m"))))

(use-package cider
  :ensure t
  :init (add-hook 'cider-repl-mode-hook (lambda () (local-set-key (kbd "C-c M-o") #'cider-repl-clear-buffer))))

(use-package rainbow-delimiters
    :ensure t
    :init (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode))
