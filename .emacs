(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; for homebrew
(let ((default-directory "/usr/local/share/emacs/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

(require 'use-package)

(add-to-list 'load-path "~/.emacs.d/lisp/")

(setq ring-bell-function 'ignore)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq custom-file "~/.emacs.d/custom.el")

(add-hook 'after-init-hook 'server-start)

(load "aesthetic")
(load "mouse-config")
(load "global-keybindings")
(load "maybe-open-with-sudo")
(load "clojure")
(load "common-lisp")

(use-package diminish
  :ensure t)

(diminish 'local-keys)

(if (eq system-type 'darwin)
    (load "macosx-clipboard")
    (load "linux-clipboard"))

;; Packages

(use-package magit
  :ensure t
  :bind ("C-c g" . magit-status)
  :diminish magit-auto-revert-mode)

(use-package forge
  :ensure t)

(use-package ws-butler
  :ensure t)

(use-package flycheck-joker
  :ensure t)

(use-package flycheck-pos-tip
  :ensure t)

(use-package windmove
  :init (windmove-default-keybindings))

(use-package company
  :ensure t
  :init (global-company-mode)
  :diminish company-mode)

(use-package eldoc
  :ensure t
  :diminish eldoc-mode)

(use-package aggressive-indent
  :ensure t
  ;; binding conflicts with Cider, is pointless anyway
  :config (define-key aggressive-indent-mode-map (kbd "C-c C-q") nil))

(use-package ibuffer
  :bind ("C-x C-b" . ibuffer))

(use-package ibuffer-vc
  :ensure t
  :init (add-hook
         'ibuffer-hook
         (lambda ()
           (ibuffer-vc-set-filter-groups-by-vc-root)
           (unless (eq ibuffer-sorting-mode 'alphabetic)
             (ibuffer-do-sort-by-alphabetic)))))

(use-package company-emoji
  :ensure t
  :init (company-emoji-init))

(use-package ivy :demand
  :config (progn
            (ivy-mode 1)
            (setq ivy-use-virtual-buffers t
                  ivy-count-format "%d/%d "))
  :bind
  ("C-s" . swiper)
  ("C-x b" . ivy-switch-buffer))

(use-package counsel
  :ensure t
  :config (counsel-mode 1)
  :bind ("M-x" . counsel-M-x))

(use-package counsel-projectile
  :ensure t
  :config (progn
            (counsel-projectile-mode 1)
            (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)))

(use-package dired-x)

(use-package tramp
  :init
  (progn
    ;; Show remote hostname in
    (defconst my-mode-line-buffer-identification
      (list
       '(:eval
      (when (file-remote-p default-directory 'host)
        (format "%s: " (file-remote-p default-directory 'host))))
       "%12b"))

    (setq-default
     mode-line-buffer-identification
     my-mode-line-buffer-identification)

    (add-hook
     'dired-mode-hook
     (lambda ()
       (setq
     mode-line-buffer-identification
     my-mode-line-buffer-identification)))))

(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode)

(use-package web-mode
  :ensure t
  :mode ("\\.erb\\'" . web-mode))

(load custom-file :noerror)
