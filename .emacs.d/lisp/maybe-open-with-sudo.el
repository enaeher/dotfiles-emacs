(defun maybe-open-with-sudo ()
  "Find file as root if necessary."
  (unless (and buffer-file-name
               (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo::" buffer-file-name))))

(add-hook 'find-file-hook 'maybe-open-with-sudo)
