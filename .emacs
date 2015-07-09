(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(require 'use-package)

(add-to-list 'load-path "~/.emacs.d/lisp/")

(setq ring-bell-function 'ignore)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(add-hook 'after-init-hook 'server-start)
(add-hook 'before-save-hook 'whitespace-cleanup)

(load "aesthetic")
(load "mouse-config")
(load "global-keybindings")
(load "maybe-open-with-sudo")
(load "clojure")
(load "common-lisp")

(diminish 'local-keys)

(if (eq system-type 'darwin)
    (load "macosx-clipboard")
    (load "linux-clipboard"))

;; Packages

(use-package hl-sexp
  :ensure t
  :init
  (progn
    (add-hook 'emacs-lisp-mode-hook (lambda () (hl-sexp-mode +1)))
    (add-hook 'lisp-mode-hook (lambda () (hl-sexp-mode +1)))
    (add-hook 'clojure-mode-hook (lambda () (hl-sexp-mode +1)))))

(use-package js2-mode
  :ensure t
  :mode "\\.js\\'"
  :init (setq js-indent-level 4))

(use-package magit
  :ensure t
  :bind ("C-c g" . magit-status)
  :diminish magit-auto-revert-mode)

(use-package smex
  :ensure t
  :bind ("M-x" . smex))

(use-package tern
  :load-path "~/.emacs.d/lisp/tern/emacs"
  :init
  (progn
    (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
    (add-hook 'js-mode-hook 'flymake-mode)))

(use-package windmove
  :init (windmove-default-keybindings))

(use-package smex
  :ensure t
  :init (smex-initialize))

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

(use-package ibuffer-projectile
   :init (add-hook 'ibuffer-hook
		  (lambda ()
		    (ibuffer-projectile-set-filter-groups)
		    (unless (eq ibuffer-sorting-mode 'alphabetic)
		      (ibuffer-do-sort-by-alphabetic)))))

(use-package helm
  :ensure t
  :init
  (progn
    (require 'helm-config)
    (setq helm-c-locate-command
      (cl-case system-type
	('gnu/linux "locate -i -r %s")
	('berkeley-unix "locate -i %s")
	('windows-nt "es %s")
	('darwin "mdfind %s %s")
	(t "locate %s")))))

(use-package helm-swoop
  :ensure t
  :bind ("M-i" . helm-swoop))

(use-package multiple-cursors
  :ensure t
  :bind (("C-c ." . mc/mark-next-like-this)
	 ("C-c ," . mc/mark-prev-like-this)
	 ("C-c /" . mc/mark-all-like-this)))

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


;;; END OF EDITABLE CONFIGURATION

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Linum-format "%7i ")
 '(atom-api:author "Eli Naeher")
 '(atom-api:feed/seed-urls (quote ("http://blog.flyoverblues.com/atom")))
 '(auto-compression-mode t nil (jka-compr))
 '(background-color "#202020")
 '(background-mode dark)
 '(browse-url-browser-function (quote eww-browse-url))
 '(case-fold-search t)
 '(cider-prompt-for-symbol nil)
 '(cider-repl-history-file "~/.nrepl-history.eld")
 '(cider-repl-use-pretty-printing t)
 '(column-number-mode t)
 '(company-begin-commands (quote (self-insert-command)))
 '(company-tooltip-limit 20)
 '(compilation-message-face (quote default))
 '(css-indent-offset 2)
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(current-language-environment "UTF-8")
 '(cursor-color "#cccccc")
 '(custom-enabled-themes (quote (distinguished)))
 '(custom-safe-themes
   (quote
    ("14225e826195202fbc17dcf333b94d91deb6e6f5ca3f5a75357009754666822a" "92d35a9332f9cb30881828fe0d58131aec5950430dc07c4f609980d4ddc5aef5" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "696927ed40057050d219989dd473cc08fab27995e4febd6cf14429a448364bc6" "8a1810f2b329aa49672efa6d9d694d31c374baf59a6358309c9507ebc4a08049" "90af7d0da6b97c28098177271c1d9198234435a2d1874880ba36e5bdae9da113" "90b5269aefee2c5f4029a6a039fb53803725af6f5c96036dee5dc029ff4dff60" "0ebe0307942b6e159ab794f90a074935a18c3c688b526a2035d14db1214cf69c" "645599a2aab022fd7677124515a3104a60ba64d2cafdd77a6e7703f8ae97250c" "f2f2941e226bc578fa82b8badbb6ff252eef6b50b6f8f6263f8102cf5e029db8" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "3a727bdc09a7a141e58925258b6e873c65ccf393b2240c51553098ca93957723" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" "b21bf64c01dc3a34bc56fff9310d2382aa47ba6bc3e0f4a7f5af857cd03a7ef7" "1e194b1010c026b1401146e24a85e4b7c545276845fc38b8c4b371c8338172ad" "8f7e1668dd3a097964e6016c26d36822ab2e48fc3e9a3a2e2634224a5ca728c8" "f2013cb180ad77a5e55ff9821cb25db59fb728cfedef24a6c44b88f275c873c0" "af27b8480041655846b7d4027eeed1ec05300e27326c45e2469330741a54cdf7" "6f5cd11faab50eaf1fb833a29d9610d7d8637bc71eab6705de87bfe5caa4edb9" "4071907906bd0b99c756dc3fa420e9dfa984ad0d6272b199491a52b0177f4f79" "15c74698201a09b5cdfca2c0228fe6389255355dd94114ccb48bdf4e51a5cc91" "6cef5e0849b451a7ad48efe682831f578489583ac85be4873781be46c7b45d7c" "0abd76545e79b360e26e61c993cb608aef4a19475a6bfc9fd29ad21540cf4d96" "fe84157cad7e0ababea56126cc47108353f04f0b7ea7443c573c09f45f8f5c30" "8fd393097ac6eabfcb172f656d781866beec05f27920a0691e8772aa2cdc7132" "25f330cb050c7e7ec402af1b60243e8185a7837b455af0fa026593d4f48a78b2" "e5355b4030a701c681f04cb87542d4eecad2ad6b2334cec44a5dadc6bce5598b" "e08675d2b56a06fe0003ae53dc5a4332c813f32f48cb8bc66063a41f7b3c3e81" "6f5029f343803f18390b994c221c4cf5f907d30838402204c3c9661a6f45eeab" "77bd459212c0176bdf63c1904c4ba20fce015f730f0343776a1a14432de80990" "75c9f0b0499ecdd0c856939a5de052742d85af81814e84faa666522c2bba7e85" "cab317d0125d7aab145bc7ee03a1e16804d5abdfa2aa8738198ac30dc5f7b569" "290987f8b1cbe93977fc21403c1e9bdc95013cb0cf29d0f6120768463ee61442" "28ea856c2f85b4a908fe72e3dea5e28254b969b93cbe88e7cad1ed2fd19b53a1" "e80a0a5e1b304eb92c58d0398464cd30ccbc3622425b6ff01eea80e44ea5130e" "d5336b707d375fbc2c00a53a60cafa264fc7e600fd747cce2dde976609b37573" "1989847d22966b1403bab8c674354b4a2adf6e03e0ffebe097a6bd8a32be1e19" "9bcb8ee9ea34ec21272bb6a2044016902ad18646bd09fdd65abae1264d258d89" "ce79400f46bd76bebeba655465f9eadf60c477bd671cbcd091fe871d58002a88" "bad832ac33fcbce342b4d69431e7393701f0823a3820f6030ccc361edd2a4be4" "cea6d15a8333e0c78e1e15a0524000de69aac2afa7bb6cf9d043a2627327844e" "f41fd682a3cd1e16796068a2ca96e82cfd274e58b978156da0acce4d56f2b0d5" "33c5a452a4095f7e4f6746b66f322ef6da0e770b76c0ed98a438e76c497040bb" "53c542b560d232436e14619d058f81434d6bbcdc42e00a4db53d2667d841702e" "2c74e2959ce6a9123b60ed7621c90479fb5bb0d8613c8b858bebba6c979a46bd" "4eaad15465961fd26ef9eef3bee2f630a71d8a4b5b0a588dc851135302f69b16" "758da0cfc4ecb8447acb866fb3988f4a41cf2b8f9ca28de9b21d9a68ae61b181" "42ac06835f95bc0a734c21c61aeca4286ddd881793364b4e9bc2e7bb8b6cf848" "e24180589c0267df991cf54bf1a795c07d00b24169206106624bb844292807b9" "57072d797dc09fcf563051a85a29d6a51d6f2b1a602e029c35b05c30df319b2a" "ee6081af57dd389d9c94be45d49cf75d7d737c4a78970325165c7d8cb6eb9e34" "353861e69d6510a824905208f7290f90248f0b9354ee034fd4562b962790bdfc" "d143750cb9fadb9ea9a3a27e0632418d2ad09788e115a61a64dd5404fedfe178" "6e92ca53a22d9b0577ad0b16e07e2e020c8b621197e39fec454048e51b7954cb" "f5e9f66da69f504cb61aacedeb8284d8f38f2e6f835fd658cac5f0ad5d924549" "e74d80bf86c7951b1a27994faa417f7e3b4a02f7a365ed224f032bd29f5d2d6d" "e26780280b5248eb9b2d02a237d9941956fc94972443b0f7aeec12b5c15db9f3" "bf648fd77561aae6722f3d53965a9eb29b08658ed045207fe32ffed90433eb52" "c7359bd375132044fe993562dfa736ae79efc620f68bab36bd686430c980df1c" "7d4d00a2c2a4bba551fcab9bfd9186abe5bfa986080947c2b99ef0b4081cb2a6" "a774c5551bc56d7a9c362dca4d73a374582caedb110c201a09b410c0ebbb5e70" "a99e7c91236b2aba4cd374080c73f390c55173c5a1b4ac662eeb3172b60a9814" "572caef0c27b100a404db8d540fd5b31397f90ab660ef5539ff0863ff9bee26a" "e0b1e7cea8624d6c724a8f046fd456db8af3ffff14a85bea46d1bc87b08b5964" "53e29ea3d0251198924328fd943d6ead860e9f47af8d22f0b764d11168455a8e" "1011be33e9843afd22d8d26b031fbbb59036b1ce537d0b250347c19e1bd959d0" "013e87003e1e965d8ad78ee5b8927e743f940c7679959149bbee9a15bd286689" "9eb5269753c507a2b48d74228b32dcfbb3d1dbfd30c66c0efed8218d28b8f0dc" "0744f61189c62ed6d1f8fa69f6883d5772fe8577310b09e623c62c040f208cd4" "e292ec749f785d348969926448e25790356a7ce1a8fda6e695f5e8b70bed786b" "6c9ddb5e2ac58afb32358def7c68b6211f30dec8a92e44d2b9552141f76891b3" "1ef7df153ee59ef210acf0060073cd98e4992c9014b4fc7766243a3cb56cc6e4" "0d19ff470ad7029d2e1528b3472ca2d58d0182e279b9ab8acd65e2508845d2b6" "0795e2c85394140788d72d34969be4acb305e4a54149e7237787d9df27832fbb" "0c311fb22e6197daba9123f43da98f273d2bfaeeaeb653007ad1ee77f0003037" "94e0091d9f9395ee25bb317da1b529ac47a1bcb68d5be5ddf1d2c70daac8351e" "e8ff60c7811d4532ee9f756b654d2f13d455e04851ee60c5e033e1b6a17e968f" "8dd5991bf912b39dc4ae77e2d6aa4882949f4441570222eaf25e07ec38c44d50" "39dd7106e6387e0c45dfce8ed44351078f6acd29a345d8b22e7b8e54ac25bac4" "0e121ff9bef6937edad8dfcff7d88ac9219b5b4f1570fd1702e546a80dba0832" "d19805e56e8c5ea79d0345ead674f55f602be3a0544f1fc9db1c1875432da76e" "cc0dbb53a10215b696d391a90de635ba1699072745bf653b53774706999208e3" "b9183de9666c3a16a7ffa7faaa8e9941b8d0ab50f9aaba1ca49f2f3aec7e3be9" "4a60f0178f5cfd5eafe73e0fc2699a03da90ddb79ac6dbc73042a591ae216f03" "70cf411fbf9512a4da81aa1e87b064d3a3f0a47b19d7a4850578c8d64cac2353" "96efbabfb6516f7375cdf85e7781fe7b7249b6e8114676d65337a1ffe78b78d9" "c1fb68aa00235766461c7e31ecfc759aa2dd905899ae6d95097061faeb72f9ee" "7feeed063855b06836e0262f77f5c6d3f415159a98a9676d549bfeb6c49637c4" "024b0033a950d6a40bbbf2b1604075e6c457d40de0b52debe3ae994f88c09a4a" "454dc6f3a1e9e062f34c0f988bcef5d898146edc5df4aa666bf5c30bed2ada2e" "255de8fde9647c6a0fbd0c9877ee02b612f8ed3cf5c78162b83ee68dfef05952" "7ed6913f96c43796aa524e9ae506b0a3a50bfca061eed73b66766d14adfa86d1" "c739f435660ca9d9e77312cbb878d5d7fd31e386a7758c982fa54a49ffd47f6e" "50edb7914e8d369bc03820d2dcde7e74b7efe2af5a39511d3a130508e2f6ac8f" "86f4407f65d848ccdbbbf7384de75ba320d26ccecd719d50239f2c36bec18628" "7dd515d883520286fc8936ce32381fb01b978d0d7cfb6fe56f7f55d8accbf63a" "ca229a0a89717c8a6fe5cd580ee2a85536fbafce6acb107d33cf38d52e2f492c" "fc2782b33667eb932e4ffe9dac475f898bf7c656f8ba60e2276704fabb7fa63b" "769bb56fb9fd7e73459dcdbbfbae1f13e734cdde3cf82f06a067439568cdaa95" "96b023d1a6e796bab61b472f4379656bcac67b3af4e565d9fb1b6b7989356610" "f0a99f53cbf7b004ba0c1760aa14fd70f2eabafe4e62a2b3cf5cabae8203113b" "297063d0000ca904abb446944398843edaa7ef2c659b7f9087d724bf6f8c1d1f" "bc89fda3d232a3daa4eb3a9f87d6ffe1272fea46e4cf86686d9e8078e4209e2c" "2affb26fb9a1b9325f05f4233d08ccbba7ec6e0c99c64681895219f964aac7af" "97a2b10275e3e5c67f46ddaac0ec7969aeb35068c03ec4157cf4887c401e74b1" "65ae93029a583d69a3781b26044601e85e2d32be8f525988e196ba2cb644ce6a" "c4e6fe8f5728a5d5fd0e92538f68c3b4e8b218bcfb5e07d8afff8731cc5f3df0" "e53cc4144192bb4e4ed10a3fa3e7442cae4c3d231df8822f6c02f1220a0d259a" "de2c46ed1752b0d0423cde9b6401062b67a6a1300c068d5d7f67725adc6c3afb" "978ff9496928cc94639cb1084004bf64235c5c7fb0cfbcc38a3871eb95fa88f6" "41b6698b5f9ab241ad6c30aea8c9f53d539e23ad4e3963abff4b57c0f8bf6730" "405fda54905200f202dd2e6ccbf94c1b7cc1312671894bc8eca7e6ec9e8a41a2" "ae8d0f1f36460f3705b583970188e4fbb145805b7accce0adb41031d99bd2580" "51bea7765ddaee2aac2983fac8099ec7d62dff47b708aa3595ad29899e9e9e44" "1affe85e8ae2667fb571fc8331e1e12840746dae5c46112d5abb0c3a973f5f5a" "9bac44c2b4dfbb723906b8c491ec06801feb57aa60448d047dbfdbd1a8650897" "dc77fb4e02417a6a932599168bd61927f6f2fe4fe3dbc4e4086a0bfb25babd67" "2b5aa66b7d5be41b18cc67f3286ae664134b95ccc4a86c9339c886dfd736132d" "d8a4e35ee1b219ccb8a8c15cdfed687fcc9d467c9c8b9b93bd25229b026e4703" "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "f0ea6118d1414b24c2e4babdc8e252707727e7b4ff2e791129f240a2b3093e32" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "60f04e478dedc16397353fb9f33f0d895ea3dab4f581307fbf0aa2f07e658a40" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "146d24de1bb61ddfa64062c29b5ff57065552a7c4019bee5d869e938782dfc2a" default)))
 '(default-input-method "rfc1345")
 '(desktop-save-mode t)
 '(diary-entry-marker (quote font-lock-variable-name-face))
 '(ecb-options-version "2.32")
 '(emms-mode-line-icon-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
static char *note[] = {
/* width height num_colors chars_per_pixel */
\"    10   11        2            1\",
/* colors */
\". c #358d8d\",
\"# c None s None\",
/* pixels */
\"###...####\",
\"###.#...##\",
\"###.###...\",
\"###.#####.\",
\"###.#####.\",
\"#...#####.\",
\"....#####.\",
\"#..######.\",
\"#######...\",
\"######....\",
\"#######..#\" };")))
 '(erc-nick "enn")
 '(explicit-shell-file-name "/bin/bash")
 '(fci-rule-character-color "#192028")
 '(fci-rule-color "#c7c7c7")
 '(flx-ido-mode t)
 '(flycheck-display-errors-delay 0)
 '(flycheck-display-errors-function (quote flycheck-pos-tip-error-messages))
 '(foreground-color "#cccccc")
 '(frame-brackground-mode (quote dark))
 '(fringe-mode 10 nil (fringe))
 '(global-font-lock-mode t nil (font-lock))
 '(global-linum-mode t)
 '(global-rudel-header-subscriptions-mode t)
 '(global-rudel-mode-line-publish-state-mode t)
 '(global-undo-tree-mode t)
 '(gnus-logo-colors (quote ("#0d7b72" "#adadad")) t)
 '(gnus-mode-line-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
static char *gnus-pointer[] = {
/* width height num_colors chars_per_pixel */
\"    18    13        2            1\",
/* colors */
\". c #358d8d\",
\"# c None s None\",
/* pixels */
\"##################\",
\"######..##..######\",
\"#####........#####\",
\"#.##.##..##...####\",
\"#...####.###...##.\",
\"#..###.######.....\",
\"#####.########...#\",
\"###########.######\",
\"####.###.#..######\",
\"######..###.######\",
\"###....####.######\",
\"###..######.######\",
\"###########.######\" };")) t)
 '(helm-mode t)
 '(highlight-changes-colors (quote ("#D700D7" "#AF87FF")))
 '(highlight-symbol-colors
   (quote
    ("#EFFF00" "#73CD4F" "#83DDFF" "MediumPurple1" "#66CDAA" "DarkOrange" "HotPink1" "#809FFF" "#ADFF2F")))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#303030" . 0)
     ("#B3EE3A" . 20)
     ("#AFEEEE" . 30)
     ("#8DE6F7" . 50)
     ("#FFF68F" . 60)
     ("#FFA54F" . 70)
     ("#FE87F4" . 85)
     ("#303030" . 100))))
 '(hl-paren-background-colors
   (quote
    ("#00FF99" "#CCFF99" "#FFCC99" "#FF9999" "#FF99CC" "#CC99FF" "#9999FF" "#99CCFF" "#99FFCC" "#7FFF00")))
 '(hl-paren-colors (quote ("#326B6B")))
 '(ido-create-new-buffer (quote always))
 '(ido-enable-flex-matching t)
 '(ido-mode (quote both) nil (ido))
 '(ido-use-faces nil)
 '(ido-use-filename-at-point (quote guess))
 '(ido-vertical-mode t)
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(linum-format " %6d ")
 '(magit-diff-use-overlays nil)
 '(magit-use-overlays nil)
 '(main-line-color1 "#222232")
 '(main-line-color2 "#333343")
 '(main-line-separator-style (quote chamfer))
 '(menu-bar-mode nil)
 '(org-babel-load-languages (quote ((lisp . t) (emacs-lisp . t))))
 '(org-src-fontify-natively t)
 '(projectile-global-mode t)
 '(projectile-project-root-files-bottom-up
   (quote
    ("project.clj" ".projectile" ".git" ".hg" ".fslckout" ".bzr" "_darcs")))
 '(rainbow-delimiters-max-face-count 1)
 '(rainbow-identifiers-cie-l*a*b*-lightness 80)
 '(rainbow-identifiers-cie-l*a*b*-saturation 18)
 '(safe-local-variable-values
   (quote
    ((ffip-project-file . "project.clj")
     (Package . imho-system)
     (package . rune-dom)
     (Package . net\.html\.generator)
     (pbook-heading-regexp . "^;;;\\(;+\\)")
     (pbook-commentary-regexp . "^;;;\\($\\|[^;]\\)")
     (package . odcl)
     (Package . wco-framework)
     (Package . HTML-TEMPLATE)
     (Package . wco-framework-utils)
     (Package . wco-system)
     (Package . wcof-tests)
     (Package . planq)
     (Package . cl-svg)
     (Lowercase . Yes)
     (indent-tabs)
     (show-trailing-whitespace . t)
     (Package . CHUNGA)
     (Package . CL-PPCRE)
     (Package . FLEXI-STREAMS)
     (package . puri)
     (Package . CL-WHO)
     (Package . CLOUCHDB)
     (Package . HUNCHENTOOT)
     (Package . CXML)
     (Syntax . Common-Lisp)
     (Package . SAX)
     (readtable . runes)
     (Encoding . utf-8)
     (Package . CLIM-INTERNALS)
     (Package . DREI-LISP-SYNTAX)
     (Package . DREI)
     (Package . CLIMACS-GUI)
     (Package . CLIMACS)
     (Package . XML)
     (Package . C)
     (Log . C\.Log)
     (Package . DRAKMA)
     (Package . webapp)
     (Syntax . COMMON-LISP)
     (Package . CL-USER)
     (Syntax . Lisp)
     (Package . Lisp)
     (Log . code\.log)
     (Package . LISP)
     (unibyte . t)
     (Package . odcl)
     (Package . Multiprocessing)
     (Package . CL)
     (Syntax . ANSI-Common-Lisp)
     (Package . webcheckout)
     (Package . imho)
     (Package . cl-user)
     (Package PCL
	      (LISP WALKER))
     (syntax . ansi-common-lisp)
     (base . 10)
     (package . wcof)
     (Package . PCL)
     (Syntax . Common-lisp)
     (Package . wcof)
     (Syntax . Ansi-Common-Lisp)
     (Base . 10)
     (Package . wco))))
 '(savehist-mode t)
 '(scroll-bar-mode nil)
 '(scss-sass-command "~/.gem/ruby/1.9.1/bin/sass")
 '(shell-file-name "/bin/bash")
 '(shift-select-mode nil)
 '(show-paren-mode t nil (paren))
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(sml/active-background-color "#34495e")
 '(sml/active-foreground-color "#ecf0f1")
 '(sml/inactive-background-color "#dfe4ea")
 '(sml/inactive-foreground-color "#34495e")
 '(sml/pre-modes-separator (propertize " " (quote face) (quote sml/modes)))
 '(syslog-debug-face
   (quote
    ((t :background unspecified :foreground "#5FFFFF" :weight bold))))
 '(syslog-error-face
   (quote
    ((t :background unspecified :foreground "#FF1493" :weight bold))))
 '(syslog-hour-face (quote ((t :background unspecified :foreground "#87D700"))))
 '(syslog-info-face
   (quote
    ((t :background unspecified :foreground "#5FD7FF" :weight bold))))
 '(syslog-ip-face (quote ((t :background unspecified :foreground "#CDC673"))))
 '(syslog-su-face (quote ((t :background unspecified :foreground "#D700D7"))))
 '(syslog-warn-face
   (quote
    ((t :background unspecified :foreground "#FF8C00" :weight bold))))
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#FF1493")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#CDC673")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#87D700")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#5FFFFF")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#5FD7FF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#1B1E1C" "#303030" "#5F0000" "#FF1493" "#6B8E23" "#87D700" "#968B26" "#CDC673" "#21889B" "#5FD7FF" "#A41F99" "#D700D7" "#349B8D" "#5FFFFF" "#F5F5F5" "#FFFAFA")))
 '(xterm-mouse-mode t))
;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
; '(default ((t (:inherit nil :stipple nil :background "#000000" :foreground "#eaeaea" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 160 :width normal :foundry "apple" :family "Inconsolata")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(hl-sexp-face ((t (:background "color-235" :weight bold))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "brightwhite"))))
 '(vertical-border ((t (:background nil)))))
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
