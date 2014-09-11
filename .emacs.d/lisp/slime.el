(setq inferior-lisp-program "/usr/bin/sbcl")
(add-to-list 'load-path "~/quicklisp/dists/quicklisp/software/slime-2.8/")
(require 'slime)

(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))

(add-hook 'slime-mode-hook
	  (lambda ()
            (setq slime-net-coding-system 'utf-8-unix) ; from wmannis on #lisp
            (setq indent-tabs-mode nil)
            (setq lisp-indent-function 'common-lisp-indent-function)
	    (put 'defmethod 'common-lisp-indent-function '(2 2 2 2))
            (put 'define-web-method 'common-lisp-indent-function '(2 2 2 2))
	    (put 'deftest 'common-lisp-indent-function '(2 2 2 2))
	    (put 'format-http-code 'common-lisp-indent-function '1) 
	    (put 'when-bind 'common-lisp-indent-function '3)
	    (put 'handler-case-if 'common-lisp-indent-function '(4 &rest (&whole 2 &lambda &body)))
	    (put 'if-bind 'common-lisp-indent-function '3)))

(slime-setup '(slime-fancy slime-presentations slime-tramp slime-asdf))

(add-to-list 'auto-mode-alist '(".asd" . lisp-mode)) ; .asd files are Lisp
(push ".x86f" completion-ignored-extensions)
(push ".fasl" completion-ignored-extensions)
(push ".core" completion-ignored-extensions)

;; CLHS

(setq common-lisp-hyperspec-root
      "file:///home/eli/HyperSpec/") ;;; FIXME

(global-set-key [(control ?c) (control ?v)] 'slime-selector)

(setq slime-words-of-encouragement
  '("Maleficus longa, vita brevis."
    "The world is burning. Run."
    "Deleted code has no bugs."
    "Any programmer who fails to comply with the standard naming, formatting, 
or commenting conventions should be shot.  If it so happens that it is
inconvenient to shoot him, then he is to be politely requested to recode
his program in adherence to the above standard."
    "A CONS is an object which cares."
    "Due to the holiday, there will be no garbage collection today."
    "One man's constant is another man's variable. -- Perlis"
    "TECO Madness: a moment of convenience, a lifetime of regret. -- Moon"
    "I will not be numbered, stamped, briefed, debriefed, or filed!"
    "A good rule of thumb is never to use PROG under any circumstances for
anything. -- Moon"))
