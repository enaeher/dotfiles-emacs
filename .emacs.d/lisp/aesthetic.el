(set-display-table-slot  standard-display-table  'vertical-border ?\u2502)

;; Syntax highlighting
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; Get rid of opaque foo<0> foo<1> foo<2> buffer names,
;; use bar/foo, quux/foo instead.
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(set-background-color "#000000")
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
