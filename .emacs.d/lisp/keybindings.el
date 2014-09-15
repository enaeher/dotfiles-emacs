;; concept taken from a stackoverflow question

(defvar local-keys-map (make-keymap) "local-keys keymap.")

(define-key local-keys-map (kbd "C-c m") 'magit-status)
(define-key local-keys-map (kbd "C-c o") 'find-file-at-point)
(define-key local-keys-map (kbd "M-x") 'smex)
(define-key local-keys-map (kbd "C-o") 'other-window)

(defun kill-this-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(define-key local-keys-map (kbd "C-x k") 'kill-this-buffer)

;; key bindings
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta))

(define-minor-mode local-keys
    "A minor mode so that my key settings override major modes."
  t " local-keys" 'local-keys-map)

(local-keys 1)
