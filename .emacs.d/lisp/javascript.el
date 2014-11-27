(setq js-indent-level 4)

;; tern

(add-to-list 'load-path "~/.emacs.d/lisp/tern/emacs")
(autoload 'tern-mode "tern.el" nil t)
(require 'js2-mode)
(cl-pushnew "define" js2-global-externs)
(cl-pushnew "require" js2-global-externs)
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js2-mode-hook 'flymake-mode)
