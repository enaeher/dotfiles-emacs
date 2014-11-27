(set-display-table-slot  standard-display-table  'vertical-border ?\u2502)

;; Syntax highlighting
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; Get rid of opaque foo<0> foo<1> foo<2> buffer names,
;; use bar/foo, quux/foo instead.
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(set-display-table-slot standard-display-table 'wrap ?↩)

(set-face-inverse-video-p 'vertical-border nil)
(set-face-background 'vertical-border (face-background 'default))
(set-display-table-slot standard-display-table
                        'vertical-border (make-glyph-code ?·))

(add-hook 'clojure-mode-hook (lambda () (linum-mode +1)))
(add-hook 'lisp-mode-hook (lambda () (linum-mode +1)))
(add-hook 'emacs-lisp-mode-hook (lambda () (linum-mode +1)))
