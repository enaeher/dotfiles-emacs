(autoload 'css-mode "css-mode")
(add-to-list 'auto-mode-alist '(".css" . css-mode)) 

;; the default CSS indentation is absurd

(setq cssm-indent-function #'cssm-c-style-indenter)
(setq cssm-indent-level '2)
