;; concept taken from a stackoverflow question

(defvar local-keys-map (make-keymap) "local-keys keymap.")

(define-key local-keys-map (kbd "C-c g") 'magit-status)
(define-key local-keys-map (kbd "C-c o") 'find-file-at-point)
(define-key local-keys-map (kbd "M-x") 'smex)
(define-key local-keys-map (kbd "C-o") 'other-window)
(define-key local-keys-map (kbd "M-i") 'helm-swoop)

(defun kill-this-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(define-key local-keys-map (kbd "C-x k") 'kill-this-buffer)

(defun fish-term ()
  (interactive)
  (ansi-term "fish"))

(define-key local-keys-map (kbd "M-t") 'fish-term)

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
	     (next-win-buffer (window-buffer (next-window)))
	     (this-win-edges (window-edges (selected-window)))
	     (next-win-edges (window-edges (next-window)))
	     (this-win-2nd (not (and (<= (car this-win-edges)
					 (car next-win-edges))
				     (<= (cadr this-win-edges)
					 (cadr next-win-edges)))))
	     (splitter
	      (if (= (car this-win-edges)
		     (car (window-edges (next-window))))
		  'split-window-horizontally
		'split-window-vertically)))
	(delete-other-windows)
	(let ((first-win (selected-window)))
	  (funcall splitter)
	  (if this-win-2nd (other-window 1))
	  (set-window-buffer (selected-window) this-win-buffer)
	  (set-window-buffer (next-window) next-win-buffer)
	  (select-window first-win)
	  (if this-win-2nd (other-window 1))))))

;; window management

(define-key local-keys-map (kbd "C-x 4") 'toggle-window-split)

(define-minor-mode local-keys
    "A minor mode so that my key settings override major modes."
  t " local-keys" 'local-keys-map)

(local-keys 1)
