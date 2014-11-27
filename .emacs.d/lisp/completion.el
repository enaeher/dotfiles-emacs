;; ido
(ido-mode 1)
;(ido-everywhere 1)
(flx-ido-mode 1)

;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(setq ido-use-filename-at-point 'guess)
(setq ido-create-new-buffer 'always)

;; ido vertical mode is more readable

(ido-vertical-mode 1)

;; smex is ido-like for commands

(smex-initialize)

(require 'company)
(require 'company-go)

(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-idle-delay .5)                         ; decrease delay before autocompletion popup shows
(setq company-echo-delay 0)                          ; remove annoying blinking
(setq company-minimum-prefix-length 1)
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

(add-hook 'cider-mode-hook 'company-mode)
(add-hook 'cider-repl-mode-hook 'company-mode)

(defun maybe-open-with-sudo ()
  "Find file as root if necessary."
  (unless (and buffer-file-name
               (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo::" buffer-file-name))))

(add-hook 'find-file-hook 'maybe-open-with-sudo)

(require 'helm-config)

(setq helm-c-locate-command
      (cl-case system-type
        ('gnu/linux "locate -i -r %s")
        ('berkeley-unix "locate -i %s")
        ('windows-nt "es %s")
        ('darwin "mdfind -name %s %s")
        (t "locate %s")))

(helm-mode 1)
