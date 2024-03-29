(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; ;; for homebrew
;; (let ((default-directory "/usr/local/share/emacs/site-lisp/"))
;;   (normal-top-level-add-subdirs-to-load-path))

(require 'use-package)

(add-to-list 'load-path "~/.emacs.d/lisp/")

(setq ring-bell-function 'ignore)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq custom-file "~/.emacs.d/custom.el")

(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))

(add-hook 'after-init-hook 'server-start)

(load "distinguished-theme")
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

(use-package flycheck-clj-kondo
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
  ("C-x b" . ivy-switch-buffer)
  ("M-s" . ivy-restrict-to-matches))

(use-package counsel
  :ensure t
  :config (counsel-mode 1)
  :bind
  ("M-i" . counsel-imenu)
  ("M-x" . counsel-M-x)
  ("C-c f" . counsel-git)
  ("C-c k" . counsel-git-grep))

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

(use-package shortcut-backend
  :load-path "~/shortcut/backend/tools/elisp"
  :if (file-exists-p "~/shortcut/backend/tools/elisp")
  :hook (clojure-mode . shortcut-backend-font-lock)
  :bind (("C-c C-r" . shortcut-backend-goto-defresource)
         ("C-c a" . shortcut-backend-insert-co-authored-by)
         ("C-c l" . shortcut-backend-insert-shortcut-story-url))
  :config (shortcut-backend-enable-matcher-combinator-test-output-colors))

(use-package expand-region
  :ensure t
  :bind (("M-="  . er/expand-region)))
