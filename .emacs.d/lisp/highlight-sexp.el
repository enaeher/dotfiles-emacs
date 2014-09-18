;;; hl-sexp-mode -- highlight sexp containing point.

(autoload 'hl-sexp-mode "hl-sexp"
  "Minor mode to highlight s-expression at point."
 t)
(add-hook 'lisp-mode-hook (lambda () (hl-sexp-mode +1)))
(add-hook 'clojure-mode-hook (lambda () (hl-sexp-mode +1)))
