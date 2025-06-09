(use-package flycheck-clj-kondo
  :ensure t)

(use-package clojure-mode
  :ensure t
  :config (require 'flycheck-clj-kondo)
  :init (progn
	  (add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)
          (add-hook 'clojure-mode-hook 'flycheck-mode)))

(use-package paredit
  :ensure t
  :init (progn
	  (add-hook 'clojure-mode-hook (lambda () (paredit-mode 1)))
	  (add-hook 'cider-repl-mode-hook (lambda () (paredit-mode 1)))))

(use-package cider
  :ensure t
  :init (add-hook 'cider-repl-mode-hook (lambda () (local-set-key (kbd "C-c M-o") #'cider-repl-clear-buffer))))

(use-package rainbow-delimiters
  :ensure t
  :init (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode))

(use-package macrostep-geiser
  :ensure t
  :after cider-mode
  :config (add-hook 'cider-mode-hook #'macrostep-geiser-setup)
  :bind (("C-c e" . macrostep-expand)))

(defun rename-buffer-to-ns ()
  (interactive)
  (when (buffer-file-name)
    (let ((ns (clojure-find-ns)))
      (when (and ns (not (string= "" ns)))
        (rename-buffer ns)))))

(add-hook 'clojure-mode-hook 'rename-buffer-to-ns)
