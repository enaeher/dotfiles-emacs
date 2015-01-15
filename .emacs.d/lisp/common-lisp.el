(use-package slime
  :ensure t
  :load-path "~/quicklisp/dists/quicklisp/software/slime-2.8/"
  :mode ("\\.asd\\'" . lisp-mode)
  :init
  (progn
    (setq inferior-lisp-program "sbcl")
    (add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
    (add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
    
    (add-hook 'slime-mode-hook
              (lambda ()
                (setq slime-net-coding-system 'utf-8-unix) ; from wmannis on #lisp
                (setq indent-tabs-mode nil)
                (setq lisp-indent-function 'common-lisp-indent-function)))

    
    (slime-setup '(slime-fancy slime-presentations slime-tramp slime-asdf))

    (push ".x86f" completion-ignored-extensions)
    (push ".fasl" completion-ignored-extensions)
    (push ".core" completion-ignored-extensions)))
