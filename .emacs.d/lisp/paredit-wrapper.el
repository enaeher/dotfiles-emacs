;;; paredit -- better s-exp manipulation/pseudo-structured-text mode

(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code."
  t)
(add-hook 'lisp-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))

;; get rid of annoying newlines

(eval-after-load "paredit"
  '(progn
    (define-key paredit-mode-map (kbd ")")
      'paredit-close-parenthesis)
    (define-key paredit-mode-map (kbd "M-)")
      'paredit-close-parenthesis-and-newline)))
